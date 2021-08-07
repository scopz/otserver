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
	if getPlayerVocation(cid) == 2 or getPlayerVocation(cid) == 6 then
	npcHandler:setMessage(MESSAGE_GREET, "Crunor's blessings. I am glad to see you again, ".. getPlayerName(cid) .."!")
	return true
	else
	npcHandler:setMessage(MESSAGE_GREET, "Welcome to our humble guild, wanderer. May I be of any assistance to you?")
	return true
	end
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the grand druid of Carlin. I am responsible for the guild, the fields, and our citizens health."})
keywordHandler:addKeyword({'grand'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am the grand druid of Carlin. I am responsible for the guild, the fields, and our citizens health."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Padreia, Grand Druid of our fine city."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Time is just a crystal pillar. The center of creation and life."})
keywordHandler:addKeyword({'member'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our members wield magic powers of protection and healing."})
keywordHandler:addKeyword({'power'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Every member of the Druids is able to learn the numerous spells of our craft."})
keywordHandler:addKeyword({'druid'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We are druids, preservers of life. Our magic is about defense, healing, and nature."})
keywordHandler:addKeyword({'sorcerer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorcerers are destrucitve. Their power lies in destruction and pain."})
keywordHandler:addKeyword({'vocation'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Your vocation is your profession. There are four vocations in this world: Druids, paladins, knights, and sorcerers."})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "In a spellbook, your spells are listed. There you will find the pronunciation of each spell. If you want to buy one, visit Rachel."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	local queststate = getPlayerStorageValue(cid,6665)

	if msgcontains(msg, 'crunor\'s caress') and queststate == 1 then
		npcHandler:playerSay(cid, 'Don\'t ask. They were only an unimportant footnote of history.')
		cidData.state = 1
	elseif msgcontains(msg, 'footnote') and cidData.state == 1 then
		npcHandler:playerSay(cid, 'They thought they have to bring Crunor to the people, if people did not find to Crunor of their own. To achieve that they founded the inn Crunor\'s Cottage, south of Mt. Sternum.')
		setPlayerStorageValue(cid,6666,1)
		cidData.state = 2
	end
	return true
end

local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isDruid(cid) end
spellSellModule.conditionFailText = "Sorry, I only teach druids!"
spellSellModule:addSpellStock({
	"Find Person",
	"Sudden Death",
	"Energy Wave",
	"Great Energy Beam",
	"Energy Beam",
	"Fire Wave",
	"Energy Wall",
	"Summon Creature",
	"Invisibility",
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
	"Food",
	"Light",
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())