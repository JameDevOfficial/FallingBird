local M = {}

M.rgbToDecimal = function(r, g, b)
    return { r / 255, g / 255, b / 255 };
end

local fontDefault = love.graphics.newFont(20)
local font30 = love.graphics.newFont(30)
local font50 = love.graphics.newFont(50)
local lightBlue = M.rgbToDecimal(154, 220, 243)

M.drawFrame = function()
    love.graphics.setBackgroundColor(lightBlue)
    love.graphics.setFont(fontDefault)
    --Clouds
    for i, v in ipairs(Clouds) do
        v:render()
    end
    --Bird
    love.graphics.setColor(Bird.color[1], Bird.color[2], Bird.color[3], Bird.color[4])
    Bird.render()
    --Obstacles
    for i, v in ipairs(Obstacles) do
        v:render()
    end
    -- points
    love.graphics.setColor(0, 0, 0)
    love.graphics.print("Points: " .. Player.points, 10, 10)
    --Screens
    if Player.gameRunning == false then
        M.lostScreen()
    end

    M.drawDebug()
end

M.drawDebug = function()
    if Settings.DEBUG == true then
        love.graphics.setFont(fontDefault)
        love.graphics.setColor(0, 0, 0, 1)

        local y = fontDefault:getHeight() + 10

        -- FPS
        local fps = love.timer.getFPS()
        local fpsText = string.format("FPS: %d", fps)
        love.graphics.print(fpsText, 10, y)
        y = y + fontDefault:getHeight()

        -- Performance
        local stats = love.graphics.getStats()
        local usedMem = collectgarbage("count")
        local perfText = string.format(
            "Memory: %.2f MB\n" ..
            "GC Pause: %d%%\n" ..
            "Draw Calls: %d\n" ..
            "Canvas Switches: %d\n" ..
            "Texture Memory: %.2f MB\n" ..
            "Images: %d\n" ..
            "Fonts: %d\n" ..
            "Obstacles: %d\n" ..
            "Clouds: %d",
            usedMem / 1024,
            collectgarbage("count") > 0 and collectgarbage("count") / 10 or 0,
            stats.drawcalls,
            stats.canvasswitches,
            stats.texturememory / 1024 / 1024,
            stats.images,
            stats.fonts,
            #Obstacles,
            #Clouds
        )
        love.graphics.print(perfText, 10, y)
        y = y + fontDefault:getHeight() * 9

        -- Game
        local dt = love.timer.getDelta()
        local avgDt = love.timer.getAverageDelta()
        local playerText = string.format(
            "Game Started: %s\n" ..
            "Game Running: %s\n" ..
            "Bird X: %.1f Y: %.1f\n" ..
            "Velocity X: %.1f Y: %.1f\n" ..
            "Rotation: %.1f°\n" ..
            "Delta Time: %.4fs (%.1f ms)\n" ..
            "Avg Delta: %.4fs (%.1f ms)\n" ..
            "Time: %.2fs",
            tostring(Player.gameStarted),
            tostring(Player.gameRunning),
            Bird.position.X, Bird.position.Y,
            Bird.velocity.X, Bird.velocity.Y,
            Bird.rotation,
            dt, dt * 1000,
            avgDt, avgDt * 1000,
            Time
        )
        love.graphics.print(playerText, 10, y)
        y = y + fontDefault:getHeight() * 10

        -- System Info
        local renderer = love.graphics.getRendererInfo and love.graphics.getRendererInfo() or ""
        local systemText = string.format(
            "OS: %s\nGPU: %s",
            love.system.getOS(),
            select(4, love.graphics.getRendererInfo()) or 0
        )
        love.graphics.print(systemText, 10, y)
    end
end


M.drawMenu = function()
    love.graphics.setBackgroundColor(lightBlue)
    love.graphics.setFont(fontDefault)
    love.graphics.setColor(0, 0, 0, 1)

    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY - 30), "Falling Bird!", font50)
    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY + 10), "Press enter to start", font30)

    local text = "Use W/D or left/right to move."
    love.graphics.setFont(fontDefault)
    fontDefault:setFilter("nearest")
    local textWidth  = fontDefault:getWidth(text)
    local textHeight = fontDefault:getHeight()
    local drawX = Screen.centerX - textWidth / 2
    local drawY = Screen.Y - textHeight - 10
    love.graphics.print(text, math.floor(drawX), math.floor(drawY))

    M.drawDebug()
end

M.lostScreen = function()
    love.graphics.setColor(0, 0, 0, 1)
    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY + 50), "Points: " .. Player.points, font30)
    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY - 40), "You lost!", font50)
    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY + 10), "Press enter to try again", font30)
end

function M.drawCenteredText(centerX, centerY, text, font)
    love.graphics.setFont(font)
    font:setFilter("nearest")
    local textWidth  = font:getWidth(text)
    local textHeight = font:getHeight()

    local drawX      = centerX - textWidth / 2
    local drawY      = centerY - textHeight / 2
    love.graphics.print(text, math.floor(drawX), math.floor(drawY))
end

M.windowResized = function()
    local screen = {
        X = 0,
        Y = 0,
        centerX = 0,
        centerY = 0,
        minSize = 0,
        topLeft = { X = 0, Y = 0 },
        topRight = { X = 0, Y = 0 },
        bottomLeft = { X = 0, Y = 0 },
        bottomRight = { X = 0, Y = 0 }
    }
    screen.X, screen.Y = love.graphics.getDimensions()
    screen.minSize = (screen.Y < screen.X) and screen.Y or screen.X
    screen.centerX = screen.X / 2
    screen.centerY = screen.Y / 2

    local half = screen.minSize / 2
    screen.topLeft.X = screen.centerX - half
    screen.topLeft.Y = screen.centerY - half
    screen.topRight.X = screen.centerX + half
    screen.topRight.Y = screen.centerY - half
    screen.bottomRight.X = screen.centerX + half
    screen.bottomRight.Y = screen.centerY + half
    screen.bottomLeft.X = screen.centerX - half
    screen.bottomLeft.Y = screen.centerY + half

    return screen
end


return M;
