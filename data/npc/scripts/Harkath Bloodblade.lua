

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

local fire = createConditionObject(CONDITION_FIRE)
setConditionParam(fire, CONDITION_PARAM_DELAYED, 10)
addDamageCondition(fire, 1, 2000, -10)

function FocusModule:init(handler)
	FOCUS_GREETSWORDS = {'hail general', 'salutations general'}
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

keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "No news are good news."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "HAIL TO KING TIBIANUS, OUR WISE LEADER!"})
keywordHandler:addKeyword({'leader'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "King Tibianus III is our wise and just leader."})
keywordHandler:addKeyword({'how are you'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am in perfect condition, commoner."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The army protects our city. I divided it into three battlegroups."})
keywordHandler:addKeyword({'guard'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The army protects our city. I divided it into three battlegroups."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is my duty to lead the armed forces of our beloved city into battle against our enemies."})
keywordHandler:addKeyword({'enemies'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Evil has many faces. The servants of evil cannot always be recognized as easily as Ferumbras, for instance."})
keywordHandler:addKeyword({'enemy'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Evil has many faces. The servants of evil cannot always be recognized as easily as Ferumbras, for instance."})
keywordHandler:addKeyword({'battlegroup'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The battlegroups are the 'dogs of war', the 'red guards', and the 'silver guards'."})
keywordHandler:addKeyword({'castle'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The castle is prepared to withstand any direct assault."})
keywordHandler:addKeyword({'subject'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We all live under the rule of our beloved king."})
keywordHandler:addKeyword({'dogs of war'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are our main army."})
keywordHandler:addKeyword({'red guard'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are our special forces. Some serve as city guards, others as secret police."})
keywordHandler:addKeyword({'secret police'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The branch of the red guard that serves as secret police is known as the TBI."})
keywordHandler:addKeyword({'tbi'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The Tibian Bureau of Investigation. Kind of secret police. I don't bother much about such things, I prefer my fights eye to eye."})
keywordHandler:addKeyword({'chester'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know much about him. He is a very secretive person."})
keywordHandler:addKeyword({'silver guard'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The best sorcerers, paladins, knights, and druids of our forces are chosen to serve as silver guards. They are the bodyguards of the king."})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The rapid growth of the city makes it hard to patrol and vulnerable to attacks."})
keywordHandler:addKeyword({'scum'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We will eliminate all resistance against law and order!"})
keywordHandler:addKeyword({'stutch'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is one of our best men and serves in the silver guard."})
keywordHandler:addKeyword({'harsky'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is one of our best men and serves in the silver guard."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I hardly know him."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sam is responsible to supply our troops with weapons and armor."})
keywordHandler:addKeyword({'weapon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sam is responsible to supply our troops with weapons and armor."})
keywordHandler:addKeyword({'armor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sam is responsible to supply our troops with weapons and armor."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "AH! WHAT A WOMAN!"})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He was an adventurer once. He was a fine fighter but lacked the discipline to serve in our army."})
keywordHandler:addKeyword({'benjamin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He was the king's general before I was promoted. Poor guy, lost his mind in a battle against the evil Ferumbras."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is allied with evil itself! Each time we kill him he returns to take revenge."})
keywordHandler:addKeyword({'join army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, we don't recruit today. Perhaps you can join by doing a quest for the king."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Join what?"})
keywordHandler:addKeyword({'quest'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sometimes the king calls for heroes. Keep eyes and ears open! I also heared Baxter has some work for young adventurers."})
keywordHandler:addKeyword({'mission'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sometimes the king calls for heroes. Keep eyes and ears open! I also heared Baxter has some work for young adventurers."})
keywordHandler:addKeyword({'god'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I whorship Banor, the first warrior!"})
keywordHandler:addKeyword({'banor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is the idol of all knights and paladins."})
keywordHandler:addKeyword({'zathroth'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Don't mention the dark one!"})
keywordHandler:addKeyword({'brog'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The orcs, trolls, and cyclopses sacrificed more than one of my men to Brog, the raging one."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They seldom dare to attack the city itself."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "In the legends it is told, that this weapon made its wielder able to fight the mightiest demons hand to hand."})
keywordHandler:addKeyword({'rebellion'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Ask Chester of the T.B.I. about that."})


function creatureSayCallback(cid, type, msg)
	msg = string.lower(msg)

	if not npcHandler:hasFocus(cid) then
		if msgcontains(msg, 'hi') or msgcontains(msg, 'hello') then
			npcHandler:playerSay(cid, "Address me properly ".. getPlayerName(cid) .."!", 1)
		elseif msgcontains(msg, 'hail') or msgcontains(msg, 'salutations') then
			npcHandler:playerSay(cid, "Address me with my title, commoner ".. getPlayerName(cid) .."!", 1)

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
			doAddCondition(cid, fire)
			npcHandler:playerSay(cid, "Take this!", 0.5)
		end

	else
		local cidData = npcHandler:getFocusPlayerData(cid)

		if msgcontains(msg, 'job') then
			if getPlayerSex(cid) == 1 then
				npcHandler:playerSay(cid, "I am the general of the king's army.", 1)
			else
				npcHandler:playerSay(cid, "My Lady, I am the general of the king's army.", 1)
			end
			cidData.state = 0

		elseif msgcontains(msg, 'sell') then
			npcHandler:playerSay(cid, "Are you suggesting I am corruptible?", 1)
			cidData.state = 2

		elseif cidData.state == 2 and msgcontains(msg, 'yes') then
			doSendMagicEffect(getCreaturePosition(getNpcCid()), 13)
			doSendMagicEffect(getPlayerPosition(cid), 15)
			doAddCondition(cid, fire)
			npcHandler:playerSay(cid, "Take this!", 0.5)
			cidData.state = 0

		elseif cidData.state == 2 and msgcontains(msg, '') then
			npcHandler:playerSay(cid, "You should be careful with your words!", 1)
			cidData.state = 0

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
			doAddCondition(cid, fire)
			npcHandler:playerSay(cid, "Take this!", 0.5)
			cidData.state = 0
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())