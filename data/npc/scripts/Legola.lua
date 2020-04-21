dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

function greetCallback(cid)
	if getPlayerVocation(cid) == 3 or getPlayerVocation(cid) == 7 then
	npcHandler:setMessage(MESSAGE_GREET, "Hello, ".. getPlayerName(cid) .."! Nice to see you.")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "Welcome to the Paladins, ".. getPlayerName(cid) .."! What is your business here?")
	return true
	end	
end	
npcHandler:setCallback(CALLBACK_GREET, greetCallback)


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the local leader of the paladins' guild. I am trainer and teacher to our members."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Legola. I am the head of the local paladins' guild."})
keywordHandler:addKeyword({'member'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins profit from their chosen vocation. It has many advantages to be a paladin."})
keywordHandler:addKeyword({'profit'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The guild will help paladins to improve their skills. Besides we offer spells for our members."})
keywordHandler:addKeyword({'advantage'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The guild will help paladins to improve their skills. Besides we offer spells for our members."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Your vocation is your profession. There are four vocations in Tibia: Paladins, knights, sorcerers, and druids."})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins are great warriors and able magicians. Besides we are deadly missile fighters. Many people in Tibia want to join us."})
keywordHandler:addKeyword({'skill'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins are great warriors and able magicians. Besides we are deadly missile fighters. Many people in Tibia want to join us."})
keywordHandler:addKeyword({'warrior'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Of course, we aren't as strong as knights, but no druid or sorcerer will ever defeat a paladin with a sword."})
keywordHandler:addKeyword({'magician'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins learn to use most runes and can cast some usefull spells."})
keywordHandler:addKeyword({'woman'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "All guild leaders in Carlin are chosen for their wisdom, and so all are women."})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "In a spellbook, your spells are listed. There you will find the pronunciation of each spell. If you want to buy one, visit the magicians' shop in the south of Carlin."})
keywordHandler:addKeyword({'ghostlands'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Many tried to break that curse, but the evil there is so deep and overwhelmig there seems to be no hope."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is |TIME|."})


local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isPaladin(cid) end
spellSellModule.conditionFailText = "Sorry, I only sell spells to paladins."
spellSellModule:addSpellStock({
	"Find Person",
	"Invisibility",
	"Conjure Explosive Arrow",
	"Ultimate Healing",
	"Destroy Field",
	"Conjure Poisoned Arrow",
	"Fireball",
	"Magic Shield",
	"Heavy Magic Missile",
	"Great Light",
	"Conjure Arrow",
	"Intense Healing",
	"Antidote",
	"Light Magic Missile",
	"Light Healing",
	"Light",
	"Food",
})

keywordHandler:sortKeywords()
npcHandler:addModule(FocusModule:new())