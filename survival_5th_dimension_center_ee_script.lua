-- Based on Survival Extreme V3FA script
-- First modified by Brock Samson
-- Then modified by Phelom, Spoon and Duck_42
-- And finally modified by EntropyWins

local ScenarioUtils = import('/lua/sim/ScenarioUtilities.lua');
local ScenarioFramework = import('/lua/ScenarioFramework.lua');

local Survival_TickInterval = 0.50; -- how much delay between each script iteration

local Survival_NextSpawnTime = 0;
local Survival_CurrentTime = 0;

local Survival_GameState = 0; -- 0 pre-spawn, 1 post-spawn, 2 player win, 3 player defeat
local Survival_PlayerCount = 0; -- how many edge players there are
local Survival_PlayerCount_Total = 0; -- how many total players there are

local Survival_MarkerRefs = {{}, {}, {}, {}, {}}; -- 1 center / 2 waypoint / 3 spawn / 4 arty / 5 nuke
local spawnPositionsPerArmyName = {}

local Survival_UnitCountPerMinute = 0; -- how many units to spawn per minute (taking into consideration player count)
local Survival_UnitCountPerWave = 0; -- how many units to spawn with each wave (taking into consideration player count)

local Survival_MinWarnTime = 0;

local Survival_DefUnit
local Survival_DefCheckHP = 0.0
local Survival_DefLastHP = 0

local Survival_ObjectiveTime = 2400

local ANNOUNCEMENT_COLOR_GOOD = 'ff55ff99'
local ANNOUNCEMENT_COLOR_FAIL = 'ffff5555'
local ANNOUNCEMENT_COLOR_BAD = 'ffff5599'

local function localImport(fileName)
	return import('/maps/survival_5th_dimension_center_ee.v0006/src/' .. fileName)
end

local function vendorImport(fileName)
	return import('/maps/survival_5th_dimension_center_ee.v0006/vendor/lib/src/' .. fileName)
end

local waveTables = localImport('WaveTables.lua').getWaveTables()
local textPrinter = vendorImport('TextPrinter.lua').newInstance()
local unitCreator = vendorImport('UnitCreator.lua').newUnitCreator()
local mapPositions = vendorImport('MapPositions.lua').newInstance(ScenarioInfo)

unitCreator.onUnitCreated(function(unit, unitInfo)
	unit:SetVeterancy(5)

	if EntityCategoryContains(categories.AIR - categories.EXPERIMENTAL, unit) then
		unit:SetFuelUseTime(9999)
	end
end)

local function defaultOptions()
	if (ScenarioInfo.Options.opt_Survival_BuildTime == nil) then
		ScenarioInfo.Options.opt_Survival_BuildTime = 300
	end

	if (ScenarioInfo.Options.opt_Survival_EnemiesPerMinute == nil) then
		ScenarioInfo.Options.opt_Survival_EnemiesPerMinute = 32
	end

	if (ScenarioInfo.Options.opt_Survival_WaveFrequency == nil) then
		ScenarioInfo.Options.opt_Survival_WaveFrequency = 10
	end

    if (ScenarioInfo.Options.opt_CenterAutoReclaim == nil) then
        ScenarioInfo.Options.opt_CenterAutoReclaim = 0
    end

    if (ScenarioInfo.Options.opt_CenterAllFactions == nil) then
        ScenarioInfo.Options.opt_CenterAllFactions = 0
    end

	if (ScenarioInfo.Options.opt_CenterBonusEnergy == nil) then
		ScenarioInfo.Options.opt_CenterBonusEnergy = 100
	end

	if (ScenarioInfo.Options.opt_CenterObjectiveRegen == nil) then
		ScenarioInfo.Options.opt_CenterObjectiveRegen = 25
	end

	if (ScenarioInfo.Options.opt_CenterObjectiveHealth == nil) then
		ScenarioInfo.Options.opt_CenterObjectiveHealth = 5000
	end

	if (ScenarioInfo.Options.opt_CenterObjectiveVision == nil) then
		ScenarioInfo.Options.opt_CenterObjectiveVision = 350
	end
end

