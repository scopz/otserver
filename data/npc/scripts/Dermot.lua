	-- NPC Converter System - developed by Utroz <utroz@oakcoders.com>
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)	npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid)	npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg) end
function onThink()	npcHandler:onThink() end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the magistrate of this isle.'})
keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am not selling equipment. You\'ll have to visit Timur.'})
keywordHandler:addKeyword({'timur'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'He is the salesman in this village. '})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am Dermot, the magistrate of this isle.'})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Time is not important on Fibula.'})
keywordHandler:addKeyword({'dermot'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the magistrate of this isle.'})
keywordHandler:addKeyword({'magistrate'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Thats me.'})
keywordHandler:addKeyword({'fibula'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'You are at Fibula. This isle is not very dangerous. Just the wolves bother outside the village.'})
keywordHandler:addKeyword({'wolf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'There are a lot of wolves outside the townwall. They disturb our farmers.'})
keywordHandler:addKeyword({'farmer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The inhabitants of Fibula live on fishing, farming, and hunting.'})
keywordHandler:addKeyword({'dungeon','sewer','monster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Oh, my god. In the dungeon of Fibula are a lot of monsters. That\'s why we have sealed it with a solid door.'})
keywordHandler:addKeyword({'entrance'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'The entrance is near here.'})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)
	
	-- The Postman Missions Quest
	if msgcontains(msg, 'present') and getPlayerStorageValue(cid, 231) == 0 then
		npcHandler:playerSay(cid, 'I don\'t understand what you are talking about.')
		cidData.state = 0

	elseif msgcontains(msg, 'present') and getPlayerStorageValue(cid, 231) == 1 then
		npcHandler:playerSay(cid, 'You have a present for me?? Really?')
		cidData.state = 2

	elseif msgcontains(msg, 'yes') and getPlayerItemCount(cid, 2331) >= 1 and cidData.state == 2 then
		doPlayerRemoveItem(cid,2331,1)
		setPlayerStorageValue(cid,231,2)
		npcHandler:playerSay(cid, 'Thank you very much!')
		cidData.state = 0

	elseif msgcontains(msg, 'yes') and cidData.state == 2 then
		npcHandler:playerSay(cid, 'What? There is no present, at least none for me! Stop this foolish jokes!')
		cidData.state = 0

	elseif msgcontains(msg, '') and cidData.state == 2 then
		npcHandler:playerSay(cid, 'Hmm, maybe next time.')
		cidData.state = 0

	elseif msgcontains(msg, 'key') then
		npcHandler:playerSay(cid, 'Do you want to buy the dungeon key for 2000 gold?')
		cidData.state = 1

	elseif msgcontains(msg, 'yes') and getPlayerMoney(cid) >= 2000 and cidData.state == 1 then
		npcHandler:playerSay(cid, 'Now you own the key to the dungeon.')
		doPlayerRemoveMoney(cid, 2000)
		key = doPlayerAddItem(cid, 2089,1)
		doSetItemActionId(key,3940)
		doSetItemSpecialDescription(key, "(Key: 3940)")
		cidData.state = 0

	elseif msgcontains(msg, 'yes') and getPlayerMoney(cid) < 2000 and cidData.state == 1 then
		npcHandler:playerSay(cid, 'You\'ve not enough money to buy the key.')
		cidData.state = 0

	elseif msgcontains(msg, '') and cidData.state == 2 then
		npcHandler:playerSay(cid, 'Hmm, maybe next time.')
		cidData.state = 0
	end
	
	return true
end	

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())