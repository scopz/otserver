local CLOSED_HOLE = {468, 481, 483}

local TILE_SAND = 231
local TUMB_ENTRANCE = 25001
local TUMB_ENTRANCE_HOLE = 489


function onCastSpell(cid, var)
	local pos = getCreaturePosition(cid)
	pos.stackpos = 0
	local grounditem = getThingfromPos(pos)
	if isInArray(CLOSED_HOLE, grounditem.itemid) then

		doTransformItem(grounditem.uid, grounditem.itemid + 1)
		doDecayItem(grounditem.uid)

		local newpos = pos
		newpos.z = newpos.z + 1
		doTeleportThing(cid, newpos)
		doSendMagicEffect(newpos, CONST_ME_TELEPORT)
		return LUA_NO_ERROR

	elseif grounditem.itemid == TILE_SAND and grounditem.actionid == TUMB_ENTRANCE then
		doTransformItem(grounditem.uid, TUMB_ENTRANCE_HOLE)
		doSetItemActionId(grounditem.uid, grounditem.actionid)
		doDecayItem(grounditem.uid)

		local newpos = pos
		newpos.z = newpos.z + 1
		doTeleportThing(cid, newpos)
		doSendMagicEffect(newpos, CONST_ME_TELEPORT)
		return LUA_NO_ERROR
		
	end
	doPlayerSendDefaultCancel(cid, RETURNVALUE_NOTPOSSIBLE)
	doSendMagicEffect(pos, CONST_ME_POFF)
	return LUA_ERROR
end