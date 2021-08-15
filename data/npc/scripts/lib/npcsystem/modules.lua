-- This file is part of Jiddo's advanced NpcSystem v3.0x. This npcsystem is free to use by anyone, for any purpuse. 
-- Initial release date: 2007-02-21
-- Credits: Jiddo, honux(I'm using a modified version of his Find function).
-- Please include full credits whereever you use this system, or parts of it.
-- For support, questions and updates, please consult the following thread:
-- http://opentibia.net/topic/59592-release-advanced-npc-system-v30a/

if(Modules == nil) then
	
	-- default words for greeting and ungreeting the npc. Should be a talbe containing all such words.
	FOCUS_GREETWORDS = {'hi', 'hello'}
	FOCUS_FAREWELLWORDS = {'bye', 'farewell', 'cya'}
	
	-- The word for accepting/declining an offer. CAN ONLY CONTAIN ONE FIELD! Should be a teble with a single string value.
	SHOP_YESWORD = {'yes'}
	SHOP_NOWORD = {'no'}
	
	-- Pattern used to get the amount of an item a player wants to buy/sell.
	PATTERN_COUNT = '%d+'
	
	
	-- Constants used to separate buying from selling.
	SHOPMODULE_SELL_ITEM 	= 1
	SHOPMODULE_BUY_ITEM 	= 2
	
	
	Modules = {
			parseableModules = {}
		}
	
	
	StdModule = {
		
		}
	
	-- These callback function must be called with parameters.npcHandler = npcHandler in the parameters table or they will not work correctly.
	-- Notice: The members of StdModule have not yet been tested. If you find any bugs, please report them to me.
	
	-- Usage:
		-- keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell many powerful melee weapons.'})
	function StdModule.say(cid, message, keywords, parameters, node)
		local npcHandler = parameters.npcHandler
		if(npcHandler == nil) then
			error('StdModule.say called without any npcHandler instance.')
		end
		if not npcHandler:hasFocus(cid) and (parameters.onlyFocus == nil or parameters.onlyFocus == true) then
			return false
		end
		
		local cost, costMessage = parameters.cost, '%d gold coins'
		if cost and cost > 0 then
			if parameters.discount then
				cost = cost - StdModule.travelDiscount(cid, parameters.discount)
			end

			costMessage = cost > 0 and string.format(costMessage, cost) or 'free'
		else
			costMessage = 'free'
		end

		local parseInfo = {
				[TAG_PLAYERNAME] = getPlayerName(cid),
				[TAG_TIME] = getTibiaTime(),
				[TAG_TRAVELCOST] = costMessage,
			}
		msgout = npcHandler:parseMessage(parameters.text or parameters.message, parseInfo)
		npcHandler:playerSay(cid, msgout)
		if(parameters.reset == true) then
			npcHandler:resetNpc(cid)
		elseif(parameters.moveup ~= nil and type(parameters.moveup) == 'number') then
			npcHandler.keywordHandler:moveUp(cid, parameters.moveup)
		end
		return true
	end
	
	
	--Usage:
		-- local node1 = keywordHandler:addKeyword({'promot'}, StdModule.say, {npcHandler = npcHandler, text = 'I can promote you for 20000 gold coins. Do you want me to promote you?'})
		-- 		node1:addChildKeyword({'yes'}, StdModule.promotePlayer, {npcHandler = npcHandler, cost = 20000, level = 20}, text = 'Congratulations! You are now promoted.')
		-- 		node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Allright then. Come back when you are ready.'}, reset = true)
	function StdModule.promotePlayer(cid, message, keywords, parameters, node)
		
		local npcHandler = parameters.npcHandler
		if(npcHandler == nil) then
			error('StdModule.promotePlayer called without any npcHandler instance.')
		end
		if not npcHandler:hasFocus(cid) then
			return false
		end

		local oldVoc = getPlayerVocation(cid)
		local prom = getPromotedVocation(oldVoc);

		if oldVoc == 0 then
			npcHandler:playerSay(cid, 'You can\'t promote!')
		elseif(prom == 0) then
			npcHandler:playerSay(cid, 'You are already promoted!')
		elseif isPlayerPremiumCallback(cid) == false then
			npcHandler:playerSay(cid, 'You need a premium account in order to promote.')
		elseif(getPlayerLevel(cid) < parameters.level) then
			npcHandler:playerSay(cid, 'You need to be at least level ' .. parameters.level .. ' in order to be promoted.')
		elseif(doPlayerRemoveMoney(cid, parameters.cost) ~= true) then
			npcHandler:playerSay(cid, 'You do not have enough money!')
		else
			doPlayerSetVocation(cid, prom)
			doPlayerRemoveSkillLossPercent(cid, 30)
			doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_BLUE)
			npcHandler:playerSay(cid, parameters.text)
		end

		npcHandler:resetNpc(cid)
		return true
		
	end

	function StdModule.rebirthPlayer(cid, message, keywords, parameters, node)
		local npcHandler = parameters.npcHandler
		if(npcHandler == nil) then
			error('StdModule.promotePlayer called without any npcHandler instance.')
		end
		if not npcHandler:hasFocus(cid) then
			return false
		end

		npcHandler:playerSay(cid, 'You need to be at least level 100, and you will lose all your levels and skills. You\'ll need to start all over again. ' .. 
			'However, not everything is negative. Do you want to hear the positive part?')

		local node1 = node:addChildKeyword({'yes'}, function()
			if not npcHandler:hasFocus(cid) then return false end

			npcHandler:playerSay(cid, 'Once you reach to Tibia, you will develop as a stronger class. Also, and your lost skills can be recoved back once you reach a least level 110 again. '..
				'You can see this process as a sacrifice. All your equipment will be sent automatically to your depot. Did you understand?')

			return true;
		end, {})

		local node2 = node1:addChildKeyword({'yes'}, function()
			if not npcHandler:hasFocus(cid) then return false end

			npcHandler:playerSay(cid, 'This process is not easy either, it has a cost of 100000 gold coins. DO YOU WANT TO PROCEED?')

			return true;
		end, {})

		node2:addChildKeyword({'yes'}, function()
			if not npcHandler:hasFocus(cid) then return false end

			local oldVoc = getPlayerVocation(cid)
			local reb = getRebirthVocation(oldVoc)

			if oldVoc == 0 then
				npcHandler:playerSay(cid, 'You can\'t rebirth!')

			elseif reb == 0 then
				npcHandler:playerSay(cid, 'You are already reborn!')

			elseif not isPlayerPremiumCallback(cid) then
				npcHandler:playerSay(cid, 'You need a premium account in order to rebirth.')

			elseif getPlayerLevel(cid) < 110 then
				npcHandler:playerSay(cid, 'You need to be at least level 110 in order to be reborn.')

			elseif not doPlayerRemoveMoney(cid, 100000) then
				npcHandler:playerSay(cid, 'You do not have 100000 gold!')

			else
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
				if doPlayerRebirth(cid, reb) then
					doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
					setFirstItems(cid);
				end
				npcHandler:playerSay(cid, parameters.text)
				npcHandler:releaseFocus(cid)
			end

			return true;
		end, {})

		node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ok, then not.', reset = true})
		node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ok, then not.', reset = true})
		node2:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ok, then not.', reset = true})
		return true
	end


	function StdModule.recoverSkills(cid, message, keywords, parameters, node)
		local npcHandler = parameters.npcHandler
		if not npcHandler:hasFocus(cid) then
			return false
		end

		if not isReborn(cid) then
			npcHandler:playerSay(cid, 'You haven\'t lost anything yet...')
			return true
		end

		npcHandler:playerSay(cid, 'You will recover the skills you lost when you reborn, but this is not free... It will cost you exactly 50000 gold coins. Are you Sure?')

		node:addChildKeyword({'yes'}, function()
			if not npcHandler:hasFocus(cid) then return false end

			if not canRecoverSkills(cid) then
				npcHandler:playerSay(cid, 'You don\'t have anything to recover.')

			elseif not isPlayerPremiumCallback(cid) then
				npcHandler:playerSay(cid, 'You need a premium account in order to recover what you lost.')

			elseif getPlayerLevel(cid) < 110 then
				npcHandler:playerSay(cid, 'You need to be at least level 110 to recover your skills.')

			elseif not doPlayerRemoveMoney(cid, 50000) then
				npcHandler:playerSay(cid, 'You do not have 50000 gold!')

			else
				doPlayerRecoverSkills(cid)
				doSendMagicEffect(getCreaturePosition(cid), CONST_ME_MAGIC_RED)
				npcHandler:playerSay(cid, "Done. There you are.")
			end

			npcHandler:resetNpc(cid)
			return true;
		end, {})

		node:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ok, then not.', reset = true})
		return true
	end

	
	function StdModule.travel(cid, message, keywords, parameters, node)
		local npcHandler = parameters.npcHandler
		if(npcHandler == nil) then
			error('StdModule.travel called without any npcHandler instance.')
		end
		if not npcHandler:hasFocus(cid) then
			return false
		end
		
		local cost = parameters.cost
		if cost and cost > 0 then
			if parameters.discount then
				cost = cost - StdModule.travelDiscount(cid, parameters.discount)
				if cost < 0 then
					cost = 0
				end
			end
		else
			cost = 0
		end
		
		if(isPlayerPremiumCallback == nil or isPlayerPremiumCallback(cid) == true or parameters.premium == false) then
			if(parameters.level ~= nil and getPlayerLevel(cid) < parameters.level) then
				npcHandler:playerSay(cid, 'You must reach level ' .. parameters.level .. ' before I can let you go there.')
			elseif isPzLocked(cid) then
				npcHandler:playerSay(cid, "Get out of there with this blood.")	
			elseif(doPlayerRemoveMoney(cid, cost) ~= true) then
				npcHandler:playerSay(cid, 'You do not have enough money!')
			else
				doTeleportThing(cid, parameters.destination)
				doSendMagicEffect(parameters.destination, 10)
			end
		else
			npcHandler:playerSay(cid, 'I can only allow premium players to travel with me.')
		end
		
		npcHandler:resetNpc(cid)
		return true
	end
	
	
	
	FocusModule = {
			npcHandler = nil
		}
	
	-- Creates a new instance of FocusModule without an associated NpcHandler.
	function FocusModule:new()
		local obj = {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end
	
	-- Inits the module and associates handler to it.
	function FocusModule:init(handler)
		self.npcHandler = handler
		for i, word in pairs(FOCUS_GREETWORDS) do
			local obj = {}
			table.insert(obj, word)
			obj.callback = FOCUS_GREETWORDS.callback or FocusModule.messageMatcher
			handler.keywordHandler:addKeyword(obj, FocusModule.onGreet, {module = self})
		end
		
		for i, word in pairs(FOCUS_FAREWELLWORDS) do
			local obj = {}
			table.insert(obj, word)
			obj.callback = FOCUS_FAREWELLWORDS.callback or FocusModule.messageMatcher
			handler.keywordHandler:addKeyword(obj, FocusModule.onFarewell, {module = self})
		end
		
		return true
	end
	
	
	-- Greeting callback function.
	function FocusModule.onGreet(cid, message, keywords, parameters)
		parameters.module.npcHandler:onGreet(cid)
		return true
	end
	
	-- UnGreeting callback function.
	function FocusModule.onFarewell(cid, message, keywords, parameters)
		if parameters.module.npcHandler:hasFocus(cid) then
			parameters.module.npcHandler:onFarewell(cid)
			return true
		else
			return false
		end
	end
	
	-- Custom message matching callback function for greeting messages.
	function FocusModule.messageMatcher(keywords, message)
		for i, word in pairs(keywords) do
			if(type(word) == 'string') then
				if string.find(message, word) and not string.find(message, '[%w+]' .. word) and not string.find(message, word .. '[%w+]') then
					return true
				end
			end
		end
		return false
	end
	
	
	
	KeywordModule = {
		npcHandler = nil
	}
	-- Add it to the parseable module list.
	Modules.parseableModules['module_keywords'] = KeywordModule
	
	function KeywordModule:new()
		local obj = {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end
	
	function KeywordModule:init(handler)
		self.npcHandler = handler
		return true
	end
	
	-- Parses all known parameters.
	function KeywordModule:parseParameters()
		local ret = NpcSystem.getParameter('keywords')
		if(ret ~= nil) then
			self:parseKeywords(ret)
		end
	end
	
	function KeywordModule:parseKeywords(data)
		local n = 1
		for keys in string.gmatch(data, '[^;]+') do
			local i = 1
			
			local keywords = {}
			
			for temp in string.gmatch(keys, '[^,]+') do
				table.insert(keywords, temp)
				i = i+1
			end
			
			if(i ~= 1) then
				local reply = NpcSystem.getParameter('keyword_reply' .. n)
				if(reply ~= nil) then
					self:addKeyword(keywords, reply)
				else
					print('[Warning] NpcSystem:', 'Parameter \'' .. 'keyword_reply' .. n .. '\' missing. Skipping...')
				end
			else
				print('[Warning] NpcSystem:', 'No keywords found for keyword set #' .. n .. '. Skipping...')
			end
			n = n+1
		end
	end
	
	function KeywordModule:addKeyword(keywords, reply)
		self.npcHandler.keywordHandler:addKeyword(keywords, StdModule.say, {npcHandler = self.npcHandler, onlyFocus = true, text = reply, reset = true})
	end
	
	
	
	TravelModule = {
		npcHandler = nil,
		destinations = nil,
		yesNode = nil,
		noNode = nil,
	}
	-- Add it to the parseable module list.
	Modules.parseableModules['module_travel'] = TravelModule
	
	function TravelModule:new()
		local obj = {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end
	
	function TravelModule:init(handler)
		self.npcHandler = handler
		self.yesNode = KeywordNode:new(SHOP_YESWORD, TravelModule.onConfirm, {module = self})
		self.noNode = KeywordNode:new(SHOP_NOWORD, TravelModule.onDecline, {module = self})
		self.destinations = {}
		return true
	end
	
	-- Parses all known parameters.
	function TravelModule:parseParameters()
		local ret = NpcSystem.getParameter('travel_destinations')
		if(ret ~= nil) then
			self:parseDestinations(ret)
			
			self.npcHandler.keywordHandler:addKeyword({'destination'}, TravelModule.listDestinations, {module = self})
			self.npcHandler.keywordHandler:addKeyword({'where'}, TravelModule.listDestinations, {module = self})
			self.npcHandler.keywordHandler:addKeyword({'travel'}, TravelModule.listDestinations, {module = self})
			
		end
	end
	
	function TravelModule:parseDestinations(data)
		for destination in string.gmatch(data, '[^;]+') do
			local i = 1
			
			local name = nil
			local x = nil
			local y = nil
			local z = nil
			local cost = nil
			local premium = false
			
			
			for temp in string.gmatch(destination, '[^,]+') do
				if(i == 1) then
					name = temp
				elseif(i == 2) then
					x = tonumber(temp)
				elseif(i == 3) then
					y = tonumber(temp)
				elseif(i == 4) then
					z = tonumber(temp)
				elseif(i == 5) then
					cost = tonumber(temp)
				elseif(i == 6) then
					premium = temp == 'true'
				else
					print('[Warning] NpcSystem:', 'Unknown parameter found in travel destination parameter.', temp, destination)
				end
				i = i+1
			end
			
			if(name ~= nil and x ~= nil and y ~= nil and z ~= nil and cost ~= nil) then
				self:addDestination(name, {x=x, y=y, z=z}, cost, premium)
			else
				print('[Warning] NpcSystem:', 'Parameter(s) missing for travel destination:', name, x, y, z, cost, premium)
			end
		end
	end
	
	function TravelModule:addDestination(name, position, price, premium)
		table.insert(self.destinations, name)
		
		local parameters = {
				cost = price,
				destination = position,
				premium = premium,
				module = self
			}
		local keywords = {}
		table.insert(keywords, name)
		
		local keywords2 = {}
		table.insert(keywords2, 'bring me to ' .. name)
		local node = self.npcHandler.keywordHandler:addKeyword(keywords, TravelModule.travel, parameters)
		self.npcHandler.keywordHandler:addKeyword(keywords2, TravelModule.bringMeTo, parameters)
		node:addChildKeywordNode(self.noNode)
	end
	
	function TravelModule.travel(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		node:addChildKeywordNode(self.yesNode)
		
		local npcHandler = module.npcHandler
		
		
		local cost = parameters.cost
		local destination = parameters.destination
		local premium = parameters.premium
		
		module.npcHandler:playerSay(cid, 'Do you want to travel to ' .. keywords[1] .. ' for ' .. cost .. ' gold coins?')
		return true
		
	end
	
	function TravelModule.onConfirm(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		
		local npcHandler = module.npcHandler
		
		
		local parentParameters = node:getParent():getParameters()
		local cost = parentParameters.cost
		if cost and cost > 0 then
			if parameters.discount then
				cost = cost - StdModule.travelDiscount(cid, parameters.discount)
			end
		end
		local destination = parentParameters.destination
		local premium = parentParameters.premium
		
		if(isPlayerPremiumCallback == nil or isPlayerPremiumCallback(cid) == true or parameters.premium ~= true) then
			if isPzLocked(cid) then
				npcHandler:playerSay(cid, "Get out of there with this blood.")	
			elseif(doPlayerRemoveMoney(cid, cost) ~= true) then
				npcHandler:playerSay(cid, 'You do not have enough money!')
			else
				npcHandler:playerSay(cid, 'It was a pleasure doing business with you.', false)
				npcHandler:releaseFocus(cid)
				doTeleportThing(cid, destination)
				doSendMagicEffect(destination, 10)
			end
		else
			npcHandler:playerSay(cid, 'I can only allow premium players to travel there.')
		end
		
		npcHandler:resetNpc(cid)
		return true
	end
	
	-- onDecliune keyword callback function. Generally called when the player sais 'no' after wanting to buy an item. 
	function TravelModule.onDecline(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local parentParameters = node:getParent():getParameters()
		local parseInfo = {
				[TAG_PLAYERNAME] = getPlayerName(cid),
			}
		local msg = module.npcHandler:parseMessage(module.npcHandler:getMessage(MESSAGE_DECLINE), parseInfo)
		module.npcHandler:playerSay(cid, msg)
		module.npcHandler:resetNpc(cid)
		return true
	end
	
	function TravelModule.bringMeTo(cid, message, keywords, parameters, node)
		local module = parameters.module
		if module.npcHandler:hasFocus(cid) then
			return false
		end
		
		local cost = parameters.cost
		local destination = parameters.destination
		local premium = parameters.premium
		
		if(isPlayerPremiumCallback == nil or isPlayerPremiumCallback(cid) == true or parameters.premium ~= true) then
			if(doPlayerRemoveMoney(cid, cost) == true) then
				doTeleportThing(cid, destination)
				doSendMagicEffect(destination, 10)
			end
		end
		
		return true
	end
	
	function TravelModule.listDestinations(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		
		local msg = 'I can bring you to '
		--local i = 1
		local maxn = table.maxn(module.destinations)
		for i,destination in pairs(module.destinations) do
			msg = msg .. destination
			if(i == maxn-1) then
				msg = msg .. ' and '
			elseif(i == maxn) then
				msg = msg .. '.'
			else
				msg = msg .. ', '
			end
			i = i+1
		end
		
		module.npcHandler:playerSay(cid, msg)
		module.npcHandler:resetNpc(cid)
		return true
	end
	
	
	
	
	ShopModule = {
		yesNode = nil,
		noNode = nil,
		npcHandler = nil,
		noText = '',
		maxCount = 500,
		autosellConfirm = "Here you are.",
		autosellCancel = "You can't sell that.",
	}
	-- Add it to the parseable module list.
	Modules.parseableModules['module_shop'] = ShopModule
	
	-- Creates a new instance of ShopModule
	function ShopModule:new()
		local obj = {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end
	
	-- Parses all known parameters.
	function ShopModule:parseParameters()
		
		local ret = NpcSystem.getParameter('shop_sellable')
		if(ret ~= nil) then
			self:parseSellable(ret)
		end
		
		local ret = NpcSystem.getParameter('shop_buyable')
		if(ret ~= nil) then
			self:parseBuyable(ret)
		end
		
	end
	
	-- Parse a string contaning a set of buyable items.
	function ShopModule:parseBuyable(data)
		for item in string.gmatch(data, '[^;]+') do
			local i = 1
			
			local name = nil
			local itemid = nil
			local cost = nil
			local charges = nil
			
			for temp in string.gmatch(item, '[^,]+') do
				if(i == 1) then
					name = temp
				elseif(i == 2) then
					itemid = tonumber(temp)
				elseif(i == 3) then
					cost = tonumber(temp)
				elseif(i == 4) then
					charges = tonumber(temp)
				else
					print('[Warning] NpcSystem:', 'Unknown parameter found in buyable items parameter.', temp, item)
				end
				i = i+1
			end
			
			if(name ~= nil and itemid ~= nil and cost ~= nil) then
				if((isItemRune(itemid) == true or isItemFluidContainer(itemid) == true) and charges == nil) then
					print('[Warning] NpcSystem:', 'Charges missing for parameter item:' , item)
				else
					local names = {}
					table.insert(names, name)
					self:addBuyableItem(names, itemid, cost, charges)
				end
			else
				print('[Warning] NpcSystem:', 'Parameter(s) missing for item:', name, itemid, cost)
			end
		end
	end
	
	-- Parse a string contaning a set of sellable items.
	function ShopModule:parseSellable(data)
		for item in string.gmatch(data, '[^;]+') do
			local i = 1
			
			local name = nil
			local itemid = nil
			local cost = nil
			
			for temp in string.gmatch(item, '[^,]+') do
				if(i == 1) then
					name = temp
				elseif(i == 2) then
					itemid = tonumber(temp)
				elseif(i == 3) then
					cost = tonumber(temp)
				else
					print('[Warning] NpcSystem:', 'Unknown parameter found in sellable items parameter.', temp, item)
				end
				i = i+1
			end
			
			if(name ~= nil and itemid ~= nil and cost ~= nil) then
				local names = {}
				table.insert(names, name)
				self:addSellableItem(names, itemid, cost)
			else
				print('[Warning] NpcSystem:', 'Parameter(s) missing for item:', name, itemid, cost)
			end
		end
	end
	
	-- Initializes the module and associates handler to it.
	function ShopModule:init(handler)
		self.sellableItems = {}
		self.npcHandler = handler
		self.yesNode = KeywordNode:new(SHOP_YESWORD, ShopModule.onConfirm, {module = self})
		self.noNode = KeywordNode:new(SHOP_NOWORD, ShopModule.onDecline, {module = self})
		self.noText = handler:getMessage(MESSAGE_DECLINE)

		handler.keywordHandler:addKeyword({"sell items"}, ShopModule.startSellingTransaction, {module = self})
		
		return true
	end
	
	-- Resets the module-specific variables.
	function ShopModule:reset()
	end
	
	-- Function used to match a number value from a string.
	function ShopModule:getCount(message)
		local ret = 1
		local b, e = string.find(message, PATTERN_COUNT)
		if b ~= nil and e ~= nil then
			ret = tonumber(string.sub(message, b, e))
		end
		if(ret <= 0) then
			ret = 1
		elseif(ret > self.maxCount) then
			ret = self.maxCount
		end
		
		return ret
	end

	-- Start selling transaction with player
	function ShopModule.startSellingTransaction(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		module.npcHandler:startSelling(cid)
		return true
	end

	function ShopModule:sellItemToPlayer(cid, posX, posY, posZ, stackPos, itemId)
		if not self.npcHandler:hasFocus(cid) then
			return false
		end

		if self.sellableItems[itemId] ~= nil then 
			local ret = doPlayerSellItemByPosition(cid, posX, posY, posZ, stackPos, itemId, self.sellableItems[itemId])
			if(ret == LUA_NO_ERROR) then
				self.npcHandler:playerSay(cid, ShopModule.autosellConfirm, false)
			else
				self.npcHandler:playerSay(cid, ShopModule.autosellCancel, false)
			end
		else
			self.npcHandler:playerSay(cid, ShopModule.autosellCancel, false)
		end
	end
	
	-- Adds a new buyable item. 
	--	names = A table containing one or more strings of alternative names to this item.
	--	itemid = the itemid of the buyable item
	--	cost = the price of one single item with item id itemid ^^
	--	charges - The charges of each rune or fluidcontainer item. Can be left out if it is not a rune/fluidcontainer and no realname is needed. Default value is nil.
	--	realname - The real, full name for the item. Will be used as ITEMNAME in MESSAGE_ONBUY and MESSAGE_ONSELL if defined. Default value is nil (keywords[1]/names will be used)
	function ShopModule:addBuyableItem(names, itemid, cost, charges, realname)
		for i, name in pairs(names) do
			local parameters = {
					itemid = itemid,
					cost = cost,
					eventType = SHOPMODULE_BUY_ITEM,
					module = self
				}
			if(realname ~= nil) then
				parameters.realname = realname
			end
			if(isItemRune(itemid) == true or isItemFluidContainer(itemid) == true) then
				parameters.charges = charges
			end
			keywords = {}
			table.insert(keywords, name)
			local node = self.npcHandler.keywordHandler:addKeyword(keywords, ShopModule.tradeItem, parameters)
			node:addChildKeywordNode(self.yesNode)
			node:addChildKeywordNode(self.noNode)
		end
	end
	
	-- Adds a new sellable item. 
	--	names = A table containing one or more strings of alternative names to this item.
	--	itemid = the itemid of the buyable item
	--	cost = the price of one single item with item id itemid ^^
	--	realname - The real, full name for the item. Will be used as ITEMNAME in MESSAGE_ONBUY and MESSAGE_ONSELL if defined. Default value is nil (keywords[2]/names will be used)
	function ShopModule:addSellableItem(names, itemid, cost, realname)
		self.sellableItems[itemid] = cost
		for i, name in pairs(names) do
			local parameters = {
					itemid = itemid,
					cost = cost,
					eventType = SHOPMODULE_SELL_ITEM,
					module = self
				}
			if(realname ~= nil) then
				parameters.realname = realname
			end
			keywords = {}
			table.insert(keywords, 'sell')
			table.insert(keywords, name)
			local node = self.npcHandler.keywordHandler:addKeyword(keywords, ShopModule.tradeItem, parameters)
			node:addChildKeywordNode(self.yesNode)
			node:addChildKeywordNode(self.noNode)
		end
	end
	
	
	-- onModuleReset callback function. Calls ShopModule:reset()
	function ShopModule:callbackOnModuleReset()
		self:reset()
		
		return true
	end
	
	
	-- tradeItem callback function. Makes the npc say the message defined by MESSAGE_BUY or MESSAGE_SELL
	function ShopModule.tradeItem(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local count = module:getCount(message)
		local cidData = module.npcHandler:getFocusPlayerData(cid)
		cidData.amount = count
		local tmpName = nil
		local article = nil
		if count > 1 then
			tmpName = getItemDescriptions(parameters.itemid).plural
		else
			article = getItemDescriptions(parameters.itemid).article
			if(parameters.eventType == SHOPMODULE_SELL_ITEM) then
				tmpName = node:getKeywords()[2]
			elseif(parameters.eventType == SHOPMODULE_BUY_ITEM) then
				tmpName = node:getKeywords()[1]
			end
		end
		local parseInfo = {
				[TAG_PLAYERNAME] = getPlayerName(cid),
				[TAG_ITEMCOUNT] = article or cidData.amount,
				[TAG_TOTALCOST] = parameters.cost*cidData.amount,
				[TAG_ITEMNAME] = parameters.realname or tmpName
			}
		
		if(parameters.eventType == SHOPMODULE_SELL_ITEM) then
			local msg = module.npcHandler:getMessage(MESSAGE_SELL)
			msg = module.npcHandler:parseMessage(msg, parseInfo)
			module.npcHandler:playerSay(cid, msg)
		elseif(parameters.eventType == SHOPMODULE_BUY_ITEM) then
			local msg = module.npcHandler:getMessage(MESSAGE_BUY)
			msg = module.npcHandler:parseMessage(msg, parseInfo)
			module.npcHandler:playerSay(cid, msg)
		end
		
		return true
		
	end
	
	
	-- onConfirm keyword callback function. Sells/buys the actual item.
	function ShopModule.onConfirm(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)
		local parentParameters = node:getParent():getParameters()
		local parseInfo = {
				[TAG_PLAYERNAME] = getPlayerName(cid),
				[TAG_ITEMCOUNT] = cidData.amount,
				[TAG_TOTALCOST] = parentParameters.cost*cidData.amount,
				[TAG_ITEMNAME] = parentParameters.realname or node:getParent():getKeywords()[1]
			}
		
		if(parentParameters.eventType == SHOPMODULE_SELL_ITEM) then
			local ret = doPlayerSellItem(cid, parentParameters.itemid, cidData.amount, parentParameters.cost*cidData.amount)
			if(ret == LUA_NO_ERROR) then
				local msg = module.npcHandler:getMessage(MESSAGE_ONSELL)
				msg = module.npcHandler:parseMessage(msg, parseInfo)
				module.npcHandler:playerSay(cid, msg)
			else
				local msg = module.npcHandler:getMessage(MESSAGE_NOTHAVEITEM)
				msg = module.npcHandler:parseMessage(msg, parseInfo)
				module.npcHandler:playerSay(cid, msg)
			end
		elseif(parentParameters.eventType == SHOPMODULE_BUY_ITEM) then
			local ret = doPlayerBuyItem(cid, parentParameters.itemid, cidData.amount, parentParameters.cost*cidData.amount, parentParameters.charges)
			if(ret == LUA_NO_ERROR) then
				local msg = module.npcHandler:getMessage(MESSAGE_ONBUY)
				msg = module.npcHandler:parseMessage(msg, parseInfo)
				module.npcHandler:playerSay(cid, msg)
			else
				local msg = module.npcHandler:getMessage(MESSAGE_NEEDMOREMONEY)
				msg = module.npcHandler:parseMessage(msg, parseInfo)
				module.npcHandler:playerSay(cid, msg)
			end
		end
		
		module.npcHandler:resetNpc(cid)
		return true
	end
	
	-- onDecliune keyword callback function. Generally called when the player sais 'no' after wanting to buy an item. 
	function ShopModule.onDecline(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)
		local parentParameters = node:getParent():getParameters()
		local parseInfo = {
				[TAG_PLAYERNAME] = getPlayerName(cid),
				[TAG_ITEMCOUNT] = cidData.amount,
				[TAG_TOTALCOST] = parentParameters.cost*cidData.amount,
				[TAG_ITEMNAME] = parentParameters.realname or node:getParent():getKeywords()[1]
			}
		local msg = module.npcHandler:parseMessage(module.noText, parseInfo)
		module.npcHandler:playerSay(cid, msg)
		module.npcHandler:resetNpc(cid)
		return true
	end

	SpellSellModule = {
		yesNode = nil,
		noNode = nil,
		npcHandler = nil,
		spellsList = nil,

		askText = "Do you want to learn the spell '|ITEMNAME|' for |TOTALCOST| gold?",
		okText = "Here you are, you can find it in your spellbook now. Cast it by pronouncing '|SPELLWORDS|'.",
		alreadyKnownText = "You already know how to cast this spell. Just say '|SPELLWORDS|'.",
		mlevelFailText = "You must have at least magic level |SPELLMLEVEL| to learn this spell.",
		levelFailText = "You must have at least level |SPELLLEVEL| to learn this spell.",
		cantLearnText = "I am sorry but you can not learn this spell.",
		noText = "Maybe next time",
		conditionFailText = "Sorry, I can not teach you spells.",
		listPreText = "I sell",
		condition = function() return true end
	}
	-- Add it to the parseable module list.
	Modules.parseableModules['module_shop'] = SpellSellModule
	
	-- Creates a new instance of SpellSellModule
	function SpellSellModule:new()
		local obj = {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end
	
	-- Initializes the module and associates handler to it.
	function SpellSellModule:init(handler)
		self.npcHandler = handler
		self.spellsList = {}
		self.yesNode = KeywordNode:new(SHOP_YESWORD, SpellSellModule.onConfirm, {module = self})
		self.noNode = KeywordNode:new(SHOP_NOWORD, SpellSellModule.onDecline, {module = self})
		self.noText = handler:getMessage(MESSAGE_DECLINE)

		handler.keywordHandler:addKeyword({ 'spells' }, SpellSellModule.listSpell, {module = self})
		return true
	end
	
	-- Resets the module-specific variables.
	function SpellSellModule:reset()
		self.amount = 0
	end
	
	
	-- Adds a new buyable item. 
	--	names = A table containing one or more strings of alternative names to this item.
	--	itemid = the itemid of the buyable item
	--	cost = the price of one single item with item id itemid ^^
	--	charges - The charges of each rune or fluidcontainer item. Can be left out if it is not a rune/fluidcontainer and no realname is needed. Default value is nil.
	--	realname - The real, full name for the item. Will be used as ITEMNAME in MESSAGE_ONBUY and MESSAGE_ONSELL if defined. Default value is nil (keywords[1]/names will be used)
	function SpellSellModule:addSpellStock(spells)
		for i, name in pairs(spells) do
			local parameters = {
					name = name,
					module = self
				}

			keywords = {}
			table.insert(keywords, name:lower())
			table.insert(self.spellsList, name)

			local node = self.npcHandler.keywordHandler:addKeyword(keywords, SpellSellModule.buySpell, parameters)
			node:addChildKeywordNode(self.yesNode)
			node:addChildKeywordNode(self.noNode)
		end
	end
	
	
	-- onModuleReset callback function. Calls SpellSellModule:reset()
	function SpellSellModule:callbackOnModuleReset()
		self:reset()
		
		return true
	end
	
	
	-- tradeItem callback function. Makes the npc say the message defined by MESSAGE_BUY or MESSAGE_SELL
	function SpellSellModule.listSpell(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		module.npcHandler:playerSay(cid, module.listPreText .. " '" .. table.concat(module.spellsList, "', '") .. "'.")
		return true
	end

	-- tradeItem callback function. Makes the npc say the message defined by MESSAGE_BUY or MESSAGE_SELL
	function SpellSellModule.buySpell(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		if not module.condition(cid) then
			module.npcHandler:playerSay(cid, module.conditionFailText)
			return false
		end

		local spell = getInstantSpellInfoByName(cid, parameters.name)
		node.spell = spell
		node.playerName = getPlayerName(cid)

		local parseInfo = {
				[TAG_PLAYERNAME] = node.playerName,
				[TAG_TOTALCOST] = spell.price,
				[TAG_ITEMNAME] = spell.name,
				['|SPELLWORDS|'] = spell.words,
				['|SPELLMLEVEL|'] = spell.mlevel,
				['|SPELLLEVEL|'] = spell.level
			}

		if spell then
			found = true

			if spell.available==1 then
				local msg = module.npcHandler:parseMessage(module.askText, parseInfo)
				module.npcHandler:playerSay(cid, msg)
				return true

			elseif spell.known==1 then
				local msg = module.npcHandler:parseMessage(module.alreadyKnownText, parseInfo)
				module.npcHandler:playerSay(cid, msg)

			elseif getPlayerMagLevel(cid) < spell.mlevel then
				local msg = module.npcHandler:parseMessage(module.mlevelFailText, parseInfo)
				module.npcHandler:playerSay(cid, msg)

			elseif getPlayerLevel(cid) < spell.level then
				local msg = module.npcHandler:parseMessage(module.levelFailText, parseInfo)
				module.npcHandler:playerSay(cid, msg)

			else
				local msg = module.npcHandler:parseMessage(module.cantLearnText, parseInfo)
				module.npcHandler:playerSay(cid, msg)
			end

			return false
		end

		return true		
	end
	
	
	-- onConfirm keyword callback function. Sells/buys the actual item.
	function SpellSellModule.onConfirm(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		local parentNode = node:getParent()
		local spell = parentNode.spell

		local parseInfo = {
				[TAG_PLAYERNAME] = parentNode.playerName,
				[TAG_TOTALCOST] = spell.price,
				[TAG_ITEMNAME] = spell.name,
				['|SPELLWORDS|'] = spell.words
			}

		if spell.available then
			if doPlayerRemoveMoney(cid, spell.price) == true then
				playerLearnInstantSpell(cid, spell.name)
				doSendMagicEffect(getPlayerPosition(cid), 14)

				local msg = module.npcHandler:parseMessage(module.okText, parseInfo)
				module.npcHandler:playerSay(cid, msg)

			else
				local msg = module.npcHandler:getMessage(MESSAGE_NEEDMOREMONEY)
				msg = module.npcHandler:parseMessage(msg, parseInfo)
				module.npcHandler:playerSay(cid, msg)
			end
		end
		
		module.npcHandler:resetNpc(cid)
		return true
	end
	
	-- onDecliune keyword callback function. Generally called when the player sais 'no' after wanting to buy an item. 
	function SpellSellModule.onDecline(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local parentNode = node:getParent()
		local parseInfo = {
				[TAG_PLAYERNAME] = parentNode.playerName,
				[TAG_TOTALCOST] = parentNode.spell.price,
				[TAG_ITEMNAME] = parentNode.spell.name
			}
		local msg = module.npcHandler:parseMessage(module.noText, parseInfo)
		module.npcHandler:playerSay(cid, msg)
		module.npcHandler:resetNpc(cid)
		return true
	end



	OracleModule = {
		npcHandler = nil,
	}
	-- Add it to the parseable module list.
	
	-- Creates a new instance of OracleModule
	function OracleModule:new(premmy)
		local obj = {}
		self.premmy = premmy
		setmetatable(obj, self)
		self.__index = self
		return obj
	end

	-- Initializes the module and associates handler to it.
	function OracleModule:init(handler)
		self.npcHandler = handler

		local node1 = handler.keywordHandler:addKeyword({ 'yes' }, OracleModule.askTown, {module = self, premmy = self.premmy})

		if self.premmy then

			addCityNode(self, node1,'edron',        9, {x=33217, y=31814, z=8}, 'EDRON')
			addCityNode(self, node1,'ankrahmun',    6, {x=33194, y=32853, z=8}, 'ANKRAHMUN')
			addCityNode(self, node1,'port',         8, {x=32595, y=32745, z=7}, 'PORT HOPE')
			addCityNode(self, node1,'hope',         8, {x=32595, y=32745, z=7}, 'PORT HOPE')
			addCityNode(self, node1,'darashia',     7, {x=33215, y=32456, z=1}, 'DARASHIA')

		else

			addCityNode(self, node1,'carlin',       5, {x=32360, y=31782, z=7}, 'CARLIN')
			addCityNode(self, node1,'thais',        3, {x=32369, y=32241, z=7}, 'THAIS')
			addCityNode(self, node1,'venore',       4, {x=32957, y=32076, z=7}, 'VENORE')
			addCityNode(self, node1,'ab\'dendriel', 1, {x=32732, y=31634, z=7}, 'AB\'DENDRIEL')
			addCityNode(self, node1,'kazordoon',    2, {x=32649, y=31925, z=11}, 'KAZORDOON')

		end

		return true
	end

	function addCityNode(module, parentNode, keyword, townId, destinadion, town)
		local node = parentNode:addChildKeyword({keyword}, OracleModule.askVocation, {module = module, townId = townId, destination = destinadion, town = town})
		addVocationNode(module, node, 'sorcerer', 1, 'SORCERER')
		addVocationNode(module, node, 'druid',    2, 'DRUID')
		addVocationNode(module, node, 'paladin',  3, 'PALADIN')
		addVocationNode(module, node, 'knight',   4, 'KNIGHT')
		andConfirmNode(module, node)
	end

	function addVocationNode(module, parentNode, keyword, vocId, vocName)
		local node = parentNode:addChildKeyword({keyword}, OracleModule.chooseVocation, {module = module, vocId = vocId, vocName = vocName})
		andConfirmNode(module, node)
	end

	function andConfirmNode(module, parentNode)
		parentNode:addChildKeyword({'yes'}, OracleModule.onConfirm, {module = module})
		parentNode:addChildKeyword({'no'}, OracleModule.onCancel, {module = module})
	end
	
	
	-- tradeItem callback function. Makes the npc say the message defined by MESSAGE_BUY or MESSAGE_SELL
	function OracleModule.askTown(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		if parameters.premmy then
			module.npcHandler:playerSay(cid, 'IN WHICH TOWN DO YOU WANT TO LIVE: EDRON, ANKRAHMUN, PORT HOPE OR DARASHIA?')
		else
			module.npcHandler:playerSay(cid, 'IN WHICH TOWN DO YOU WANT TO LIVE: CARLIN, THAIS, VENORE, AB\'DENDRIEL OR KAZORDOON?')
		end

		return true
	end

	-- tradeItem callback function. Makes the npc say the message defined by MESSAGE_BUY or MESSAGE_SELL
	function OracleModule.askVocation(cid, message, keywords, parameters, node)
		local module = parameters.module

		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		local mustRebirth = getPlayerRebirthsTo(cid)

		if (mustRebirth>0) then
			local vocName = "DOOMCASTER"
			if mustRebirth==10     then vocName = "SAGE"
			elseif mustRebirth==11 then vocName = "TEMPLAR"
			elseif mustRebirth==12 then vocName = "GUARDIAN"
			end

			parameters.vocId = mustRebirth
			parameters.vocName = vocName
			parameters.rebirth = true

			module.npcHandler:playerSay(cid, 'IN ' .. parameters.town .. '! AND YOUR PROFESSION WILL BE ' .. vocName .. '! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!')
		else
			parameters.rebirth = false
			module.npcHandler:playerSay(cid, 'IN ' .. parameters.town .. '! AND WHAT PROFESSION HAVE YOU CHOSEN: KNIGHT, PALADIN, SORCERER, OR DRUID?')
		end

		return true
	end


	-- tradeItem callback function. Makes the npc say the message defined by MESSAGE_BUY or MESSAGE_SELL
	function OracleModule.chooseVocation(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		if node:getParent():getParameters().rebirth then
			return false
		end


		node:getParent():getParameters().vocId = parameters.vocId;
		node:getParent():getParameters().vocName = parameters.vocName;


		module.npcHandler:playerSay(cid, 'A ' .. parameters.vocName .. '! ARE YOU SURE? THIS DECISION IS IRREVERSIBLE!')

		return true
	end

	function OracleModule.onConfirm(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		local vocNode =	node:getParent()

		if not vocNode:getParameters().rebirth then
			vocNode = vocNode:getParent()
		end

		if not vocNode:getParameters().vocId then
			return false;
		end

		if getPlayerLevel(cid) < 8 then
			module.npcHandler:playerSay(cid, 'CHILD! COME BACK WHEN YOU HAVE GROWN UP!')

		else
			module.npcHandler:playerSay(cid, 'SO BE IT!')
			doPlayerSetVocation(cid,vocNode:getParameters().vocId)
			doPlayerSetTown(cid,vocNode:getParameters().townId)
			doTeleportThing(cid,vocNode:getParameters().destination)
			doSendMagicEffect(vocNode:getParameters().destination, CONST_ME_MAGIC_BLUE)

		end

		return true
	end

	function OracleModule.onCancel(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		module.npcHandler:playerSay(cid, 'COME BACK WHEN YOU ARE PREPARED TO FACE YOUR DESTINY!')
		return true
	end




	BankModule = {
		npcHandler = nil,

		balanceText = "Your account balance is |BALANCE| gold.",

		askChangeText = "How many |NAMECOINS| do you want to get?",
		askChangeDowngradeText = "How many |NAMEFROMCOINS| do you want to change to |NAMETOCOINS|?",
		changeCoinsConfirmText = "So I should change |AMOUNTFROMCOINS| of your |NAMEFROMCOINS| to |AMOUNTTOCOINS| |NAMETOCOINS| for you?",
		changeGoldOrCrystalText = "Do you want to change your platinum coins to gold or crystal?",
		okChangeText = "Here you are.",
		failChangeText = "You don't have money.",

		depositConfirmText = "Would you like to deposit |DEPOSITAMOUNT| gold?",
		askDepositPartialText = "How much would you like to deposit?",
		okDepositText = "You have added |DEPOSITAMOUNT| gold to your bank account.",
		failDepositText = "You don't have that money amount!",
		failNoMoneyDepositText = "You don't have money.",
		invalidDepositText = "I'm sorry, but you must give me an valid amount of how much you would like to deposit.",

		withdrawConfirmText = "Would you like to withdraw |WITHDRAWAMOUNT| gold?",
		askWithdrawPartialText = "How much would you like to withdraw?",
		okWithdrawText = "Here you are.",
		failWithdrawText = "There is not enough gold on your account.",
		failNoMoneyWithdrawText = "You don't have money on your bank account!",
		invalidWithdrawText = "I'm sorry, but you must give me a valid amount of how much you would like to withdraw.",

		transferConfirmText = 'Would you like to transfer |TRANSFERAMOUNT| gold to |SENDPLAYERNAME|?',
		askTransferPartialText = "Please tell me the amount of gold you would like to transfer.",
		askTransferMissingPlayerText = 'Who would you like transfer |TRANSFERAMOUNT| gold to?',
		okTransferText = "Very well. You have transferred |TRANSFERAMOUNT| gold to |SENDPLAYERNAME|.",
		failTransferNoPlayerText = 'This player does not exist.',
		failTransferRookText = 'You can not send money to Rookgaard!',
		failTransferYourselfText = 'You can not send money to yourself.',
		failTransferText = "There is not enough gold on your account.",

		GOLD_ID = 2148,
		PLATINUM_ID = 2152,
		CRYSTAL_ID = 2160,
	}
	-- Add it to the parseable module list.

	-- Creates a new instance of BankModule
	function BankModule:new()
		local obj = {}
		setmetatable(obj, self)
		self.__index = self
		return obj
	end

	-- Initializes the module and associates handler to it.
	function BankModule:init(handler)
		self.npcHandler = handler

		local changeNode = handler.keywordHandler:addKeyword({ 'balance' }, BankModule.showBalance, {module = self})

		local changeNode = handler.keywordHandler:addKeyword({ 'change' }, BankModule.initChange, {module = self})
		changeNode:addChildKeyword({""}, BankModule.manageChange, {module = self})

		local depositNode = handler.keywordHandler:addKeyword({ 'deposit' }, BankModule.initDeposit, {module = self})
		depositNode:addChildKeyword({""}, BankModule.manageDeposit, {module = self})

		local withdrawNode = handler.keywordHandler:addKeyword({ 'withdraw' }, BankModule.initWithdraw, {module = self})
		withdrawNode:addChildKeyword({""}, BankModule.manageWithdraw, {module = self})

		local transferNode = handler.keywordHandler:addKeyword({ 'transfer' }, BankModule.initTransfer, {module = self})
		transferNode:addChildKeyword({""}, BankModule.manageTransfer, {module = self})

		return true
	end

	function BankModule.showBalance(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end

		local msg = module.npcHandler:parseMessage(module.balanceText, {
			['|BALANCE|'] = getPlayerBalance(cid),
		})
		module.npcHandler:playerSay(cid, msg)
		return true
	end

	function BankModule.initChange(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		if msgcontains(message, 'change gold') then
			cidData.changeFrom = module.GOLD_ID
			cidData.changeTo = module.PLATINUM_ID
			cidData.amountFrom = nil
			cidData.amountTo = nil
			local msg = module.npcHandler:parseMessage(module.askChangeText, {
				['|NAMECOINS|'] = 'platinum coins',
			})
			module.npcHandler:playerSay(cid, msg)

		elseif msgcontains(message, 'change platinum') then
			cidData.changeFrom = module.PLATINUM_ID
			cidData.changeTo = nil
			cidData.amountFrom = nil
			cidData.amountTo = nil
			module.npcHandler:playerSay(cid, module.changeGoldOrCrystalText)

		elseif msgcontains(message, 'change crystal') then
			cidData.changeFrom = module.CRYSTAL_ID
			cidData.changeTo = module.PLATINUM_ID
			cidData.amountFrom = nil
			cidData.amountTo = nil
			local msg = module.npcHandler:parseMessage(module.askChangeDowngradeText, {
				['|NAMEFROMCOINS|'] = 'crystal coins',
				['|NAMETOCOINS|'] = 'platinum',
			})
			module.npcHandler:playerSay(cid, msg)

		else
			module.npcHandler:resetNpc(cid)
		end
		return true
	end

	function BankModule.manageChange(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		if not cidData.changeTo then
			if msgcontains(message, 'gold') then
				cidData.changeTo = module.GOLD_ID
				local msg = module.npcHandler:parseMessage(module.askChangeDowngradeText, {
					['|NAMEFROMCOINS|'] = 'platinum coins',
					['|NAMETOCOINS|'] = 'gold',
				})
				module.npcHandler:playerSay(cid, msg)


			elseif msgcontains(message, 'crystal') then
				cidData.changeTo = module.CRYSTAL_ID
				local msg = module.npcHandler:parseMessage(module.askChangeText, {
					['|NAMECOINS|'] = 'crystal coins',
				})
				module.npcHandler:playerSay(cid, msg)
			end
			return true


		elseif not cidData.amountFrom or not cidData.amountTo then

			local amount = getMoneyCount(message)

			if amount > 0 then
				if cidData.changeFrom == module.GOLD_ID then -- gold to platinum
					cidData.amountFrom = amount * 1000
					cidData.amountTo = amount

				elseif cidData.changeFrom == module.CRYSTAL_ID then -- crystal to platinum
					cidData.amountFrom = amount
					cidData.amountTo = amount * 1000

				elseif cidData.changeTo == module.GOLD_ID then -- platinum to gold
					cidData.amountFrom = amount
					cidData.amountTo = amount * 1000

				elseif cidData.changeTo == module.CRYSTAL_ID then -- platinum to crystal
					cidData.amountFrom = amount * 1000
					cidData.amountTo = amount
				end

				local msg = module.npcHandler:parseMessage(module.changeCoinsConfirmText, {
					['|AMOUNTFROMCOINS|'] = cidData.amountFrom,
					['|NAMEFROMCOINS|'] = cidData.changeFrom == module.GOLD_ID and "gold coins" or (cidData.changeFrom == module.CRYSTAL_ID and "crystal coins" or "platinum coins"),
					['|AMOUNTTOCOINS|'] = cidData.amountTo,
					['|NAMETOCOINS|'] = cidData.changeTo == module.GOLD_ID and "gold coins" or (cidData.changeTo == module.CRYSTAL_ID and "crystal coins" or "platinum coins"),
				})
				module.npcHandler:playerSay(cid, msg)
				cidData.amount = amount
				return true

			else
				module.npcHandler:playerSay(cid, module.invalidTransferText)
			end


		else
			if msgcontains(message, 'yes') then
				if doPlayerRemoveItem(cid, cidData.changeFrom, cidData.amountFrom) then
					doPlayerAddItem(cid, cidData.changeTo, cidData.amountTo)
					module.npcHandler:playerSay(cid, module.okChangeText)
				else
					module.npcHandler:playerSay(cid, module.failChangeText)
				end

			elseif msgcontains(message, 'no') then
				module.npcHandler:playerSay(cid, "Ok. We cancel", 1)
			else
				return true
			end
			cidData.amountFrom = nil
			cidData.amountTo = nil
			cidData.changeFrom = nil
			cidData.changeTo = nil

		end
		module.npcHandler:resetNpc(cid)
		return true
	end

	function BankModule.initDeposit(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		local amount = 0
		if msgcontains(message, ' all') then
			amount = getPlayerMoney(cid)
			if amount == 0 then
				module.npcHandler:playerSay(cid, module.failNoMoneyDepositText)
				module.npcHandler:resetNpc(cid)
				return true
			end
		else
			amount = getMoneyCount(message)
		end

		if amount > 0 then
			local msg = module.npcHandler:parseMessage(module.depositConfirmText, {
				['|DEPOSITAMOUNT|'] = amount
			})
			module.npcHandler:playerSay(cid, msg)
			cidData.amount = amount

		else
			module.npcHandler:playerSay(cid, module.askDepositPartialText)
			cidData.amount = nil
		end
		return true
	end

	function BankModule.manageDeposit(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		if not cidData.amount then
			local amount = 0
			if msgcontains(message, 'all') then
				amount = getPlayerMoney(cid)
				if amount == 0 then
					module.npcHandler:playerSay(cid, module.failNoMoneyDepositText)
					module.npcHandler:resetNpc(cid)
					return true
				end
			else
				amount = getMoneyCount(message)
			end

			if amount > 0 then
				local msg = module.npcHandler:parseMessage(module.depositConfirmText, {
					['|DEPOSITAMOUNT|'] = amount
				})
				module.npcHandler:playerSay(cid, msg)
				cidData.amount = amount
				return true

			else
				module.npcHandler:playerSay(cid, module.invalidDepositText)
			end


		else
			if msgcontains(message, 'yes') then
				if doPlayerDepositMoney(cid, cidData.amount) then
					local msg = module.npcHandler:parseMessage(module.okDepositText, {
						['|DEPOSITAMOUNT|'] = cidData.amount
					})
					module.npcHandler:playerSay(cid, msg, 1)

				else
					module.npcHandler:playerSay(cid, module.failDepositText, 1)
				end

			elseif msgcontains(message, 'no') then
				module.npcHandler:playerSay(cid, "Ok then.", 1)
			else
				return true
			end
			cidData.amount = nil
		end
		module.npcHandler:resetNpc(cid)
		return true
	end

	function BankModule.initWithdraw(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		local amount = 0
		if msgcontains(message, ' all') then
			amount = getPlayerBalance(cid)
			if amount == 0 then
				module.npcHandler:playerSay(cid, module.failNoMoneyWithdrawText)
				module.npcHandler:resetNpc(cid)
				return true
			end
		else
			amount = getMoneyCount(message)
		end

		if amount > 0 then
			local msg = module.npcHandler:parseMessage(module.withdrawConfirmText, {
				['|WITHDRAWAMOUNT|'] = amount
			})
			module.npcHandler:playerSay(cid, msg)
			cidData.amount = amount

		else
			module.npcHandler:playerSay(cid, module.askWithdrawPartialText)
			cidData.amount = nil
		end
		return true
	end

	function BankModule.manageWithdraw(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		if not cidData.amount then
			local amount = 0
			if msgcontains(message, 'all') then
				amount = getPlayerBalance(cid)
				if amount == 0 then
					module.npcHandler:playerSay(cid, module.failNoMoneyWithdrawText)
					module.npcHandler:resetNpc(cid)
					return true
				end
			else
				amount = getMoneyCount(message)
			end

			if amount > 0 then
				local msg = module.npcHandler:parseMessage(module.withdrawConfirmText, {
					['|WITHDRAWAMOUNT|'] = amount
				})
				module.npcHandler:playerSay(cid, msg)
				cidData.amount = amount
				return true

			else
				module.npcHandler:playerSay(cid, module.invalidWithdrawText)
			end


		else
			if msgcontains(message, 'yes') then
				if doPlayerWithdrawMoney(cid, cidData.amount) then
					module.npcHandler:playerSay(cid, module.okWithdrawText, 1)
				else
					module.npcHandler:playerSay(cid, module.failWithdrawText, 1)
				end

			elseif msgcontains(message, 'no') then
				module.npcHandler:playerSay(cid, "Ok then.", 1)
			else
				return true
			end
			cidData.amount = nil
		end

		module.npcHandler:resetNpc(cid)
		return true
	end

	function BankModule.initTransfer(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)

		local amount = getMoneyCount(message)
		if amount > 0 then
			cidData.amount = amount
			cidData.transferPlayer = nil

			local idxStart, idxEnd = string.find(message:lower(), ' to ')
			if idxEnd ~= nil then
				local name = string.sub(message, idxEnd+1)
				if name and #name > 0 then
					local transferPlayer = getPlayerGUIDByName(name)
					if transferPlayer > 0 then
						cidData.transferPlayer = {
							guid = transferPlayer,
							name = string.upper(string.sub(name, 0, 1)) .. string.sub(name, 2),
							message = name,
						}
					end
				end
			end

			local msg
			if cidData.transferPlayer then
				msg = module.npcHandler:parseMessage(module.transferConfirmText, {
					['|TRANSFERAMOUNT|'] = cidData.amount,
					['|SENDPLAYERNAME|'] = cidData.transferPlayer.name,
				})
			else
				msg = module.npcHandler:parseMessage(module.askTransferMissingPlayerText, {
					['|TRANSFERAMOUNT|'] = amount
				})
			end
			module.npcHandler:playerSay(cid, msg)

		else
			module.npcHandler:playerSay(cid, module.askTransferPartialText)
			cidData.amount = nil
			cidData.transferPlayer = nil
		end

		return true
	end

	function BankModule.manageTransfer(cid, message, keywords, parameters, node)
		local module = parameters.module
		if not module.npcHandler:hasFocus(cid) then
			return false
		end
		local cidData = module.npcHandler:getFocusPlayerData(cid)


		if not cidData.amount then
			local amount = getMoneyCount(message)

			if amount > 0 then
				local msg = module.npcHandler:parseMessage(module.askTransferMissingPlayerText, {
					['|TRANSFERAMOUNT|'] = amount
				})
				module.npcHandler:playerSay(cid, msg)
				cidData.amount = amount
				cidData.transferPlayer = nil
				return true

			else
				module.npcHandler:playerSay(cid, module.invalidTransferText)
			end


		elseif not cidData.transferPlayer then
			local transferPlayer = getPlayerGUIDByName(message)
			if transferPlayer > 0 then

				cidData.transferPlayer = {
					guid = transferPlayer,
					name = string.upper(string.sub(message, 0, 1)) .. string.sub(message, 2),
					message = message,
				}

				local msg = module.npcHandler:parseMessage(module.transferConfirmText, {
					['|TRANSFERAMOUNT|'] = cidData.amount,
					['|SENDPLAYERNAME|'] = cidData.transferPlayer.name,
				})
				module.npcHandler:playerSay(cid, msg, 1)
				return true

			else
				module.npcHandler:playerSay(cid, module.failTransferNoPlayerText, 1)
			end


		else
			if msgcontains(message, 'yes') then

				if getVocationByPlayerGUID(cidData.transferPlayer.guid) <= 0 then
					module.npcHandler:playerSay(cid, module.failTransferRookText, 1)

				elseif cidData.transferPlayer.guid == getPlayerGUIDByName(getPlayerName(cid)) then
					module.npcHandler:playerSay(cid, module.failTransferYourselfText, 1)

				elseif doPlayerTransferMoneyTo(cid, cidData.transferPlayer.message, cidData.amount) then
					local msg = module.npcHandler:parseMessage(module.okTransferText, {
						['|TRANSFERAMOUNT|'] = cidData.amount,
						['|SENDPLAYERNAME|'] = cidData.transferPlayer.name,
					})
					module.npcHandler:playerSay(cid, msg, 1)
				else
					module.npcHandler:playerSay(cid, module.failTransferText, 1)
				end

			elseif msgcontains(message, 'no') then
				module.npcHandler:playerSay(cid, "Ok then.", 1)
			else
				return true
			end
			cidData.amount = nil
			cidData.transferPlayer = nil
		end

		module.npcHandler:resetNpc(cid)
		return true
	end
end
