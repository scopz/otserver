dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)



-- OTServ event handling functions
function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

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
	if(npcHandler.focus ~= cid) then
		return false
	end


----PARCEL SELLER------------------------------------------------------------------------------
	if msgcontains(msg, 'parcel') or msgcontains(msg, 'Parcel') then
		itemname = "parcel"
		itemprice = 10
		npcHandler:say("Would you like to buy a parcel for 10 gold?", 1)
		talk_state = 8595
		
	elseif msgcontains(msg, 'letter') or msgcontains(msg, 'Letter') then
		itemname = "letter"
		itemprice = 5
		npcHandler:say("Would you like to buy a letter for 5 gold?", 1)
		talk_state = 8596	
		
				
	elseif talk_state == 8595 and msgcontains(msg, 'yes') or talk_state == 8595 and msgcontains(msg, 'Yes') then
		if doPlayerRemoveMoney(cid, 10) == true then
			npcHandler:say("Here you are. Don't forget to write the name and the address of the receiver on the label. The label has to be in the parcel before you put the parcel in a mailbox.", 1)
			doPlayerAddItem(cid, 2595)
			doPlayerAddItem(cid, 2599)
		else
		npcHandler:say("Oh, you do not have enough gold to buy a ".. itemname ..".", 1)
		end
	elseif talk_state == 8596 and msgcontains(msg, 'yes') or talk_state == 8596 and msgcontains(msg, 'Yes') then
		if doPlayerRemoveMoney(cid, 5) == true then
			npcHandler:say("Here it is. Don't forget to write the name of the receiver in the first line and the address in the second one before you put the letter in a mailbox.", 1)
			doPlayerAddItem(cid, 2597)
		else
		npcHandler:say("Oh, you do not have enough gold to buy a ".. itemname ..".", 1)
		end
		
	elseif (talk_state == 8595 or talk_state == 8596) and msgcontains(msg, '') then
		npcHandler:say("Ok.", 1)
		talk_state = 0

	elseif  msgcontains(msg, 'mail') then
	    npcHandler:say('Our mail system is unique! And everyone can use it. Do you want to know more about it?', 1)
	    talk_state = 505   

	        elseif talk_state == 505 and msgcontains(msg, 'yes') then
			npcHandler:say('The Tibia Mail System enables you to send and receive letters and parcels. You can buy them here if you want.', 1)
			talk_state = 0
	        elseif talk_state == 505 and msgcontains(msg, 'no') then
			npcHandler:say('Is there anything else I can do for you?', 1)
			talk_state = 0		


----MESSAGES------------------------------------------------------------------------------
	elseif msgcontains(msg, 'change gold') then
		npcHandler:say('How many platinum coins do you want to get?')
		talkState = 8

	elseif msgcontains(msg, 'change platinum') then
		npcHandler:say('Do you want to change your platinum coins to gold or crystal?')
		talkState = 10

	elseif msgcontains(msg, 'change crystal') then
		npcHandler:say('How many crystal coins do you want to change to platinum?')
		talkState = 15

----CHANGE GOLD---------------------------------------------------------------------------------
	elseif talkState == 8 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
    npcHandler:say('Well, can I help you with something else?')
    talkState = 0
	elseif talkState == 8 then
		n = getMoneyCount(msg)
		b = n * 100
		npcHandler:say('So I should change '..b..' of your gold coins to '..n..' platinum coins for you?')
		talkState = 9

	elseif talkState == 9 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2148, b) == true then
				doPlayerAddItem(cid, 2152, n)
				npcHandler:say('Here you are.')
				talkState = 0
			else
				npcHandler:say('You don\'t have money.')
				talkState = 0
			end
		else
			npcHandler:say('Ok. We cancel.')
			talkState = 0
		end

