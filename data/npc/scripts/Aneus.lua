dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Aneus, the storyteller."})
keywordHandler:addKeyword({'bruno'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know much about him. I only know that he is selling fish in the village."})
keywordHandler:addKeyword({'marlene'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A lovely woman. But I give you a hint: Better keep away from her. *grin*"})
keywordHandler:addKeyword({'graubart'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't know much about him. But he sails much and has seen nearly the whole world."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I'm a storyteller."})
keywordHandler:addKeyword({'storyteller'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Well, if you wish I can tell you the story about this place here. The story about the Fields of Glory!"})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'story') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "Ok, sit down and listen. Back in the early days, one of the ancestors of our king Tibianus III wanted to build the best city in whole of Tibia.", 1)
		cidData.state = 2

	elseif msgcontains(msg, 'fields of glory') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "Ok, sit down and listen. Back in the early days, one of the ancestors of our king Tibianus III wanted to build the best city in whole of Tibia.", 1)
		cidData.state = 2

	elseif cidData.state == 2 and msgcontains(msg, 'ancestor') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "Please forgive me. I forgot his name. I'm not that young anymore.", 1)
		cidData.state = 2

	elseif cidData.state == 2 and msgcontains(msg, 'city') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "The works on this new city began and the king sent his best soldiers to protect the workers from orcs and to make them work harder.", 1)
		cidData.state = 3

	elseif cidData.state == 3 and msgcontains(msg, 'soldier') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "It was the elite of the whole army. They were called the Red Legion (also known as the Bloody Legion).", 1)
		cidData.state = 3

	elseif cidData.state == 3 and msgcontains(msg, 'orc') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "The orcs attacked the workers from time to time and so they disturbed the works on the city.", 1)
		cidData.state = 4

	elseif cidData.state == 3 and msgcontains(msg, 'work harder') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "The soldiers treated them like slaves.", 1)
		cidData.state = 4

	elseif cidData.state == 4 and msgcontains(msg, 'slave') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "You dont know what a slave is? I really hope that you will never have to make this experience.", 1)
		cidData.state = 3

	elseif cidData.state == 4 and msgcontains(msg, 'works') and npcHandler:hasFocus(cid) then
		npcHandler:story("The development of the city was fine. Also a giant castle was build northeast of the city. ...", 1)
		npcHandler:story("But more and more workers started to rebel because of the bad conditions.", 5)
		cidData.state = 5

	elseif cidData.state == 5 and msgcontains(msg, 'rebel') and npcHandler:hasFocus(cid) then
		npcHandler:story("All rebels were brought to the giant castle. Guarded by the Red Legion, they had to work and live in even worse conditions. ...", 1)
		npcHandler:playerSay(cid, "Also some friends of the king's sister were brought there.", 5)
		cidData.state = 6

	elseif cidData.state == 6 and msgcontains(msg, 'friends') and npcHandler:hasFocus(cid) then
		npcHandler:story("The king's sister was pretty upset about the situation there but her brother didn't want to do anything about this matter. ...", 1)
		npcHandler:playerSay(cid, "So she made a plan to destroy the Red Legion for their cruelty forever.", 5)
		cidData.state = 7

	elseif cidData.state == 7 and msgcontains(msg, 'cruelty') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "The soldiers treated the workers like slaves.", 1)
		cidData.state = 7

	elseif cidData.state == 7 and msgcontains(msg, 'plan') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "She ordered her loyal druids and hunters to disguise themselves as orcs from the near island and to attack the Red Legion by night over and over again.", 1)
		cidData.state = 8

	elseif cidData.state == 8 and msgcontains(msg, 'island') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "The General of the Red Legion became very angry about these attacks and after some months he stroke back!", 1)
		cidData.state = 9

	elseif cidData.state == 8 and msgcontains(msg, 'attack') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "The General of the Red Legion became very angry about these attacks and after some months he stroke back!", 1)
		cidData.state = 9

	elseif cidData.state == 9 and msgcontains(msg, 'stroke') and npcHandler:hasFocus(cid) then
		npcHandler:story("Most of the Red Legion went to the island by night. The orcs were not prepared and the Red Legion killed hundreds of orcs with nearly no loss. ...", 1)
		npcHandler:playerSay(cid, "After they were satisfied they walked back to the castle.", 5)
		cidData.state = 10

	elseif cidData.state == 10 and msgcontains(msg, 'back') and npcHandler:hasFocus(cid) then
		npcHandler:story("It is said that the orcish shamans cursed the Red Legion. ...", 1)
		npcHandler:story("Nobody knows. But one third of the soldiers died by a disease on the way back. ...", 5)
		npcHandler:story("And the orcs wanted to take revenge, and after some days they stroke back! ...", 9)
		npcHandler:story("The orcs and many allied cyclopses and minotaurs from all over Tibia came to avenge their friends, and they killed nearly all workers and soldiers in the castle. ...", 13)
		npcHandler:playerSay(cid, "The help of the king's sister came too late.", 17)
		cidData.state = 11

	elseif cidData.state == 10 and  msgcontains(msg, 'walk') and npcHandler:hasFocus(cid) then
		npcHandler:story("It is said that the orcish shamans cursed the Red Legion. ...", 1)
		npcHandler:story("Nobody knows. But one third of the soldiers died by a disease on the way back. ...", 5)
		npcHandler:story("And the orcs wanted to take revenge, and after some days they stroke back! ...", 9)
		npcHandler:story("The orcs and many allied cyclopses and minotaurs from all over Tibia came to avenge their friends, and they killed nearly all workers and soldiers in the castle. ...", 13)
		npcHandler:playerSay(cid, "The help of the king's sister came too late.", 17)
		cidData.state = 11

	elseif cidData.state == 11 and  msgcontains(msg, 'help') and npcHandler:hasFocus(cid) then
		npcHandler:story("She tried to rescue the workers but it was too late. The orcs started immediately to attack her troops, too. ...", 1)
		npcHandler:playerSay(cid, "Her royal troops went back to the city. A trick saved the city from destruction.", 5)
		cidData.state = 12

	elseif cidData.state == 12 and  msgcontains(msg, 'trick') and npcHandler:hasFocus(cid) then
		npcHandler:story("They used the same trick as against the Red Legion and the orcs started to fight their non-orcish-allies. ...", 1)
		npcHandler:story("After a bloody long fight the orcs went back to their cities. The city of Carlin was rescued. ...", 5)
		npcHandler:story("Since then, a woman has always been ruling over Carlin and this statue was made to remind us of their great tactics against the orcs and the Red Legion. ...", 9)
		npcHandler:playerSay(cid, "So that was the story of Carlin and these Fields of Glory. I hope you liked it. *smiles*", 13)

	elseif cidData.state == 12 and  msgcontains(msg, 'destruction') and npcHandler:hasFocus(cid) then
		npcHandler:story("They used the same trick as against the Red Legion and the orcs started to fight their non-orcish-allies. ...", 1)
		npcHandler:story("After a bloody long fight the orcs went back to their cities. The city of Carlin was rescued. ...", 5)
		npcHandler:story("Since then, a woman has always been ruling over Carlin and this statue was made to remind us of their great tactics against the orcs and the Red Legion. ...", 9)
		npcHandler:playerSay(cid, "So that was the story of Carlin and these Fields of Glory. I hope you liked it. *smiles*", 13)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())