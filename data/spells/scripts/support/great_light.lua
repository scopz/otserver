local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_LIGHT)
setConditionParam(condition, CONDITION_PARAM_LIGHT_LEVEL, 9)
setConditionParam(condition, CONDITION_PARAM_LIGHT_COLOR, 215)
setConditionParam(condition, CONDITION_PARAM_TICKS, ((15*60)+9)*1000) --15 minutes and 9 seconds(time in ms)
setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end