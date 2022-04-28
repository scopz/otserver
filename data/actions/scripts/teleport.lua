-- by Nottinghster

function onUse(cid, item, fromPosition, itemEx, toPosition)
	npos = {x = fromPosition.x, y = fromPosition.y, z = fromPosition.z}
	if isInArray(LADDER, itemEx.itemid) == true then
		doTeleportUpOrDown(cid, npos, true, itemEx.itemid)
	else
		doTeleportUpOrDown(cid, npos, false, 0)
	end
	return true
end