----CHANGE PLATINUM-------------------------------------------------------------------------
	elseif talkState == 10 then
		if msgcontains(msg, 'gold') then
			npcHandler:say('How many platinum coins do you want to change to gold?')
			talkState = 11
		elseif msgcontains(msg, 'crystal') then
			npcHandler:say('How many crystal coins do you want to get?')
			talkState = 13
		end

	elseif talkState == 11 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
		npcHandler:say('Well, can I help you with something else?')
    talkState = 0
	elseif talkState == 11 then
		n = getMoneyCount(msg)
		b = n * 100
		npcHandler:say('So I should change '..n..' of your platinum coins to '..b..' gold coins for you?')
		talkState = 12

	elseif talkState == 12 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2152, n) == true then
				doPlayerAddItem(cid, 2148, b)
				npcHandler:say('Here you are.')
				talkState = 0
			else
				npcHandler:say('You don\'t have money.')
				talkState = 0
			end
		else
			npcHandler:say('Ok. We cancel.')
			talkState = 0
		end
	elseif talkState == 13 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
    npcHandler:say('Well, can I help you with something else?')
    talkState = 0
	elseif talkState == 13 then
		n = getMoneyCount(msg)
		b = n * 100
		npcHandler:say('So I should change '..b..' of your platinum coins to '..n..' crystal coins for you?')
		talkState = 14

	elseif talkState == 14 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2152, b) == true then
				doPlayerAddItem(cid, 2160, n)
				npcHandler:say('Here you are.')
				talkState = 0
			else
				npcHandler:say('You don\'t have money.')
				talkState = 0
			end
		else
			npcHandler:say('Ok. We cancel.')
			talkState = 0
		end

----CHANGE CRYSTAL-------------------------------------------------------------------------------
	elseif talkState == 15 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
    npcHandler:say('Well, can I help you with something else?')
    talkState = 0
	elseif talkState == 15 then
		n = getMoneyCount(msg)
		b = n * 100
		npcHandler:say('So I should change '..n..' of your crystal coins to '..b..' platinum coins for you?')
		talkState = 16

	elseif talkState == 16 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2160, n) == true then
				doPlayerAddItem(cid, 2152, b)
				npcHandler:say('Here you are.')
				talkState = 0
			else
				npcHandler:say('You don\'t have money.')
				talkState = 0
			end
		else
			npcHandler:say('Ok. We cancel.')
			talkState = 0
		end

----BALANCE-------------------------------------------------------------------------
	elseif	msgcontains(msg, 'balance') then
		npcHandler:say("Your account balance is ".. getPlayerBalance(cid) .." gold.", 1)
		talk_state = 0

----DEPOSIT------------------------------------------------------------------------
	elseif	msgcontains(msg, 'deposit all') then
		if getPlayerMoney(cid) > 0 then
			npcHandler:say('Would you like to deposit '.. getPlayerMoney(cid) ..' gold?', 1)
			talk_state = 205
		else
			npcHandler:say('You don\'t have money.', 1)
			talk_state = 0
		end

	elseif	msgcontains(msg, 'deposit') then
		DEPOSITAMOUNT = getMoneyCount(msg)
		if DEPOSITAMOUNT >= 1 then
			if DEPOSITAMOUNT <= getPlayerMoney(cid) then
				npcHandler:say("Would you like to deposit ".. DEPOSITAMOUNT .." gold?", 1)
				talk_state = 203
			else
				npcHandler:say("You don't have that money amount!", 1)
				talk_state = 0
			end
		else
			npcHandler:say('How much would you like to deposit?', 1)
			talk_state = 201
		end

	elseif talk_state == 201 then
		DEPOSITAMOUNT = getMoneyCount(msg)
		if DEPOSITAMOUNT >= 1 then
			if DEPOSITAMOUNT <= getPlayerMoney(cid) then
				npcHandler:say("Would you like to deposit ".. DEPOSITAMOUNT .." gold?", 1)
				talk_state = 203
			else
				npcHandler:say("You don't have that money amount!", 1)
				talk_state = 0
			end
		else
			npcHandler:say("I'm sorry, but you must give me an valid amount of how much you would like to deposit.", 1)
		end

	elseif talk_state == 203 and msgcontains(msg,'no') then
		npcHandler:say('Ok then.')
		talk_state = 0

	elseif talk_state == 203 and msgcontains(msg, 'yes') then
		if doPlayerDepositMoney(cid, DEPOSITAMOUNT) == true then
			npcHandler:say("You have added ".. DEPOSITAMOUNT .." gold to your bank account.", 1)
			talk_state = 0
		else
			npcHandler:say("You don't have that money amount!", 1)
			talk_state = 0
		end

	elseif talk_state == 205 and msgcontains(msg, 'yes') then
		PLAYERCURRENTMONEY = getPlayerMoney(cid)
		if doPlayerDepositMoney(cid, PLAYERCURRENTMONEY) == true then
			npcHandler:say("You have added ".. PLAYERCURRENTMONEY .." gold to your bank account.", 1)
			talk_state = 0
		else
			npcHandler:say("Hey! where did you put the money?", 1)
			talk_state = 0
		end

