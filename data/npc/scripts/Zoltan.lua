dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am a teacher of the most powerful spells in Tibia."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am known in this world as Zoltan."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "King Tibianus III was the founder of our academy."})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "King Tibianus III was the founder of our academy."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "They rely too much on their brawn instead of their brain."})
--keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A fallen sorcerer, indeed. What a shame."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You will need no weapon if you manipulate the essence of magic."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Thais is a place of barbary."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "There is still much left to be explored in this world."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Carlin's druids waste the influence they have in enviromentalism."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sciences are thriving on this isle."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have no time for chit chat."})
keywordHandler:addKeyword({'rumo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have no time for chit chat."})
keywordHandler:addKeyword({'eremo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is an old and wise man that has seen a lot of Tibia. He is also one of the best magicians. Visit him on his little island."})
keywordHandler:addKeyword({'visit'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You should visit Eremo on his little island. Just ask Pemaret on Cormaya for passage."})
keywordHandler:addKeyword({'spellbook'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Don't bother me with that. Ask in the shops for it."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's |TIME|."})

function creatureSayCallback(cid, type, msg)
	if(npcHandler.focus ~= cid) then
		return false
	end
	
	local queststate = getPlayerStorageValue(cid,6664)
	
	if msgcontains(msg, 'yenny the gentle') and queststate == 1 then
    	npcHandler:say('Ah, Yenny the Gentle was one of the founders of the druid order called Crunor\'s Caress, that has been originated in her hometown Carlin.')
    	talk_state = 1
	elseif msgcontains(msg, 'crunor\'s caress') and talk_state == 1 then
        npcHandler:say('A quite undruidic order of druids they were, as far as we know. I have no more enlightening knowledge about them though.')
		setPlayerStorageValue(cid,6665,1)
        talk_state = 2
	elseif msgcontains(msg, 'no') and (talk_state >= 1 and talk_state <= 2) then
		npcHandler:say('Use your knowledge wisely')
		talk_state = 0
	end
	
	if msgcontains(msg, 'ferumbras') then
		npcHandler:story('A fallen sorcerer, indeed. What a shame. ...', 1)
		npcHandler:story('I see, you managed to reach Kharos, the harbinger isle, and discovered the gates to Ferumbras citadel, and now you are here full of questions. Are you ready to listen?', 5)
		talk_state = 3
	
	elseif msgcontains(msg,'yes') and talk_state == 3 then
		npcHandler:story('So know that destroying the mortal shell of the being called Ferumbras was the best we were able to achieve with our combined efforts in the past. ...', 1)
		npcHandler:story('He was destroyed not only once but several times. Eventually we were able to figure out the secret of his seeming immortality. ...', 5)
		npcHandler:story('On one of the most remote islands of the Shattered Isles, he built a citadel with demonic aid right around a powerful magical nexus. ...', 9)
		npcHandler:story('The only reason for the whole complex was to establish a point of return into our world. Whenever he is slain, his soul retreats to some demonic dimension to regain enough strength to re-enter the world. ...', 13)
		npcHandler:story('We were not able to destroy his citadel, this unholy construct. To make matters worse, the nexus makes it easy for demons of all kind to pass into our world. ...', 17)
		npcHandler:story('The best thing we could do was to seal the citadel and to install a device that will alarm us whenever Ferumbras tries tore-enter our world. ...', 21)
		npcHandler:story('We grant heroes like you the permission to pass our seals and enter Ferumbras citadel. ...', 25)
		npcHandler:story('Just ask for the permission if you are ready to go there. Be warned that the citadel is no holiday place though. You will encounter large amounts of demons and traps that scare off most adventurers. ...', 29)
		npcHandler:story('On the other hand, WHEN Ferumbras re-enters the world we need heroes like you to face him on his very own ground before he can escape. ...', 33)
		npcHandler:story('His return is not very likely but it can happen each and every day. If you should manage to defeat him, bring a proof of his death here and you will be rewarded. ...', 37)
		npcHandler:story('Use your knowledge wisely.', 41)
		talk_state = 4
	
	elseif msgcontains(msg, 'permission') and talk_state == 4 then
		npcHandler:say('The attuning to our seals is a costly process and it will grant you access to the citadel ONLY ONCE. Each time you want toenter, you will need a new attuning. Are you willing to ***SECRET*** to become attuned to the seal of the citadel?')
		talk_state = 5
	
	elseif msgcontains(msg,'yes') and talk_state == 5 then
		selfSay('SO BE IT!')
		doTeleportThing(cid, {x=32416, y=32646, z=7})
		doSendMagicEffect(getCreaturePosition(cid), 10)
		talk_state = 0
	elseif msgcontains(msg,'no') and talk_state == 5 then
		npcHandler:say('You do better stay here then.')
		talk_state = 0
	end
	
    return true
end


local spellSellModule = SpellSellModule:new()
npcHandler:addModule(spellSellModule)

spellSellModule.condition = function(cid) return isDruid(cid) or isSorcerer(cid) end
spellSellModule.conditionFailText = "Sorry, I only sell spells to druids or sorcerers."
spellSellModule.listPreText = "I have some very powerful spells:"
spellSellModule:addSpellStock({
	"Energy Bomb",
	"Ultimate Explosion",
	"Paralyze",
	"Poison Storm",
	"Mass Healing",
})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())