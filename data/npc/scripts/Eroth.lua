dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the leader of the Cenath caste."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Eroth Ramathi."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "That is a inferior concept invented by the minor races."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Their druids seek my counsel quite often. I provide them with as many insights their little minds can keep up with and I feel appropriate."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A city of filth and dirt. Any elf should visit this city at least once to see what a society without good guidance can become."})
keywordHandler:addKeyword({'venore'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The merchants of venore have prooven usefull and are therefore tolerated."})
keywordHandler:addKeyword({'roderick'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A stupid human who won't comprehend our complex society."})
keywordHandler:addKeyword({'olrik'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A human who dreams to become an elf. It would be funny if it were not that pathetic."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our people have no use for kings or queens."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our people have no use for kings or queens."})
keywordHandler:addKeyword({'elves'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our people are the children of light and darkness, the heirs of dusk and dawn."})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The diggers are not welcome in our realm."})
keywordHandler:addKeyword({'human'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We tolerate them and allow them to be used by us."})
keywordHandler:addKeyword({'troll'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The Kuridai have the distasteful habit to keep some trolls for inferior work."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Stop this Kuridai nonsense."})
keywordHandler:addKeyword({'cenath'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We are the shepherds of our people. The other castes need our guidance."})
keywordHandler:addKeyword({'kuridai'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The Kuridai are aggressive and victims of their instincts. Without our help they would surely die in a foolish war."})
keywordHandler:addKeyword({'deraisim'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They lack the understanding of unity. We are keeping them together and prevent them from being slaughtered one by one."})
keywordHandler:addKeyword({'abdaisim'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are fools and almost deserve the extinction that awaits them. Though we will take it upon us to rescue even them by leading them home."})
keywordHandler:addKeyword({'teshial'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They are gone. They alone were almost equal to us Cenath among elvenkind."})
keywordHandler:addKeyword({'dreamer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The Teshial were masters of the so called dream magic."})
keywordHandler:addKeyword({'dream master'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The dream masters, though overestimated, wielded some impressive power without much practical use."})
keywordHandler:addKeyword({'dreammaster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The dream masters, though overestimated, wielded some impressive power without much practical use."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A human born evil. Another evidence of the destructive potential of that race."})
keywordHandler:addKeyword({'crunor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Gods are for the weak. We will master the world on our own. We need no gods."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Just another human myth."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I heared the new human settlement in the west became independent from the human empire."})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Druids master spells of defence, healing, and nature."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorcerers are not attuned to nature and therefore can't master it."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You are narrow minded to think in such boundaries."})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Cenath rarely use spellbooks. The minor castes rely on them though."})
keywordHandler:addKeyword({'magic'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Magic comes almost naturally to the Cenath. We keep the secrets of ages."})


local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isPaladin(cid) or isDruid(cid) end
spellSellModule.conditionFailText = "Sorry, I only teach paladins and druids!"
spellSellModule.listPreText = "For you my friend, I sell"
spellSellModule:addSpellStock({
	"Magic Shield",
	"Invisibility",
	"Summon Creature",
	"Convince Creature",
	"Creature Illusion",
	"Chameleon",
	"Destroy Field",
})


npcHandler:addModule(FocusModule:new())