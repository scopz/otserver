-- This file is part of Jiddo's advanced NpcSystem v3.0x. This npcsystem is free to use by anyone, for any purpuse. 
-- Initial release date: 2007-02-21
-- Credits: Jiddo, honux(I'm using a modified version of his Find function).
-- Please include full credits whereever you use this system, or parts of it.
-- For support, questions and updates, please consult the following thread:
-- http://opentibia.net/topic/59592-release-advanced-npc-system-v30a/

if(NpcHandler == nil) then
	
	-- Constant talkdelay behaviors.
	TALKDELAY_NONE = 0 -- No talkdelay. Npc will reply immedeatly.
	TALKDELAY_ONTHINK = 1 -- Talkdelay handled through the onThink callback function. (Default)
	TALKDELAY_EVENT = 2 -- Not yet implemented
	
	-- Currently applied talkdelay behavior. TALKDELAY_ONTHINK is default.
	NPCHANDLER_TALKDELAY = TALKDELAY_ONTHINK
	
	
	
	-- Constant indexes for defining default messages.
	MESSAGE_GREET 		= 1 -- When the player greets the npc.
	MESSAGE_FAREWELL 	= 2 -- When the player unGreets the npc.
	MESSAGE_BUY 		= 3 -- When the npc asks the player if he wants to buy something.
	MESSAGE_SELL 		= 4 -- When the npc asks the player if he wants to sell something.
	MESSAGE_ONBUY 		= 5 -- When the player successfully buys something
	MESSAGE_ONSELL 		= 6 -- When the player successfully sells something
	MESSAGE_NEEDMOREMONEY = 7 -- When the player does not have enough money
	MESSAGE_NOTHAVEITEM = 8 -- When the player is trying to sell an item he does not have.
	MESSAGE_IDLETIMEOUT = 9 -- When the player has been idle for longer then idleTime allows.
	MESSAGE_WALKAWAY 	= 10 -- When the player walks out of the talkRadius of the npc.
	MESSAGE_ALREADYFOCUSED = 11 -- When the player already has the focus of this nopc.
	MESSAGE_PLACEDINQUEUE = 12 -- When the player has been placed in the costumer queue. 
	MESSAGE_DECLINE 	= 13 -- When the player sais no to something.
	
	-- Constant indexes for callback functions. These are also used for module callback ids.
	CALLBACK_CREATURE_APPEAR 	= 1
	CALLBACK_CREATURE_DISAPPEAR = 2
	CALLBACK_CREATURE_SAY 		= 3
	CALLBACK_ONTHINK 			= 4
	CALLBACK_GREET 				= 5
	CALLBACK_FAREWELL 			= 6
	CALLBACK_MESSAGE_DEFAULT 	= 7
	
	-- Addidional module callback ids
	CALLBACK_MODULE_INIT		= 10
	CALLBACK_MODULE_RESET		= 11
	
	
	-- Constant strings defining the keywords to replace in the default messages.
	TAG_PLAYERNAME = '|PLAYERNAME|'
	TAG_ITEMCOUNT = '|ITEMCOUNT|'
	TAG_TOTALCOST = '|TOTALCOST|'
	TAG_ITEMNAME = '|ITEMNAME|'
	TAG_QUEUESIZE = '|QUEUESIZE|'
	TAG_TIME = '|TIME|'
	TAG_TRAVELCOST = '|TRAVELCOST|'	
	
	NpcHandler = {
		keywordHandler = nil,
		idleTime = 30,
		talkRadius = 5,
		talkDelayTime = 1, -- Seconds to delay outgoing messages.
		talkDelay = nil,
		callbackFunctions = nil,
		modules = nil,
		messages = {
				-- These are the default replies of all npcs. They can/should be changed individually for each npc.
			[MESSAGE_GREET] 		= 'Welcome, |PLAYERNAME|! I have been expecting you.',
			[MESSAGE_FAREWELL] 		= 'Good bye, |PLAYERNAME|!',
			[MESSAGE_BUY] 			= 'Do you want to buy |ITEMCOUNT| |ITEMNAME| for |TOTALCOST| gold coins?',
			[MESSAGE_SELL] 			= 'Do you want to sell |ITEMCOUNT| |ITEMNAME| for |TOTALCOST| gold coins?',
			[MESSAGE_ONBUY] 		= 'It was a pleasure doing business with you.',
			[MESSAGE_ONSELL] 		= 'Thank you for this item, |PLAYERNAME|.',
			[MESSAGE_NEEDMOREMONEY] = 'You do not have enough money.',
			[MESSAGE_NOTHAVEITEM] 	= 'You don\'t even have that item!',
			[MESSAGE_IDLETIMEOUT] 	= 'Next please!',
			[MESSAGE_WALKAWAY] 		= 'How rude!',
			[MESSAGE_ALREADYFOCUSED]= '|PLAYERNAME|, I am already talking to you.',
			[MESSAGE_PLACEDINQUEUE] = '|PLAYERNAME|, please wait for your turn. There are |QUEUESIZE| customers before you.',
			[MESSAGE_DECLINE]		= 'Not good enough, is it?'
		}
	}
	
	
	-- Creates a new NpcHandler with an empty callbackFunction stack. 
	function NpcHandler:new(keywordHandler)
		local obj = {}
		obj.callbackFunctions = {}
		obj.modules = {}
		obj.talkDelay = {
				message = nil,
				time = nil
			}
		obj.messages = {}
		obj.focusList = {}
		obj.keywordHandler = keywordHandler
		keywordHandler.getLastNode = function(cid)
			if obj.focusList[cid] then
				return obj.focusList[cid].lastNode
			end
			return keywordHandler:getRoot()
		end
		keywordHandler.setLastNode = function(cid, lastNode)
			if obj.focusList[cid] then
				obj.focusList[cid].lastNode = lastNode
			end
		end
		setmetatable(obj.messages, self.messages)
		self.messages.__index = self.messages
		
		setmetatable(obj, self)
		self.__index = self
		return obj
	end




	
	-- Re-defines the maximum idle time allowed for a player when talking to this npc.
	function NpcHandler:setMaxIdleTime(newTime)
		self.idleTime = newTime
	end

	-- Function used to check if npc is focusing a player.
	function NpcHandler:hasFocus(cid)
		return self.focusList[cid] and true or false
	end

	-- Function used to focus a player
	function NpcHandler:addFocus(cid)
		sendFocus(cid)
		self.focusList[cid] = {
			talkStart = os.time(),
			state = 0,
			lastNode = self.keywordHandler:getRoot(),
		}
	end

	-- Function used to remove a focused player
	function NpcHandler:removeFocus(cid)
		sendFocusLost(cid)
		self.focusList[cid] = nil
	end

	-- Function used to focus a player
	function NpcHandler:getFocusPlayerData(cid)
		if self:hasFocus(cid) then
			return self.focusList[cid]
		end
		return nil
	end
	
	-- This function should be called on each onThink and makes sure the npc faces the player it is talking to.
	--	Should also be called whenever a new player is focused.
	function NpcHandler:updateFocus(cid)
		doNpcSetCreatureFocus(cid)
	end
	
	-- Used when the npc should un-focus the player. 
	function NpcHandler:releaseFocus(cid)
		self:removeFocus(cid)

		local keepFocus = false
		for player, _ in pairs(self.focusList) do
			self:updateFocus(player)
			keepFocus = true
			break
		end
		if not keepFocus then
			self:updateFocus(0)
		end
	end
	
	-- Returns the callback function with the specified id or nil if no such callback function exists.
	function NpcHandler:getCallback(id)
		local ret = nil
		if(self.callbackFunctions ~= nil) then
			ret = self.callbackFunctions[id]
		end
		return ret
	end
	
	-- Changes the callback function for the given id to callback.
	function NpcHandler:setCallback(id, callback)
		if(self.callbackFunctions ~= nil) then
			self.callbackFunctions[id] = callback
		end
	end
	
	-- Adds a module to this npchandler and inits it.
	function NpcHandler:addModule(module)
		if(self.modules ~= nil) then
			table.insert(self.modules, module)
			module:init(self)
		end
	end
	
	-- Calls the callback function represented by id for all modules added to this npchandler with the given arguments.
	function NpcHandler:processModuleCallback(id, ...)
		local ret = true
		for i, module in pairs(self.modules) do
			local tmpRet = true
			if(id == CALLBACK_CREATURE_APPEAR and module.callbackOnCreatureAppear ~= nil) then
				tmpRet = module:callbackCreatureAppear(unpack(arg))
				
			elseif(id == CALLBACK_CREATURE_DISAPPEAR and module.callbackOnCreatureDisappear ~= nil) then
				tmpRet = module:callbackCreatureDisappear(unpack(arg))
				
			elseif(id == CALLBACK_CREATURE_SAY and module.callbackOnCreatureSay ~= nil) then
				tmpRet = module:callbackCreatureSay(unpack(arg))
				
			elseif(id == CALLBACK_ONTHINK and module.callbackOnThink ~= nil) then
				tmpRet = module:callbackOnThink(unpack(arg))
				
			elseif(id == CALLBACK_GREET and module.callbackOnGreet ~= nil) then
				tmpRet = module:callbackOnGreet(unpack(arg))
				
			elseif(id == CALLBACK_FAREWELL and module.callbackOnFarewell ~= nil) then
				tmpRet = module:callbackOnFarewell(unpack(arg))
				
			elseif(id == CALLBACK_MESSAGE_DEFAULT and module.callbackOnMessageDefault ~= nil) then
				tmpRet = module:callbackOnMessageDefault(unpack(arg))
				
			elseif(id == CALLBACK_MODULE_RESET and module.callbackOnModuleReset ~= nil) then
				tmpRet = module:callbackOnModuleReset(unpack(arg))
			end
			if(not tmpRet) then
				ret = false
				break
			end
		end
		return ret
	end
	
	-- Returns the message represented by id.
	function NpcHandler:getMessage(id)
		local ret = nil
		if(self.messages ~= nil) then
			ret = self.messages[id]
		end
		return ret
	end
	
	-- Changes the default response message with the specified id to newMessage.
	function NpcHandler:setMessage(id, newMessage)
		if(self.messages ~= nil) then
			self.messages[id] = newMessage
		end
	end
	
	-- Translates all message tags found in msg using parseInfo
	function NpcHandler:parseMessage(msg, parseInfo)
		local ret = msg
		for search, replace in pairs(parseInfo) do
			ret = string.gsub(ret, search, replace)
		end
		return ret
	end
	
	-- Makes sure the npc un-focuses the furrently focused player, and greets the next player in the queue is it is not empty.
	function NpcHandler:unGreet(cid)
		if not self:hasFocus(cid) then
			return
		end
		local callback = self:getCallback(CALLBACK_FAREWELL)
		if(callback == nil or callback()) then
			if(self:processModuleCallback(CALLBACK_FAREWELL)) then
				local msg = self:getMessage(MESSAGE_FAREWELL)
				local parseInfo = { [TAG_PLAYERNAME] = getPlayerName(cid) }
				msg = self:parseMessage(msg, parseInfo)
				self:playerSay(cid, msg)
				self:releaseFocus(cid)
			end
		end
	end
	
	-- Greets a new player. 
	function NpcHandler:greet(cid)
		if(cid ~= 0) then
			local callback = self:getCallback(CALLBACK_GREET)
			if(callback == nil or callback(cid)) then
				if(self:processModuleCallback(CALLBACK_GREET, cid)) then
					local msg = self:getMessage(MESSAGE_GREET)
					local parseInfo = { [TAG_PLAYERNAME] = getPlayerName(cid) }
					msg = self:parseMessage(msg, parseInfo)
					self:playerSay(cid, msg)
				else
					return
				end
			else
				return
			end
		end
		self:addFocus(cid)
		self:updateFocus(cid)
	end
	
	-- Handles onCreatureAppear events. If you with to handle this yourself, please use the CALLBACK_CREATURE_APPEAR callback.
	function NpcHandler:onCreatureAppear(cid)
		local callback = self:getCallback(CALLBACK_CREATURE_APPEAR)
		if(callback == nil or callback(cid)) then
			if(self:processModuleCallback(CALLBACK_CREATURE_APPEAR, cid)) then
				
			end
		end
	end
	
	-- Handles onCreatureDisappear events. If you with to handle this yourself, please use the CALLBACK_CREATURE_DISAPPEAR callback.
	function NpcHandler:onCreatureDisappear(cid)
		local callback = self:getCallback(CALLBACK_CREATURE_DISAPPEAR)
		if(callback == nil or callback(cid)) then
			if(self:processModuleCallback(CALLBACK_CREATURE_DISAPPEAR, cid)) then
				if self:hasFocus(cid) then
					self:unGreet(cid)
				end
			end
		end
	end
	
	-- Handles onCreatureSay events. If you with to handle this yourself, please use the CALLBACK_CREATURE_SAY callback.
	function NpcHandler:onCreatureSay(cid, msgtype, msg)
		local callback = self:getCallback(CALLBACK_CREATURE_SAY)
		if(callback == nil or callback(cid, msgtype, msg)) then
			if(self:processModuleCallback(CALLBACK_CREATURE_SAY, cid, msgtype, msg)) then
				if not self:isInRange(cid) then
					return
				end
				if(self.keywordHandler ~= nil) then
					local ret = self.keywordHandler:processMessage(cid, msg)
					if(not ret) then
						local callback = self:getCallback(CALLBACK_MESSAGE_DEFAULT)
						if callback ~= nil and callback(cid, msgtype, msg) and self:hasFocus(cid) then
							self.focusList[cid].talkStart = os.time()
						end
					elseif self:hasFocus(cid) then
						self.focusList[cid].talkStart = os.time()
					end
				end
			end
		end
	end
	
	-- Handles onThink events. If you with to handle this yourself, please use the CALLBACK_ONTHINK callback.
	function NpcHandler:onThink()
		local callback = self:getCallback(CALLBACK_ONTHINK)
		if(callback == nil or callback()) then
			
			if(NPCHANDLER_TALKDELAY == TALKDELAY_ONTHINK and self.talkDelay.time ~= nil and self.talkDelay.message ~= nil and os.time() >= self.talkDelay.time) then
				if self.talkDelay.cid then
					playerSay(self.talkDelay.cid, self.talkDelay.message)
				else
					selfSay(self.talkDelay.message)
				end

				self.talkDelay.time = nil
				self.talkDelay.cid = nil
				self.talkDelay.message = nil
			end
			
			if(self:processModuleCallback(CALLBACK_ONTHINK)) then
				local walkAway = {}
				local ungreet = {}

				for cid, focus in pairs(self.focusList) do
					if not self:isInRange(cid) then
						table.insert(walkAway, cid)
					elseif os.time()-focus.talkStart > self.idleTime then
						table.insert(ungreet, cid)
					end
				end

				for _,cid in pairs(walkAway) do self:onWalkAway(cid) end
				for _,cid in pairs(ungreet) do self:unGreet(cid) end
			end
		end
	end
	
	-- Tries to greet the player iwth the given cid. This function does not override queue order, current focus etc.
	function NpcHandler:onGreet(cid)
		if(self:isInRange(cid)) then
			if self:hasFocus(cid) then
				local msg = self:getMessage(MESSAGE_ALREADYFOCUSED)
				local parseInfo = { [TAG_PLAYERNAME] = getPlayerName(cid) }
				msg = self:parseMessage(msg, parseInfo)
				self:playerSay(cid, msg)
			else
				self:greet(cid)
			end
		end
	end
	
	-- Simply calls the underlying unGreet function. 
	function NpcHandler:onFarewell(cid)
		self:unGreet(cid)
	end
	
	-- Should be called on this npc's focus if the distance to focus is greater then talkRadius.
	function NpcHandler:onWalkAway(cid)
		if self:hasFocus(cid) then
			local callback = self:getCallback(CALLBACK_CREATURE_DISAPPEAR)
			if(callback == nil or callback()) then
				if(self:processModuleCallback(CALLBACK_CREATURE_DISAPPEAR, cid)) then
					local msg = self:getMessage(MESSAGE_WALKAWAY)
					local parseInfo = { [TAG_PLAYERNAME] = getPlayerName(cid) }
					msg = self:parseMessage(msg, parseInfo)
					self:playerSay(cid, msg)
				end
				self:releaseFocus(cid)
			end
		end
	end
	
	-- Returns true if cid is within the talkRadius of this npc.
	function NpcHandler:isInRange(cid)
		local playerPos = getPlayerPosition(cid)
		if playerPos == LUA_ERROR or playerPos == LUA_NO_ERROR then
			return false
		end
		
		local sx = selfGetPosition().x
		local sy = selfGetPosition().y
		local sz = selfGetPosition().z
		
		local dx = math.abs(sx-playerPos.x)
		local dy = math.abs(sy-playerPos.y)
		local dz = math.abs(sz-playerPos.z)
		
		local dist = (dx^2 + dy^2)^0.5
		
		return (dist <= self.talkRadius and dz == 0)
	end
	
	-- Resets the npc into it's initial state (in regard of the keyrodhandler). 
	--	All modules are also receiving a reset call through their callbackOnModuleReset function.
	function NpcHandler:resetNpc(cid)
		if self:processModuleCallback(CALLBACK_MODULE_RESET) and self:hasFocus(cid) then
			self.focusList[cid].lastNode = self.keywordHandler:getRoot()
		end
	end
	
	
	-- Makes the npc represented by this instance of NpcHandler say something. 
	--	This implements the currently set type of talkdelay.
	--	shallDelay is a boolean value. If it is false, the message is not delayed. Default value is true.
	function NpcHandler:say(message, shallDelay)
		if(shallDelay == nil) then
			shallDelay = true
		end
		if(NPCHANDLER_TALKDELAY == TALKDELAY_NONE or shallDelay == false) then
			selfSay(message)
			return
		end
		self.talkDelay.message = message
		self.talkDelay.cid = false
		self.talkDelay.time = os.time()+self.talkDelayTime
	end


	-- Makes the npc represented by this instance of NpcHandler say something. 
	--	This implements the currently set type of talkdelay.
	--	shallDelay is a boolean value. If it is false, the message is not delayed. Default value is true.
	function NpcHandler:playerSay(cid, message, shallDelay)
		if(shallDelay == nil) then
			shallDelay = true
		end
		if(NPCHANDLER_TALKDELAY == TALKDELAY_NONE or shallDelay == false) then
			playerSay(cid, message)
			return
		end
		self.talkDelay.message = message
		self.talkDelay.cid = cid
		self.talkDelay.time = os.time()+self.talkDelayTime
	end
	

	function NpcHandler:startSelling(cid)
		if not self:isInRange(cid) then
			return false
		end

		selfSell(cid)
		return true
	end
end