local function printAnnouncement(text, options)
	options.location = "leftcenter"
	textPrinter.print(string.rep(" ", 12) .. text, options)
end

local function setupAutoReclaim()
	local percentage = ScenarioInfo.Options.opt_CenterAutoReclaim

	if percentage > 0 then
		unitCreator.onUnitCreated(function(unit, unitInfo)
			if unitInfo.isSurvivalSpawned then
				unit.CreateWreckage = function() end
			end
		end)

		ForkThread(
			vendorImport('AutoReclaim.lua').AutoResourceThread,
			percentage / 100,
			percentage / 100
		)
	end
end

local function isPlayerArmy(armyName)
    return armyName == "ARMY_1" or armyName == "ARMY_2" or armyName == "ARMY_3" or armyName == "ARMY_4"
            or armyName == "ARMY_5" or armyName == "ARMY_6" or armyName == "ARMY_7" or armyName == "ARMY_8"
end

local function setupAllFactions()
    if ScenarioInfo.Options.opt_CenterAllFactions ~= 0 then
        local allFactions = vendorImport('AllFactions.lua')

        for armyIndex, armyName in ListArmies() do
            if isPlayerArmy(armyName) then
                if ScenarioInfo.Options.opt_CenterAllFactions == 1 then
                    allFactions.spawnExtraEngineers(ArmyBrains[armyIndex])
                else
                    allFactions.spawnExtraAcus(ArmyBrains[armyIndex])
                end
            end
        end
    end
end

local function setBotColor()
	ForkThread(function()
		SetArmyColor("ARMY_SURVIVAL_ENEMY", 110, 90, 90)

		WaitSeconds(900+10) -- Start just after wave set 16

		local RED = "ffff0000"
		local GREEN = "ff00ff00"
		local BLUE = "ff0000ff"

		local SIZE = 22
		local DURATION = 7.5

		printAnnouncement("DISCO", {size = SIZE, color=RED, duration=DURATION})
		printAnnouncement("MODE", {size = SIZE, color=GREEN, duration=DURATION})
		printAnnouncement("RANGEBOTS!", {size = SIZE, color=BLUE, duration=DURATION})

		textPrinter.print("DISCO", {size = SIZE, color=BLUE, location="center", duration=DURATION})
		textPrinter.print("MODE", {size = SIZE, color=RED, location="center", duration=DURATION})
		textPrinter.print("RANGEBOTS!", {size = SIZE, color=GREEN, location="center", duration=DURATION})

		textPrinter.print("DISCO", {size = SIZE, color=GREEN, location="rightcenter", duration=DURATION})
		textPrinter.print("MODE", {size = SIZE, color=BLUE, location="rightcenter", duration=DURATION})
		textPrinter.print("RANGEBOTS!", {size = SIZE, color=RED, location="rightcenter", duration=DURATION})

		local colorChanger = vendorImport('ColorChanger.lua').newInstance("ARMY_SURVIVAL_ENEMY")
		colorChanger.start()

		WaitSeconds(60) -- Duration of wave set 16

		colorChanger.stop()
		SetArmyColor("ARMY_SURVIVAL_ENEMY", 110, 90, 90)
	end)
end

local function showWelcomeMessages()
	local welcomeMessages = localImport('WelcomeMessages.lua').newInstance(
		textPrinter,
		ScenarioInfo.Options,
		ScenarioInfo.map_version
	)

	welcomeMessages.startDisplay()
end

local function vanguardify()
	unitCreator.onUnitCreated(function(unit, unitInfo)
		if unitInfo.isSurvivalSpawned and unitInfo.blueprintName == "DEL0204" then
			unit:SetCustomName("Minion of Vanguard")
		end
	end)
end

function OnPopulate()
	ScenarioUtils.InitializeArmies()

	defaultOptions()

	setBotColor()
    setupAutoReclaim()
    setupAllFactions()
	vanguardify()

	for _, armyName in ListArmies() do
		spawnPositionsPerArmyName[armyName] = {}
	end

	Survival_InitGame()

	showWelcomeMessages()
end

local function randomValueFromList(list)
	if table.getn(list) == 0 then
		return nil
	end
	return list[math.random(1, table.getn(list))]
