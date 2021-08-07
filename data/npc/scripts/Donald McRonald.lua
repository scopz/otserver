local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

	function FocusModule:init(handler)
	FOCUS_GREETSWORDS = {'hi', 'hello'}
	FOCUS_FAREWELLSWORDS = {'bye', 'farewell'}
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

function greetCallback(cid)
	if isDruid(cid) then
	npcHandler:setMessage(MESSAGE_GREET, "Hello, Druid ".. getPlayerName(cid) .."!")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "Hmmm, well, hello ".. getPlayerName(cid) .."!")
	return true
	end
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'wheat'}, 2694, 1)
shopModule:addBuyableItem({'cheese'}, 2696, 5)
shopModule:addBuyableItem({'carrot'}, 2684, 3)
shopModule:addBuyableItem({'corncob'}, 2686, 3)

keywordHandler:addKeyword({'weather'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Weather is good enough to work on the fields."})
keywordHandler:addKeyword({'crops'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I take care of our crops"})
keywordHandler:addKeyword({'crop'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is hard to grow but worth the effort."})
keywordHandler:addKeyword({'field'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My fields are enchanted by the druids and the wheat grows very quickly."})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The city is to the north."})
keywordHandler:addKeyword({'mill'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I somtimes have to bring the wheat there."})
keywordHandler:addKeyword({'spooked'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I dont know."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "King Tibianus is our king."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Frodo? He is a friend of mine."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He ignores us and we ignore him."})
keywordHandler:addKeyword({'bloodblade'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A general in the army."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Too noble to care about us."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hardly know him."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A blacksmith, eh?"})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A generous person."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "She has a good soul."})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you wheat, cheese, carrots, and corncobs."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you wheat, cheese, carrots, and corncobs."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you wheat, cheese, carrots, and corncobs."})
keywordHandler:addKeyword({'food'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Are you looking for food? I have wheat, cheese, carrots, and corn to sell. If you want to sell bread, talk to my wife, Sherry."})
keywordHandler:addKeyword({'bread'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "If you want to sell bread, talk to my wife, Sherry."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'bye') or msgcontains(msg, 'farewell') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "May Crunor bless you, Druid ".. getPlayerName(cid) .."!", 1)
		else
			npcHandler:playerSay(cid, "Yes, bye!", 1)
		end
		cidData.state = 0
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif msgcontains(msg, 'job') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "My wife and I run this farm as good as we can.", 1)
		else
			npcHandler:playerSay(cid, "I run a farm, what else?!", 1)
		end

	elseif msgcontains(msg, 'wife') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "Sherry is my beloved wife.", 1)
		else
			npcHandler:playerSay(cid, "Sherry is my wife.", 1)
		end

	elseif msgcontains(msg, 'donald') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "I was named Donald, like my grandfather.", 1)
		else
			npcHandler:playerSay(cid, "I am Donald.", 1)
		end

	elseif msgcontains(msg, 'farm') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "It's a hard but rewarding task to run this farm.", 1)
		else
			npcHandler:playerSay(cid, "It is my farm, yes.", 1)
		end

	elseif msgcontains(msg, 'time') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "My name is Donald McRonald, noble druid.", 1)
		else
			npcHandler:playerSay(cid, "Donald McRonald.", 1)
		end

	elseif msgcontains(msg, 'time') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "Unfortunately I can't help you with that, noble druid.", 1)
		else
			npcHandler:playerSay(cid, "Who cares?", 1)
		end

	elseif msgcontains(msg, 'muriel') then
		if isSorcerer(cid) then
			npcHandler:playerSay(cid, "I dont trust sorcerers like you.", 1)
		else
			npcHandler:playerSay(cid, "I dont trust sorcerers.", 1)
		end

	elseif msgcontains(msg, 'gregor') then
		if isKnight(cid) then
			npcHandler:playerSay(cid, "Knights like you always feel superior to us farmers.", 1)
		else
			npcHandler:playerSay(cid, "Knights always feel superior to us farmers.", 1)
		end

	elseif msgcontains(msg, 'marvik') then
		if isDruid(cid) then
			npcHandler:playerSay(cid, "Druids like you are a great help for us, they know much about nature.", 1)
		else
			npcHandler:playerSay(cid, "Druids are a great help for us, they know much about nature.", 1)
		end

	elseif msgcontains(msg, 'spider') then
		npcHandler:playerSay(cid, "I will give you 2 gold for every spider you bring me. But not a rotten spider that was already dead for some time. Do you have any with you?", 1)
		cidData.state = 2

	elseif cidData.state == 2 and msgcontains(msg, 'yes') then
		AMOUNTSPIDER = getPlayerItemCount(cid,2807)
		if AMOUNTSPIDER >= 1 then
			if doPlayerRemoveItem(cid, 2807, AMOUNTSPIDER) then
				doPlayerAddMoney(cid, AMOUNTSPIDER*2)
				npcHandler:playerSay(cid, "Here you are.", 1)
			end
		else
			npcHandler:playerSay(cid, "You have no spider that died recently.", 1)
		end
		cidData.state = 0

	elseif cidData.state == 2 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Hmpf.", 1)
		cidData.state = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())