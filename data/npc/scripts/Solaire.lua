dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')
dofile(getDataDir() .. '../config.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Solaire. How are you?"})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't own a watch."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king does a good job promoting people, but I want a bit more."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the only army I need."})
keywordHandler:addKeyword({'dark souls'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dark what? I am pure light. Why not help one another on this lonely journey?"})
keywordHandler:addKeyword({'artorias'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Never heard about him."})
keywordHandler:addKeyword({'astora'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A place I would like to visit someday."})

if rebirth_system_enabled then
	
	keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I used to be a brave warrior. Now here I am, looking for my sun. Oh, would you like to reborn? Just ask for it."})

	local node1 = keywordHandler:addKeyword({'reborn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you want to rebirth?'})
		node1:addChildKeyword({'yes'}, StdModule.rebirthPlayer, {npcHandler = npcHandler, text = 'Congratulations!!! Bye bye.'})
		node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ok, then not.', reset = true})

	node1 = keywordHandler:addKeyword({'rebirth'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Do you want to rebirth?'})
		node1:addChildKeyword({'yes'}, StdModule.rebirthPlayer, {npcHandler = npcHandler, text = 'Congratulations!!! Bye bye.'})
		node1:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'Ok, then not.', reset = true})

else
	keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I used to be a brave warrior. Now here I am, looking for my sun."})
end

npcHandler:addModule(FocusModule:new())