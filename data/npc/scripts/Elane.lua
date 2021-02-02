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
	if isPaladin(cid) then
		npcHandler:setMessage(MESSAGE_GREET, "Hi, ".. getPlayerName(cid) .."! What can I do for you?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Welcome to the paladins, ".. getPlayerName(cid) .."! Can I help you?")
	end	
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the leader of the Paladins. I help our members."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Elane. I am the famous leader of the Paladins."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Oops. I have forgotten my watch."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "King Tibianus is a wise ruler."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "King Tibianus is a wise ruler."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A humble monk and a wise man."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hm, a litte too nice for my taste."})
keywordHandler:addKeyword({'harkath'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A fine warrior and a skilled general."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Some paladins serve in the kings army."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Someday I will slay that bastard!"})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Harkath Bloodblade is the royal general."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Strong man. But a little shy."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He sells a lot of useful equipment."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The alcohol he sells shrouds the mind and the eye."})
keywordHandler:addKeyword({'galuna'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "One of the most important members of our guild. She makes all the bows and arrows we need."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "How spineless do you have to be to become a jester?"})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He has some potential."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "If there wouldn't be higher powers to protect him..."})
keywordHandler:addKeyword({'sherry'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The McRonalds are simple farmers."})
keywordHandler:addKeyword({'donald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The McRonalds are simple farmers."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The McRonalds are simple farmers."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yes?"})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Just another arrogant sorcerer."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He and his guildfellows lack the grace of a true warrior."})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A skilled healer, that's for sure."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A follower of evil that will get what he deserves one day."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A weapon of myth. I don't believe that this weapon exists."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a paladin, not a storyteller."})
keywordHandler:addKeyword({'member'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Every paladin profits from his vocation. It has many advantages to be a paladin."})
keywordHandler:addKeyword({'profit'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We will help you to improve your skills. Besides I offer spells for paladins."})
keywordHandler:addKeyword({'advantage'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We will help you to improve your skills. Besides I offer spells for paladins."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Your vocation is your profession. There are four vocations in Tibia: Paladins, knights, sorcerers, and druids."})
keywordHandler:addKeyword({'paladin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins are great warriors and magicians. Besides that we are excellent missile fighters. Many people in Tibia want to join us."})
keywordHandler:addKeyword({'skill'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins are great warriors and magicians. Besides that we are excellent missile fighters. Many people in Tibia want to join us."})
keywordHandler:addKeyword({'warrior'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Of course, we aren't as strong as knights, but no druid or sorcerer will ever defeat a paladin with a sword."})
keywordHandler:addKeyword({'magician'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There are many magic spells and runes paladins can use."})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "In a spellbook your spells are listed. There you will find the pronunciation of each spell. If you want to buy one, visit Xodet in his magic shop."})
keywordHandler:addKeyword({'missile'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Paladins are the best missile fighters in Tibia!"})


local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isPaladin(cid) end
spellSellModule.conditionFailText = "Sorry, I only sell spells to paladins."
spellSellModule:addSpellStock({
	"Find Person",
	"Ultimate Healing",
	"Invisibility",
	"Conjure Explosive Arrow",
	"Destroy Field",
	"Conjure Poisoned Arrow",
	"Fireball",
	"Magic Shield",
	"Heavy Magic Missile",
	"Great Light",
	'Conjure Bolt',
	"Conjure Arrow",
	"Intense Healing",
	"Antidote",
	"Light Magic Missile",
	"Light Healing",
	"Food",
	"Light",
})

keywordHandler:sortKeywords()
npcHandler:addModule(FocusModule:new())