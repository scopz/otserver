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


#ifndef __OTSERV_SPELLS_H__
#define __OTSERV_SPELLS_H__

#include "definitions.h"
#include "luascript.h"
#include "player.h"
#include "actions.h"
#include "talkaction.h"
#include "baseevents.h"

class InstantSpell;
class ConjureSpell;
class RuneSpell;
class AimSpell;
class AttackSpell;
class Spell;

typedef std::map<uint32_t, RuneSpell*> RunesMap;
typedef std::map<std::string, InstantSpell*> InstantsMap;

class SpellSet {
public:
	SpellSet();
	virtual ~SpellSet() {};

	uint16_t getId() const {return id;}
	uint32_t getElements() const {return elements;}
	InstantSpell* getFirstElement() const {return firstSpell;}

	void setSpell(InstantSpell* spell);

protected:
	friend class SpellSets;
	uint16_t id;
	InstantSpell* firstSpell;
	uint32_t elements;
};

class SpellSets
{
public:
	SpellSets();
	~SpellSets();

	SpellSet* getSpellSet(const uint16_t& id);
	std::list<SpellSet*> getSpellSets(const Player* player);

private:
	typedef std::map<uint16_t, SpellSet*> SpellSetsMap;
	SpellSetsMap sets;
};


class Spells : public BaseEvents
{
public:
	Spells();
	virtual ~Spells();

	Spell* getSpellByName(const std::string& name);
	RuneSpell* getRuneSpell(uint32_t id);
	RuneSpell* getRuneSpellByName(const std::string& name);

	InstantSpell* getInstantSpell(const std::string& words);
	InstantSpell* getInstantSpellByName(std::string name);
	std::list<InstantSpell*> getInstantSpells(const Player* player);

	uint32_t getInstantSpellCount(const Player* player);
	InstantSpell* getInstantSpellByIndex(const Player* player, uint32_t index);

	TalkActionResult_t playerSaySpell(Player* player, SpeakClasses type, std::string& words);

	static Direction getAttackerDirection(Creature* creature);
	static Position getCasterPosition(Creature* creature, Direction dir) { return getFrontPosition(creature->getPosition(), dir); }
	static Position getFrontPosition(Position pos, Direction dir);

	virtual std::string getScriptBaseName();

protected:

	virtual void clear();
	virtual LuaScriptInterface& getScriptInterface();
	virtual Event* getEvent(const std::string& nodeName);
	virtual bool registerEvent(Event* event, xmlNodePtr p);

	RunesMap runes;
	InstantsMap instants;

	friend class CombatSpell;
	LuaScriptInterface m_scriptInterface;
};

typedef bool (InstantSpellFunction)(const InstantSpell* spell, Creature* creature, const std::string& param);
typedef bool (ConjureSpellFunction)(const ConjureSpell* spell, Creature* creature, const std::string& param);
typedef bool (RuneSpellFunction)(const RuneSpell* spell, Creature* creature, Item* item, const Position& posFrom, const Position& posTo);

class BaseSpell{
public:
	BaseSpell() {};
	virtual ~BaseSpell(){};

	virtual bool castSpell(Creature* creature) = 0;
	virtual bool castSpell(Creature* creature, Creature* target) = 0;

	//used by some child classes, like CombatSpell and InstantSpell
	bool internalExecuteCastSpell(Event *event, Creature* creature, const LuaVariant& var, bool &result);
};


class CombatSpell : public Event, public BaseSpell{
public:
	CombatSpell(Combat* _combat, bool _needTarget, bool _needDirection);
	virtual ~CombatSpell();

	virtual bool castSpell(Creature* creature);
	virtual bool castSpell(Creature* creature, Creature* target);
	virtual bool configureEvent(xmlNodePtr p) {return true;}

	//scripting
	bool executeCastSpell(Creature* creature, const LuaVariant& var);

	bool loadScriptCombat();
	Combat* getCombat() {return combat;}

protected:
	virtual std::string getScriptEventName() {return "onCastSpell";}
	bool needDirection;
	bool needTarget;
	Combat* combat;
};

