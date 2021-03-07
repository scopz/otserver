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
	if getPlayerStorageValue(cid,8128) >= 3 then
	npcHandler:setMessage(MESSAGE_GREET, "Greetings, human ".. getPlayerName(cid) ..". My patience with your kind is limited, so speak quickly and choose your words well.")
	return true
	elseif getPlayerStorageValue(cid,8128) <= 2 then
	npcHandler:setMessage(MESSAGE_GREET, "...")
	end	
end	
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:addModule(FocusModule:new())