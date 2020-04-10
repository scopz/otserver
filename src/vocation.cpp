//////////////////////////////////////////////////////////////////////
// OpenTibia - an opensource roleplaying game
//////////////////////////////////////////////////////////////////////
//
//////////////////////////////////////////////////////////////////////
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software Foundation,
// Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
//////////////////////////////////////////////////////////////////////
#include "otpch.h"

#include "vocation.h"
#include "tools.h"
#include <libxml/xmlmemory.h>
#include <libxml/parser.h>
#include <iostream>
#include <cmath>
#include <boost/algorithm/string/predicate.hpp>

Vocations::Vocations()
{
	//
}

Vocations::~Vocations()
{
	for(VocationsMap::iterator it = vocationsMap.begin(); it != vocationsMap.end(); ++it){
		delete it->second;
	}
	vocationsMap.clear();
}

bool Vocations::loadFromXml(const std::string& datadir)
{
	std::string filename = datadir + "vocations.xml";

	xmlDocPtr doc = xmlParseFile(filename.c_str());
	if(doc){
		xmlNodePtr root, p;
		root = xmlDocGetRootElement(doc);

		if(xmlStrcmp(root->name,(const xmlChar*)"vocations") != 0){
			xmlFreeDoc(doc);
			return false;
		}

		p = root->children;

		while(p){
			std::string str;
			int intVal;
			float floatVal;
			if(xmlStrcmp(p->name, (const xmlChar*)"vocation") == 0){
				Vocation* voc = new Vocation();
				uint32_t voc_id;
				xmlNodePtr skillNode;
				if(readXMLInteger(p, "id", intVal)){
					voc_id = intVal;

					voc->baseVocation = voc_id;
					voc->promotesTo = 0;

					if(readXMLString(p, "name", str)){
						voc->name = str;
					}
					if(readXMLString(p, "description", str)){
						voc->description = str;
					}
					if(readXMLInteger(p, "gaincap", intVal)){
						voc->gainCap = intVal;
					}
					if(readXMLInteger(p, "gainhp", intVal)){
						voc->gainHP = intVal;
					}
					if(readXMLInteger(p, "gainmana", intVal)){
						voc->gainMana = intVal;
					}
					if(readXMLInteger(p, "gainhpticks", intVal)){
						voc->gainHealthTicks = intVal;
					}
					if(readXMLInteger(p, "gainhpamount", intVal)){
						voc->gainHealthAmount = intVal;
					}
					if(readXMLInteger(p, "gainmanaticks", intVal)){
						voc->gainManaTicks = intVal;
					}
					if(readXMLInteger(p, "gainmanaamount", intVal)){
						voc->gainManaAmount = intVal;
					}
					if(readXMLInteger(p, "maxsoul", intVal)){
						voc->maxSoul = intVal;
					}
					if(readXMLInteger(p, "gainsoulticks", intVal)){
						voc->gainSoulTicks = intVal;
					}
					if(readXMLFloat(p, "manamultiplier", floatVal)){
						voc->manaMultiplier = floatVal;
					}
					if(readXMLInteger(p, "attackspeed", intVal)){
						voc->attackSpeed = intVal;
					}
					skillNode = p->children;
					while(skillNode){
						if(xmlStrcmp(skillNode->name, (const xmlChar*)"skill") == 0){
							int32_t skill_id;
							if(readXMLInteger(skillNode, "id", intVal)){
								skill_id = intVal;
								if(skill_id < SKILL_FIRST || skill_id > SKILL_LAST){
									std::cout << "No valid skill id. " << skill_id << std::endl;

								}
								else{
									if(readXMLInteger(skillNode, "base", intVal)){
										voc->skillBases[skill_id] = intVal;
									}
									if(readXMLFloat(skillNode, "multiplier", floatVal)){
										voc->skillMultipliers[skill_id] = floatVal;
									}
								}
							}
							else{
								std::cout << "Missing skill id." << std::endl;
							}
						}
						else if(xmlStrcmp(skillNode->name, (const xmlChar*)"damage") == 0){
							if(readXMLFloat(skillNode, "magicDamage", floatVal)){
								voc->magicBaseDamage = floatVal;
							}
							if(readXMLFloat(skillNode, "wandDamage", floatVal)){
								voc->wandBaseDamage = floatVal;
							}
							if(readXMLFloat(skillNode, "healingDamage", floatVal)){
								voc->healingBaseDamage = floatVal;
							}
						}
						else if(xmlStrcmp(skillNode->name, (const xmlChar*)"meleeDamage") == 0){
							if(readXMLFloat(skillNode, "sword", floatVal)){
								voc->swordBaseDamage = floatVal;
							}
							if(readXMLFloat(skillNode, "axe", floatVal)){
								voc->axeBaseDamage = floatVal;
							}
							if(readXMLFloat(skillNode, "club", floatVal)){
								voc->clubBaseDamage = floatVal;
							}
							if(readXMLFloat(skillNode, "dist", floatVal)){
								voc->distBaseDamage = floatVal;
							}
							if(readXMLFloat(skillNode, "fist", floatVal)){
								voc->fistBaseDamage = floatVal;
							}
						}
						else if(xmlStrcmp(skillNode->name, (const xmlChar*)"defense") == 0){
							if(readXMLFloat(skillNode, "baseDefense", floatVal)){
								voc->baseDefense = floatVal;
							}
							if(readXMLFloat(skillNode, "armorDefense", floatVal)){
								voc->armorDefense = floatVal;
							}
						}
						else if(xmlStrcmp(skillNode->name, (const xmlChar*)"evolution") == 0){
							if(readXMLInteger(skillNode, "base", intVal)){
								voc->baseVocation = intVal;
							}
							if(readXMLInteger(skillNode, "promotes", intVal)){
								voc->promotesTo = intVal;
							}
						}
						skillNode = skillNode->next;
					}

					//std::cout << "Voc id: " << voc_id << std::endl;
					//voc->debugVocation();
					vocationsMap[voc_id] = voc;
					voc->loadCacheSkillValues();

				}
				else{
					std::cout << "Missing vocation id." << std::endl;
				}
			}
			p = p->next;
		}
		xmlFreeDoc(doc);

	}
	return true;
}

