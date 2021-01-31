local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
setCombatParam(combat, COMBAT_PARAM_BLOCKARMOR, 1)

function onGetFormulaValues(cid, level, attackSkill, attackValue, attackFactor)
	local min = math.floor((attackSkill*0.4 + attackValue*0.6 + level*0.3) / attackFactor)
	local max = math.ceil ((attackSkill*1.1 + attackValue*0.9 + level*0.6) / attackFactor)
	return -min, -max
end

setCombatCallback(combat, CALLBACK_PARAM_SKILLVALUE, "onGetFormulaValues")

function onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end