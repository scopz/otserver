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

NpcPreset:mainWeaponShop(shopModule)
NpcPreset:mainArmorShop(shopModule)

NpcPreset:altWeaponShop(shopModule)
NpcPreset:altArmorShop(shopModule)

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end
	msg = string.lower(msg)
	local cidData = npcHandler:getFocusPlayerData(cid)

	if msgcontains(msg, 'magic plate armor') then
		npcHandler:playerSay(cid, 'WOW! Do you really want to sell me a MAGIC plate armor?')
		cidData.state = 3

	elseif msgcontains(msg, 'yes') and cidData.state == 3 then
		npcHandler:playerSay(cid, 'Oh, unbelievable! I would pay 6400 gold for this wonderful piece of armor. Are you still interested?')
		cidData.state = 4
	elseif msgcontains(msg, 'no') and cidData.state == 3 then
		npcHandler:playerSay(cid, 'Hmmm, what a pity! I am looking for such an armor since I live in Thais.')
		cidData.state = 0

	elseif msgcontains(msg, 'yes') and cidData.state == 4 and getPlayerItemCount(cid, 2472) >= 1 then
		npcHandler:playerSay(cid, 'Finally it is mine! Here is your money. Can I be of any further help?')
		doPlayerAddMoney(cid, 6400)
		doPlayerRemoveItem(cid, 2472, 1)
		cidData.state = 0
	elseif msgcontains(msg, 'yes') and cidData.state == 4 and getPlayerItemCount(cid, 2472) == 0 then
		npcHandler:playerSay(cid, 'Argl! You do not have one! Trying to tease me? Get lost or I call the guards!')
	elseif msgcontains(msg, 'no') and cidData.state == 4 then
		npcHandler:playerSay(cid, 'Maybe my offer is too low? Unfortunately I can not bring up more money, I am just a smith.')
		cidData.state = 0

	elseif msgcontains(msg, 'backpack') or msgcontains(msg, 'old backpack') then
		npcHandler:playerSay(cid, 'What? Are you telling me you found my old adventurer\'s backpack that I lost years ago??')
		cidData.state = 5

	elseif msgcontains(msg, 'yes') and cidData.state == 5 and getPlayerItemCount(cid, 3960) >= 1 then
		npcHandler:playerSay(cid, 'Thank you very much! This brings back good old memories! Please, as a reward, travel to kazordoon and ask my old friend Kroox to provide you a special dwarven armor. ...', 1)
		npcHandler:playerSay(cid, 'I will mail him about you immediately. Just tell him, his old buddy sam is sending you.', 5)
		setPlayerStorageValue(cid, 289, 1)
		doPlayerRemoveItem(cid, 3960, 1)
		cidData.state = 0
	elseif msgcontains(msg, 'yes') and cidData.state == 5 and getPlayerItemCount(cid, 3960) == 0 then
		npcHandler:playerSay(cid, 'No, you don\'t have my old backpack. What a pity.')
		cidData.state = 0
	elseif msgcontains(msg, 'no') and cidData.state == 5 then
		npcHandler:playerSay(cid, 'What a pity.')
		cidData.state = 0
	end

	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am the blacksmith. If you need weapons or armor - just ask me.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My offers are weapons, armors, helmets, legs, and shields.'})
keywordHandler:addKeyword({'trade'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'My offers are weapons, armors, helmets, legs, and shields.'})
keywordHandler:addKeyword({'weapons'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I have hand axes, axes, spears, maces, battle hammers, swords, rapiers, daggers, and sabres. What's your choice?"})
keywordHandler:addKeyword({'helmets'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling leather helmets and chain helmets. What do you want?'})
keywordHandler:addKeyword({'armor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling leather, chain and brass armors. What do you need?'})
keywordHandler:addKeyword({'shield'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling wooden shields and steel shields. What do you want?'})
keywordHandler:addKeyword({'legs'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = 'I am selling chain legs. Do you want to buy any?'})

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "My name is Samuel, but you can call me Sam."})
keywordHandler:addKeyword({'king'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king supports Tibia's economy a lot."})
keywordHandler:addKeyword({'tibanus'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The king supports Tibia's economy a lot."})
keywordHandler:addKeyword({'quentin'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is a monk of some kind!"})
keywordHandler:addKeyword({'lynda'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Uhm! ---blush---"})
keywordHandler:addKeyword({'harkath'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A warrior who is a joy for Banor."})
keywordHandler:addKeyword({'general'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A warrior who is a joy for Banor."})
keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I supply the army with weapons and armor."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A threat for mankind! Buy weapons to be ready to face him."})
keywordHandler:addKeyword({'sam'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I was named after my grandfather."})
keywordHandler:addKeyword({'gorn'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He can tell a tale or two about his adventures with baxter in their younger days."})
keywordHandler:addKeyword({'frodo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I don't like crowded places like his bar."})
keywordHandler:addKeyword({'elane'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Oh, I hardly know her."})
keywordHandler:addKeyword({'muriel'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Sorcerers seldom need my skills."})
keywordHandler:addKeyword({'gregor'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "His guild relies heavily on my wares."})
keywordHandler:addKeyword({'marvik'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I never visited his ... cave or whatever it's called."})
keywordHandler:addKeyword({'bozo'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "He is funny now and then."})
keywordHandler:addKeyword({'baxter'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "A fine warrior."})
keywordHandler:addKeyword({'oswald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Oswald isn't one of the most liked people in this city."})
keywordHandler:addKeyword({'sherry'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The McRonalds are the local farmers, aren't they?"})
keywordHandler:addKeyword({'donald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The McRonalds are the local farmers, aren't they?"})
keywordHandler:addKeyword({'mcronald'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "The McRonalds are the local farmers, aren't they?"})
keywordHandler:addKeyword({'lurgi'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I just know some rumours that he is a follower of evil."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is rumoured to be a weapon beyond mortal craftsmanship."})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I know nothing of interest."})
keywordHandler:addKeyword({'help'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "I sell and buy weapons, armor, helmets, and shields. So you are able to slash the monsters."})
keywordHandler:addKeyword({'monster'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Yeah, these awful beasts. They live in the forests near the city and in the sewers and dungeons."})
keywordHandler:addKeyword({'dungeon'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Below our city are the sewers and I heard about a passage to the deeper dungeons."})
keywordHandler:addKeyword({'sewer'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Below our city are the sewers and I heard about a passage to the deeper dungeons."})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Don't ask me. I have never been there."})
keywordHandler:addKeyword({'thanks'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You are welcome."})
keywordHandler:addKeyword({'thank'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "You are welcome."})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It is |TIME|."})

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())

function onCreatureSell(...)
	shopModule:sellItemToPlayer(unpack(arg))
end