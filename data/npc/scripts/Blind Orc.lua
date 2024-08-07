dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

	function FocusModule:init(handler)
	FOCUS_GREETSWORDS = {'charach'}
	FOCUS_FAREWELLSWORDS = {'xbxyxeewzzxxwe'}
		self.npcHandler = handler
		for i, word in pairs(FOCUS_GREETSWORDS) do
			local obj = {}
			table.insert(obj, word)
			obj.callback = FOCUS_GREETSWORDS.callback or FocusModule.messageMatcher
			handler.keywordHandler:addKeyword(obj, FocusModule.onGreet, {module = self})
		end
		
		for i, word in pairs(FOCUS_FAREWELLSWORDS) do
			local obj = {}
			table.insert(obj, word)
			obj.callback = FOCUS_FAREWELLSWORDS.callback or FocusModule.messageMatcher
			handler.keywordHandler:addKeyword(obj, FocusModule.onFarewell, {module = self})
		end
		
		return true
	end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'goshak charcha') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 101
	elseif msgcontains(msg, 'goshak burka bata') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 103
	elseif msgcontains(msg, 'goshak burka') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 102						
	elseif msgcontains(msg, 'goshak hakhak') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 104
	elseif msgcontains(msg, 'goshak bora') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 105
	elseif msgcontains(msg, 'goshak tulak bora') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 106
	elseif msgcontains(msg, 'goshak grofa') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 107
	elseif msgcontains(msg, 'goshak donga') then
		npcHandler:playerSay(cid, "Maruk goshak ta?", 1)
		cidData.state = 108	
	elseif msgcontains(msg, 'goshak batuk') then
		npcHandler:playerSay(cid, "Ahhhh, maruk goshak batuk?", 1)
		cidData.state = 109
	elseif msgcontains(msg, 'goshak pixo') then
		npcHandler:playerSay(cid, "Maruk goshak tefar pixo ul batuk?", 1)
		cidData.state = 110
	elseif cidData.state == 101 and msgcontains(msg, 'mok') == true then
		if doPlayerRemoveMoney(cid, 25) then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2385)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end
	elseif cidData.state == 102 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 30) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2406)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end
	elseif cidData.state == 103 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 85) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2376)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end
	elseif cidData.state == 104 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 85) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2388)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end
	elseif cidData.state == 105 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 25) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2467)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end	
	elseif cidData.state == 106 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 90) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2484)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end	
	elseif cidData.state == 107 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 60) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2482)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end	
	elseif cidData.state == 108 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 65) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2511)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end	
	elseif cidData.state == 109 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 400) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2456)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end	
	elseif cidData.state == 110 and msgcontains(msg, 'mok') then
		if doPlayerRemoveMoney(cid, 30) == true then
			npcHandler:playerSay(cid, "Maruk rambo zambo!", 1)
			doPlayerAddItem(cid, 2544, 10)
			cidData.state = 806
		else
			npcHandler:playerSay(cid, "Maruk nixda!", 1)
			cidData.state = 806
		end

	end		
	return true
end

keywordHandler:addKeyword({'ikem'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ikem pashak porak, bata, dora. Ba goshak maruk?"})
keywordHandler:addKeyword({'goshak porak'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ikem pashak charcha, burka, burka bata, hakhak. Ba goshak maruk?"})
keywordHandler:addKeyword({'goshak bata'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ikem pashak aka bora, tulak bora, grofa. Ba goshak maruk?"})
keywordHandler:addKeyword({'goshak dora'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ikem pashak donga. Ba goshak maruk?"})
keywordHandler:addKeyword({'yes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "huh?"})
keywordHandler:addKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "huh?"})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())