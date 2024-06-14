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

#ifndef __OTSERV_CONDITION_H__
#define __OTSERV_CONDITION_H__

#include "definitions.h"
#include "fileloader.h"
#include "item.h"
#include "enums.h"
#include <list>
#include <vector>

class Creature;
class Player;
class PropStream;

enum ConditionType_t {
	CONDITION_NONE,
	CONDITION_POISON,
	CONDITION_FIRE,
	CONDITION_ENERGY,
	CONDITION_LIFEDRAIN,
	CONDITION_HASTE,
	CONDITION_PARALYZE,
	CONDITION_OUTFIT,
	CONDITION_INVISIBLE,
	CONDITION_LIGHT,
	CONDITION_MANASHIELD,
	CONDITION_INFIGHT,
	CONDITION_DRUNK,
	CONDITION_EXHAUST_YELL,
	CONDITION_REGENERATION,
	CONDITION_REGENERATION_FOOD,
	CONDITION_REGENERATION_ICON,
	CONDITION_REGENERATION_MANA,
	CONDITION_MUTED,
	CONDITION_ATTRIBUTES,
	CONDITION_BUFF_ATTACK,
	//CONDITION_FREEZING,
	//CONDITION_DAZZLED,
	//CONDITION_CURSED,
	CONDITION_EXHAUST_COMBAT,
	CONDITION_EXHAUST_HEAL,
	CONDITION_PACIFIED,       // Cannot attack anything
	CONDITION_HUNTING,        // Killing monsters
	CONDITION_TRADE_MUTED,    // Cannot talk on trade channels
	CONDITION_EXHAUST_OTHERS, // 65536 -> maxValue
	CONDITION_FROZEN,
	CONDITION_INFIGHT_PRE,
};

enum ConditionExhaust_t : uint8_t {
	CONDITIONEXHAUST_NONE = 0,
	CONDITIONEXHAUST_TICKS = 1,
	CONDITIONEXHAUST_DURATION = 2,
	CONDITIONEXHAUST_DURATION_FROZEN = 3
};

enum ConditionEnd_t{
	CONDITIONEND_CLEANUP,
	CONDITIONEND_DIE,
	CONDITIONEND_TICKS,
	CONDITIONEND_ABORT
};

enum ConditionAttr_t{
	CONDITIONATTR_TYPE = 1,
	CONDITIONATTR_ID = 2,
	CONDITIONATTR_TICKS = 3,
	CONDITIONATTR_HEALTHTICKS = 4,
	CONDITIONATTR_HEALTHGAIN = 5,
	CONDITIONATTR_MANATICKS = 6,
	CONDITIONATTR_MANAGAIN = 7,
	CONDITIONATTR_DELAYED = 8,
	CONDITIONATTR_OWNER = 9,
	CONDITIONATTR_INTERVALDATA = 10,
	CONDITIONATTR_SPEEDDELTA = 11,
	CONDITIONATTR_FORMULA_MINA = 12,
	CONDITIONATTR_FORMULA_MINB = 13,
	CONDITIONATTR_FORMULA_MAXA = 14,
	CONDITIONATTR_FORMULA_MAXB = 15,
	CONDITIONATTR_LIGHTCOLOR = 16,
	CONDITIONATTR_LIGHTLEVEL = 17,
	CONDITIONATTR_LIGHTTICKS = 18,
	CONDITIONATTR_LIGHTINTERVAL = 19,
	CONDITIONATTR_SOULTICKS = 20,
	CONDITIONATTR_SOULGAIN = 21,
	CONDITIONATTR_SKILLS = 22,
	CONDITIONATTR_STATS = 23,
	CONDITIONATTR_OUTFIT = 24,
	CONDITIONATTR_PERIODDAMAGE = 25,
	CONDITIONATTR_SKILLSPERCENT = 26,
	CONDITIONATTR_ISBUFF = 27,
	CONDITIONATTR_SUBID = 28,
	CONDITIONATTR_RELATEDITEM = 29,

	CONDITIONATTR_AFFECTEDBYFIRE = 30,

	//reserved for serialization
	CONDITIONATTR_END      = 254
};

struct IntervalInfo{
	int32_t timeLeft;
	int32_t value;
	int32_t interval;
};

