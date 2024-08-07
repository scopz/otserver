dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am responsible for this post office."})
keywordHandler:addKeyword({'kevin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Mr. Postner is the leader of our guild and the most prominent postofficer in the whole land."})
keywordHandler:addKeyword({'postner'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Mr. Postner is the leader of our guild and the most prominent postofficer in the whole land."})
keywordHandler:addKeyword({'postmasters guild'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yes, our guild is the lifeblood of the tibia cominity so to say."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can apply to join only at our headquarter."})
keywordHandler:addKeyword({'headquarter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can find it on the road from Thais to Kazordoon."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hail to the king!"})
keywordHandler:addKeyword({'tibianus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Hail to the king!"})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The army ensures the safety of the traderoutes and of our mail system."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I bet he never gets any letters."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Better ask knights about that."})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our post system spans the entire known world."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We deliver letters and parcels even there."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We deliver letters and parcels even there."})
keywordHandler:addKeyword({'kazordoon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We deliver letters and parcels even there."})
keywordHandler:addKeyword({"ab'dendriel"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "We deliver letters and parcels even there."})
keywordHandler:addKeyword({'edron'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Our post system even delivers letters and parcels to and from this isle."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, that's postal secret."})
keywordHandler:addKeyword({'rumo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, that's postal secret."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's |TIME|, precisely."})

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
	elseif msgcontains(msg, 'measurements') and getPlayerStorageValue(cid,234) > 0 and getPlayerStorageValue(cid,241) < 1 then
		npcHandler:playerSay(cid, 'If its necessary ... <tells you her measurements>')
		setPlayerStorageValue(cid,241,1)
		setPlayerStorageValue(cid,234,getPlayerStorageValue(cid,234)+1)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())