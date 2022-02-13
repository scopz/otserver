dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a sorcerer. I was sent here by the academy of Edron to function as an adviser in magical matters and as a teacher for sorcerers in need of training."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Myra is my name."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We are here on the behalf of the king and try our best to make this colony prosper."})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I find the Venoran activity here disturbing, but, after all, that's not my business."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Thais lacks the lovely peace of Edron, but as the capital of the Thaian kingdom it offers more chances to study or entertain yourself than this fledgling city."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The druids of Carlin could do a lot with all the freedom they have, but they waste their resources in some strange cult and lack any scientific approach to magic."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I loved my time at the academy. I had my differences with some superiors though, and when it came to select somebody to come here, my name was mentioned once too often I think."})
keywordHandler:addKeyword({'jungle'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am working on a spell aiming specifically on destroying plant life. I am sure it would be of enormous help and would earn me a positon in the academy once more."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have already seen more of the world as I had ever planned."})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I would have even preferred an appointment to the dark halls of Kazordoon than to this colony."})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dwarves are good miners, I can't say much more about them."})
keywordHandler:addKeyword({'dwarves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Dwarves are good miners, I can't say much more about them."})
keywordHandler:addKeyword({"ab'dendriel"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves would probably be more suitable to this environment."})
keywordHandler:addKeyword({'elf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves would probably be more suitable to this environment."})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Elves would probably be more suitable to this environment."})
keywordHandler:addKeyword({'darama'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I think all this talk about the conquest of a new continent is simply exaggerated."})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Living in the desert must be even worse than living here."})
keywordHandler:addKeyword({'ankrahmun'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Although I'd love to study the undeath more closely, I'd not want to study it first hand."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He wastes all his power to spread terror and destruction. Doesn't this become boring after a while?"})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The magic used to create that weapon would be more interesting than the weapon itself."})
keywordHandler:addKeyword({'ape'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are annoying but easily driven away."})
keywordHandler:addKeyword({'lizard'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The lizards are somewhat mysterious, but who would care to travel through the whole cursed jungle to learn the boring secrets of some fly-eaters?"})
keywordHandler:addKeyword({'dworc'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sooner or later we will have to face this threat in the south."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Your vocation is your profession. There are four vocations in Tibia: Sorcerers, paladins, knights, and druids."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is |TIME| right now."})



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

npcHandler:addModule(FocusModule:new())
