dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink()                     npcHandler:onThink()                     end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I work in this bank. I can change money for you."})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I am Eva."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is exactly |TIME|."})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

----MESSAGES------------------------------------------------------------------------------
	if msgcontains(msg, 'change gold') then
		npcHandler:playerSay(cid, 'How many platinum coins do you want to get?')
		cidData.state = 8

	elseif msgcontains(msg, 'change platinum') then
		npcHandler:playerSay(cid, 'Do you want to change your platinum coins to gold or crystal?')
		cidData.state = 10

	elseif msgcontains(msg, 'change crystal') then
		npcHandler:playerSay(cid, 'How many crystal coins do you want to change to platinum?')
		cidData.state = 15

----CHANGE GOLD---------------------------------------------------------------------------------
	elseif cidData.state == 8 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
		npcHandler:playerSay(cid, 'Well, can I help you with something else?')
		cidData.state = 0
	elseif cidData.state == 8 then
		n = getMoneyCount(msg)
		b = n * 1000
		npcHandler:playerSay(cid, 'So I should change '..b..' of your gold coins to '..n..' platinum coins for you?')
		cidData.state = 9

	elseif cidData.state == 9 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2148, b) == true then
				doPlayerAddItem(cid, 2152, n)
				npcHandler:playerSay(cid, 'Here you are.')
				cidData.state = 0
			else
				npcHandler:playerSay(cid, 'You don\'t have money.')
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'Ok. We cancel.')
			cidData.state = 0
		end

----CHANGE PLATINUM-------------------------------------------------------------------------
	elseif cidData.state == 10 then
		if msgcontains(msg, 'gold') then
			npcHandler:playerSay(cid, 'How many platinum coins do you want to change to gold?')
			cidData.state = 11
		elseif msgcontains(msg, 'crystal') then
			npcHandler:playerSay(cid, 'How many crystal coins do you want to get?')
			cidData.state = 13
		end

	elseif cidData.state == 11 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
		npcHandler:playerSay(cid, 'Well, can I help you with something else?')
		cidData.state = 0
	elseif cidData.state == 11 then
		n = getMoneyCount(msg)
		b = n * 1000
		npcHandler:playerSay(cid, 'So I should change '..n..' of your platinum coins to '..b..' gold coins for you?')
		cidData.state = 12

	elseif cidData.state == 12 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2152, n) == true then
				doPlayerAddItem(cid, 2148, b)
				npcHandler:playerSay(cid, 'Here you are.')
				cidData.state = 0
			else
				npcHandler:playerSay(cid, 'You don\'t have money.')
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'Ok. We cancel.')
			cidData.state = 0
		end
	elseif cidData.state == 13 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
		npcHandler:playerSay(cid, 'Well, can I help you with something else?')
		cidData.state = 0
	elseif cidData.state == 13 then
		n = getMoneyCount(msg)
		b = n * 1000
		npcHandler:playerSay(cid, 'So I should change '..b..' of your platinum coins to '..n..' crystal coins for you?')
		cidData.state = 14

	elseif cidData.state == 14 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2152, b) == true then
				doPlayerAddItem(cid, 2160, n)
				npcHandler:playerSay(cid, 'Here you are.')
				cidData.state = 0
			else
				npcHandler:playerSay(cid, 'You don\'t have money.')
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'Ok. We cancel.')
			cidData.state = 0
		end

----CHANGE CRYSTAL-------------------------------------------------------------------------------
	elseif cidData.state == 15 and (getMoneyCount(msg) <= 0 or getMoneyCount(msg) >= 999) then
		npcHandler:playerSay(cid, 'Well, can I help you with something else?')
		cidData.state = 0
	elseif cidData.state == 15 then
		n = getMoneyCount(msg)
		b = n * 1000
		npcHandler:playerSay(cid, 'So I should change '..n..' of your crystal coins to '..b..' platinum coins for you?')
		cidData.state = 16

	elseif cidData.state == 16 then
		if msgcontains(msg, 'yes') then
			if doPlayerRemoveItem(cid, 2160, n) == true then
				doPlayerAddItem(cid, 2152, b)
				npcHandler:playerSay(cid, 'Here you are.')
				cidData.state = 0
			else
				npcHandler:playerSay(cid, 'You don\'t have money.')
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'Ok. We cancel.')
			cidData.state = 0
		end

