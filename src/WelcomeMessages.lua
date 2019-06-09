newInstance = function(textPrinter, options, mapVersion)
    local WELCOME_MESSAGE_DURATION = 30

    local function displayWeclome()
        local headerOptions = { color = "ff5599ff", duration = WELCOME_MESSAGE_DURATION, location = "leftcenter" }
        local titleOptions = { color = "ff5599ff", duration = WELCOME_MESSAGE_DURATION, location = "leftcenter", size = 35 }
        local textOptions = { color = "ff3377cc", duration = WELCOME_MESSAGE_DURATION, location = "leftcenter" }

        textPrinter.print(string.rep(" ", 20) .. "Welcome to", headerOptions)
        textPrinter.print(string.rep(" ", 12) .. "5th Dimension Center Survival", titleOptions)
        textPrinter.print(string.rep(" ", 39) .. "Entropy Edition, version " .. mapVersion, headerOptions)
        textPrinter.printBlankLine(textOptions)
        textPrinter.printBlankLine(textOptions)
        textPrinter.print(string.rep(" ", 20) .. "Enemies spawn in " .. options.opt_Survival_BuildTime .. " seconds", textOptions)

        textPrinter.print(string.rep(" ", 20) .. "Survival nukes: off", textOptions)
        textPrinter.print(string.rep(" ", 20) .. "Survival air: off", textOptions)

        textPrinter.print(
            string.rep(" ", 20) .. "Auto reclaim: " ..
                    (
                    options.opt_CenterAutoReclaim == 0
                            and "off"
                            or (options.opt_CenterAutoReclaim .. "%")
                    ),
            textOptions
        )

        textPrinter.print(string.rep(" ", 20) .. "Enemies spawn every " .. options.opt_Survival_WaveFrequency .. " seconds", textOptions)
        textPrinter.print(string.rep(" ", 20) .. "Difficulty " .. options.opt_Survival_EnemiesPerMinute, textOptions)
    end

    return {
        startDisplay = function()
            ForkThread(function()
                displayWeclome()
            end)
        end
    }
end