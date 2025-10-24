local M = {}

M.rgbToDecimal = function(r, g, b)
    return { r / 255, g / 255, b / 255 };
end

local fontDefault = love.graphics.newFont(20)
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
    love.graphics.print("Points: " .. Player.points)
    --Screens
    if Player.gameRunning == false then
        M.lostScreen()
    end
end

M.drawMenu = function()
    love.graphics.setBackgroundColor(lightBlue)
    love.graphics.setFont(fontDefault)

    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY - 30), "Falling Bird!", 50)
    M.drawCenteredText(math.floor(Screen.centerX),
        math.floor(Screen.centerY + 10), "Press enter to start", 30)
end

M.lostScreen = function()
    love.graphics.setColor(0, 0, 0, 1)
    M.drawCenteredText(
        math.floor(Screen.centerX),
        math.floor(Screen.centerY),
        "You lost!",
        50
    )
end

function M.drawCenteredText(centerX, centerY, text, fontSize)
    local font = love.graphics.newFont(fontSize)
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
