local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITBYICE)


function onGetFormulaValues(cid, level, attackSkill, attackValue, attackFactor)
	local min = math.floor((attackSkill*0.50 + attackValue*0.70 + level*0.40) / attackFactor * 0.9)
	local max = math.ceil ((attackSkill*0.70 + attackValue*0.63 + level*0.63) / attackFactor * 0.9)
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end