bool Vocations::exists(const uint32_t& vocationId) const
{
	return vocationsMap.find(vocationId) != vocationsMap.end();
}

bool Vocations::getVocation(const uint32_t vocationId, Vocation*& vocation)
{
	VocationsMap::const_iterator it = vocationsMap.find(vocationId);
	if(it != vocationsMap.end()){
		vocation = it->second;
		return true;
	}
	std::cout << "Warning: [Vocations::getVocation] Vocation " << vocationId << " not found." << std::endl;
	return false;
}

bool Vocations::getVocationId(const std::string& name, int32_t& vocationId) const
{
	for(VocationsMap::const_iterator it = vocationsMap.begin(); it != vocationsMap.end(); ++it){
		if(boost::algorithm::iequals(it->second->name, name)){
			vocationId = it->first;
			return true;
		}
	}
	return false;
}

bool Vocations::getUnpromotedVocation(const uint32_t vocationId, uint32_t& unpromoted)
{
	bool found = false;
	Vocation* vocation;
	for(VocationsMap::iterator it = vocationsMap.begin(); it != vocationsMap.end(); ++it){
		vocation = it->second;
		if (vocation->getPromotion() == vocationId) {
			unpromoted = it->first;
			return true;
		}
	}
	return false;
}

Vocation::Vocation()
{
	name = "none";
	gainHealthTicks = 6;
	gainHealthAmount = 1;
	gainManaTicks = 6;
	gainManaAmount = 1;
	gainCap = 5;
	gainMana = 5;
	gainHP = 5;
	maxSoul = 100;
	gainSoulTicks = 120;
	manaMultiplier = 4.0;
	attackSpeed = 1500;

	skillMultipliers[0] = 1.5f;
	skillMultipliers[1] = 2.0f;
	skillMultipliers[2] = 2.0f;
	skillMultipliers[3] = 2.0f;
	skillMultipliers[4] = 2.0f;
	skillMultipliers[5] = 1.5f;
	skillMultipliers[6] = 1.1f;

	skillBases[0] = 50;
	skillBases[1] = 50;
	skillBases[2] = 50;
	skillBases[3] = 50;
	skillBases[4] = 30;
	skillBases[5] = 100;
	skillBases[6] = 20;

	swordBaseDamage = 1.;
	axeBaseDamage = 1.;
	clubBaseDamage = 1.;
	distBaseDamage = 1.;
	fistBaseDamage = 1.;

	magicBaseDamage = 1.;
	wandBaseDamage = 1.;
	healingBaseDamage = 1.;

	baseDefense = 1.;
	armorDefense = 1.;
}

Vocation::~Vocation()
{
	cacheMana.clear();
	for(uint32_t i = SKILL_FIRST; i < SKILL_LAST; ++i){
		cacheSkill[i].clear();
	}
}

void Vocation::loadCacheSkillValues()
{
	for (int skill = SKILL_FIRST; skill<=SKILL_LAST; skill++) {
		skillCacheMap& skillMap = cacheSkill[skill];
		const float &mult = skillMultipliers[skill];

		double value = skillBases[skill]*std::pow(mult,(double)-11);
		skillMap[0] = 0;
		for (int level=1; level<=200; level++) {
			value *= mult;
			uint64_t accValue = (uint64_t) (skillMap[level-1]+value);
			if (accValue < UINT_MAX) {
				skillMap[level] = accValue;
			} else {
				break;
			}
		}
	}
}

int32_t Vocation::getPercent(const int32_t &skill, const uint64_t &level, uint64_t count)
{
	const uint32_t &baseCount = cacheSkill[skill][level];
	uint32_t endValue = cacheSkill[skill][level+1]-baseCount;
	count -= baseCount;

	if(endValue > 0){
		if (count >= endValue) {
			return 100;
		} else {
			return (int32_t)((double)count / endValue * 100);
		}
	}

	return 0;
}

uint32_t Vocation::getSkillLevel(const int32_t &skill, const uint64_t &count)
{
	skillCacheMap& skillMap = cacheSkill[skill];

	for(std::map<uint32_t, uint32_t>::iterator it = skillMap.begin(); it != skillMap.end();it++){
		if (count < it->second) {
			return it->first-1;
		}
	}
	return 0;
}

uint64_t Vocation::getReqMana(int32_t magLevel)
{
	manaCacheMap::iterator it = cacheMana.find(magLevel);
	if(it != cacheMana.end()){
		return it->second;
	}

	uint64_t reqMana = (uint64_t)(1600*std::pow(manaMultiplier, magLevel-1));
	cacheMana[magLevel] = reqMana;

	return reqMana;
}

void Vocation::debugVocation()
{
	std::cout << "name: " << name << std::endl;
	std::cout << "gain cap: " << gainCap << " hp: " << gainHP << " mana: " << gainMana << std::endl;
	std::cout << "gain time: Health(" << gainHealthTicks << " ticks, +" << gainHealthAmount << "). Mana(" <<
		gainManaTicks << " ticks, +" << gainManaAmount << ")" << std::endl;
	std::cout << "mana multiplier: " << manaMultiplier << std::endl;
	for(int i = SKILL_FIRST; i < SKILL_LAST; ++i){
		std::cout << "Skill id: " << i << " multiplier: " << skillMultipliers[i] << std::endl;
	}
}