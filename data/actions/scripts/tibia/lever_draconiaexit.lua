function onUse(cid, item, fromPosition, target, toPosition, isHotkey)
	local bridgePositions = {
		{x=32627, y=31699, z=10, stackpos=0},
		{x=32628, y=31699, z=10, stackpos=0},
		{x=32629, y=31699, z=10, stackpos=0},
	}

	local makeItem = (item.itemid == 1945) and 1284 or 493 -- bridge / water

	for i = 1, #bridgePositions do
		local bridge = getThingfromPos(bridgePositions[i])
		doTransformItem(bridge.uid, makeItem)
	end
	return false -- false to make the lever switch
end