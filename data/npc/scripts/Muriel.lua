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
	if isMage(cid) then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome back, ".. getPlayerName(cid) .."!")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Greetings, ".. getPlayerName(cid) .."! Looking for wisdom and power, eh?")
	end	
	return true
end	
npcHandler:setCallback(CALLBACK_GREET, greetCallback)


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the second sorcerer. I am selling spellbooks and spells."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You may call me Muriel."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Time is unimportant."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king is a patron of the arcane arts."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king is a patron of the arcane arts."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He has some minor magic powers."})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Pretty and compentent."})
keywordHandler:addKeyword({'harkath'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He's not as dumb as the average fighter but a warrior nonetheless."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We supply the army with some sorcerer recruits now and then."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We supply the army with some sorcerer recruits now and then."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I wonder how he actually got this awesome powers."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A simple smith."})
keywordHandler:addKeyword({'xodet'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He has our permission to sell mana fluids."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A bar is no place that suits a scholar like me."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "She is quite proud of her puny magic tricks."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't like jokes about my name!"})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Knights! Childs with swords. Not worth of any attention."})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Marvik and his Sorcerers lack spells with real power."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He's not a jester but a poor joke himself."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know him."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Only his boss keeps him from being burned to ashes."})
keywordHandler:addKeyword({'sherry'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Simple farmers."})
keywordHandler:addKeyword({'donald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Simple farmers."})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Simple farmers."})
keywordHandler:addKeyword({'lugri'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is rumoured to posses some secrets our guild might find ... interesting."})
keywordHandler:addKeyword({'lungelen'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "She keeps the whole wisdom of our ancestors and leads our guild."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The enchantements on this weapon must be awesome."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our guild is working on a new spell, but I won't give away any details yet."})
keywordHandler:addKeyword({'flaming'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "These pits, you refer to, might be the legendary 'Pits of Inferno', also known as the 'Nightmare Pits'."})
keywordHandler:addKeyword({'inferno'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are rumoured to be hidden somewhere in the Plains of Havoc, far to the east."})
keywordHandler:addKeyword({'nightmare'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are rumoured to be hidden somewhere in the Plains of Havoc, far to the east."})
keywordHandler:addKeyword({'wisdom'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The wisdom of spellcasting is the source of power."})
keywordHandler:addKeyword({'ancestor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There were many generations of sorcerers in the past. Today a lot of people want to join us."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A sorcerer spends his lifetime studying spells to gain power."})
keywordHandler:addKeyword({'power'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Of course, power is the most important thing in the universe."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Your vocation is your profession. There are four vocations in Tibia: Sorcerers, paladins, knights, and Sorcerers."})
keywordHandler:addKeyword({'wand'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm sorry, you can find wand and rods at Xodet's magic shop."})
keywordHandler:addKeyword({'rod'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm sorry, you can find wand and rods at Xodet's magic shop."})
keywordHandler:addKeyword({'rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Each spell, that starts with 'Ad', needs a rune. You have to hold a blank rune in one of your hands when you cast it. You can buy runes at the magic shop."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'spellbook') or msgcontains(msg, 'spellbook') then
		npcHandler:playerSay(cid, "In a spellbook, your spells are listed. There you can find the pronunciation of each spell. Do you want to buy one for 150 gold?", 1)
		cidData.state = 814

	elseif cidData.state == 814 and msgcontains(msg, 'yes') then
		if doPlayerRemoveMoney(cid, 150) == true then
			doPlayerAddItem(cid, 2175, 1)
			npcHandler:playerSay(cid, "Here you are.", 1)
		else
			npcHandler:playerSay(cid, "Come back when you have enough money.", 1)
		end
		cidData.state = 0

	elseif cidData.state == 814 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Hmm, maybe next time.", 1)
		cidData.state = 0
	end		
    return true
end


local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isMage(cid) end
spellSellModule.conditionFailText = "Sorry, I only sell spells to mages!"
spellSellModule:addSpellStock({
	"Find Person",
	"Creature Illusion",
	"Sudden Death",
	"Energy Wave",
	"Energy Wall",
	"Summon Creature",
	"Invisibility",
	"Great Energy Beam",
	"Fire Wall",
	"Explosion",
	"Poison Wall",
	"Energy Beam",
	"Fire Bomb",
	"Great Fireball",
	"Ultimate Healing",
	"Fire Wave",
	"Destroy Field",
	"Energy Field",
	"Magic Shield",
	"Heavy Magic Missile",
	"Fire Field",
	"Great Light",
	"Poison Field",
	"Intense Healing",
	"Antidote",
	"Light Healing",
	"Light",
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())