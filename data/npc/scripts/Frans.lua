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

shopModule:addBuyableItem({'spellbook'}, 2175, 150)

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

keywordHandler:addKeyword({'spell rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell missile runes, explosive runes, field runes, wall runes, bomb runes and healing runes."})
keywordHandler:addKeyword({'missile rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you heavy magic missile runes and sudden death runes."})
keywordHandler:addKeyword({'explosive runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you great fireball runes and explosion runes."})
keywordHandler:addKeyword({'field runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you fire field runes, energy field runes, poison field runes and destroy field runes."})
keywordHandler:addKeyword({'wall rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you fire wall runes, energy wall runes and poison wall runes."})
keywordHandler:addKeyword({'bomb runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you firebomb runes."})
keywordHandler:addKeyword({'healing runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you ultimate healing runes."})

shopModule:addBuyableItem({'wand of cosmic energy'}, 2189, 2800)
shopModule:addBuyableItem({'wand of plague'}, 2188, 1500)
shopModule:addBuyableItem({'wand of dragonbreath'}, 2191, 400)
shopModule:addBuyableItem({'wand of vortex'}, 2190, 150)
shopModule:addBuyableItem({'moonlight rod'}, 2186, 400)
shopModule:addBuyableItem({'volcanic rod'}, 2185, 1500)
shopModule:addBuyableItem({'snakebite rod'}, 2182, 150)
shopModule:addBuyableItem({'quagmire rod'}, 2181, 2800)

keywordHandler:addKeyword({'wand of inferno'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, this wand contains magic far too powerful and we are afraid to store it here. I heard they have a few of these at the Edron academy though"})
keywordHandler:addKeyword({'tempest rod'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, this rod contains magic far too powerful and we are afraid to store it here. I heard they have a few of these at the Edron academy though."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if getPlayerStorageValue(cid, 999) == -1 and (msgcontains(msg, 'rod') or msgcontains(msg, 'wand')) then
		if isMage(cid) then
			doPlayerAddItem(cid,2190,1)
			doPlayerAddItem(cid,2182,1)
			npcHandler:playerSay(cid, 'Here\'s your wand and rod!', 1)
			setPlayerStorageValue(cid, 999, 1)

		else
			npcHandler:playerSay(cid, 'I\'m sorry, but you\'re not a mage!', 1)
		end
		cidData.state = 0

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

	elseif msgcontains(msg, 'rune') then
		npcHandler:playerSay(cid, "I sell blank runes and spell runes.", 1)
		cidData.state = 0
	end
	return true
end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a FRANS."})
keywordHandler:addKeyword({'frans'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Floating ReeeeAnimated Necromantic Seeeervant ... FRANS."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am selliiiing ruuuunes, wands, roooods and spellbooooooks."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorcerorssss, druidssss, they all come to ussss."})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorcerorssss, druidssss, they all come to ussss."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Is aaaall about magic more or lesssss, isn't it?"})
keywordHandler:addKeyword({'vladruc'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Heeee is the bossss. Better don't messss with him!"})
keywordHandler:addKeyword({'urghain'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Heeee is the bossss. Better don't messss with him!"})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Wouldn't he beeee the perfect FRANS?"})
keywordHandler:addKeyword({'market'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yes, that's a market heeeere, smarty ... Nice to seeeee I am not the only one without a braiiiin here."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We FRANSes don't liiiike any bugssss."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What do youuuu think I am? A lousy barberrrr? I'm selliiiing ruuuunes and spellboooooks."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What do youuuu think I am? A lousy barberrrr? I'm selliiiing ruuuunes and spellboooooks."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What do youuuu think I am? A lousy barberrrr? I'm selliiiing ruuuunes and spellboooooks."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What do youuuu think I am? A lousy barberrrr? I'm selliiiing ruuuunes and spellboooooks."})


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())