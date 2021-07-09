local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)

function onGetFormulaValues(cid, level, attackSkill, attackValue, attackFactor)
	local min = math.floor((attackSkill*0.50 + attackValue*0.70 + level*0.40) / attackFactor)
	local max = math.ceil ((attackSkill*0.70 + attackValue*0.63 + level*0.63) / attackFactor)
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end