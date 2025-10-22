local M = {}

M.drawFrame = function ()
    love.graphics.setBackgroundColor(1, 1, 1)
    --Bird
    love.graphics.setColor(Bird.color[1], Bird.color[2], Bird.color[3], Bird.color[4])
    Bird.render()
    for i,v in ipairs(Obstacles) do
        v:render()
    end
    if Player.gameRunning == false then
        M.lostScreen()
    end
end

M.lostScreen = function ()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("You lost!")
    M.drawCenteredText(
        math.floor(Screen.centerX),
        math.floor(Screen.centerY),
        100, 30,
        "You lost!",
        2
    )
end

function M.drawCenteredText(rectX, rectY, rectWidth, rectHeight, text, scale)
    local font       = love.graphics.getFont()
    font:setFilter("nearest")
    local textWidth  = font:getWidth(text)
    local textHeight = font:getHeight()
    love.graphics.print(text, math.floor(rectX + rectWidth / 2), math.floor(rectY + rectHeight / 2), 0,scale, scale, textWidth / 2, textHeight / 2)
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