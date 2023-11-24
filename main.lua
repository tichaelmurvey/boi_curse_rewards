Mod = RegisterMod("Curse Experiment", 1)
if not CurseRewards then
	CurseRewards = {}
end
print("mod loaded")
local currentRewardTables = {}
local RECOMMENDED_SHIFT_IDX = 35
local game = Game()
local seeds = game:GetSeeds()
local startSeed = seeds:GetStartSeed()
local rng = RNG()
rng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)

-- add items to the reward table
function Mod:addToPool (localTable, tableIndex,item,weight)
	print("adding item to pool" .. item)
	weight = weight or 1
	if not localTable[tableIndex] then
		localTable[tableIndex] = {}
	end
	if localTable[tableIndex] then
		for i = 1,weight do
			table.insert(localTable[tableIndex],item)
		end
	end
end

function Mod:definePools()
	-- define table
	local spawnPoolTables = {}
	--darkness pool
	Mod:addToPool(spawnPoolTables, 0,588,1)
	Mod:addToPool(spawnPoolTables, 0,589,1)
	Mod:addToPool(spawnPoolTables, 0,590,1)
	print("pool defined " .. #spawnPoolTables[0])
	return spawnPoolTables
end
------------ Save Data stuff

local JSON = require("json")
-- Load save data
function Mod:LoadSaveData(save)
	if save then
		print("continuing run")
		log("loading save data")
		--Loading Moddata--
		if Mod:HasData() then
			print("found save data")
			--local currentRewardTables = JSON.decode(Mod:LoadData())
			print(Mod:LoadData())
		end
	else
		print("starting new run")
		log("creating save data")
		print("creating save data")
		currentRewardTables = Mod:definePools()
		print("received pool ".. #currentRewardTables[0])
		-- save save data
		local jsonString = JSON.encode(currentRewardTables)
		Mod:SaveData(jsonString)
		print(jsonString)
		log("saved initial data")
		print("saved initial data")
	end
end
Mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Mod.LoadSaveData)

-- save save data
function Mod:SaveDataOnExit ()
	log("saving data")
	print("saving data")
	local jsonString = JSON.encode(currentRewardTables)
	Mod:SaveData(jsonString)
	print(jsonString)
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

-- choose item from reward table

function Mod:PickItemFromPool(rngLocal,tableIndex)
	print("picking item from pool")
	rngLocal = rngLocal or RNG()
	tableIndex = tableIndex or 0
	local pool = currentRewardTables[tableIndex]
	local poolsize = #pool
	local resulti = rng:RandomInt(poolsize) + 1
	local result = pool[resulti]
	-- remove item from pool
	Mod:RemoveItemFromPool(tableIndex,result)
	print("picked item from pool" .. result)
	print("new pool size " .. #currentRewardTables[tableIndex])
	return result
end

-- remove item from pool
function Mod:RemoveItemFromPool(tableIndex,item)
	tableIndex = tableIndex or 0
	local pool = currentRewardTables[tableIndex]
	local poolsize = #pool
	for i = 1,poolsize do
		if pool[i] == item then
			table.remove(pool,i)
			break
		end
	end
end

-- give rewards on room clear
function Mod:spawnReward()
	print("spawning reward")
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

Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Mod.spawnReward)
