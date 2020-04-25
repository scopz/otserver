-- by JDB @otland.net
-- http://otland.net/threads/first-items.40857/

function onLogin(cid)
	local lastLogin = getPlayerLastLogin(cid)
	if not (lastLogin ~= 0) then
		setFirstItems(cid)
	end
	return true
end