dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a mystic."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am known as Maealil."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't own one of those little machines."})
keywordHandler:addKeyword({'mystic'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a philosopher and healer."})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We are an ancient race, abandoned by the gods and doomed to find our way alone."})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They cultivate earth but don't understand it."})
keywordHandler:addKeyword({'human'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are somewhat orcish in their nature."})
keywordHandler:addKeyword({'cenath'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My parents were Deraisim but joined the Cenath caste before my birth."})
keywordHandler:addKeyword({'kuridai'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I hope they don't do something foolish one day."})
keywordHandler:addKeyword({'deraisim'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Unfortunately they are to busy to care for the finer things in life."})
keywordHandler:addKeyword({'abdaisim'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They should join our town for their and our own safety."})
keywordHandler:addKeyword({'teshial'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I would love to learn more about the Teshial."})
keywordHandler:addKeyword({'dream'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I would love to learn more about the Teshial."})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The great tree is the beginning for all things living and Priyla helps us to understand that."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Only another servant of evil."})
keywordHandler:addKeyword({'priyla'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The daughter of the stars gives us knowledge and teaches us magic."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Is that a new kind of bug the Deraisim found?"})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know anything of importance."})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Druids are great healers."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They understand so few..."})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have none here."})
keywordHandler:addKeyword({'bles'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The lifeforce of this world is waning. There are no more blessings avaliable on this world."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I can heal you or even teach you some spells of healing."})

function creatureSayCallback(cid, type, msg)
	if(npcHandler.focus ~= cid) then
		return false
	end

	if msg == "heal" then
		if getCreatureHealth(cid) <= 39 then
		npcHandler:say("You are looking really bad. Let me heal your wounds.", 1)
		doCreatureAddHealth(cid, -getCreatureHealth(cid)+40)
		doSendMagicEffect(getPlayerPosition(cid), 12)
		talk_state = 0
		return true
		else
		npcHandler:say("You aren't looking really bad. Sorry, I can't help you.", 1)
		return true
		end
		talk_state = 0	
	    return true
	end
end



local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isDruid(cid) or isPaladin(cid) end
spellSellModule.conditionFailText = "Sorry, I only teach paladins and druids!"
spellSellModule.listPreText = "I teach the spells"
spellSellModule:addSpellStock({
	"Light Healing",
	"Ultimate Healing Rune",
	"Ultimate Healing",
	"Intense Healing",
	"Antidote",
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())