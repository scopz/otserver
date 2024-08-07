dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'life crystal'}, 2177, 85)
shopModule:addSellableItem({'mind stone'}, 2178, 170)
shopModule:addSellableItem({'crystal ball'}, 2192, 190)
shopModule:addBuyableItem({'life ring'}, 2168, 900)
shopModule:addBuyableItem({'crystal ball'}, 2192, 530)

shopModule:addBuyableItem({'blank rune','blankrune'}, 2260, 10)
shopModule:addBuyableItem({'destroy field rune'}, 2261, 15)
shopModule:addBuyableItem({'energy field rune'}, 2277, 38)
shopModule:addBuyableItem({'energy wall rune'}, 2279, 85)
shopModule:addBuyableItem({'explosion rune','explosion'}, 2313, 64)
shopModule:addBuyableItem({'fire bomb rune'}, 2305, 118)
shopModule:addBuyableItem({'fire field rune'}, 2301, 28)
shopModule:addBuyableItem({'fire wall rune'}, 2303, 62)
shopModule:addBuyableItem({'great fireball rune','gfb'}, 2304, 45)
shopModule:addBuyableItem({'heavy magic missile rune','hmm'}, 2311, 24)
shopModule:addBuyableItem({'poison field rune'}, 2285, 22)
shopModule:addBuyableItem({'poison wall rune'}, 2289, 52)
shopModule:addBuyableItem({'sudden death rune','sd'}, 2268, 325)
shopModule:addBuyableItem({'ultimate healing rune', 'uh'}, 2273, 175)
shopModule:addBuyableItem({'desintegrate rune'}, 2310, 26)
shopModule:addBuyableItem({'poison bomb rune'}, 2286, 128)
shopModule:addBuyableItem({'energy bomb rune'}, 2262, 162)
shopModule:addBuyableItem({'magic wall rune'}, 2293, 88)

keywordHandler:addKeyword({'spell rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell missile runes, explosive runes, field runes, wall runes, bomb runes and healing runes."})
keywordHandler:addKeyword({'missile rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you heavy magic missile runes and sudden death runes."})
keywordHandler:addKeyword({'explosive runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you fireball runes, great fireball runes, fireball runes and explosion runes."})
keywordHandler:addKeyword({'field runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you fire field runes, energy field runes, poison field runes, destroy field runes and desintegrate runes."})
keywordHandler:addKeyword({'wall rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you fire wall runes, energy wall runes, poison wall runes and magic wall runes."})
keywordHandler:addKeyword({'bomb runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you firebomb runes, poison bomb runes and energy bomb runes."})
keywordHandler:addKeyword({'healing runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you ultimate healing runes."})
keywordHandler:addKeyword({'rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell blank runes and spell runes."})

shopModule:addBuyableItem({'wand of cosmic energy'}, 2189, 2800)
shopModule:addBuyableItem({'wand of plague'}, 2188, 1500)
shopModule:addBuyableItem({'wand of dragonbreath'}, 2191, 400)
shopModule:addBuyableItem({'wand of vortex'}, 2190, 150)
shopModule:addBuyableItem({'moonlight rod'}, 2186, 400)
shopModule:addBuyableItem({'volcanic rod'}, 2185, 1500)
shopModule:addBuyableItem({'snakebite rod'}, 2182, 150)
shopModule:addBuyableItem({'quagmire rod'}, 2181, 2800)
shopModule:addBuyableItem({'tempest rod'}, 2183, 15000)
shopModule:addBuyableItem({'wand of inferno'}, 2187, 15000)

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)

	local cidData = npcHandler:getFocusPlayerData(cid)

	if getPlayerStorageValue(cid, 999) == -1 and msgcontains(msg, 'rod') or getPlayerStorageValue(cid, 999) == -1 and msgcontains(msg, 'wand') then
		if getPlayerStorageValue(cid, 999) == -1 then
		if isMage(cid) then
			doPlayerAddItem(cid,2190,1)
			doPlayerAddItem(cid,2182,1)
			npcHandler:playerSay(cid, 'Here\'s your wand and rod!', 1)
			setPlayerStorageValue(cid, 999, 1)

		else
			npcHandler:playerSay(cid, 'I\'m sorry, but you\'re not a mage!', 1)
			setPlayerStorageValue(cid, 999, 1)
		end
		cidData.state = 0
	end

	elseif msgcontains(msg, 'rod') then
		npcHandler:playerSay(cid, "Rods can be wielded by mages only and have a certain level requirement. There are five different rods, would you like to hear about them?", 1)
		cidData.state = 7613

	elseif cidData.state == 7613 and msgcontains(msg, 'yes') then
		npcHandler:playerSay(cid, "The names of the rods are 'Snakebite Rod', 'Moonlight Rod', 'Volcanic Rod', 'Quagmire Rod', and 'Tempest Rod'. Which one would you like to buy?", 1)
		cidData.state = 7613

	elseif msgcontains(msg, 'wand') then
		npcHandler:playerSay(cid, "Wands can be wielded by mages only and have a certain level requirement. There are five different wands, would you like to hear about them?", 1)
		cidData.state = 7624

	elseif cidData.state == 7624 and msgcontains(msg, 'yes') then
		npcHandler:playerSay(cid, "The names of the wands are 'Wand of Vortex', 'Wand of Dragonbreath', 'Wand of Plague', 'Wand of Cosmic Energy' and 'Wand of Inferno'. Which one would you like to buy?", 1)
		cidData.state = 7624

	end
    return true
end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Alexander."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I trade with runes and other magic items."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king has not much interest in magic items as far as I know."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king has not much interest in magic items as far as I know."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The army uses weapons and armor rather then items of magic."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A hero has to be well prepared to face this threat."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ah, I would trade a fortune for this fabulous item."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am glad the king founded this academy far away from the mundane troubles of Thais"})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The world is filled with wonderous places and items."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I heard it's a city of druids."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "In our town, science and arts are thriving."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ask for news and rumors in the tavern."})
keywordHandler:addKeyword({'rumo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ask for news and rumors in the tavern."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling runes, life rings, wands, rods and crystal balls."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling runes, life rings, wands, rods and crystal balls."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling runes, life rings, wands, rods and crystal balls."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling runes, life rings, wands, rods and crystal balls."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's |TIME| right now."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onCreatureSell(...)
	shopModule:sellItemToPlayer(unpack(arg))
end