----WITHDRAW-------------------------------------------------------------------------
	elseif	msgcontains(msg, 'withdraw all') then
		WITHDRAWMONEY = getPlayerBalance(cid)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:say("Would you like to withdraw ".. WITHDRAWMONEY .." gold?", 1)
				talk_state = 303
			else
				npcHandler:say('There is not enough gold on your account.', 1)
				talk_state = 0
			end
		else
			npcHandler:say("You don't have money on your bank account!", 1)
			talk_state = 0
		end

	elseif msgcontains(msg, 'withdraw') then
		WITHDRAWMONEY = getMoneyCount(msg)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:say("Would you like to withdraw ".. WITHDRAWMONEY .." gold?", 1)
				talk_state = 303
			else
				npcHandler:say('There is not enough gold on your account.', 1)
				talk_state = 0
			end
		else
			npcHandler:say('How much would you like to withdraw?', 1)
			talk_state = 301
		end

	elseif talk_state == 301 then
		WITHDRAWMONEY = getMoneyCount(msg)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:say("Would you like to withdraw ".. WITHDRAWMONEY .." gold?", 1)
				talk_state = 303
			else
				npcHandler:say('There is not enough gold on your account.', 1)
				talk_state = 0
			end
		else
			npcHandler:say("I'm sorry, but you must give me a valid amount of how much you would like to withdraw.", 1)
			talk_state = 0
		end

	elseif talk_state == 303 and msgcontains(msg, 'yes') then
		if doPlayerWithdrawMoney(cid, WITHDRAWMONEY) == true then
			npcHandler:say("Here you are.", 1)
			talk_state = 0
		else
			npcHandler:say("You don't have that money amount on your bank account!", 1)
			talk_state = 0
		end

	elseif talk_state == 303 and msgcontains(msg, 'no') then
		npcHandler:say('Ok then.')
		talk_state = 0

----TRANSFER-------------------------------------------------------------------------
	elseif msgcontains(msg, 'transfer') then
		TRANSFERAMOUNT = getMoneyCount(msg)
		if TRANSFERAMOUNT >= 1 then
			if getPlayerBalance(cid) > TRANSFERAMOUNT then
				npcHandler:say('Who would you like transfer ' .. TRANSFERAMOUNT .. ' gold to?', 1)
				talk_state = 504
			else
				npcHandler:say('There is not enough gold on your account.', 1)
				talk_state = 0
			end
		else
			npcHandler:say('Please tell me the amount of gold you would like to transfer.', 1)
			talk_state = 501
		end

	elseif talk_state == 501 and getMoneyCount(msg) >= 1 then
		TRANSFERAMOUNT = getMoneyCount(msg)
		if getPlayerBalance(cid) > TRANSFERAMOUNT then
			npcHandler:say('Who would you like transfer ' .. TRANSFERAMOUNT .. ' gold to?', 1)
			talk_state = 504
		else
			npcHandler:say('There is not enough gold on your account.', 1)
			talk_state = 0
		end

	elseif talk_state == 504 then
		TRANSFERTO = msg
		if playerExists(TRANSFERTO) then
			newmsg = string.upper(string.sub(msg, 0, 1)) .. string.sub(msg, 2)
			UPPERCASETRANSFERTO = newmsg
			npcHandler:say("Would you like to transfer ".. TRANSFERAMOUNT .." gold to ".. UPPERCASETRANSFERTO .."?", 1)
			talk_state = 505
		else
			npcHandler:say("This player does not exist.", 1)
			talk_state = 0
		end

	elseif talk_state == 505 and msgcontains(msg, 'no') then
		npcHandler:say('Ok then.')
		talk_state = 0

	elseif talk_state == 505 and msgcontains(msg, 'yes') then
		receiver = getPlayerGUIDByName(UPPERCASETRANSFERTO)
		if (getVocationByPlayerGUID(getPlayerGUIDByName(UPPERCASETRANSFERTO)) <= 0) or (getVocationByPlayerGUID(getPlayerGUIDByName(UPPERCASETRANSFERTO)) >= 9) then
			npcHandler:say("You can not send money to Rookgaard!", 1)
			talk_state = 0
		elseif receiver == getPlayerGUIDByName(getPlayerName(cid)) then
			npcHandler:say("You can not send money to yourself.", 1)
			talk_state = 0
		else
			doPlayerTransferMoneyTo(cid, UPPERCASETRANSFERTO, TRANSFERAMOUNT)
			npcHandler:say('Very well. You have transferred ' .. TRANSFERAMOUNT .. ' gold to ' .. UPPERCASETRANSFERTO ..'.', 1)
			talk_state = 0
		end
	end

	return true
end



npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())