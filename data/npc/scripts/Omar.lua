dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I change and deposit money. I can also help using our Mail System."})
keywordHandler:addKeyword({'join'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Please travel to our headquarters if you wish to join our guild."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Omar."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A weapon of legend. We rarely hear stories about it around here, however."})
keywordHandler:addKeyword({'new'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It does not befit a member of my position to spread rumours and stories, pilgrim."})
keywordHandler:addKeyword({'thais'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Thais is the capital of a kingdom on a far-off continent."})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Carlin is a city far, far away from here. They say it is run by women and druids."})
keywordHandler:addKeyword({'daraman'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "As far as I can tell he was some philosopher."})
keywordHandler:addKeyword({'darama'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "On this continent, the only place of real importance is our city."})
keywordHandler:addKeyword({'darashia'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A minor settlement to the north."})
keywordHandler:addKeyword({'ankrahmun'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "This city is a safe haven that protects its citizens from the dangers of the desert."})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "This city is a safe haven that protects its citizens from the dangers of the desert."})
keywordHandler:addKeyword({'pharaoh'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The pharaoh keeps this city safe. He is both our political and our spiritual leader."})
keywordHandler:addKeyword({'arkhothep'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The pharaoh keeps this city safe. He is both our political and our spiritual leader."})
keywordHandler:addKeyword({'ascension'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, but you should discuss religous issues like these in the temple. I am not a priest, and there is little I can tell you about it."})
keywordHandler:addKeyword({"Akh'rah Uthun"}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, but you should discuss religous issues like these in the temple. I am not a priest, and there is little I can tell you about it."})
keywordHandler:addKeyword({'Akh'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, but you should discuss religous issues like these in the temple. I am not a priest, and there is little I can tell you about it."})
keywordHandler:addKeyword({'Rah'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, but you should discuss religous issues like these in the temple. I am not a priest, and there is little I can tell you about it."})
keywordHandler:addKeyword({'uthun'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorry, but you should discuss religous issues like these in the temple. I am not a priest, and there is little I can tell you about it."})
keywordHandler:addKeyword({'arena'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Fights are frequently staged in the arena to entertain the people."})
keywordHandler:addKeyword({'palace'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You can't miss the palace. It is probably the biggest pyramid in the whole world."})
keywordHandler:addKeyword({'temple'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The temple is to the east of the city."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The time is |TIME|, pilgrim."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

----PARCEL SELLER------------------------------------------------------------------------------
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
		
	elseif (cidData.state == 8595 or cidData.state == 8596) and msgcontains(msg, '') then
		npcHandler:playerSay(cid, "Ok.", 1)
		cidData.state = 0

	elseif  msgcontains(msg, 'mail') then
		npcHandler:playerSay(cid, 'Our mail system is unique! And everyone can use it. Do you want to know more about it?', 1)
		cidData.state = 505   

	elseif cidData.state == 505 and msgcontains(msg, 'yes') then
		npcHandler:playerSay(cid, 'The Tibia Mail System enables you to send and receive letters and parcels. You can buy them here if you want.', 1)
		cidData.state = 0
	elseif cidData.state == 505 and msgcontains(msg, 'no') then
		npcHandler:playerSay(cid, 'Is there anything else I can do for you?', 1)
		cidData.state = 0		
	end
	return true
end



npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
npcHandler:addModule(BankModule:new())
