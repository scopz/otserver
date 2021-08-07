dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

function greetCallback(cid)
	if getPlayerVocation(cid) >= 5 and getPlayerVocation(cid) <= 8 then
	npcHandler:setMessage(MESSAGE_GREET, "Welcome to my little garden, humble ".. getPlayerName(cid) .."!")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "Welcome to my little garden, adventurer ".. getPlayerName(cid) .."!")
	return true
	end	
end	

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addBuyableItem({'amulet of loss'}, 2173, 50000)
shopModule:addBuyableItem({'protection amulet'}, 2200, 700, 250)
shopModule:addBuyableItem({'broken amulet', 'amulet of life'}, 2196, 25000)

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Eremo, an old man who has seen many things."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I teach some spells, provide one of the five blessings, and sell some amulets."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I teach some spells, provide one of the five blessings, and sell some amulets."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I teach some spells, provide one of the five blessings, and sell some amulets."})
keywordHandler:addKeyword({'island'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have retired from my adventures to this place"})
keywordHandler:addKeyword({'isle'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have retired from my adventures to this place"})
keywordHandler:addKeyword({'garden'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have retired from my adventures to this place"})
keywordHandler:addKeyword({'adventure'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I explored dungeons, I walked through deserts, I sailed on the seas and climbed up on many a mountain."})
keywordHandler:addKeyword({'thing'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I explored dungeons, I walked through deserts, I sailed on the seas and climbed up on many a mountain."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A great world full of magic and wonder."})
keywordHandler:addKeyword({'amulet'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I've collected quite a few protection amulets, and some amulets of loss as well. Also, I'm interested in buying broken amulets."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)
	
	-- teleport
	if msgcontains(msg, 'teleport') or msgcontains(msg, 'pemaret') or msgcontains(msg, 'back') or msgcontains(msg, 'cormaya') or msgcontains(msg, 'edron') then
		npcHandler:playerSay(cid, 'Should I teleport you back to Pemaret?')
		cidData.state = 2
	elseif msgcontains(msg, 'yes') and cidData.state == 2 then
		npcHandler:playerSay(cid, 'Here you go!')
		doTeleportThing(cid, BOATPOS_CORMAYA)
		doSendMagicEffect(getCreaturePosition(cid), 10)
	elseif msgcontains(msg, 'no') and cidData.state == 2 then
		npcHandler:playerSay(cid, 'Maybe later.')
		cidData.state = 0
	end
	
	if msgcontains(msg, 'bless') then
		npcHandler:playerSay(cid, "There are five different blessings available in five sacred places. These blessings are: the spiritual shielding, the spark of the phoenix, the embrace of tibia, the fire of the suns and the wisdom of solitude.", 1)
		cidData.state = 0

	elseif msgcontains(msg, 'wisdom') or msgcontains(msg, 'solitude') then
		npcHandler:playerSay(cid, "I can provide you with the wisdom of solitude. But you will have to sacrifice 10.000 gold to receive it. Are you still interested?", 1)
		cidData.state = 1394


	elseif cidData.state == 1394 and msgcontains(msg, 'yes') then
		if doPlayerRemoveMoney(cid, 10000) == true then
			if doPlayerAddBless(cid, 4) == true then
				npcHandler:playerSay(cid, "So receive the wisdom of solitude, pilgrim", 1)
				doSendMagicEffect(getPlayerPosition(cid), 13)
				setPlayerStorageValue(cid, 30006, 1)
				cidData.state = 0		
			else
				doPlayerAddMoney(cid, 10000)
				npcHandler:playerSay(cid, "You already possess this blessing.", 1)
				cidData.state = 0			
			end
		else
			npcHandler:playerSay(cid, "Oh. You do not have enough money.", 1)
			cidData.state = 0	
		end
	
	elseif cidData.state == 1394 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Ok. Suits me.", 1)
		cidData.state = 0	
	
	elseif msgcontains(msg, 'phoenix') then
		npcHandler:playerSay(cid, "The spark of the phoenix is given by the dwarven priests of earth and fire in Kazordoon.", 1)
		cidData.state = 0
	
	elseif msgcontains(msg, 'embrace') then
		npcHandler:playerSay(cid, "The druids north of Carlin will provide you with the embrace of tibia.", 1)
		cidData.state = 0
		
	elseif msgcontains(msg, 'suns') then
		npcHandler:playerSay(cid, "You can ask for the blessing of the two suns in the suntower near Ab'Dendriel.", 1)
		cidData.state = 0
		
	elseif msgcontains(msg, 'wisdom') then
		npcHandler:playerSay(cid, "Talk to the hermit Eremo on the isle of Cormaya about this blessing.", 1)
		cidData.state = 0
		
	elseif msgcontains(msg, 'spiritual') then
		npcHandler:playerSay(cid, "You can ask for the blessing of spiritual shielding the whiteflower temple south of Thais.", 1)
		cidData.state = 0
	end
	
    return true
end



local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isPromoted(cid) end
spellSellModule.conditionFailText = "I am sorry, but you are not promoted yet."
spellSellModule.listPreText = "I can teach"
spellSellModule:addSpellStock({
	"Enchant Staff",
	"Challenge",
	"Wild Growth",
	"Conjure Power Bolt",
})


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())