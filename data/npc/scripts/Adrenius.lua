dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local fire = createConditionObject(CONDITION_FIRE)
setConditionParam(fire, CONDITION_PARAM_DELAYED, 10)
addDamageCondition(fire, 450, 3000, -10)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Adrenius."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm a priest of Fafnar."})
keywordHandler:addKeyword({'fafnar'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Fafnar is the stronger one of the two suns above our world."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yyyyess. Yes, it's the capital city of Tibia I think."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Carlin? Don't you mean Thais?"})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Who needs a king? I don't."})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Who needs weapons? I never had and i never will have weapons - what for?"})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Help? Help? Nothing more? Don't we all demand some help?"})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Time? What is time? A word? A thing? An object?"})
keywordHandler:addKeyword({'sword'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Swords? Don't you have something else to do?"})
keywordHandler:addKeyword({'desert'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sand, sand and again sand. Sand all over. Yes, I'd say: it's truly a desert!"})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "What's that? You start annoying me."})
keywordHandler:addKeyword({'fight'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Leave me alone. I don't want to fight."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Fafnar is the greatest among the gods."})
keywordHandler:addKeyword({'way'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Way? Which way? I forgot where most ways go to... excuse me."})
keywordHandler:addKeyword({'door'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Who needs doors? Free your mind!"})
keywordHandler:addKeyword({'secret'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Secrets ... What do you mean?"})
keywordHandler:addKeyword({'treasure'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Treasures? What is a treasure for you?"})
keywordHandler:addKeyword({'book'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Read books, it increases your intelligence and, furthermore, it's a great source of inspiration!"})
keywordHandler:addKeyword({'gharonk'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hmmmm... I don't know much about it."})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can offer you religion and mysticism."})
keywordHandler:addKeyword({'library'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I heard of the library, but I never was very interested in it."})


function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)

	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'netlios') then
		npcHandler:playerSay(cid, "This fool! His book is nothing but a hoax! At least I believe that. Or did you find an answer for my questions?", 1)
		cidData.state = 1

	elseif cidData.state == 1 and msgcontains(msg, 'yes') then
		npcHandler:playerSay(cid, "By the way, I would like a donation for my temple. Are 500 gold ok?", 1)
		cidData.state = 2

	elseif cidData.state == 1 and msgcontains(msg, 'no') then
		npcHandler:playerSay(cid, "Oh. So once again I am proved right.", 1)
		cidData.state = 0

	elseif cidData.state == 1 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "You can't even say 'yes' or 'no'. You are not worth talking to me!", 1)
		cidData.state = 0
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif cidData.state == 2 and msgcontains(msg, 'yes') then
		if doPlayerRemoveMoney(cid, 500) == true then
			npcHandler:playerSay(cid, "Thank you very much. Now, name me the first person in alphabetical order, his age, his fate, and how long he was on his journeys!", 1)
			cidData.state = 4
		else
			npcHandler:playerSay(cid, "You want to fool me? May Fafnar burn your soul!", 1)
			doSendMagicEffect(getCreaturePosition(getNpcCid()), 13)
			doSendMagicEffect(getPlayerPosition(cid), 15)
			doAddCondition(cid, fire)
			cidData.state = 0
		end
	elseif cidData.state == 2 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Then I don't want to talk to you.", 1)
		cidData.state = 0
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif cidData.state == 4 and msgcontains(msg, 'anaso') and msgcontains(msg, '41') and msgcontains(msg, 'mother') and msgcontains(msg, '117') then
		npcHandler:playerSay(cid, "Hmmm, maybe. What can you tell me about the second 'adventurer'?", 1)
		cidData.state = 5

	elseif cidData.state == 4 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "No, sorry, that doesn't sound correct to me. Maybe you should reconsider your words one more time...", 1)
		cidData.state = 4

	elseif cidData.state == 5 and msgcontains(msg, 'elaeus') and msgcontains(msg, '39') and msgcontains(msg, 'dragon') and msgcontains(msg, '100') then
		npcHandler:playerSay(cid, "Yes, that might be true. What did you find out about the third man?", 1)
		cidData.state = 6

	elseif cidData.state == 5 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "No, no, no! Think about it, that simply can't be true!", 1)
		cidData.state = 5

	elseif cidData.state == 6 and msgcontains(msg, 'gadinius') and msgcontains(msg, '42') and msgcontains(msg, 'fire') and msgcontains(msg, '83') then
		npcHandler:playerSay(cid, "Correct again! Hmmmm... I doubt you know anything about the fourth person!", 1)
		cidData.state = 7

	elseif cidData.state == 6 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Hmmmm... well, no. That is not true, it does not fit to the data provided by the books.", 1)
		cidData.state = 6

	elseif cidData.state == 7 and msgcontains(msg, 'heso') and msgcontains(msg, '40') and msgcontains(msg, 'troll') and msgcontains(msg, '66') then
		npcHandler:playerSay(cid, "Yes! Really, how did you figure that out? I bet, you don't know anything about the last adventurer!", 1)
		cidData.state = 8

	elseif cidData.state == 7 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "No, sorry. Incorrect...", 1)
		cidData.state = 7

	elseif cidData.state == 8 and msgcontains(msg, 'hestus') and msgcontains(msg, '38') and msgcontains(msg, 'poison') and msgcontains(msg, '134') then
		npcHandler:playerSay(cid, "That's right! Why didn't I see it? It's obvious, Netlios was right, and his stories are great! Wait, I'll give you something!", 1)
		DESERTTPROOM = doPlayerAddItem(cid, 2088, 1)
		doSetItemActionId(DESERTTPROOM, 2016)
		doSetItemSpecialDescription(DESERTTPROOM, "(Key: 4023)")
		cidData.state = 0

	elseif cidData.state == 8 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Well, and again it was shown: I am right and Netlios is wrong!", 1)
		cidData.state = 8
	end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())