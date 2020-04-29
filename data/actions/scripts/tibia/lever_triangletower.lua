function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
	local gatePos = {x=32566, y=32119, z=7, stackpos=1}
	local gateItem = getThingfromPos(gatePos)

	if item.itemid == 1945 and gateItem.itemid == 1025 then -- wallbrick
		doRemoveItem(gateItem.uid,1)

	elseif item.itemid == 1946 then
		doCreateItem(1025, 1, gatePos)
	end
	return false -- false to make the lever switch
end