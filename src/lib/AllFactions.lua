local UEF = 1
local AEON = 2
local CYBRAN = 3
local SERA = 4

local UEF_ACU = "UEL0001"
local AEON_ACU = "UAL0001"
local CYBRAN_ACU = "URL0001"
local SERA_ACU = "XSL0001"

local UEF_ENGI = "UEL0105"
local AEON_ENGI = "UAL0105"
local CYBRAN_ENGI = "URL0105"
local SERA_ENGI = "XSL0105"

local units = {
    ["acu"] = {
        [UEF] = UEF_ACU,
        [AEON] = AEON_ACU,
        [CYBRAN] = CYBRAN_ACU,
        [SERA] = SERA_ACU
    },
    ["engi"] = {
        [UEF] = UEF_ENGI,
        [AEON] = AEON_ENGI,
        [CYBRAN] = CYBRAN_ENGI,
        [SERA] = SERA_ENGI
    }
}

local function getExtraUnits(factionIndex, unitKey)
    local extraUnits = {}

    if factionIndex ~= UEF then
        table.insert(extraUnits, units[unitKey][UEF])
    end
    if factionIndex ~= AEON then
        table.insert(extraUnits, units[unitKey][AEON])
    end
    if factionIndex ~= CYBRAN then
        table.insert(extraUnits, units[unitKey][CYBRAN])
    end
    if factionIndex ~= SERA then
        table.insert(extraUnits, units[unitKey][SERA])
    end

    return extraUnits
end

local function spawnExtraUnits(armyBrain, unitKey)
    local posX, posY = armyBrain:GetArmyStartPos()

    for _, unit in getExtraUnits(armyBrain:GetFactionIndex(), unitKey) do
        armyBrain:CreateUnitNearSpot(unit, posX, posY)
    end
end

function spawnExtraAcus(armyBrain)
    spawnExtraUnits(armyBrain, "acu")
end

function spawnExtraEngineers(armyBrain)
    spawnExtraUnits(armyBrain, "engi")
end