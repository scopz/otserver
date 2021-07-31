local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_GREEN)
setCombatParam(combat, COMBAT_PARAM_AGGRESSIVE, false)

local condition = createConditionObject(CONDITION_REGENERATION_ICON)
setConditionParam(condition, CONDITION_PARAM_TICKS, 60*1000)
setConditionParam(condition, CONDITION_PARAM_HEALTHGAIN, 20)
setConditionParam(condition, CONDITION_PARAM_HEALTHTICKS, 3000)

setCombatCondition(combat, condition)

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end