end

local function getSpawnPositionForEachArmy()
	local positions = {}

	for _, armyName in ListArmies() do
		table.insert(positions, randomValueFromList(spawnPositionsPerArmyName[armyName]))
	end

	return positions
end

local function createSurvivalUnit(blueprint, x, z, y)
    local unit = unitCreator.create({
		isSurvivalSpawned = true,
        blueprintName = blueprint,
        armyName = "ARMY_SURVIVAL_ENEMY",
        x = x,
        z = z,
        y = y
    })

    return unit
end

-- econ adjust based on who is playing
-- taken from original survival/Jotto
--------------------------------------------------------------------------
function ScenarioUtils.CreateResources()

	local Markers = ScenarioUtils.GetMarkers();

	for i, tblData in pairs(Markers) do -- loop marker list

		local SpawnThisResource = false; -- default to no

		if (tblData.resource and not tblData.SpawnWithArmy) then -- if this is a regular resource
			SpawnThisResource = true;
		elseif (tblData.resource and tblData.SpawnWithArmy) then -- if this is an army-specific resource

			if (tblData.SpawnWithArmy == "ARMY_0") then
				SpawnThisResource = true;
			else
				for x, army in ListArmies() do -- loop through army list

					if (tblData.SpawnWithArmy == army) then -- if this army is present
						SpawnThisResource = true; -- spawn this resource
						break;
					end
				end
			end
		end

		if (SpawnThisResource) then -- if we can spawn the resource do it

			local bp, albedo, sx, sz, lod;

			if (tblData.type == "Mass") then
				albedo = "/env/common/splats/mass_marker.dds";
				bp = "/env/common/props/massDeposit01_prop.bp";
				sx = 2;
				sz = 2;
				lod = 100;
			else
				albedo = "/env/common/splats/hydrocarbon_marker.dds";
				bp = "/env/common/props/hydrocarbonDeposit01_prop.bp";
				sx = 6;
				sz = 6;
				lod = 200;
			end

			-- create the resource
			CreateResourceDeposit(tblData.type,	tblData.position[1], tblData.position[2], tblData.position[3], tblData.size);

			-- create the resource graphic on the map
			CreatePropHPR(bp, tblData.position[1], tblData.position[2], tblData.position[3], Random(0,360), 0, 0);

			-- create the resource icon on the map
			CreateSplat(
				tblData.position,           -- Position
				0,                          -- Heading (rotation)
				albedo,                     -- Texture name for albedo
				sx, sz,                     -- SizeX/Z
				lod,                        -- LOD
				0,                          -- Duration (0 == does not expire)
				-1,                         -- army (-1 == not owned by any single army)
				0							-- ???
			);
		end
	end
end



function OnStart(self)
	ForkThread(Survival_Tick);
end



