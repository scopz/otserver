dofile(getDataDir() .. 'npc/scripts/lib/greeting.lua')

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

local fire = createConditionObject(CONDITION_FIRE)
setConditionParam(fire, CONDITION_PARAM_DELAYED, 10)
addDamageCondition(fire, 10, 3000, -10)

-- OTServ event handling functions
function onCreatureAppear(cid)         npcHandler:onCreatureAppear(cid)         end
function onCreatureDisappear(cid)      npcHandler:onCreatureDisappear(cid)      end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end

function getMonstersfromArea(pos, radiusx, radiusy, stack)
  local monsters = { }
  local starting = {x = (pos.x - 4), y = (pos.y - 3), z = pos.z, stackpos = stack}
  local ending = {x = (pos.x + 4), y = (pos.y + 3), z = pos.z, stackpos = stack}
  local checking = {x = starting.x, y = starting.y, z = starting.z, stackpos = starting.stackpos}
  repeat
    creature = getThingfromPos(checking)
    if creature.itemid > 0 then
      if isCreature(creature.uid) == true then
        if isPlayer(creature.uid) == false then
          table.insert (monsters, creature.uid)
        end
      end
    end
    if checking.x == pos.x-1 and checking.y == pos.y then
      checking.x = checking.x+2
    else
      checking.x = checking.x+1
    end
    if checking.x > ending.x then
      checking.x = starting.x
      checking.y = checking.y+1
    end
  until checking.y > ending.y
  return monsters
end

function onThink()
  npcHandler:onThink()
  local monster_table = getMonstersfromArea(getCreaturePosition(getNpcCid()), radiusx, radiusy, 253)
  if #monster_table >= 1 then
    for i = 1, #monster_table do
      if getCreatureMaxHealth(monster_table[i]) >= 401 and isPlayer(monster_table[i]) == false then
        doRemoveCreature(monster_table[i])
        npcHandler:say('Get lost your beast!', 0.5)
      end
    end
  elseif table.getn(monster_table) < 1 then
  end
end

keywordHandler:addKeyword({'sell'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Visit Tibia's shopkeepers to buy their fine wares."})
keywordHandler:addKeyword({'buy'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Visit Tibia's shopkeepers to buy their fine wares."})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "It's my duty to protect the city."})
keywordHandler:addKeyword({'city'}, StdModule.say, {npcHandler = npcHandler, onlyFocus = true, text = "Behave while in the city or we get you! Do you want to know where to find a shop or a guild?"})

function creatureSayCallback(cid, type, msg)
	if not npcHandler:hasFocus(cid) then
		return false
	end

	msg = string.lower(msg)

	if msgcontains(msg, "idiot")   or msgcontains(msg, "asshole")
	or msgcontains(msg, "retard")  or msgcontains(msg, "sucker")
	or msgcontains(msg, "fag")     or msgcontains(msg, "fuck")
	or msgcontains(msg, "shut up") or msgcontains(msg, "shit")
	or msgcontains(msg, "ugly")    or msgcontains(msg, "smell")
	or msgcontains(msg, "blow")    or msgcontains(msg, "cock")
	or msgcontains(msg, "dick")    or msgcontains(msg, "pussy")
	or msgcontains(msg, "vagina")  or msgcontains(msg, "bitch")
	or msgcontains(msg, "nigger") then
		doSendMagicEffect(getCreaturePosition(getNpcCid()), 13)
		doSendMagicEffect(getPlayerPosition(cid), 15)
		doAddCondition(cid, fire)
		npcHandler:playerSay(cid, "Take this!", 0.5)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())