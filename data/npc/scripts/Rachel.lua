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
	if isMage(cid) then
		if getPlayerSex(cid) == 1 then
			npcHandler:setMessage(MESSAGE_GREET, "Welcome back, brother ".. getPlayerName(cid) .."!")
		else
			npcHandler:setMessage(MESSAGE_GREET, "Welcome back, sister ".. getPlayerName(cid) .."!")
		end
		return true
	else
		npcHandler:setMessage(MESSAGE_GREET, "Welcome ".. getPlayerName(cid) .."! Whats your need?")
		return true
	end
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'talon'}, 2151, 320)

shopModule:addBuyableItem({'mana'}, 5099, 100)
shopModule:addBuyableItem({'life', 'health'}, 5098, 100)

shopModule:addBuyableItem({'life fluid'}, 2006, 60, 10, 'life fluid')
shopModule:addBuyableItem({'mana fluid'}, 2006, 55, 7, 'mana fluid')
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
keywordHandler:addKeyword({'healing runes'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you and ultimate healing runes."})
keywordHandler:addKeyword({'rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell blank runes and spell runes."})

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

	if msgcontains(msg, 'vial') or msgcontains(msg, 'deposit') or msgcontains(msg, 'flask') then
		npcHandler:playerSay(cid, "I will pay you 5 gold for every empty vial. Ok?", 1)
		cidData.state = 857
	elseif cidData.state == 857 and msgcontains(msg, 'yes') then
		if sellPlayerEmptyVials(cid) == true then
			npcHandler:playerSay(cid, "Here's your money!", 1)
		else
			npcHandler:playerSay(cid, "You don't have any empty vials!", 1)
		end
		cidData.state = 0
	end

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

	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the head alchemist of Carlin. I keep the secret recipies of our ancestors. Besides, I am selling mana and life fluids, spellbooks, wands, rods and runes."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the illusterous Rachel, of course."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Time is of no meaning to us sorcerers."})
keywordHandler:addKeyword({'wisdom'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Wisdom arises from patience."})
keywordHandler:addKeyword({'patience'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You have to free yourself from unpatience to learn the deeper secrets of magic."})
keywordHandler:addKeyword({'ancestor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We are a guild of old traditions and even older secrets."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Spells are the minor parts that make a sorcerer. To be one is a state of mind, not of a full spellbook."})
keywordHandler:addKeyword({'power'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Power is important, but it is just the way, not the ultimate goal."})
keywordHandler:addKeyword({'goal'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "This secrect will be taught you by life, not by me."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Your vocation is your profession. There are four vocations in Tibia: Sorcerers, paladins, knights, and druids."})
keywordHandler:addKeyword({'spells'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am too busy to teach you, ask in your guild about that."})



npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onCreatureSell(...)
	shopModule:sellItemToPlayer(unpack(arg))
end