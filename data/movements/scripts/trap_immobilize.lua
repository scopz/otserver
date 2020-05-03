function onStepIn(cid, item, position, fromPosition)
	if item.itemid == 5091 then
		doTransformItem(item.uid, 5090)
	
		if not getTilePzInfo(position) then
			doTargetCombatFreeze(0, cid, 2000, 1000, item.uid)
		end
	end
	return true
end

function onAddItem(item, tile, position)
	local thing = getThingfromPos({x=position.x, y=position.y, z=position.z, stackpos=253})
	if thing.uid > 0 and isCreature(thing.uid) == true and item.itemid == 5091 then
		doTransformItem(item.uid, 5090)
	
		if not getTilePzInfo(position) then
			doTargetCombatFreeze(0, thing.uid, 2000, 1000, item.uid)
		end
	end
	return true
end