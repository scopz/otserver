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

shopModule:addSellableItem({'watch'}, 2036, 6)
shopModule:addSellableItem({'rope'}, 2120, 15)
shopModule:addSellableItem({'scythe'}, 2550, 12)
shopModule:addSellableItem({'pick'}, 2553, 15)
shopModule:addSellableItem({'shovel'}, 2554, 8)
shopModule:addSellableItem({'mirror'}, 2560, 10)
shopModule:addSellableItem({'rod'}, 2580, 40, 'fishing rod')
shopModule:addSellableItem({'inkwell'}, 2600, 8)
shopModule:addSellableItem({'sickle'}, 2405, 3)
shopModule:addSellableItem({'crowbar'}, 2416, 50)
shopModule:addSellableItem({'trap'}, 2578, 75, 'closed trap')
shopModule:addBuyableItem({'torch'}, 2050, 2)
shopModule:addBuyableItem({'bag'}, 1995, 5)
shopModule:addBuyableItem({'backpack'}, 2002, 20)
shopModule:addBuyableItem({'bucket'}, 2005, 4, 0)
shopModule:addBuyableItem({'watch'}, 2036, 20)
shopModule:addBuyableItem({'rope'}, 2120, 50)
shopModule:addBuyableItem({'scythe'}, 2550, 50)
shopModule:addBuyableItem({'pick'}, 2553, 50)
shopModule:addBuyableItem({'shovel'}, 2554, 50)
shopModule:addBuyableItem({'rod'}, 2580, 150, 'fishing rod')
shopModule:addBuyableItem({'crowbar'}, 2416, 260)
shopModule:addBuyableItem({'lamp'}, 2044, 8)
shopModule:addBuyableItem({'candlestick'}, 2047, 2)
shopModule:addBuyableItem({'basket'}, 1989, 6)
shopModule:addBuyableItem({'trap'}, 2578, 280)
shopModule:addBuyableItem({'football'}, 2109, 111)
shopModule:addBuyableItem({'worm'}, 3976, 1, 'worms')

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am called Beatrice."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My job is to sell all kind of useful equipment."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have seen him once. What a handsome man he is."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have seen him once. What a handsome man he is."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I supply them with some basic stuff."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I vaguely remember that name."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A myth like the screwdriver of Kurik or the endless vial of manafluid."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We are no longer in need to be supplied from there."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't like travelling much. I prefer to live in the safety of our city."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Though they rebelled against our king it's said that the city is very lovely."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's the best place to live at."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There are always rumors about the dangers in the far north of Edron."})
keywordHandler:addKeyword({'rumo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There are always rumors about the dangers in the far north of Edron."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My inventory is large, just have a look at the blackboard."})
keywordHandler:addKeyword({'good'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My inventory is large, just have a look at the blackboard."})
keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My inventory is large, just have a look at the blackboard."})
keywordHandler:addKeyword({'have'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My inventory is large, just have a look at the blackboard."})
keywordHandler:addKeyword({'equipment'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My inventory is large, just have a look at the blackboard."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's |TIME| right now."})

npcHandler:addModule(FocusModule:new())

function onCreatureSell(...)
	shopModule:sellItemToPlayer(unpack(arg))
end