class Spell : public BaseSpell{
public:
	Spell();
	virtual ~Spell(){};

	bool configureSpell(xmlNodePtr xmlspell);
	const std::string& getName() const {return name;}

	void postCastSpell(Player* player, bool finishedSpell = true, uint8_t payCost = 1) const;
	void postCastSpell(Player* player, uint32_t manaCost) const;

	int32_t getManaCost(const Player* player) const;
	uint32_t getLevel() const {return level;}
	uint32_t getMagicLevel() const {return magLevel;}
	uint32_t getPrice() const {return price;}
	int32_t getMana() const {return mana;}
	static bool playerHasEnoughManaToCast(const Player *p, int32_t manaCost)
	{
		return (p->getMana() >= manaCost || p->hasFlag(PlayerFlag_IgnoreSpellCheck)
				 || p->hasFlag(PlayerFlag_HasInfiniteMana));
	}
	int32_t getManaPercent() const {return manaPercent;}
	bool isPremium() const {return premium;}
	bool hasArea() const {return areaSpell;}
	void setArea(bool b) {areaSpell = b;}
	virtual bool isInstant() const = 0;
	bool isLearnable() const {return learnable;}
	bool requiresPromotion() const {return promotion;}
	SpellType_t getType() const {return type;}
	bool availableForVocation(Vocation* vocation, bool checkPromotion = false) const;

	static ReturnValue CreateIllusion(Creature* creature, const Outfit_t outfit, int32_t time);
	static ReturnValue CreateIllusion(Creature* creature, const std::string& name, int32_t time);
	static ReturnValue CreateIllusion(Creature* creature, uint32_t itemId, int32_t time);

protected:
	bool playerSpellCheck(Player* player) const;
	bool playerInstantSpellCheck(Player* player, const Creature* target);
	bool playerInstantSpellCheck(Player* player, const Position& toPos);
	bool playerRuneSpellCheck(Player* player, const Position& toPos);

	bool learnable;
	bool enabled;
	bool premium;
	uint32_t level;
	uint32_t magLevel;
	uint32_t price;
	int32_t mana;
	int32_t manaPercent;
	int32_t levelPercent;
	int32_t range;
	int32_t exhaustion;
	bool needTarget;
	bool needWeapon;
	bool selfTarget;
	bool blockingSolid;
	bool blockingCreature;
	bool isAggressive;
	bool areaSpell;
	SpellType_t type;

	typedef std::map<int32_t, bool> VocSpellMap;
	VocSpellMap vocSpellMap;
	bool promotion = false;

private:
	std::string name;
};

class InstantSpell : public TalkAction, public Spell
{
public:
	InstantSpell(LuaScriptInterface* _interface);
	virtual ~InstantSpell();

	virtual bool configureEvent(xmlNodePtr p);
	virtual bool loadFunction(const std::string& functionName);

	virtual bool playerCastInstant(Player* player, const std::string& param);

	virtual bool castSpell(Creature* creature);
	virtual bool castSpell(Creature* creature, Creature* target);

	//scripting
	virtual bool loadScript(const std::string& scriptFile, bool reserveEnviroment = true);
	bool executeCastSpell(Creature* creature, const LuaVariant& var);

	virtual bool isInstant() const { return true;}
	virtual bool requiresTarget() const { return false;}
	bool getHasParam() const { return hasParam;}
	bool canLearn(const Player* player) const;
	bool canCast(const Player* player) const;
	bool canThrowSpell(const Creature* creature, const Creature* target) const;

	uint16_t getSpellSet() const {return spellSet;}
	InstantSpell* getNextSpell() const {return nextSpell;}
	InstantSpell* getPrevSpell() const {return prevSpell;}
	void setNextSpell(InstantSpell* spell) {nextSpell = spell;}
	void setPrevSpell(InstantSpell* spell) {prevSpell = spell;}

protected:
	virtual std::string getScriptEventName();

	static InstantSpellFunction HouseGuestList;
	static InstantSpellFunction HouseSubOwnerList;
	static InstantSpellFunction HouseDoorList;
	static InstantSpellFunction HouseKick;
	static InstantSpellFunction SearchPlayer;
	static InstantSpellFunction SummonMonster;
	static InstantSpellFunction Levitate;
	static InstantSpellFunction Illusion;