-- initializes the game settings
--------------------------------------------------------------------------
Survival_InitGame = function()
	Survival_NextSpawnTime = ScenarioInfo.Options.opt_Survival_BuildTime; -- set first wave time to build time
	Survival_MinWarnTime = Survival_NextSpawnTime - 60; -- set time for minute warning


	ScenarioInfo.Options.Victory = 'sandbox'; -- force sandbox in order to implement our own rules

	Survival_PlayerCount = 0;
	
	local Armies = ListArmies();
	Survival_PlayerCount_Total = table.getn(Armies) - 3;

	for i, Army in ListArmies() do
		if (Army == "ARMY_1" or Army == "ARMY_2" or Army == "ARMY_3" or Army == "ARMY_4") then
			Survival_PlayerCount = Survival_PlayerCount + 1; -- save player count (ignore players in the middle)
		end
	
		-- Add build restrictions
		if (Army == "ARMY_1" or Army == "ARMY_2" or Army == "ARMY_3" or Army == "ARMY_4" or Army == "ARMY_5" or Army == "ARMY_6" or Army == "ARMY_7" or Army == "ARMY_8") then 
			ScenarioFramework.AddRestriction(Army, categories.WALL)
			ScenarioFramework.AddRestriction(Army, categories.AIR - categories.ENGINEER)

			for _, ArmyX in ListArmies() do
				if (ArmyX == "ARMY_1" or ArmyX == "ARMY_2" or ArmyX == "ARMY_3" or ArmyX == "ARMY_4" or ArmyX == "ARMY_5" or ArmyX == "ARMY_6" or ArmyX == "ARMY_7" or ArmyX == "ARMY_8") then
					SetAlliance(Army, ArmyX, 'Ally'); 
				end
			end			

			SetAlliance(Army, "ARMY_SURVIVAL_ALLY", 'Ally')
			SetAlliance(Army, "ARMY_SURVIVAL_ENEMY", 'Enemy')
			SetAlliance(Army, "ARMY_RANGE_BOATS", 'Enemy')

			SetAlliedVictory(Army, true)
		end
	end

	SetAlliance("ARMY_SURVIVAL_ALLY", "ARMY_SURVIVAL_ENEMY", 'Enemy')
	SetAlliance("ARMY_RANGE_BOATS", "ARMY_SURVIVAL_ALLY", 'Ally')
	SetAlliance("ARMY_RANGE_BOATS", "ARMY_SURVIVAL_ENEMY", 'Ally')

	SetIgnoreArmyUnitCap('ARMY_SURVIVAL_ENEMY', true)

	Survival_InitMarkers()
	Survival_SpawnDef()

	Survival_CalcWaveCounts()

end

function GetMarker(MarkerName)
	return Scenario.MasterChain._MASTERCHAIN_.Markers[MarkerName]
end

Survival_InitMarkers = function()
	LOG("----- Survival MOD: Initializing marker lists...");

	local MarkerRef
	local Break = 0
	local i = 1

	while (Break < 3) do

		Break = 0; -- reset break counter

		MarkerRef = GetMarker("SURVIVAL_CENTER_" .. i)

		if (MarkerRef ~= nil) then
			table.insert(Survival_MarkerRefs[1], MarkerRef);
--			Survival_MarkerCounts[1] = Survival_MarkerCounts[1] + 1;
		else
			Break = Break + 1;
		end

		MarkerRef = GetMarker("SURVIVAL_PATH_" .. i)

		if (MarkerRef ~= nil) then
			table.insert(Survival_MarkerRefs[2], MarkerRef);
--			Survival_MarkerCounts[2] = Survival_MarkerCounts[2] + 1;
		else
			Break = Break + 1;
		end

		MarkerRef = GetMarker("SURVIVAL_SPAWN_" .. i)

		if (MarkerRef ~= nil) then
			for _, armyName in ListArmies() do -- loop through army list
				if (MarkerRef.SpawnWithArmy == armyName) then -- if this army is present
					table.insert(Survival_MarkerRefs[3], MarkerRef)
					table.insert(spawnPositionsPerArmyName[armyName], MarkerRef.position)
					break;
				end
			end
			
--			Survival_MarkerCounts[3] = Survival_MarkerCounts[3] + 1;
		else
			Break = Break + 1
		end

		i = i + 1 -- increment counter

	end
end

