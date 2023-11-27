Mod = RegisterMod("Curse Experiment", 1)
print("mod loaded")
CurrentRewardTables = {}
local RECOMMENDED_SHIFT_IDX = 35
local game = Game()
local seeds = game:GetSeeds()
local startSeed = seeds:GetStartSeed()
local rng = RNG()
rng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)

-- add items to the reward table
function Mod:addToPool (localTable, curse, item, type, rarity)
	-- 0 = base pool, 1 = rare pool, 2 = super rare, 3 = ultra rare
	print("adding item to pool" .. item)
	print("curse " .. curse)
	localTable[curse] = localTable[curse] or {}
	print("created rarity table")
	print(localTable[curse])
	print("rarity " .. rarity)
	localTable[curse][rarity] = localTable[curse][rarity] or {}
	print("created item pool")
	table.insert(localTable[curse][rarity],{
		item = item,
		type = type,
	})
	print("added item to pool" .. item)
	print("pool size " .. #localTable[curse][rarity])
end
-- curse enums
DARKNESS = 0
LABYRINTH = 1
LOST = 2
UNKNOWN = 3
MAZE = 4
BLIND = 5

-- rarity enums
COMMON = 0
RARE = 1
SUPER_RARE = 2
ULTRA_RARE = 3

-- type enums
ITEM = 100
TRINKET = 350
HEART = 10
COIN = 20
KEY = 30
BOMB = 40
POOP = 245
CARD = 300
PILL = 70

function Mod:definePools()
	-- define table
	local spawnPoolTables = {}
	print(spawnPoolTables)
	--0 darkness pool
	Mod:addToPool(spawnPoolTables, DARKNESS, 588, ITEM, SUPER_RARE) -- sol
	Mod:addToPool(spawnPoolTables, DARKNESS, 589, ITEM, ULTRA_RARE) -- luna
	Mod:addToPool(spawnPoolTables, DARKNESS, 425, ITEM, RARE) -- night light
	Mod:addToPool(spawnPoolTables, DARKNESS, 159, ITEM, SUPER_RARE) -- spirit of the night
	Mod:addToPool(spawnPoolTables, DARKNESS, 259, ITEM, SUPER_RARE) -- Dark matter
	Mod:addToPool(spawnPoolTables, DARKNESS, 535, ITEM, RARE) -- Blanket
	Mod:addToPool(spawnPoolTables, DARKNESS, 428, ITEM, SUPER_RARE) -- Pajamas
	Mod:addToPool(spawnPoolTables, DARKNESS, 438, ITEM, RARE) -- Binky
	Mod:addToPool(spawnPoolTables, DARKNESS, 6, HEART, COMMON)-- black heart
	Mod:addToPool(spawnPoolTables, DARKNESS, 20, CARD, COMMON)-- the sun
	Mod:addToPool(spawnPoolTables, DARKNESS, 75, CARD, RARE)-- the sun?
	Mod:addToPool(spawnPoolTables, DARKNESS, 35, CARD, COMMON)-- DAGAZ
	Mod:addToPool(spawnPoolTables, DARKNESS, 41, CARD, RARE)-- Black rune
	Mod:addToPool(spawnPoolTables, DARKNESS, 101, TRINKET, RARE)-- Dim bulb
	-- 1 labrynth pool (XL)
	Mod:addToPool(spawnPoolTables, LABYRINTH, 580, ITEM, ULTRA_RARE) -- red key
	Mod:addToPool(spawnPoolTables, LABYRINTH, 625, ITEM, ULTRA_RARE) -- Mega mush
	Mod:addToPool(spawnPoolTables, LABYRINTH, 698, ITEM, ULTRA_RARE) -- Twisted pair
	Mod:addToPool(spawnPoolTables, LABYRINTH, 347, ITEM, SUPER_RARE) -- Diplopia
	Mod:addToPool(spawnPoolTables, LABYRINTH, 485, ITEM, RARE) -- Crooked penny
	Mod:addToPool(spawnPoolTables, LABYRINTH, 248, ITEM, RARE) -- Hive mind
	Mod:addToPool(spawnPoolTables, LABYRINTH, 476, ITEM, RARE) -- D2
	Mod:addToPool(spawnPoolTables, LABYRINTH, 631, ITEM, RARE) -- Meat cleaver
	Mod:addToPool(spawnPoolTables, LABYRINTH, 203, ITEM, SUPER_RARE) -- Humbling bundle
	Mod:addToPool(spawnPoolTables, LABYRINTH, 35, CARD, COMMON)-- DAGAZ
	Mod:addToPool(spawnPoolTables, LABYRINTH, 52, CARD, RARE)-- become huge
	Mod:addToPool(spawnPoolTables, LABYRINTH, 23, CARD, COMMON)-- two of clubs
	Mod:addToPool(spawnPoolTables, LABYRINTH, 24, CARD, COMMON)-- two of diamonds
	Mod:addToPool(spawnPoolTables, LABYRINTH, 25, CARD, COMMON)-- two of spades
	Mod:addToPool(spawnPoolTables, LABYRINTH, 26, CARD, COMMON)-- two of hearts
	Mod:addToPool(spawnPoolTables, LABYRINTH, 33, CARD, COMMON)-- Jera


	--2  lost pool (no map)
	Mod:addToPool(spawnPoolTables, LOST,287,ITEM, RARE) -- book of secrets
	Mod:addToPool(spawnPoolTables, LOST,246,ITEM, SUPER_RARE) -- blue map
	Mod:addToPool(spawnPoolTables, LOST,21, ITEM, RARE) -- compass
	Mod:addToPool(spawnPoolTables, LOST, 54, ITEM, SUPER_RARE) -- treasure map
	Mod:addToPool(spawnPoolTables, LOST, 333, ITEM, ULTRA_RARE) -- the mind
	Mod:addToPool(spawnPoolTables, LOST,91, ITEM, RARE) -- Spelunker hat
	Mod:addToPool(spawnPoolTables, LOST,36, CARD, COMMON) -- Ansuz
	Mod:addToPool(spawnPoolTables, LOST,59, TRINKET, COMMON) -- Cain's eye
	Mod:addToPool(spawnPoolTables, LOST,22, CARD, COMMON) -- The world
	Mod:addToPool(spawnPoolTables, LOST, 35, CARD, COMMON)-- DAGAZ

	-- unknown pool (health blind)
	Mod:addToPool(spawnPoolTables, UNKNOWN, 1, HEART, COMMON) -- red heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 5, HEART, COMMON) -- double heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 573, ITEM, ULTRA_RARE) -- sacred heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 639, ITEM, RARE) -- yuck heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 671, ITEM, RARE) -- candy heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 694, ITEM, SUPER_RARE) -- broken heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 724, ITEM, RARE) -- hypercoagulation
	Mod:addToPool(spawnPoolTables, UNKNOWN, 15, ITEM, RARE) -- heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 140, TRINKET, RARE) -- sodom apple
	Mod:addToPool(spawnPoolTables, UNKNOWN, 156, TRINKET, RARE) -- kiss
	Mod:addToPool(spawnPoolTables, UNKNOWN, 49, TRINKET, RARE) -- bloody penny
	Mod:addToPool(spawnPoolTables, UNKNOWN, 87, TRINKET, RARE) -- bloody penny
	Mod:addToPool(spawnPoolTables, UNKNOWN, 107, TRINKET, COMMON) -- crow heart
	Mod:addToPool(spawnPoolTables, UNKNOWN, 119, TRINKET, RARE) -- stem cell
	Mod:addToPool(spawnPoolTables, UNKNOWN, 35, CARD, COMMON)-- DAGAZ
	Mod:addToPool(spawnPoolTables, UNKNOWN, 334, ITEM, SUPER_RARE)-- body
	Mod:addToPool(spawnPoolTables, UNKNOWN, 541, ITEM, COMMON)-- marrow
	Mod:addToPool(spawnPoolTables, UNKNOWN, 79, CARD, RARE) -- queen of hearts
	Mod:addToPool(spawnPoolTables, UNKNOWN, 30, CARD, RARE) -- ace of hearts
	Mod:addToPool(spawnPoolTables, UNKNOWN, 226, ITEM, ULTRA_RARE) -- sacred heart

	-- maze (teleport)
	Mod:addToPool(spawnPoolTables, MAZE, 675, ITEM, RARE) -- Cracked orb
	Mod:addToPool(spawnPoolTables, MAZE, 681, ITEM, RARE) -- Lil portal
	Mod:addToPool(spawnPoolTables, MAZE, 35, CARD, COMMON)-- DAGAZ
	Mod:addToPool(spawnPoolTables, MAZE, 172, TRINKET, RARE)-- cursed penny
	Mod:addToPool(spawnPoolTables, MAZE, 44, ITEM, RARE) -- Lil portal
	Mod:addToPool(spawnPoolTables, MAZE, 316, ITEM, COMMON) -- Cursed eye
	Mod:addToPool(spawnPoolTables, MAZE, 324, ITEM, SUPER_RARE) -- Undefined
	Mod:addToPool(spawnPoolTables, MAZE, 419, ITEM, SUPER_RARE) -- teleport 2.0
	Mod:addToPool(spawnPoolTables, MAZE, 43, TRINKET, COMMON)-- Cursed skull
	Mod:addToPool(spawnPoolTables, MAZE, 74, CARD, SUPER_RARE)-- moon?
	Mod:addToPool(spawnPoolTables, MAZE, 4, TRINKET, COMMON)-- broken remote

	-- blind (item sprites)
	Mod:addToPool(spawnPoolTables, BLIND, 460, ITEM, COMMON) -- Glaucoma
	Mod:addToPool(spawnPoolTables, BLIND, 665, ITEM, ULTRA_RARE) -- Guppy's eye
	Mod:addToPool(spawnPoolTables, BLIND, 249, ITEM, SUPER_RARE) -- Options
	Mod:addToPool(spawnPoolTables, BLIND, 414, ITEM, SUPER_RARE) -- More options
	Mod:addToPool(spawnPoolTables, BLIND, 82, TRINKET, RARE) -- More options
	Mod:addToPool(spawnPoolTables, BLIND, 723, ITEM, ULTRA_RARE) -- spindown
	Mod:addToPool(spawnPoolTables, BLIND, 689, ITEM, ULTRA_RARE) -- glitched crown
	Mod:addToPool(spawnPoolTables, BLIND, 49, CARD, COMMON) -- d6
	Mod:addToPool(spawnPoolTables, BLIND, 37, CARD, COMMON) -- perthro
	Mod:addToPool(spawnPoolTables, BLIND, 81, CARD, COMMON) -- soul of isaac
	Mod:addToPool(spawnPoolTables, BLIND, 721, CARD, RARE) -- TM trainer
	Mod:addToPool(spawnPoolTables, BLIND, 35, CARD, COMMON)-- DAGAZ
	print("pool defined " .. #spawnPoolTables)



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
			CurrentRewardTables = JSON.decode(Mod:LoadData())
			print(Mod:LoadData())
			print("found save data")
		end
	else
		print("starting new run")
		log("creating save data")
		print("creating save data")
		TestGlobal = "save data created"
		CurrentRewardTables = Mod:definePools()
		print("received pool ".. #CurrentRewardTables)
		-- save save data
		local jsonString = JSON.encode(CurrentRewardTables)
		Mod:SaveData(jsonString)
		print(JSON.encode(CurrentRewardTables[0]))
		print(#CurrentRewardTables[0][0])
		log("saved initial data")
		print("saved initial data")
	end
	local RECOMMENDED_SHIFT_IDX = 35
	local game = Game()
	local seeds = game:GetSeeds()
	local startSeed = seeds:GetStartSeed()
	rng = RNG()
	rng:SetSeed(startSeed, RECOMMENDED_SHIFT_IDX)
end
Mod:AddCallback(ModCallbacks.MC_POST_GAME_STARTED, Mod.LoadSaveData)

-- save save data
function Mod:SaveDataOnExit ()
	log("saving data")
	print("saving data")
	local jsonString = JSON.encode(CurrentRewardTables)
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

function Mod:PickItemFromPool(curse)
	print("picking item from pool")
	if #CurrentRewardTables == 0 then
		print("no pool")
		Mod:LoadSaveData(false)
	end
	print("picking item from pool")
	local randInt = rng:RandomInt(100)
	print("got rng " .. randInt)
	local rarityChoice = 0
	if randInt <= 60 then
		rarityChoice = COMMON
	elseif randInt <= 85 then
		rarityChoice = RARE
	elseif randInt <= 95 then
		rarityChoice = SUPER_RARE
	else
		rarityChoice = ULTRA_RARE
	end
	print("rarity " .. rarityChoice)
	print("curse " .. curse)
	local pool = CurrentRewardTables[curse][rarityChoice]
	local poolsize = #pool
	local resulti = rng:RandomInt(poolsize) + 1
	local result = pool[resulti]
	-- remove item from pool if it is a collectable
	if result.type == ITEM or result.type == TRINKET then
		Mod:RemoveItemFromPool(curse,rarityChoice,result)
	end
	print("picked item from pool" .. result["item"])
	print("new pool size " .. #CurrentRewardTables[curse][rarityChoice])
	Isaac.Spawn(EntityType.ENTITY_PICKUP, result.type, result.item, Vector(320,280), Vector(0,0), nil);
end

-- remove item from pool
function Mod:RemoveItemFromPool(curse, rarity, item)
	local pool = CurrentRewardTables[curse][rarity]
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
	print(LevelCurse.CURSE_OF_THE_LOST)
	print(TestGlobal)
	--check if room is boss room
	local game = Game()
	local level = game:GetLevel()
	local room = level:GetCurrentRoom()
	--Mod:PickItemFromPool(0)
	-- spawn item
	--Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, game:GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE), Vector(320,280), Vector(0,0), nil);
	--check if room is boss room
	if room:GetType() == 5 then
		-- check if player has curse of darkness
		if level:GetCurses() & LevelCurse.CURSE_OF_DARKNESS == LevelCurse.CURSE_OF_DARKNESS then
			Mod:PickItemFromPool(0)
		end
		-- check if player has curse of the labyrinth
		if level:GetCurses() & LevelCurse.CURSE_OF_LABYRINTH == LevelCurse.CURSE_OF_LABYRINTH then
			Mod:PickItemFromPool(1)
		end
		-- check if player has curse of the lost
		if level:GetCurses() & LevelCurse.CURSE_OF_THE_LOST == LevelCurse.CURSE_OF_THE_LOST then
			Mod:PickItemFromPool(2)
		end
		-- check if player has curse of the unknown
		if level:GetCurses() & LevelCurse.CURSE_OF_THE_UNKNOWN == LevelCurse.CURSE_OF_THE_UNKNOWN then
			Mod:PickItemFromPool(3)
		end
		-- check if player has curse of the maze
		if level:GetCurses() & LevelCurse.CURSE_OF_MAZE == LevelCurse.CURSE_OF_MAZE then
			Mod:PickItemFromPool(4)
		end
		-- check if player has curse of the blind
		if level:GetCurses() & LevelCurse.CURSE_OF_BLIND == LevelCurse.CURSE_OF_BLIND then
			Mod:PickItemFromPool(5)
		end
	end
end

Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Mod.spawnReward)