----BALANCE-------------------------------------------------------------------------
	elseif	msgcontains(msg, 'balance') then
		npcHandler:playerSay(cid, "Your account balance is ".. getPlayerBalance(cid) .." gold.", 1)
		cidData.state = 0

----DEPOSIT------------------------------------------------------------------------
	elseif	msgcontains(msg, 'deposit all') then
		if getPlayerMoney(cid) > 0 then
			npcHandler:playerSay(cid, 'Would you like to deposit '.. getPlayerMoney(cid) ..' gold?', 1)
			cidData.state = 205
		else
			npcHandler:playerSay(cid, 'You don\'t have money.', 1)
			cidData.state = 0
		end

	elseif	msgcontains(msg, 'deposit') then
		DEPOSITAMOUNT = getMoneyCount(msg)
		if DEPOSITAMOUNT >= 1 then
			if DEPOSITAMOUNT <= getPlayerMoney(cid) then
				npcHandler:playerSay(cid, "Would you like to deposit ".. DEPOSITAMOUNT .." gold?", 1)
				cidData.state = 203
			else
				npcHandler:playerSay(cid, "You don't have that money amount!", 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'How much would you like to deposit?', 1)
			cidData.state = 201
		end

	elseif cidData.state == 201 then
		DEPOSITAMOUNT = getMoneyCount(msg)
		if DEPOSITAMOUNT >= 1 then
			if DEPOSITAMOUNT <= getPlayerMoney(cid) then
				npcHandler:playerSay(cid, "Would you like to deposit ".. DEPOSITAMOUNT .." gold?", 1)
				cidData.state = 203
			else
				npcHandler:playerSay(cid, "You don't have that money amount!", 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, "I'm sorry, but you must give me an valid amount of how much you would like to deposit.", 1)
		end

	elseif cidData.state == 203 and msgcontains(msg,'no') then
		npcHandler:playerSay(cid, 'Ok then.')
		cidData.state = 0

	elseif cidData.state == 203 and msgcontains(msg, 'yes') then
		if doPlayerDepositMoney(cid, DEPOSITAMOUNT) == true then
			npcHandler:playerSay(cid, "You have added ".. DEPOSITAMOUNT .." gold to your bank account.", 1)
			cidData.state = 0
		else
			npcHandler:playerSay(cid, "You don't have that money amount!", 1)
			cidData.state = 0
		end

	elseif cidData.state == 205 and msgcontains(msg, 'yes') then
		PLAYERCURRENTMONEY = getPlayerMoney(cid)
		if doPlayerDepositMoney(cid, PLAYERCURRENTMONEY) == true then
			npcHandler:playerSay(cid, "You have added ".. PLAYERCURRENTMONEY .." gold to your bank account.", 1)
			cidData.state = 0
		else
			npcHandler:playerSay(cid, "Hey! where did you put the money?", 1)
			cidData.state = 0
		end

