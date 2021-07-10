dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end


keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... Selling Spells"})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... Smiley"})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... Time?... Not important... anymore."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "..."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "..."})
keywordHandler:addKeyword({'vladruc'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... Maaaaassssterrrrr"})
keywordHandler:addKeyword({'urghain'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... Maaaaassssterrrrr"})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... un...important"})
keywordHandler:addKeyword({'market'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... You buy?"})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... only sell spells..."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... more spells..."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... Ask Chatterbone?"})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... You... buy spells?"})
keywordHandler:addKeyword({'power'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... You... buy spells?"})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "... You buy book... store spells... other counter..."})


local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isDruid(cid) end
spellSellModule.conditionFailText = "... sell to... Only druids.."
spellSellModule.listPreText = "... I teach..."
spellSellModule:addSpellStock({
	"Find Person",
	"Energy Wall",
	"Summon Creature",
	"Invisibility",
	"Fire Wall",
	"Fire Wall",
	"Explosion",
	"Poison Wall",
	"Ultimate Healing Rune",
	"Creature Illusion",
	"Fire Bomb",
	"Great Fireball",
	"Ultimate Healing",
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
	"Food",
})

npcHandler:addModule(FocusModule:new())