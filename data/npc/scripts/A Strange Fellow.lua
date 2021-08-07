local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)	npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)	npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg) end
function onThink()	npcHandler:onThink() end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My name is not of your concern.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'That\'s only my business, not yours.'})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end

	local cidData = npcHandler:getFocusPlayerData(cid)

	-- The Postman Missions Quest
	if getPlayerStorageValue(cid, 229) > 1 and msgcontains(msg, 'david') or msgcontains(msg, 'brassacres') then
		npcHandler:playerSay(cid, 'Yes, yes... Its me .. you exposed me! Stop nagging me with that.')
		cidData.state = 0

	elseif getPlayerStorageValue(cid, 229) == 0 and msgcontains(msg, 'bill') or msgcontains(msg, 'brassacres') then
		npcHandler:playerSay(cid, 'I never heard that name and now get lost.')
		cidData.state = 0

	elseif getPlayerStorageValue(cid, 229) == 2 and msgcontains(msg, 'bill') then
		npcHandler:playerSay(cid, 'A bill? Oh boy so you are delivering another bill to poor me?')
		cidData.state = 5

	elseif msgcontains(msg, 'yes') and getPlayerItemCount(cid, 1952) >= 1 and cidData.state == 5 then
		npcHandler:playerSay(cid, 'Ok, ok, I\'ll take it. I guess I have no other choice anyways. And now leave me alone in my misery please.')
		doPlayerRemoveItem(cid, 1952, 1)
		setPlayerStorageValue(cid, 229, 3)
		cidData.state = 0

	elseif msgcontains(msg, 'yes') and getPlayerItemCount(cid, 1952) < 1 and cidData.state == 5 then
		npcHandler:playerSay(cid, 'Ha Ha! You have none!! Naanaanaanaaanaaaa!')
		cidData.state = 0

	elseif msgcontains(msg, '') and cidData.state == 5 then
		npcHandler:playerSay(cid, 'Hoooraaaay! Uhm... I mean, thats fine...')
		cidData.state = 0

	elseif msgcontains(msg, 'bill') then
		npcHandler:playerSay(cid, 'Thats not my concern, you are probably looking for someone else and now get lost!')
		cidData.state = 0

	--[[
	elseif getPlayerStorageValue(cid, 229) == 0 and msgcontains(msg, 'hat') then
		npcHandler:playerSay(cid, 'Get lost!')
		cidData.state = 0

	elseif getPlayerStorageValue(cid, 229) == 1 and msgcontains(msg, 'hat') then
		npcHandler:playerSay(cid, 'What? My hat?? Theres... nothing special about it!')
		cidData.state = 1

	elseif cidData.state == 1 and getPlayerStorageValue(cid, 229) == 1 and msgcontains(msg, 'hat') then
		npcHandler:playerSay(cid, 'Stop bugging me about that hat, do you listen?')
		cidData.state = 2

	elseif cidData.state == 2 and getPlayerStorageValue(cid, 229) == 1 and msgcontains(msg, 'hat') then
		npcHandler:playerSay(cid, 'Hey! Don\'t touch that hat! Leave it alone!!! Don\'t do this!!!!')
		cidData.state = 3
	]]--

	elseif getPlayerStorageValue(cid, 229) == 1 and msgcontains(msg, 'hat') then
		npcHandler:playerSay(cid, 'Noooooo! Argh, ok, ok, I guess I can\'t deny it anymore, I am David Brassacres, the magnificent, so what do you want?')
		pos = getCreaturePosition(getNpcCid())
		local northEast = {x=pos.x+1,y=pos.y-1,z=pos.z}
		local northWest = {x=pos.x-1,y=pos.y-1,z=pos.z}
		local southEast = {x=pos.x+1,y=pos.y+1,z=pos.z}
		local southWest = {x=pos.x-1,y=pos.y+1,z=pos.z}
		doSummonCreature('Rabbit', northEast)
		doSummonCreature('Rabbit', northWest)
		doSummonCreature('Rabbit', southEast)
		doSummonCreature('Rabbit', southWest)
		setPlayerStorageValue(cid, 229, 2)
		cidData.state = 0
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())