Survival_SpawnDef = function()
	local POS = ScenarioUtils.MarkerToPosition("SURVIVAL_CENTER_1");
	Survival_DefUnit = CreateUnitHPR('XRB3301', "ARMY_SURVIVAL_ALLY", POS[1], POS[2], POS[3], 0,0,0);

	Survival_DefUnit:SetReclaimable(false)
	Survival_DefUnit:SetCapturable(false)
	Survival_DefUnit:SetProductionPerSecondEnergy(Survival_PlayerCount_Total * ScenarioInfo.Options.opt_CenterBonusEnergy)
	Survival_DefUnit:SetConsumptionPerSecondEnergy(0)

	Survival_DefUnit:SetMaxHealth(ScenarioInfo.Options.opt_CenterObjectiveHealth)
	Survival_DefUnit:SetHealth(nil, ScenarioInfo.Options.opt_CenterObjectiveHealth)
	Survival_DefUnit:SetRegenRate(ScenarioInfo.Options.opt_CenterObjectiveRegen)

	local Survival_DefUnitBP = Survival_DefUnit:GetBlueprint();
	Survival_DefUnitBP.Intel.MaxVisionRadius = ScenarioInfo.Options.opt_CenterObjectiveVision
	Survival_DefUnitBP.Intel.MinVisionRadius = ScenarioInfo.Options.opt_CenterObjectiveVision
	Survival_DefUnitBP.Intel.VisionRadius = ScenarioInfo.Options.opt_CenterObjectiveVision

	Survival_DefUnit:SetIntelRadius('Vision', ScenarioInfo.Options.opt_CenterObjectiveVision)

	Survival_DefUnit.OldOnKilled = Survival_DefUnit.OnKilled;

	Survival_DefUnit.OnKilled = function(self, instigator, type, overkillRatio)
		if (Survival_GameState ~= 2) then -- If the timer hasn't expired yet...
			self.OldOnKilled(self, instigator, type, overkillRatio)

			printAnnouncement(
				"The defense object has been destroyed. You have lost!",
				{ color = ANNOUNCEMENT_COLOR_FAIL, duration = 8, size = 30 }
			)

			Survival_GameState = 3;

			for i, army in ListArmies() do

				if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5" or army == "ARMY_6" or army == "ARMY_7" or army == "ARMY_8") then
					GetArmyBrain(army):OnDefeat();
				end
			end
			GetArmyBrain("ARMY_SURVIVAL_ENEMY"):OnVictory();
		end
	end

	Survival_DefLastHP = Survival_DefUnit:GetHealth();
end

local function activateDiscoModeForRangeBoatArmy()
	vendorImport('ColorChanger.lua').newInstance("ARMY_RANGE_BOATS").start()
end

local function SecondsToTime(Seconds)
	return string.format("%02d:%02d", math.floor(Seconds / 60), math.mod(Seconds, 60));
end

--local newGameEvents = function()
--	local timeHandlers = {}
--
--	return {
--		executeAtTime = function(gameTimeInSeconds, handler)
--
--		end,
--
--		tick = function(currentTime)
--
--		end
--	}
--end
--
--local gameEvents = newGameEvents()

local function isSecondsTillVictory(seconds)
	local eventTime = Survival_ObjectiveTime - seconds
	return Survival_CurrentTime > eventTime and Survival_CurrentTime <= eventTime + 0.5
end