----WITHDRAW-------------------------------------------------------------------------
	elseif	msgcontains(msg, 'withdraw all') then
		WITHDRAWMONEY = getPlayerBalance(cid)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:playerSay(cid, "Would you like to withdraw ".. WITHDRAWMONEY .." gold?", 1)
				cidData.state = 303
			else
				npcHandler:playerSay(cid, 'There is not enough gold on your account.', 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, "You don't have money on your bank account!", 1)
			cidData.state = 0
		end

	elseif msgcontains(msg, 'withdraw') then
		WITHDRAWMONEY = getMoneyCount(msg)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:playerSay(cid, "Would you like to withdraw ".. WITHDRAWMONEY .." gold?", 1)
				cidData.state = 303
			else
				npcHandler:playerSay(cid, 'There is not enough gold on your account.', 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'How much would you like to withdraw?', 1)
			cidData.state = 301
		end

	elseif cidData.state == 301 then
		WITHDRAWMONEY = getMoneyCount(msg)
		if WITHDRAWMONEY >= 1 then
			if getPlayerBalance(cid) >= WITHDRAWMONEY then
				npcHandler:playerSay(cid, "Would you like to withdraw ".. WITHDRAWMONEY .." gold?", 1)
				cidData.state = 303
			else
				npcHandler:playerSay(cid, 'There is not enough gold on your account.', 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, "I'm sorry, but you must give me a valid amount of how much you would like to withdraw.", 1)
			cidData.state = 0
		end

	elseif cidData.state == 303 and msgcontains(msg, 'yes') then
		if doPlayerWithdrawMoney(cid, WITHDRAWMONEY) == true then
			npcHandler:playerSay(cid, "Here you are.", 1)
			cidData.state = 0
		else
			npcHandler:playerSay(cid, "You don't have that money amount on your bank account!", 1)
			cidData.state = 0
		end

	elseif cidData.state == 303 and msgcontains(msg, 'no') then
		npcHandler:playerSay(cid, 'Ok then.')
		cidData.state = 0

----TRANSFER-------------------------------------------------------------------------
	elseif msgcontains(msg, 'transfer') then
		TRANSFERAMOUNT = getMoneyCount(msg)
		if TRANSFERAMOUNT >= 1 then
			if getPlayerBalance(cid) > TRANSFERAMOUNT then
				npcHandler:playerSay(cid, 'Who would you like transfer ' .. TRANSFERAMOUNT .. ' gold to?', 1)
				cidData.state = 504
			else
				npcHandler:playerSay(cid, 'There is not enough gold on your account.', 1)
				cidData.state = 0
			end
		else
			npcHandler:playerSay(cid, 'Please tell me the amount of gold you would like to transfer.', 1)
			cidData.state = 501
		end

	elseif cidData.state == 501 and getMoneyCount(msg) >= 1 then
		TRANSFERAMOUNT = getMoneyCount(msg)
		if getPlayerBalance(cid) > TRANSFERAMOUNT then
			npcHandler:playerSay(cid, 'Who would you like transfer ' .. TRANSFERAMOUNT .. ' gold to?', 1)
			cidData.state = 504
		else
			npcHandler:playerSay(cid, 'There is not enough gold on your account.', 1)
			cidData.state = 0
		end

	elseif cidData.state == 504 then
		TRANSFERTO = msg
		if playerExists(TRANSFERTO) then
			newmsg = string.upper(string.sub(msg, 0, 1)) .. string.sub(msg, 2)
			UPPERCASETRANSFERTO = newmsg
			npcHandler:playerSay(cid, "Would you like to transfer ".. TRANSFERAMOUNT .." gold to ".. UPPERCASETRANSFERTO .."?", 1)
			cidData.state = 505
		else
			npcHandler:playerSay(cid, "This player does not exist.", 1)
			cidData.state = 0
		end

	elseif cidData.state == 505 and msgcontains(msg, 'no') then
		npcHandler:playerSay(cid, 'Ok then.')
		cidData.state = 0

	elseif cidData.state == 505 and msgcontains(msg, 'yes') then
		receiver = getPlayerGUIDByName(UPPERCASETRANSFERTO)
		if (getVocationByPlayerGUID(getPlayerGUIDByName(UPPERCASETRANSFERTO)) <= 0) or (getVocationByPlayerGUID(getPlayerGUIDByName(UPPERCASETRANSFERTO)) >= 9) then
			npcHandler:playerSay(cid, "You can not send money to Rookgaard!", 1)
			cidData.state = 0
		elseif receiver == getPlayerGUIDByName(getPlayerName(cid)) then
			npcHandler:playerSay(cid, "You can not send money to yourself.", 1)
			cidData.state = 0
		else
			doPlayerTransferMoneyTo(cid, UPPERCASETRANSFERTO, TRANSFERAMOUNT)
			npcHandler:playerSay(cid, 'Very well. You have transferred ' .. TRANSFERAMOUNT .. ' gold to ' .. UPPERCASETRANSFERTO ..'.', 1)
			cidData.state = 0
		end
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