class Condition{
public:
	Condition(ConditionId_t _id, ConditionType_t _type, int32_t _ticks);
	virtual ~Condition() = default;

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason) = 0;
	virtual void addCondition(Creature* creature, const Condition* condition) = 0;
	virtual uint16_t getIcons() const;
	ConditionId_t getId() const {return id;}
	uint32_t getSubId() const {return subId;}

	virtual Condition* clone() const = 0;

	ConditionType_t getType() const { return conditionType;}
	int64_t getEndTime() const {return ticks == -1? 0 : endTime;}
	int32_t getTicks() const { return ticks; }
	virtual int32_t getClientTicks() const { return ticks; }
	void setTicks(int32_t newTicks);
	ConditionExhaust_t getExhaustMode() const { return exhaustMode; }

	static bool canBeAggressive(ConditionType_t type);
	static Condition* createCondition(ConditionId_t _id, ConditionType_t _type, int32_t ticks, int32_t param = 0);
	static Condition* createCondition(PropStream& propStream);

	virtual bool setParam(ConditionParam_t param, int32_t value);

	//serialization
	bool unserialize(PropStream& propStream);
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

	bool isPersistent() const;

protected:
	ConditionId_t id;
	uint32_t subId;
	int32_t ticks;
	int64_t endTime;
	ConditionType_t conditionType;
	ConditionExhaust_t exhaustMode;
	bool isBuff;

	virtual bool updateCondition(const Condition* addCondition);
};

class ConditionGeneric: public Condition
{
public:
	ConditionGeneric(ConditionId_t _id, ConditionType_t _type, int32_t _ticks);

	int32_t getClientTicks() const override;

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);
	virtual void addCondition(Creature* creature, const Condition* condition);
	virtual uint16_t getIcons() const;

	virtual ConditionGeneric* clone()  const { return new ConditionGeneric(*this); }

protected:
	int32_t internalTicks;
};

class ConditionManaShield : public ConditionGeneric
{
public:
	ConditionManaShield(ConditionId_t _id, ConditionType_t _type, int32_t _ticks) : ConditionGeneric(_id, _type, _ticks) {};
	virtual ~ConditionManaShield(){};

	virtual ConditionManaShield* clone()  const { return new ConditionManaShield(*this); }
};

class ConditionAttributes : public ConditionGeneric
{
public:
	ConditionAttributes(ConditionId_t _id, ConditionType_t _type, int32_t _ticks);

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);
	virtual void addCondition(Creature* creature, const Condition* condition);

	virtual ConditionAttributes* clone()  const { return new ConditionAttributes(*this); }

	virtual bool setParam(ConditionParam_t param, int32_t value);

	//serialization
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

protected:
	int32_t skills[SKILL_LAST + 1];
	int32_t skillsPercent[SKILL_LAST + 1];
	int32_t stats[STAT_LAST + 1];
	int32_t statsPercent[STAT_LAST + 1];
	int32_t currentSkill;
	int32_t currentStat;

	void updatePercentStats(Player* player);
	void updateStats(Player* player);
	void updatePercentSkills(Player* player);
	void updateSkills(Player* player);
};

class ConditionRegeneration : public ConditionGeneric
{
public:
	ConditionRegeneration(ConditionId_t _id, ConditionType_t _type, int32_t _ticks);

	virtual void addCondition(Creature* creature, const Condition* addCondition);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual uint16_t getIcons() const;

	virtual ConditionRegeneration* clone()  const { return new ConditionRegeneration(*this); }

	virtual bool setParam(ConditionParam_t param, int32_t value);

	//serialization
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

protected:
	uint32_t internalHealthTicks;
	uint32_t internalManaTicks;

	uint32_t healthTicks;
	uint32_t manaTicks;
	uint32_t healthGain;
	uint32_t manaGain;

	bool affectedByFire;
};

class ConditionInvisible: public ConditionGeneric
{
public:
	ConditionInvisible(ConditionId_t _id, ConditionType_t _type, int32_t _ticks);

	virtual bool startCondition(Creature* creature);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);

	virtual ConditionInvisible* clone()  const { return new ConditionInvisible(*this); }
};

class ConditionDamage: public Condition
{
public:
	ConditionDamage(ConditionId_t _id, ConditionType_t _type);

	static void generateDamageList(int32_t amount, int32_t start, std::list<int32_t>& list);

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);
	virtual void addCondition(Creature* creature, const Condition* condition);
	virtual uint16_t getIcons() const;

	virtual ConditionDamage* clone()  const { return new ConditionDamage(*this); }

	virtual bool setParam(ConditionParam_t param, int32_t value);

	bool addDamage(int32_t rounds, int32_t time, int32_t value);
	bool doForceUpdate() const { return forceUpdate;}
	int32_t getTotalDamage() const;

	int32_t getLength() const
	{
		return damageList.size();
	}
	
	IntervalInfo popBackDamage() {
		IntervalInfo info = damageList.back();
		damageList.pop_back();
		return info;
	}
	IntervalInfo popFrontDamage() {
		IntervalInfo info = damageList.front();
		damageList.pop_front();
		return info;
	}
	void clearDamageList() { damageList.clear(); }

	//serialization
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

