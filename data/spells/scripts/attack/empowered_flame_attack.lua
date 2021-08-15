local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITBYFIRE)

function onGetFormulaValues(cid, level, attackSkill, attackValue, attackFactor)
	local min = math.floor((attackSkill*0.56 + attackValue*0.79 + level*0.45) / attackFactor * 0.8)
	local max = math.ceil ((attackSkill*0.79 + attackValue*0.71 + level*0.71) / attackFactor * 0.8)
	return -max, -max
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end