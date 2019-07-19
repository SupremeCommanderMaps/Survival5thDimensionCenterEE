newInstance = function(unitCreator)
    local BOAT_ARMY_NAME = "ARMY_RANGE_BOATS"

    local function spawnTransport(spawnPosition)
        local bp = GetUnitBlueprintByName("uaa0107")
        bp.Physics.Elevation = 1
        bp.StrategicIconName = ''

        local transport = unitCreator.create({
            armyName = BOAT_ARMY_NAME,
            blueprintName = "uaa0107",
            x = spawnPosition[1],
            y = spawnPosition[3],
            z = spawnPosition[2],
            isTransport = true
        })

        transport:SetMaxHealth(1337)
        transport:SetHealth(transport, 1337)

        transport:SetUnSelectable(true)
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
            armyName = BOAT_ARMY_NAME,
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

    return {
        spawnFlyingBoat = function(spawnPosition)
            local transports = {spawnTransport(spawnPosition)}
            local boat = spawnBoat()

            import('/lua/ScenarioFramework.lua').AttachUnitsToTransports(
                {boat},
                transports
            )

            boat:OnStorageChange(false)
            boat:SetUnSelectable(false)

            return transports
        end
    }
end