protected:
	int32_t maxDamage;
	int32_t minDamage;
	int32_t startDamage;
	int32_t periodDamage;
	int32_t periodDamageTick;
	int32_t tickInterval;

	bool forceUpdate;
	bool delayed;
	uint32_t owner;

	bool init();

	typedef std::list<IntervalInfo> DamageList;
	DamageList damageList;

	bool getNextDamage(int32_t& damage);
	bool doDamage(Creature* creature, int32_t damage);
	bool updateCondition(const ConditionDamage* addCondition);
};

class ConditionSpeed: public Condition
{
public:
	ConditionSpeed(ConditionId_t _id, ConditionType_t _type, int32_t _ticks, int32_t changeSpeed);

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);
	virtual void addCondition(Creature* creature, const Condition* condition);
	virtual uint16_t getIcons() const;

	virtual ConditionSpeed* clone()  const { return new ConditionSpeed(*this); }

	virtual bool setParam(ConditionParam_t param, int32_t value);

	void setFormulaVars(float _mina, float _minb, float _maxa, float _maxb);

	//serialization
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

protected:
	void getFormulaValues(int32_t var, int32_t& min, int32_t& max) const;

	int32_t speedDelta;

	//formula variables
	float mina;
	float minb;
	float maxa;
	float maxb;
};

class ConditionOutfit: public Condition
{
public:
	ConditionOutfit(ConditionId_t _id, ConditionType_t _type, int32_t _ticks);

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);
	virtual void addCondition(Creature* creature, const Condition* condition);

	virtual ConditionOutfit* clone()  const { return new ConditionOutfit(*this); }

	void addOutfit(Outfit_t outfit);

	//serialization
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

protected:
	std::vector<Outfit_t> outfits;

	void changeOutfit(Creature* creature, int32_t index = -1);
};

class ConditionLight: public Condition
{
public:
	ConditionLight(ConditionId_t _id, ConditionType_t _type, int32_t _ticks, int32_t _lightlevel, int32_t _lightcolor);

	virtual bool startCondition(Creature* creature);
	virtual bool executeCondition(Creature* creature, int32_t interval);
	virtual void endCondition(Creature* creature, ConditionEnd_t reason);
	virtual void addCondition(Creature* creature, const Condition* addCondition);

	virtual ConditionLight* clone()  const { return new ConditionLight(*this); }

	virtual bool setParam(ConditionParam_t param, int32_t value);

	//serialization
	virtual bool serialize(PropWriteStream& propWriteStream);
	virtual bool unserializeProp(ConditionAttr_t attr, PropStream& propStream);

protected:
	LightInfo lightInfo;
	uint32_t internalLightTicks;
	uint32_t lightChangeInterval;
};

class ConditionFrozen: public Condition
{
public:
	ConditionFrozen(ConditionId_t _id, ConditionType_t _type, int32_t _duration, Item* _item);
	~ConditionFrozen() override;

	virtual bool startCondition(Creature* creature);
	virtual uint16_t getIcons() const;
	virtual void endCondition(Creature* creature, ConditionEnd_t reason) {};
	virtual void addCondition(Creature* creature, const Condition* addCondition) {};
	virtual bool setParam(ConditionParam_t param, int32_t value) { return true; };

	virtual ConditionFrozen* clone()  const { return new ConditionFrozen(*this); }


private:
	Item* relatedItem;
	uint32_t eventId;
};


class ConditionBuff: public Condition
{
public:
	ConditionBuff(ConditionId_t _id, ConditionType_t _type, int32_t _usages);

	virtual uint16_t getIcons() const override;

	int32_t getClientTicks() const override { return usages; };

	void endCondition(Creature* creature, ConditionEnd_t reason) override {};
	void addCondition(Creature* creature, const Condition* addCondition) override;
	ConditionBuff* clone() const override { return new ConditionBuff(*this); };
	void use() { if (usages > 0) usages--; }
	bool isConsumed() const { return usages <= 0; }

private:
	int32_t usages;
	int32_t maxUsages;
};

#endif
