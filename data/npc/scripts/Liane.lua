dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

keywordHandler:addKeyword({'kevin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Kevin Postner was already leader of the guild as I joined. I can't imagine anyone better for that position."})
keywordHandler:addKeyword({'postner'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Kevin Postner was already leader of the guild as I joined. I can't imagine anyone better for that position."})
keywordHandler:addKeyword({'postmasters guild'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our guild relys heavily on the honor and trustworthyness of its members."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You might apply for a membership in our haedquarter."})
keywordHandler:addKeyword({'headquarter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Its just south oh Kazordoon. Follow the road and you will run right into it."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am working here at the post office. If you have questions about the Royal Carlin Mail System or the depots ask me."})
keywordHandler:addKeyword({'office'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I rarely leave my office. You are welcome at any time."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Liane."})
keywordHandler:addKeyword({'depot'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The depots are very easily to use. Just step in front of them and you will find your items in them. They are free for all citizens. Hail our Queen!"})
keywordHandler:addKeyword({'queen'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our Queen's rule makes Carlin prosper."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our wonderful town is protected by the wise Queen Eloise."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A town ruled by men, a dangerous place. Anyway, we bring also letters and parcels there."})
keywordHandler:addKeyword({'benjamin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is the postman in Thais and somewhat stupid. But he never sents wrong letters or parcels."})
keywordHandler:addKeyword({'ghostlands'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We don't deliver letters or parcels there, sorry."})
keywordHandler:addKeyword({'wally'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Wally and I became pen-pals in the course of years."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Now it's |TIME|."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'parcel') then
		npcHandler:playerSay(cid, "Would you like to buy a parcel for 10 gold?", 1)
		cidData.state = 8595

	elseif msgcontains(msg, 'letter') then
		npcHandler:playerSay(cid, "Would you like to buy a letter for 5 gold?", 1)
		cidData.state = 8596

	elseif cidData.state == 8595 and msgcontains(msg, 'yes') then
		if doPlayerRemoveMoney(cid, 10) == true then
			npcHandler:playerSay(cid, "Here you are. Don't forget to write the name and the address of the receiver on the label. The label has to be in the parcel before you put the parcel in a mailbox.", 1)
			doPlayerAddItem(cid, 2595)
			doPlayerAddItem(cid, 2599)
		else
			npcHandler:playerSay(cid, "Oh, you do not have enough gold to buy a parcel.", 1)
		end
	elseif cidData.state == 8596 and msgcontains(msg, 'yes') then
		if doPlayerRemoveMoney(cid, 5) == true then
			npcHandler:playerSay(cid, "Here it is. Don't forget to write the name of the receiver in the first line and the address in the second one before you put the letter in a mailbox.", 1)
			doPlayerAddItem(cid, 2597)
		else
			npcHandler:playerSay(cid, "Oh, you do not have enough gold to buy a letter.", 1)
		end

	elseif cidData.state == 8595 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Ok.", 1)
	elseif cidData.state == 8596 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Ok.", 1)

	elseif  msgcontains(msg, 'mail') then
		npcHandler:playerSay(cid, 'Our mail system is unique! And everyone can use it. Do you want to know more about it?', 1)
		cidData.state = 505

	elseif cidData.state == 505 and msgcontains(msg, 'yes') then
		npcHandler:playerSay(cid, 'The Tibia Mail System enables you to send and receive letters and parcels. You can buy them here if you want.', 1)
		cidData.state = 0
	elseif cidData.state == 505 and msgcontains(msg, 'no') then
		npcHandler:playerSay(cid, 'Is there anything else I can do for you?', 1)
		cidData.state = 0

	-- The Postman Missions Quest
	elseif msgcontains(msg, 'measurements') and getPlayerStorageValue(cid,234) > 0 and getPlayerStorageValue(cid,239) < 1 then
		npcHandler:playerSay(cid, 'I have more urgent problem to attend then that. Those hawks are hunting my carrier pigeons. Bring me 12 arrows and I\'ll see if I have the time for this nonsense. Do you have 12 arrows with you?')
		cidData.state = 5

	elseif msgcontains(msg, 'arrows') and getPlayerStorageValue(cid,234) > 0 and getPlayerStorageValue(cid,239) < 1 then
		npcHandler:playerSay(cid, 'Do you have 12 arrows with you?')
		cidData.state = 5

	elseif cidData.state == 5 and msgcontains(msg, 'yes') and getPlayerItemCount(cid,2544) >= 12 then
		npcHandler:playerSay(cid, 'Great! Now I\'ll teach them a lesson ... For those measurements ... <tells you her measurements>')
		doPlayerRemoveItem(cid,2544,12)
		setPlayerStorageValue(cid,239,1)
		setPlayerStorageValue(cid,234,getPlayerStorageValue(cid,234)+1)
		cidData.state = 0

	elseif cidData.state == 5 and msgcontains(msg, 'yes') and getPlayerItemCount(cid,2544) < 12 then
		npcHandler:playerSay(cid, 'Fool, you have no 12 arrows.')
		cidData.state = 0

	elseif cidData.state == 5 and msgcontains(msg, '') then
		npcHandler:playerSay(cid, 'Don\'t waste my time.')
		cidData.state = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())