Survival_Tick = function(self)
	while (Survival_GameState < 2) do

		Survival_CurrentTime = GetGameTimeSeconds();

		Survival_UpdateWaves(Survival_CurrentTime);

		if (Survival_CurrentTime >= Survival_ObjectiveTime) then

			Survival_GameState = 2;
			printAnnouncement(
				"The Defence Object is complete! You have won!",
				{ color = ANNOUNCEMENT_COLOR_GOOD, duration = 4, size = 30 }
			)
			Survival_DefUnit:SetCustomName("CHUCK NORRIS MODE!"); -- update defense object name

			for i, army in ListArmies() do
				if (army == "ARMY_1" or army == "ARMY_2" or army == "ARMY_3" or army == "ARMY_4" or army == "ARMY_5" or army == "ARMY_6" or army == "ARMY_7" or army == "ARMY_8") then
					GetArmyBrain(army):OnVictory();
				end
			end

			GetArmyBrain("ARMY_SURVIVAL_ENEMY"):OnDefeat();
		else

			if (Survival_GameState == 0) then -- build stage

				if (Survival_CurrentTime >= Survival_NextSpawnTime) then -- if build period is over

					LOG("----- Survival MOD: Build state complete. Proceeding to combat state.");
					Sync.ObjectiveTimer = 0; -- clear objective timer
					Survival_GameState = 1; -- update game state to combat mode

					printAnnouncement(
						"Space Vikings are attacking!",
						{ color = ANNOUNCEMENT_COLOR_BAD, duration = 3, size = 30 }
					)

					Survival_SpawnWave()
					Survival_NextSpawnTime = Survival_NextSpawnTime + ScenarioInfo.Options.opt_Survival_WaveFrequency; -- update next wave spawn time by wave frequency

				else -- build period still active

					Sync.ObjectiveTimer = math.floor(Survival_NextSpawnTime - Survival_CurrentTime); -- update objective timer
					Survival_DefUnit:SetCustomName(SecondsToTime(Sync.ObjectiveTimer)); -- update defense object name

					if ((Survival_MinWarnTime > 0) and (Survival_CurrentTime >= Survival_MinWarnTime)) then -- display 2 minute warning if we're at 2 minutes and it's appropriate to do so
						LOG("----- Survival MOD: Sending 1 minute warning.");

						printAnnouncement(
							"1 minute warning!",
							{ color = ANNOUNCEMENT_COLOR_BAD, duration = 2.5, size = 30 }
						)
						Survival_MinWarnTime = 0; -- reset 2 minute warning time so it wont be displayed again
					end

				end

			elseif (Survival_GameState == 1) then -- combat stage

				Sync.ObjectiveTimer = math.floor(Survival_ObjectiveTime - Survival_CurrentTime); -- update objective timer

				if (Survival_CurrentTime >= Survival_NextSpawnTime) then -- ready to spawn a wave
					Survival_SpawnWave()
					Survival_NextSpawnTime = Survival_NextSpawnTime + ScenarioInfo.Options.opt_Survival_WaveFrequency; -- update next wave spawn time by wave frequency
				end

				Survival_DefUnit:SetCustomName('Level ' ..  (waveTables[1] - 1) .. "/" .. (table.getn(waveTables) - 1) )

				if isSecondsTillVictory(500) then
					activateDiscoModeForRangeBoatArmy()
					printAnnouncement(
						"Rangeboats detected! Ready Anti-Air!",
						{ color = ANNOUNCEMENT_COLOR_BAD, duration = 6, size = 25 }
					)
				end

				if isSecondsTillVictory(120) then
					printAnnouncement(
						"2 minutes left!",
						{ color = ANNOUNCEMENT_COLOR_GOOD, duration = 2.5, size = 30 }
					)
				end
			end

			Survival_DefCheckHP = Survival_DefCheckHP - Survival_TickInterval;

			if (Survival_DefCheckHP <= 0) then
				if (Survival_DefUnit:GetHealth() < Survival_DefLastHP) then
					local health = Survival_DefUnit:GetHealth();
					local maxHealth = Survival_DefUnit:GetMaxHealth();
					local defUnitPercent = health / maxHealth;

					textPrinter.print("", {duration = 0.5, location = "lefttop"})
					textPrinter.print("", {duration = 0.5, location = "lefttop"})
					textPrinter.print("", {duration = 0.5, location = "lefttop"})
					textPrinter.print("", {duration = 0.5, location = "lefttop"})
					textPrinter.print(
						string.rep(" ", 100) .. 	"The Defence Object is taking damage! (" .. math.floor(defUnitPercent * 100) .. "%)",
						{ color = ANNOUNCEMENT_COLOR_BAD, duration = 0.5, location = "lefttop", size = 20 }
					)

					Survival_DefCheckHP = 2;
				end
			end

			Survival_DefLastHP = Survival_DefUnit:GetHealth();

			WaitSeconds(Survival_TickInterval);
		end
	end
	
	--End the game the correct way
	WaitSeconds(15);
	import('/lua/victory.lua').CallEndGame(true, false);
	KillThread(self);
end



-- updates spawn waves
--------------------------------------------------------------------------
Survival_UpdateWaves = function(GameTime)
	for waveIndex = waveTables[1], table.getn(waveTables) do -- loop through each wave table within the category

		if (GameTime >= (waveTables[waveIndex][1] * 60)) then -- compare spawn time against the first entry spawn time for each wave table
			if (waveTables[1] < waveIndex) then -- should only update a wave once
			
				waveTables[1] = waveIndex; -- update the wave id for this wave category
			end
		else
			break;
		end
	end
end

local function Survival_GetPOS(MarkerType)
	local RandID = 1

	RandID = math.random(1, table.getn(Survival_MarkerRefs[MarkerType]));  -- get a random value from the selected marker count

	if (RandID == 0) then
		return nil
	end

	local POS = Survival_MarkerRefs[MarkerType][RandID].position;

	if (MarkerType == 4) then
		table.remove(Survival_MarkerRefs[4], RandID);
	elseif (MarkerType == 5) then
		table.remove(Survival_MarkerRefs[5], RandID);
	end

	return POS
