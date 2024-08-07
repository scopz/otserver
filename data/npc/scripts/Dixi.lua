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
if getPlayerSex(cid) == 0 then
	npcHandler:setMessage(MESSAGE_GREET, "Hello, Mam. How may I help you, ".. getPlayerName(cid) ..".")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "Hello, Sir. How may I help you, ".. getPlayerName(cid) ..".")
	return true
	end
end	

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'dagger'}, 2379, 2)
shopModule:addSellableItem({'spear'}, 2389, 3)
shopModule:addSellableItem({'hand axe'}, 2380, 4)
shopModule:addSellableItem({'rapier'}, 2384, 5)
shopModule:addSellableItem({'axe'}, 2386, 7)
shopModule:addSellableItem({'hatchet'}, 2388, 25)
shopModule:addSellableItem({'sabre'}, 2385, 12)
shopModule:addSellableItem({'short sword'}, 2406, 10)
shopModule:addSellableItem({'sword'}, 2376, 25)
shopModule:addSellableItem({'mace'}, 2398, 30)
shopModule:addSellableItem({'doublet'}, 2485, 3)
shopModule:addSellableItem({'leather armor'}, 2467, 5)
shopModule:addSellableItem({'chain armor'}, 2464, 40)
shopModule:addSellableItem({'brass armor'}, 2465, 150)
shopModule:addSellableItem({'leather helmet'}, 2461, 3)
shopModule:addSellableItem({'chain helmet'}, 2458, 12)
shopModule:addSellableItem({'studded helmet'}, 2482, 20)
shopModule:addSellableItem({'wooden shield'}, 2512, 3)
shopModule:addSellableItem({'studded shield'}, 2526, 16)
shopModule:addSellableItem({'brass shield'}, 2511, 25)
shopModule:addSellableItem({'plate shield'}, 2510, 40)
shopModule:addSellableItem({'copper shield'}, 2530, 50)
shopModule:addSellableItem({'leather boots'}, 2643, 2)
shopModule:addSellableItem({'rope'}, 2120, 8)
shopModule:addBuyableItem({'spear'}, 2389, 10)
shopModule:addBuyableItem({'rapier'}, 2384, 15)
shopModule:addBuyableItem({'sabre'}, 2385, 25)
shopModule:addBuyableItem({'dagger'}, 2379, 5)
shopModule:addBuyableItem({'sickle'}, 2405, 8)
shopModule:addBuyableItem({'hand axe'}, 2380, 8)
shopModule:addBuyableItem({'axe'}, 2386, 20)
shopModule:addBuyableItem({'short sword'}, 2406, 30)
shopModule:addBuyableItem({'jacket'}, 2650, 10)
shopModule:addBuyableItem({'coat'}, 2651, 8)
shopModule:addBuyableItem({'doublet'}, 2485, 16)
shopModule:addBuyableItem({'leather armor'}, 2467, 25)
shopModule:addBuyableItem({'leather legs'}, 2649, 10)
shopModule:addBuyableItem({'leather helmet'}, 2461, 12)
shopModule:addBuyableItem({'studded helmet'}, 2482, 63)
shopModule:addBuyableItem({'chain helmet'}, 2458, 52)
shopModule:addBuyableItem({'wooden shield'}, 2512, 15)
shopModule:addBuyableItem({'studded shield'}, 2526, 50)
shopModule:addBuyableItem({'torch'}, 2050, 2)
shopModule:addBuyableItem({'bag'}, 1987, 4)
shopModule:addBuyableItem({'scroll'}, 1949, 5)
shopModule:addBuyableItem({'shovel'}, 2554, 10)
shopModule:addBuyableItem({'backpack'}, 1988, 10)
shopModule:addBuyableItem({'scythe'}, 2550, 12)
shopModule:addBuyableItem({'rope'}, 2120, 50)
shopModule:addBuyableItem({'fishing rod'}, 2580, 150)
shopModule:addBuyableItem({'worm'}, 3976, 1)

keywordHandler:addKeyword({'pick'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am sorry, an agent of Al Dee bought all our picks. Now he has a monopoly on them."})
keywordHandler:addKeyword({'club'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm sorry, we don't buy this."})
keywordHandler:addKeyword({'how are you'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am fine, thank you."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We're selling many things. Please have a look at the blackboards downstairs to see a list of our inventory."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm helping my grandfather Obi with this shop. Do you want to buy or sell anything?"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm Dixi."})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "If you need something, please let me know."})
keywordHandler:addKeyword({'stuff'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell equipment of all kinds. Please let me know if you need something."})
keywordHandler:addKeyword({'wares'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell weapons, shields, armor, helmets, and equipment. For what do you want to ask?"})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell weapons, shields, armor, helmets, and equipment. For what do you want to ask?"})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell spears, rapiers, sabres, daggers, hand axes, axes, and short swords. Just tell me what you want to buy."})
keywordHandler:addKeyword({'armor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell jackets, coats, doublets, leather armor, and leather legs. Just tell me what you want to buy."})
keywordHandler:addKeyword({'helmet'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell leather helmets, studded helmets, and chain helmets. Just tell me what you want to buy."})
keywordHandler:addKeyword({'shield'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell wooden shields and studded shields. Just tell me what you want to buy."})
keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We sell torches, bags, scrolls, shovels, picks, backpacks, sickles, scythes, ropes, fishing rods and worms. Just tell me what you want to buy."})
keywordHandler:addKeyword({'do you sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What do you need? We sell weapons, armor, helmets, shields, and equipment."})
keywordHandler:addKeyword({'do you have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What do you need? We sell weapons, armor, helmets, shields, and equipment."})
keywordHandler:addKeyword({'bolt'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm sorry, I don't have any in stock now."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is |TIME|."})

npcHandler:addModule(FocusModule:new())

function onCreatureSell(...)
	shopModule:sellItemToPlayer(unpack(arg))
end