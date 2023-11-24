Mod = RegisterMod("Curse Experiment", 1)
if not CurseRewards then
	CurseRewards = {}
end

local rewardTables = {}
rewardTables[0] = {}

local RECOMMENDED_SHIFT_IDX = 35
local game = Game()
local seeds = game:GetSeeds()
local startSeed = seeds:GetStartSeed()
local rng = RNG()
rng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)
------------ Save Data stuff
CurseRewards.SaveData = CurseRewards.SaveData or {}
local JSON = include("json")

function Mod:LoadSaveData(save)
  if Mod:HasData() and save then
    CurseRewards.SaveData = JSON.decode(Mod:LoadData())
  
  elseif CurseRewards.SaveData == nil then
    CurseRewards.SaveData = copytable(rewardTables)
 end

end

Mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED,Mod.LoadSaveData)


function Mod:SaveDataOnExit ()
  Mod:SaveData(JSON.encode(CurseRewards.SaveData))
end

Mod:AddCallback(ModCallbacks.MC_PRE_GAME_EXIT,Mod.SaveDataOnExit)
Mod:AddCallback(ModCallbacks.MC_POST_GAME_END,Mod.SaveDataOnExit)

local function copytable (t1)
	local result = {}
	for i,v in pairs(t1) do
	  result[i] = v
	end
	return result
end

function Mod:ResetPoolsOnNewRun (save)
	if not save then
	  CurseRewards.SaveData = copytable(rewardTables)
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Mod.ResetPoolsOnNewRun)

-- add items to the reward table
function Mod:addToPool (tableIndex,item,weight)
	rewardTables = rewardTables or {}
	--rewardTables[tableIndex] = rewardTables[tableIndex] or {}
	weight = weight or 1
	if rewardTables[tableIndex] then
		for i = 1,weight do
			table.insert(rewardTables[tableIndex],item)
		end
	end
end

--add items to different reward tables
-- run on game start


--add items to the darkness pool
Mod:addToPool(0,425,1)
Mod:addToPool(0,588,1)

-- choose item from reward table

function Mod:PickItemFromPool(rngLocal,tableIndex)
	rngLocal = rngLocal or RNG()
	tableIndex = tableIndex or 0
	local pool = CurseRewards.SaveData[tableIndex]
	local poolsize = #pool
	local resulti = rng:RandomInt(poolsize) + 1
	local result = pool[resulti]
	-- remove item from pool
	Mod:RemoveItemFromPool(tableIndex,result)
	return result
end

-- remove item from pool
function Mod:RemoveItemFromPool(tableIndex,item)
	tableIndex = tableIndex or 0
	local pool = CurseRewards.SaveData[tableIndex]
	local poolsize = #pool
	for i = 1,poolsize do
		if pool[i] == item then
			table.remove(pool,i)
			break
		end
	end
end

-- give rewards on room clear
function Mod:doSomething()
	--check if room is boss room
	local game = Game()
	local level = game:GetLevel()
	local room = level:GetCurrentRoom()
	local item = Mod:PickItemFromPool(rng,0)
	-- spawn item
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, item, Vector(320,280), Vector(0,0), nil);
	--Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, game:GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE), Vector(320,280), Vector(0,0), nil);
	--check if room is boss room
	if room:GetType() == 5 then
		-- check if player has curse of darkness
		if level:GetCurses() %2 == 1 then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Game():GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL), entity.Position, Vector(0,0), nil);
		end
	end
end

Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Mod.doSomething)