end

local function Survival_PlatoonOrder(UnitList, OrderID)
	if (UnitList == nil) then
		return
	end

	local aiBrain = GetArmyBrain("ARMY_SURVIVAL_ENEMY")
	local aiPlatoon = aiBrain:MakePlatoon('','');
	aiBrain:AssignUnitsToPlatoon(aiPlatoon, UnitList, 'Attack', 'None'); -- platoon, unit list, "mission" and formation

	-- 1 center / 2 waypoint / 3 spawn

	if (OrderID == 4) then -- attack move / move

		-- attack move to random path
		POS = Survival_GetPOS(2)
		aiPlatoon:AggressiveMoveToLocation(POS)

		-- move to random center
		POS = Survival_GetPOS(1)
		aiPlatoon:MoveToLocation(POS, false)

	elseif (OrderID == 3) then -- patrol paths

		-- move to random path
		POS = Survival_GetPOS(2)
		aiPlatoon:MoveToLocation(POS, false)

		-- patrol to random path
		POS = Survival_GetPOS(2)
		aiPlatoon:Patrol(POS);

	elseif (OrderID == 2) then -- attack move

		-- attack move to random path
		POS = Survival_GetPOS(2)
		aiPlatoon:AggressiveMoveToLocation(POS)

		-- attack move to random center
		POS = Survival_GetPOS(1)
		aiPlatoon:AggressiveMoveToLocation(POS)

	else -- default/order 1 is move

		-- move to random path
		POS = Survival_GetPOS(2)
		aiPlatoon:MoveToLocation(POS, false)

		-- move to random center
		POS = Survival_GetPOS(1)
		aiPlatoon:MoveToLocation(POS, false)
	end

end

local function Survival_SpawnUnit(UnitID, OrderID)
	local POS = Survival_GetPOS(3)

	local PlatoonList = {}

	local NewUnit = createSurvivalUnit(UnitID, POS[1], POS[2], POS[3])

	NewUnit:SetProductionPerSecondEnergy(325)

	table.insert(PlatoonList, NewUnit)
	Survival_PlatoonOrder(PlatoonList, OrderID)
end

local function spawnRangeBoats()
	ForkThread(function()
		local boatSpawner = localImport('RangeBoat.lua').newInstance(unitCreator)

		for _, spawnPosition in getSpawnPositionForEachArmy() do
			local units = boatSpawner.spawnFlyingBoat(spawnPosition)
			IssueAggressiveMove(units, mapPositions.getMapCenter())
		end
	end)
end

local function spawnWaveTable(waveTable)
	-- pick a random unit table from within this wave set
	local UnitTable = waveTable[math.random(2, table.getn(waveTable))]; -- reference that unit table
	local orderId = UnitTable[2]

	if orderId == 1337 then
		spawnRangeBoats()
	elseif orderId ~= 404 then
		Survival_SpawnUnit(
			Survival_GetUnitFromTable(UnitTable),
			orderId
		);
	end
end

Survival_SpawnWave = function()
	-- for the amount of units we spawn in per wave
	if (table.getn(waveTables[waveTables[1]]) > 1) then -- only do a wave spawn if there is a wave table available
		-- for the amount of units we spawn in per wave
		for z = 1,Survival_UnitCountPerWave do
			spawnWaveTable(waveTables[waveTables[1]])
		end
	end
end



Survival_GetUnitFromTable = function(UnitTable)
	return UnitTable[math.random(3, table.getn(UnitTable))]
end


-- calculates how many units to spawn per wave
function Survival_CalcWaveCounts()
	local WaveMultiplier = ScenarioInfo.Options.opt_Survival_WaveFrequency / 60;
	Survival_UnitCountPerMinute = ScenarioInfo.Options.opt_Survival_EnemiesPerMinute * Survival_PlayerCount;
	Survival_UnitCountPerWave = Survival_UnitCountPerMinute * WaveMultiplier;
end

function OnShiftF3()
	spawnRangeBoats()
end
