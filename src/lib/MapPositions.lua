function newInstance(ScenarioInfo)
    local this = {}

    local mapHeight = ScenarioInfo.size[1]
    local mapWidth = ScenarioInfo.size[2]
    local elevation = 25.9844

    this.getTopLeft = function()
        return VECTOR3(0, elevation, 0)
    end

    this.getTopRight = function()
        return VECTOR3(0, elevation, mapWidth)
    end

    this.getBottomLeft = function()
        return VECTOR3(mapHeight, elevation, 0)
    end

    this.getBottomRight = function()
        return VECTOR3(mapHeight, elevation, mapWidth)
    end

    this.getMapCenter = function()
        return VECTOR3(mapHeight / 2, elevation, mapWidth / 2)
    end

    return this
end