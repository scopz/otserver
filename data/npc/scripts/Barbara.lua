local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function onThink()
	npcHandler:onThink()
	if getWorldUpTime() == 5 then
		doMoveCreature(getNpcCid(), 0)
	elseif getWorldUpTime() == 10 then
		doMoveCreature(getNpcCid(), 2)
	end
end

function FocusModule:init(handler)
	FOCUS_GREETSWORDS = {'hi queen', 'hello queen', 'hail queen', 'salutations'}
	FOCUS_FAREWELLSWORDS = {'bye', 'farewell'}
	self.npcHandler = handler
	for i, word in pairs(FOCUS_GREETSWORDS) do
		local obj = {}
		table.insert(obj, word)
		obj.callback = FOCUS_GREETSWORDS.callback or FocusModule.messageMatcher
		handler.keywordHandler:addKeyword(obj, FocusModule.onGreet, {module = self})
	end

	for i, word in pairs(FOCUS_FAREWELLSWORDS) do
		local obj = {}
		table.insert(obj, word)
		obj.callback = FOCUS_FAREWELLSWORDS.callback or FocusModule.messageMatcher
		handler.keywordHandler:addKeyword(obj, FocusModule.onFarewell, {module = self})
	end

	return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end

	if msgcontains(msg, "hello") or msgcontains(msg, "hi") then
		npcHandler:playerSay(cid, "MIND YOUR MANNERS COMMONER! To address the queen greet with her title!", 1)

	elseif msgcontains(msg, "bye") or msgcontains(msg, "farewell") then
		npcHandler:playerSay(cid, "LONG LIVE THE QUEEN! You may leave now!", 1)

	elseif msgcontains(msg, "idiot")   or msgcontains(msg, "asshole")
		or msgcontains(msg, "retard")  or msgcontains(msg, "sucker")
		or msgcontains(msg, "fag")     or msgcontains(msg, "fuck")
		or msgcontains(msg, "shut up") or msgcontains(msg, "shit")
		or msgcontains(msg, "ugly")    or msgcontains(msg, "smell")
		or msgcontains(msg, "blow")    or msgcontains(msg, "cock")
		or msgcontains(msg, "dick")    or msgcontains(msg, "pussy")
		or msgcontains(msg, "vagina")  or msgcontains(msg, "bitch")
		or msgcontains(msg, "nigger") then

		doSendMagicEffect(getCreaturePosition(getNpcCid()), 13)
		doSendMagicEffect(getPlayerPosition(cid), 15)
		doCreatureAddHealth(cid, -getCreatureHealth(cid) +1)
		npcHandler:playerSay(cid, "Take this!", 0.5)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())