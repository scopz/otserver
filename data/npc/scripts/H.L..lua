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
	if getPlayerSex(cid) == 1 then
	npcHandler:setMessage(MESSAGE_GREET, "Hmmm. I buy weapons, armor, and other stuff. What do you want, ".. getPlayerName(cid) .."?")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "I don't serve brats. Sod off!")
	return false
	end
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

NpcPreset:mainWeaponShop(shopModule)
NpcPreset:mainArmorShop(shopModule)

NpcPreset:altWeaponShop(shopModule)
NpcPreset:altArmorShop(shopModule)

shopModule:addSellableItem({'ancient shield'}, 2532, 49)
shopModule:addSellableItem({'beholder shield'}, 2518, 79)
shopModule:addSellableItem({'black shield'}, 2529, 5)
shopModule:addSellableItem({'blessed shield'}, 2523, 650)
shopModule:addSellableItem({'bright sword'}, 2407, 280)
shopModule:addSellableItem({'broadsword'}, 2413, 10)
shopModule:addSellableItem({'combat knife'}, 2404, 1)
shopModule:addSellableItem({'copper shield'}, 2530, 10)
shopModule:addSellableItem({'crowbar'}, 2416, 1)
shopModule:addSellableItem({'crown armor'}, 2487, 210)
shopModule:addSellableItem({'crown helmet'}, 2491, 70)
shopModule:addSellableItem({'crown legs'}, 2488, 60)
shopModule:addSellableItem({'crown shield'}, 2519, 109)
shopModule:addSellableItem({'dark armor'}, 2489, 130)
shopModule:addSellableItem({'dark helmet'}, 2490, 40)
shopModule:addSellableItem({'dark shield'}, 2521, 60)
shopModule:addSellableItem({'demon armor'}, 2494, 195)
shopModule:addSellableItem({'demon helmet'}, 2493, 95)
shopModule:addSellableItem({'demon legs'}, 2495, 84)
shopModule:addSellableItem({'demon shield'}, 2520, 130)
shopModule:addSellableItem({'doublet'}, 2485, 1)
shopModule:addSellableItem({'dragon lance'}, 2414, 90)
shopModule:addSellableItem({'dragon scale legs'}, 2469, 180)
shopModule:addSellableItem({'dragon scale mail'}, 2492, 280)
shopModule:addSellableItem({'dragon shield'}, 2516, 115)
shopModule:addSellableItem({'fire axe'}, 2432, 280)
shopModule:addSellableItem({'fire sword'}, 2392, 335)
shopModule:addSellableItem({'giant sword'}, 2393, 100)
shopModule:addSellableItem({'golden armor'}, 2466, 580)
shopModule:addSellableItem({'golden helmet'}, 2471, 420)
shopModule:addSellableItem({'golden legs'}, 2470, 120)
shopModule:addSellableItem({'golden sickle'}, 2418, 10)
shopModule:addSellableItem({'great axe'}, 2415, 300)
shopModule:addSellableItem({'great shield'}, 2522, 480)
shopModule:addSellableItem({'griffin shield'}, 2533, 59)
shopModule:addSellableItem({'guardian halberd'}, 2427, 120)
shopModule:addSellableItem({'hatchet'}, 2388, 7)
shopModule:addSellableItem({'horned helmet'}, 2496, 155)
shopModule:addSellableItem({'ice rapier'}, 2396, 250)
shopModule:addSellableItem({'iron hammer'}, 2422, 9)
shopModule:addSellableItem({'katana'}, 2412, 8)
shopModule:addSellableItem({'knife'}, 2403, 1)
shopModule:addSellableItem({'knight armor'}, 2476, 140)
shopModule:addSellableItem({'knight axe'}, 2430, 2)
shopModule:addSellableItem({'knight legs'}, 2477, 130)
shopModule:addSellableItem({'legion helmet'}, 2480, 8)
shopModule:addSellableItem({'magic longsword'}, 2390, 460)
shopModule:addSellableItem({'magic plate armor'}, 2472, 720)
shopModule:addSellableItem({'magic sword'}, 2400, 350)
shopModule:addSellableItem({'mastermind shield'}, 2514, 550)
shopModule:addSellableItem({'naginata'}, 2426, 80)
shopModule:addSellableItem({'obsidian lance'}, 2425, 50)
shopModule:addSellableItem({'orcish axe'}, 2428, 12)
shopModule:addSellableItem({'ornamented shield'}, 2524, 45)
shopModule:addSellableItem({'poison dagger'}, 2411, 5)
shopModule:addSellableItem({'rose armor', 'noble armor'}, 2486, 140, 'noble armor')
shopModule:addSellableItem({'rose shield'}, 2527, 49)
shopModule:addSellableItem({'scale armor'}, 2483, 75)
shopModule:addSellableItem({'scimitar'}, 2419, 10)
shopModule:addSellableItem({'serpent sword'}, 2409, 15)
shopModule:addSellableItem({'sickle'}, 2405, 1)
shopModule:addSellableItem({'silver dagger'}, 2402, 1)
shopModule:addSellableItem({'silver mace'}, 2424, 2)
shopModule:addSellableItem({'soldier helmet'}, 2481, 16)
shopModule:addSellableItem({'stonecutter axe'}, 2431, 320)
shopModule:addSellableItem({'strange helmet'}, 2479, 55)
shopModule:addSellableItem({'studded armor'}, 2484, 18)
shopModule:addSellableItem({'studded helmet'}, 2482, 2)
shopModule:addSellableItem({'studded legs'}, 2468, 15)
shopModule:addSellableItem({'studded shield'}, 2526, 2)
shopModule:addSellableItem({'thunder hammer'}, 2421, 450)
shopModule:addSellableItem({'tower shield'}, 2528, 90)
shopModule:addSellableItem({'vampire shield'}, 2534, 119)
shopModule:addSellableItem({'war hammer'}, 2391, 90)
shopModule:addSellableItem({'warlord sword'}, 2408, 360)
shopModule:addSellableItem({'winged helmet'}, 2474, 320)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I buy all kinds of armory and weapons."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Won't tell you."})
keywordHandler:addKeyword({'h.l'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "That's me."})
keywordHandler:addKeyword({'snake eye'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Boss of the tavern. He's alright."})
keywordHandler:addKeyword({'boss'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Snake Eye isn't my boss."})
keywordHandler:addKeyword({'tavern'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Drink and eat there. What else do you do in a tavern!"})
keywordHandler:addKeyword({'brat'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Bah. Women are not good for fighting. I don't need them. And I don't like them."})
keywordHandler:addKeyword({'women'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Bah. Women are not good for fighting. I don't need them. And I don't like them."})
keywordHandler:addKeyword({'woman'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Bah. Women are not good for fighting. I don't need them. And I don't like them."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Forget the gods"})
keywordHandler:addKeyword({'durin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Forget Durin. He's the worst anyway."})
keywordHandler:addKeyword({'steve'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Forget Steve."})
keywordHandler:addKeyword({'guido'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Forget Guido."})
keywordHandler:addKeyword({'stephan'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Forget Stephan."})
keywordHandler:addKeyword({'cip'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Forget about Cip."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Tibia. At least there's one good place in Tibia. Here!"})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ha! Thais. I lived there. You know, I was in the royal army. But it's all wrong. I deserted."})
keywordHandler:addKeyword({'royal army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Good fighter training. But for the wrong cause."})
keywordHandler:addKeyword({'training'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yes. Good training."})
keywordHandler:addKeyword({'cause'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Don't want to talk about it."})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dwarfs are good people. I like them."})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I like them."})
keywordHandler:addKeyword({"ab'dendriel"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves. Hate them."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Might be a good place to live. But I'm afraid that the people are Thais friendly."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king should be dead."})
keywordHandler:addKeyword({'ruler'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Tibia doesn't need a ruler."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hang him."})
keywordHandler:addKeyword({'wild warior'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yeah. I'm a wild warrior. Well, to be honest, I left them. They became too aggressive. Attacking everyone is not good."})
keywordHandler:addKeyword({'camp'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Most people in the camp are no wild warriors."})
keywordHandler:addKeyword({'hideout'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I left the wild warriors, while we - well - they planned a new hideout."})
keywordHandler:addKeyword({'hid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Wild warriors have always something to hide."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's somewhere in the woods, of course. I don't know where."})
keywordHandler:addKeyword({'wood'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The woods are good to hide."})
keywordHandler:addKeyword({'traps'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Be careful out there."})
keywordHandler:addKeyword({'collapsed'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yes. That's why we - well - they planned a new hideout. But I think they left the vault in the old hideout."})
keywordHandler:addKeyword({'vault'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Good stuff in there, I think."})
keywordHandler:addKeyword({'stuff'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ahm. I don't know what it is. Sorry."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I buy nearly everything. Just ask."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, '') and getPlayerSex(cid) == 0 then
		npcHandler:playerSay(cid, "I don't serve brats. Sod off!", 1)
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif msgcontains(msg, 'talk') then
		npcHandler:playerSay(cid, "I said, I do not want to talk about it", 1)
		cidData.state = 1

	elseif cidData.state == 1 and msgcontains(msg, 'talk') then
		npcHandler:playerSay(cid, "Ok. Get lost!", 1)
		cidData.state = 0
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif msgcontains(msg, 'key') then
		KEYID = {2086, 2087, 2088, 2089, 2090, 2091, 2092}
		INUSE = getPlayerItemCount(cid, KEYID)
		if isInArray(INUSE, KEYID) == 1 then
			if INUSE.actionid >= 1 then
				npcHandler:playerSay(cid, "Oh. that's a new key. Hmmm. Must be for the new hideout.", 1)
			else
				npcHandler:playerSay(cid, "What key? Show me!", 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, "What key? Show me!", 1)
			cidData.state = 0
		end

	elseif msgcontains(msg, 'building') then
		npcHandler:playerSay(cid, "You mean our old building in the southwest?", 1)
		cidData.state = 2

	elseif cidData.state == 2 and msgcontains(msg, 'yes') then
		npcHandler:playerSay(cid, "That's the old hideout. It's interesting down there. Lots of security mechanics and traps. But it collapsed partly.", 1)
		cidData.state = 0
	elseif cidData.state == 2 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Sorry.", 1)
		cidData.state = 0

	elseif msgcontains(msg, 'mechanics') or msgcontains(msg, 'machines') then
		npcHandler:playerSay(cid, "Yes. Security doors driven by POWERFUL machines. But I have no idea how it works.", 1)
		cidData.state = 7

	elseif cidData.state == 7 and msgcontains(msg, 'broken') then
		npcHandler:playerSay(cid, "Hmmm. Let me think. I think, you need something big. And steel reinforced. A barrel, maybe.", 1)
		cidData.state = 0

	elseif cidData.state == 7 and msgcontains(msg, 'damaged') then
		npcHandler:playerSay(cid, "Hmmm. Let me think. I think, you need something big. And steel reinforced. A barrel, maybe.", 1)
		cidData.state = 0

	elseif cidData.state == 7 and msgcontains(msg, 'repair') then
		npcHandler:playerSay(cid, "Hmmm. Let me think. I think, you need something big. And steel reinforced. A barrel, maybe.", 1)
		cidData.state = 0

	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onCreatureSell(...)
	shopModule:sellItemToPlayer(unpack(arg))
end