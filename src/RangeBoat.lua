newInstance = function(unitCreator, mapPositions, Survival_GetPOS)
    local function spawnTransport()
        local bp = GetUnitBlueprintByName("uaa0107")
        bp.Physics.Elevation = 1
        bp.StrategicIconName = ''

        local POS = Survival_GetPOS(3, 5)

        local transport = unitCreator.create({
            armyName = "ARMY_SURVIVAL_ENEMY",
            blueprintName = "uaa0107",
            x = POS[1],
            y = POS[3],
            z = POS[2],
            isTransport = true
        })

        transport:SetMaxHealth(1337)
        transport:SetHealth(transport, 1337)

        transport:SetUnSelectable(true)
        transport:SetDoNotTarget(true)
        transport:SetCapturable(false)
        transport:SetReclaimable(false)
        transport:SetCustomName("Rangeboat")

        transport.CreateWreckage = function() end

        return transport
    end

    local function spawnBoat()
        local bp = GetUnitBlueprintByName("ues0302")
        bp.Transport.CanFireFromTransport = true

        for i in bp.Weapon do
            if bp.Weapon[i].FireTargetLayerCapsTable.Water == "Land|Water|Seabed" then
                bp.Weapon[i].FireTargetLayerCapsTable.Land = "Land|Water|Seabed"
            end
        end

        local boat = unitCreator.create({
            armyName = "ARMY_SURVIVAL_ENEMY",
            blueprintName = "ues0302", --xes0307 uel0401
            x = 0,
            y = 0,
            z = 0
        })

        boat.CreateWreckage = function() end
        boat.OnLayerChange = function() end

        boat:SetCustomName("Rangeboat")
        boat:SetReclaimable(false)

        return boat
    end

    local function spawnFlyingBoat()
        local transports = {spawnTransport()}
        local boat = spawnBoat()

        import('/lua/ScenarioFramework.lua').AttachUnitsToTransports(
            {boat},
            transports
        )

        boat:OnStorageChange(false)
        boat:SetUnSelectable(false)

        IssueAggressiveMove(transports, mapPositions.getMapCenter())
    end

    return {
        spawnFlyingBoat = spawnFlyingBoat
    }
end