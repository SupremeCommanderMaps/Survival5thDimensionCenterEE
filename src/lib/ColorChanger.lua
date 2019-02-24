function newInstance(armyName)
    local this = {}

    local red = 110
    local green = 90
    local blue = 90

    local frequency = 0.09
    local index = 1

    local active

    local function updateArmyColor()
        SetArmyColor(armyName, red, green, blue)
    end

    local function updateRgbValues()
        index = index + 1

        red = math.sin(frequency * index + 0) * 127 + 128
        green = math.sin(frequency * index + 2) * 127 + 128
        blue = math.sin(frequency* index + 4) * 127 + 128
    end

    this.start = function()
         active = true

        ForkThread(function()
            while active do
                updateRgbValues()
                updateArmyColor()
                WaitSeconds(0.1)
            end
        end)
    end

    this.stop = function()
        active = false
    end

    return this
end