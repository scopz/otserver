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
	if getPlayerSex(cid) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Oh, hello, handsome! It's a pleasure to meet you ".. getPlayerName(cid) ..".")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Oh, hello ".. getPlayerName(cid) ..", your hair looks great! Who did it for you?")
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

local shopModule = ShopModule:new()
npcHandler:addModule(shopModule)

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if getPlayerSex(cid) == 1 then
		cidData.state = 1
	end

	CHANCE = math.random(1,100)
	PROCENT = 30 --procent of the risk to get stealed on money
	if cidData.state == 0 and msgcontains(msg, '') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "I would never have guessed that.", 1)
		cidData.state = 1
	elseif msgcontains(msg, '') and npcHandler:hasFocus(cid) and getPlayerItemCount(cid,2148) <= 20 and getPlayerItemCount(cid,2152) <= 0 and getPlayerItemCount(cid,2160) <= 0 then
		npcHandler:playerSay(cid, "Oh, I just remember I have some work to do, sorry. Bye!", 1)
		cidData.state = 1
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	elseif msgcontains(msg, '') and npcHandler:hasFocus(cid) and getPlayerItemCount(cid,2148) <= 0 and getPlayerItemCount(cid,2152) <= 1 and getPlayerItemCount(cid,2160) <= 0 then
		npcHandler:playerSay(cid, "Oh, I just remember I have some work to do, sorry. Bye!", 1)
		cidData.state = 1
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)
	elseif msgcontains(msg, '') and npcHandler:hasFocus(cid) and getPlayerItemCount(cid,2148) <= 0 and getPlayerItemCount(cid,2152) <= 0 and getPlayerItemCount(cid,2160) <= 1 then
		npcHandler:playerSay(cid, "Oh, I just remember I have some work to do, sorry. Bye!", 1)
		cidData.state = 1
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif msgcontains(msg, 'how are you') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Thank you very much. How kind of you to care about me. I am fine, thank you.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'sell') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Sorry, I have nothing to sell.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'job') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I do some work now and then. Nothing unusual, though.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'new') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "You should ask Oswald about news. He loves them.", 1)
		cidData.state = 1

	elseif msgcontains(msg, 'name') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			if getPlayerSex(cid) == 1 then
				npcHandler:playerSay(cid, "I am a little sad, that you seem to have forgotten me, handsome. I am Aruda.", 1)
			else
				npcHandler:playerSay(cid, "I am Aruda.", 1)
			end
		end
		cidData.state = 1

	elseif msgcontains(msg, 'aruda') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			if getPlayerSex(cid) == 1 then
				npcHandler:playerSay(cid, "Oh, I like it, how you say my name.", 1)
			else
				npcHandler:playerSay(cid, "Yes, that's me!", 1)
			end
		end
		cidData.state = 1

	elseif msgcontains(msg, 'time') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT then
			npcHandler:playerSay(cid, "Take some time to talk to me!", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Please don't be so rude to look for the time if you are talking to me.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'help') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I am deeply sorry, I can't help you.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'monster') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "UH! What a terrifying topic. Please let us speak about something more pleasant, I am a weak and small woman after all.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'dungeon') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "UH! What a terrifying topic. Please let us speak about something more pleasant, I am a weak and small woman after all.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'sewer') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "What gives you the impression, I am the kind of women, you find in sewers?", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'god') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "You should ask about that in one of the temples.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'king') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 10) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "The king, that lives in this fascinating castle? I think he does look kind of cute in his luxurious robes, doesn't he?", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'sam') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			if getPlayerSex(cid) == 1 then
				npcHandler:playerSay(cid, "He is soooo strong! What muscles! What a body! On the other hand, compared to you he looks quite puny.", 1)
			else
				npcHandler:playerSay(cid, "He is soooo strong! What muscles! What a body! Did you ask him for a date?", 1)
			end
			cidData.state = 1
		end

	elseif msgcontains(msg, 'benjamin') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "He is a little simple minded but always nice and well dressed.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'gorn') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "He should really sell some stylish gowns or something like that. We Tibians never get some clothing of the latest fashion. It's a shame.", 1)
			cidData.state = 1
		end


	elseif msgcontains(msg, 'quentin') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I don't understand this lonely monks. I love company too much to become one. He, he, he!", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'bozo') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Oh, isn't he funny? I could listen to him the whole day.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'oswald') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "As far as I know, he is working in the castle.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'rumour') and npcHandler:hasFocus(cid) or msgcontains(msg, 'rumor') and npcHandler:hasFocus(cid) or msgcontains(msg, 'gossip') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I am a little shy and so don't hear many rumors", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'fuck') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 20) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			if getPlayerSex(cid) == 1 then
				npcHandler:playerSay(cid, "Oh, you little devil, stop talking like that! <blush>", 1)
			else
				npcHandler:playerSay(cid, "Uhm, let us change the subject, please.", 1)
			end
			cidData.state = 1
		end

	elseif msgcontains(msg, 'kiss') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 20) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			if getPlayerSex(cid) == 1 then
				npcHandler:playerSay(cid, "Oh, you little devil, stop talking like that! <blush>", 1)
			else
				npcHandler:playerSay(cid, "Uhm, let us change the subject, please.", 1)
			end
			cidData.state = 1
		end

	elseif msgcontains(msg, 'weapon') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I know so little about weapons, so tell me something about weapons, please.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'magic') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I believe that love is stronger then all magic, don't you agree?", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'thief') and npcHandler:hasFocus(cid) or msgcontains(msg, 'theft') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "Oh, sorry, I have to hurry, bye!", 1)
		cidData.state = 1
		npcHandler:releaseFocus(cid)
		npcHandler:resetNpc(cid)

	elseif msgcontains(msg, 'tibia') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I would like to visit the beach more often, but I guess it's too dangerous.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'castle') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I love this castle! It's so beautiful.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'muriel') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Powerful sorcerers frighten me a little.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'elane') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I personally think it's inappropriate for a woman to become a warrior, what do you think about that?", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'marvik') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Druids seldom visit a town, what do you know about druids?", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'gregor') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I like brave fighters like him.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'noodles') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Oh, he is sooooo cute!", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'dog') and npcHandler:hasFocus(cid) or msgcontains(msg, 'poodle') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 5) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "I like dogs, the little ones at least. Do you like dogs, too?", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'excalibug') and npcHandler:hasFocus(cid) then
		if CHANCE <= PROCENT and doPlayerRemoveMoney(cid, 10) then
			npcHandler:playerSay(cid, "Oh, sorry, I was distracted, what did you say?", 1)
			cidData.state = 1
		else
			npcHandler:playerSay(cid, "Oh, I am just a girl and know nothing about magic swords and such things.", 1)
			cidData.state = 1
		end

	elseif msgcontains(msg, 'partos') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "I ... don't know someone named like that.", 1)
		cidData.state = 4

	elseif cidData.state == 4 and msgcontains(msg, 'spouse') and npcHandler:hasFocus(cid) or cidData.state == 4 and msgcontains(msg, 'girlfriend') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "Well ... I  might have known him a little .. but there was nothing serious.", 1)
		cidData.state = 5

	elseif cidData.state == 5 and msgcontains(msg, 'fruit') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "I remember that grapes were his favourites. He was almost addicted to them.", 1)
		cidData.state = 1

	elseif msgcontains(msg, 'yenny') and npcHandler:hasFocus(cid) then
		npcHandler:playerSay(cid, "Yenny? I know no Yenny, nor have I ever used that name! You have mistook me with someone else.", 1)
		cidData.state = 1
	end
	return true
end


npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())