dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

shopModule:addSellableItem({'mace'}, 2398, 23)
shopModule:addSellableItem({'dagger'}, 2379, 1)
shopModule:addSellableItem({'carlin sword'}, 2395, 118)
shopModule:addSellableItem({'club'}, 2382, 1)
shopModule:addSellableItem({'spear'}, 2389, 1)
shopModule:addSellableItem({'rapier'}, 2384, 3)
shopModule:addSellableItem({'sabre'}, 2385, 5)
shopModule:addSellableItem({'battle axe'}, 2378, 75)
shopModule:addSellableItem({'battle hammer'}, 2417, 50)
shopModule:addSellableItem({'morning star'}, 2394, 100)
shopModule:addSellableItem({'two handed sword'}, 2377, 190)
shopModule:addSellableItem({'halberd'}, 2381, 310)
shopModule:addSellableItem({'double axe'}, 2387, 260)
shopModule:addSellableItem({'war hammer'}, 2391, 470)
shopModule:addSellableItem({'longsword'}, 2397, 51)
shopModule:addSellableItem({'spike sword'}, 2383, 225)
shopModule:addSellableItem({'fire sword'}, 2392, 1000)
shopModule:addSellableItem({'sword'}, 2376, 15)
shopModule:addBuyableItem({'royal spear'}, 5092, 25)
shopModule:addBuyableItem({'spear'}, 2389, 10)
shopModule:addBuyableItem({'rapier'}, 2384, 15)
shopModule:addBuyableItem({'sabre'}, 2385, 35)
shopModule:addBuyableItem({'battle axe'}, 2378, 235)
shopModule:addBuyableItem({'battle hammer'}, 2417, 350)
shopModule:addBuyableItem({'morning star'}, 2394, 430)
shopModule:addBuyableItem({'two handed sword'}, 2377, 950)
shopModule:addBuyableItem({'club'}, 2382, 5)
shopModule:addBuyableItem({'dagger'}, 2379, 5)
shopModule:addBuyableItem({'mace'}, 2398, 90)
shopModule:addBuyableItem({'throwing knife'}, 2410, 25)
shopModule:addBuyableItem({'axe'}, 2386, 20)
shopModule:addBuyableItem({'sword'}, 2376, 85)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me a blacksmith is, an' weapons me sell. You want buy weapons?"})
keywordHandler:addKeyword({'shop'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me a blacksmith is, an' weapons me sell. You want buy weapons?"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me is Uzgod Hammerslammer, son of Fire, from the Savage Axes. You can say you to me."})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can buy the weapons me maked or sell weapons you have, jawoll."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me make often hunt on big nasties. Me small, but very big muscles me have, jawoll."})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We no dungeon need. We prison isle have."})
keywordHandler:addKeyword({'prison'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Bad ones locked up there. Never come out again there, jawoll."})
keywordHandler:addKeyword({'mines'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me hacking and smashing rocks as me was little dwarf, jawoll."})
keywordHandler:addKeyword({'thank'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me enjoy doing that."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What you need? Me just the weapons sell."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What you need? Me just the weapons sell."})
keywordHandler:addKeyword({'light'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me having clubs, daggers, spears, axes, swords, maces, rapiers, and sabres. What is your choice?"})
keywordHandler:addKeyword({'heavy'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me having the best two handed swords in tibia. I also sell battle hammers. What is your choice?"})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me offer you light an' heavy weapons."})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me offer you light an' heavy weapons."})
keywordHandler:addKeyword({'helmet'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me just sell weapons."})
keywordHandler:addKeyword({'armor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me just sell weapons."})
keywordHandler:addKeyword({'shield'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me just sell weapons."})
keywordHandler:addKeyword({'legs'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Me just sell weapons."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Time is |TIME| now."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())