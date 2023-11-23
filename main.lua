Mod = RegisterMod("Curse Experiment", 1)

--function that removes curses based on what collectibles the players have
function Mod:removeCursesByCollectibles()
	local game = Game()
	local level = game:GetLevel()
	
	for _, player in pairs(Mod.GetPlayers()) do
		--black candle removes all curses
		if player:HasCollectible(CollectibleType.COLLECTIBLE_BLACK_CANDLE) then
			level:RemoveCurses(LevelCurse.CURSE_OF_DARKNESS | LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_THE_UNKNOWN | LevelCurse.CURSE_OF_THE_CURSED | LevelCurse.CURSE_OF_MAZE | LevelCurse.CURSE_OF_BLIND)
			--level:RemoveCurse(LevelCurse.CURSE_OF_DARKNESS)
			--level:RemoveCurse(LevelCurse.CURSE_OF_LABYRINTH) --cant remove labyrinth since that affects level generation
			--level:RemoveCurse(LevelCurse.CURSE_OF_THE_LOST)
			--level:RemoveCurse(LevelCurse.CURSE_OF_THE_UNKNOWN)
			--level:RemoveCurse(LevelCurse.CURSE_OF_THE_CURSED) --cant remove cursed since that's part of a challenge
			--level:RemoveCurse(LevelCurse.CURSE_OF_MAZE)
			--level:RemoveCurse(LevelCurse.CURSE_OF_BLIND)
		end
			
		--the compass, the treasure map, and the blue map removes curse of the lost/amnesia instantly
		if player:HasCollectible(CollectibleType.COLLECTIBLE_COMPASS) or player:HasCollectible(CollectibleType.COLLECTIBLE_TREASURE_MAP) or player:HasCollectible(CollectibleType.COLLECTIBLE_BLUE_MAP) or player:HasCollectible(CollectibleType.COLLECTIBLE_MIND) then
			level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
		end
			
		--night light removes curse of darkness
		if player:HasCollectible(CollectibleType.COLLECTIBLE_NIGHT_LIGHT) then
			level:RemoveCurses(LevelCurse.CURSE_OF_DARKNESS)
		end
	end
end

function Mod:doSomething()
	local player = Isaac.GetPlayer(0)
	--check if room is boss room
	local game = Game()
	local level = game:GetLevel()
	local room = level:GetCurrentRoom()
	Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, game:GetItemPool():GetCollectible(ItemPoolType.POOL_TREASURE), Vector(320,280), Vector(0,0), nil);
	--check if room is boss room
	if room:GetType() == 5 then
		-- check if player has curse of darkness
		if level:GetCurses() %2 == 1 then
			Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_COLLECTIBLE, Game():GetItemPool():GetCollectible(ItemPoolType.POOL_ANGEL), entity.Position, Vector(0,0), nil);
		end
	end
end

Mod:AddCallback(ModCallbacks.MC_PRE_SPAWN_CLEAN_AWARD, Mod.doSomething)
Mod:AddCallback(ModCallbacks.MC_POST_NEW_LEVEL, Mod.removeCursesByCollectibles)
Mod:AddCallback(ModCallbacks.MC_POST_NEW_ROOM, Mod.removeCursesByCollectibles)
Mod:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Mod.removeCursesByCollectibles)
Mod:AddCallback(ModCallbacks.MC_USE_ITEM, Mod.removeCursesByCollectibles)
Mod:AddCallback(ModCallbacks.MC_USE_CARD, Mod.removeCursesByCollectibles)
Mod:AddCallback(ModCallbacks.MC_USE_PILL, Mod.removeCursesByCollectibles)

Mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, itemID, rng)
	local game = Game()
	local level = game:GetLevel()
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
end, CollectibleType.COLLECTIBLE_CRYSTAL_BALL)

Mod:AddCallback(ModCallbacks.MC_USE_ITEM, function(_, itemID, rng)
	local game = Game()
	local level = game:GetLevel()
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
end, CollectibleType.COLLECTIBLE_BOOK_OF_SECRETS)

Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, cardID)
	local game = Game()
	local level = game:GetLevel()
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_DARKNESS)
	--level:RemoveCurse(LevelCurse.CURSE_OF_THE_LOST)
	--level:RemoveCurse(LevelCurse.CURSE_OF_DARKNESS)
end, Card.CARD_SUN)

Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, cardID)
	local game = Game()
	local level = game:GetLevel()
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST)
end, Card.CARD_WORLD)

Mod:AddCallback(ModCallbacks.MC_USE_CARD, function(_, cardID)
	local game = Game()
	local level = game:GetLevel()
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_BLIND)
	--level:RemoveCurse(LevelCurse.CURSE_OF_THE_LOST)
	--level:RemoveCurse(LevelCurse.CURSE_OF_BLIND)
end, Card.RUNE_ANSUZ)

Mod:AddCallback(ModCallbacks.MC_USE_PILL, function(_, pillEffect)
	local game = Game()
	local level = game:GetLevel()
	level:RemoveCurses(LevelCurse.CURSE_OF_THE_LOST | LevelCurse.CURSE_OF_BLIND)
	--level:RemoveCurse(LevelCurse.CURSE_OF_THE_LOST)
	--level:RemoveCurse(LevelCurse.CURSE_OF_BLIND)
end, PillEffect.PILLEFFECT_SEE_FOREVER)

--Stuff taken from piber20helper below--

function Mod:GetPlayers(functionCheck, ...)

	local args = {...}
	local players = {}
	
	local game = Game()
	
	for i=1, game:GetNumPlayers() do
	
		local player = Isaac.GetPlayer(i-1)
		
		local argsPassed = true
		
		if type(functionCheck) == "function" then
		
			for j=1, #args do
			
				if args[j] == "player" then
					args[j] = player
				elseif args[j] == "currentPlayer" then
					args[j] = i
				end
				
			end
			
			if not functionCheck(table.unpack(args)) then
			
				argsPassed = false
				
			end
			
		end
		
		if argsPassed then
			players[#players+1] = player
		end
		
	end
	
	return players
	
end
