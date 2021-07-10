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
	if getPlayerVocation(cid) == 1 or getPlayerVocation(cid) == 5 then
	npcHandler:setMessage(MESSAGE_GREET, "Hiho <cough> and welcome back, ".. getPlayerName(cid) .."!")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "Hiho, ".. getPlayerName(cid) ..". <cough>")
	return true
	end	
end	
npcHandler:setCallback(CALLBACK_GREET, greetCallback)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am der dwarfish mastermage. I am keeper of the secrets of magic."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Etzel Fireworker, <cough> son of fire, of the Molten Rocks."})
keywordHandler:addKeyword({'wisdom'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Wisdom is not aquired cheeply."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorcery is not for the lazy or the impatient."})
keywordHandler:addKeyword({'power'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Great power brings great responsibility, young one."})
keywordHandler:addKeyword({'arcane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Great power brings great responsibility, young one."})
keywordHandler:addKeyword({'responsibility'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Great power brings great responsibility, young one."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Being sorcerer is belonging to a vocation of great arcane power and responsibility."})
keywordHandler:addKeyword({'rune'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't sell these anymore. <cough> I'm old and have to focus on more important things. Please ask my brother Sigurd next door. <cough>"})
keywordHandler:addKeyword({'fluid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't sell these anymore. <cough> I'm old and have to focus on more important things. Please ask my brother Sigurd next door. <cough>"})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't sell these anymore. <cough> I'm old and have to focus on more important things. Please ask my brother Sigurd next door. <cough>"})
keywordHandler:addKeyword({'wand'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't sell these anymore. <cough> I'm old and have to focus on more important things. Please ask my brother Sigurd next door. <cough>"})
keywordHandler:addKeyword({'rod'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't sell these anymore. <cough> I'm old and have to focus on more important things. Please ask my brother Sigurd next door. <cough>"})
keywordHandler:addKeyword({'vial'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, I don't buy these anymore. <cough> I'm old and have to focus on more important things. Please ask my brother Sigurd next door. <cough>"})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's precisely |TIME| now."})

local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isSorcerer(cid) end
spellSellModule.conditionFailText = "Sorry, I only sell spells to Sorcerers."
spellSellModule.listPreText = "I can sell you"
spellSellModule:addSpellStock({
	"Find Person",
	"Sudden Death",
	"Energy Wave",
	"Energy Wall",
	"Summon Creature",
	"Invisibility",
	"Great Energy Beam",
	"Fire Wall",
	"Explosion",
	"Poison Wall",
	"Creature Illusion",
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

npcHandler:addModule(FocusModule:new())