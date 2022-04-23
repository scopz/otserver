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

	if msgcontains(msg, 'vial') or msgcontains(msg, 'deposit') or msgcontains(msg, 'flask') then
		npcHandler:playerSay(cid, "I will pay you 5 gold for every empty vial. Ok?", 1)
		cidData.state = 857
	elseif cidData.state == 857 and msgcontains(msg, 'yes') then
		if sellPlayerEmptyVials(cid) == true then
			npcHandler:playerSay(cid, "Here's your money!", 1)
			cidData.state = 0
		else
			npcHandler:playerSay(cid, "You don't have any empty vials!", 1)
			cidData.state = 0
		end
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

	elseif  msgcontains(msg, 'darama') then
		npcHandler:playerSay(cid, 'Although our people, spoken in cosmological terms, have setteled here just recently, there is already much history hidden here. ...', 1)
		npcHandler:playerSay(cid, "Not only mysteries and magical secrets but also many treasures are here to be explored by that person that is equipped with enough runes and fluids to master all dangers.", 5)
		cidData.state = 0
	end

	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am selling items of magic power such as runes, wands, rods, life fluids and mana fluids."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Tandros the magnificent."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is a crime against the order of things to try measuring time. The very thought of squeezing the majesty of centuries and centuries into a puny mechanical device is blasphemy."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our king is a worldly one. But if you buy enough of my fluids and runes you might become the king of magic one day."})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Technically I am an employee of those trade barons of Venore but of course no one can control my magnificent mind."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is so crowded and people there are always busy. I dare to say that this is a city that has lost its magic at some point."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I heard there are many druids that are quite influential. They should know how to keep the magic of a place alive. I am looking forward to travel there one day."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Edron is rumoured to be a place of ancient mysteries and powerful magic."})
keywordHandler:addKeyword({'jungle'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The magic is out there somewhere."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The world is full of magic that is waiting to be used ... perhaps by you! Take the first step by buying my wares to gather even more magic power for yourself."})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dwarves have little love for magic. That makes them quite suspicious, doesn't it?"})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dwarves have little love for magic. That makes them quite suspicious, doesn't it?"})
keywordHandler:addKeyword({'dwarves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dwarves have little love for magic. That makes them quite suspicious, doesn't it?"})
keywordHandler:addKeyword({"ab'dendriel"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves are such marvelous, mythic creatures. They are full of magic."})
keywordHandler:addKeyword({'elf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves are such marvelous, mythic creatures. They are full of magic."})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves are such marvelous, mythic creatures. They are full of magic."})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "An unremarkable little town, but riding there by carpet is pure magic."})
keywordHandler:addKeyword({'ankrahmun'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A city that breathes evil and dark magic. Stay away or be at least well prepared if you intend to visit the city of the dead."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He might be evil, but his powers are unimaginable! To stand a chance against evil overlords like him, you have to buy loads of my runes and fluids."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A weapon of unparalleled magic. Don't listen to people that tell you that this is only a myth. It might be a dream but remember, dreams can come true."})
keywordHandler:addKeyword({'ape'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are attacking travellers and even our settlement now and then. What can be a better way for you to survive than by preparing yourself well and to buy enough fluids and runes?"})
keywordHandler:addKeyword({'lizard'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The lizards live far away on the other side of the dangerous jungle. If you want to go there to learn more about their secrets, I strongly advise you to supply yourself with runes and fluids."})
keywordHandler:addKeyword({'dworc'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The dworcs are fierce enemies and the poison they use is lethal. If you don't have some fluids and runes with you, you are easy prey to them."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling life and mana fluids, runes, wands, rods and spellbooks."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling life and mana fluids, runes, wands, rods and spellbooks."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling life and mana fluids, runes, wands, rods and spellbooks."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm selling life and mana fluids, runes, wands, rods and spellbooks."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())