	static House* getHouseFromPos(Creature* creature);

	bool internalCastSpell(Creature* creature, const LuaVariant& var);

	bool needDirection;
	bool hasParam;
	bool checkLineOfSight;
	bool casterTargetOrDirection;
	InstantSpellFunction* function;

	uint16_t spellSet;
	InstantSpell* nextSpell;
	InstantSpell* prevSpell;
};

class ConjureSpell : public InstantSpell
{
public:
	ConjureSpell(LuaScriptInterface* _interface);
	virtual ~ConjureSpell();

	virtual bool configureEvent(xmlNodePtr p);
	virtual bool loadFunction(const std::string& functionName);

	virtual bool playerCastInstant(Player* player, const std::string& param);

	virtual bool castSpell(Creature* creature) {return false;}
	virtual bool castSpell(Creature* creature, Creature* target) {return false;}

	uint32_t getConjureId() const {return conjureId;}
	uint32_t getConjureCount() const {return conjureCount;}
	uint32_t getReagentId() const {return conjureReagentId;}

protected:
	virtual std::string getScriptEventName();

	static ReturnValue internalConjureItem(Player* player, uint32_t conjureId, uint32_t conjureCount);
	static ReturnValue internalConjureItem(Player* player, const ConjureSpell* spell, slots_t slot, uint8_t &numCasts);

	static ConjureSpellFunction ConjureItem;
	static ConjureSpellFunction ConjureFood;

	bool internalCastSpell(Creature* creature, const LuaVariant& var);
	Position getCasterPosition(Creature* creature);

	ConjureSpellFunction* function;

	uint32_t conjureId;
	uint32_t conjureCount;
	uint32_t conjureReagentId;
};

class RuneSpell : public Action, public Spell
{
public:
	RuneSpell(LuaScriptInterface* _interface);
	virtual ~RuneSpell();

	virtual bool configureEvent(xmlNodePtr p);
	virtual bool loadFunction(const std::string& functionName);

	virtual ReturnValue canExecuteAction(const Player* player, const Position& toPos);
	virtual bool hasOwnErrorHandler() {return true;}

	virtual bool executeUse(Player* player, Item* item, const PositionEx& posFrom,
		const PositionEx& posTo, bool extendedUse, uint32_t creatureId);

	virtual bool castSpell(Creature* creature);
	virtual bool castSpell(Creature* creature, Creature* target);

	//scripting
	virtual bool loadScript(const std::string& scriptFile, bool reserveEnviroment = true);
	bool executeCastSpell(Creature* creature, const LuaVariant& var);

	virtual bool isInstant() const { return false;}
	uint32_t getRuneItemId(){return runeId;};

protected:
	virtual std::string getScriptEventName();

	static RuneSpellFunction Illusion;
	static RuneSpellFunction Convince;

	bool internalCastSpell(Creature* creature, const LuaVariant& var);

	bool hasCharges;
	uint32_t runeId;

	RuneSpellFunction* function;
};

class AimSpell : public InstantSpell
{
public:
	AimSpell(LuaScriptInterface* _interface);
	virtual ~AimSpell();

	virtual bool requiresTarget() const { return true;}
	virtual bool castSpell(Creature* creature);
	virtual bool castSpell(Creature* creature, Creature* target);
	virtual bool castSpell(Player* player, const Position& toPos);

	virtual bool configureEvent(xmlNodePtr p);

private:
	enum AimUseType {
		NONE = 0,
		POSITION,
		CREATURE
	};
	AimUseType useType;
};

class AttackSpell : public InstantSpell
{
public:
	AttackSpell(LuaScriptInterface* _interface);
	virtual ~AttackSpell();

	virtual bool configureEvent(xmlNodePtr p);
	virtual bool playerCastInstant(Player* player, const std::string& param);
	virtual bool internalCastSpell(Creature* creature, Creature* target);

	uint32_t getUsages() const { return usages; }

private:
	uint32_t usages;
};

#endif
