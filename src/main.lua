Suit = require("libs.suit")
Settings = require("game.settings")
UserInterface = require("game.ui")
Bird = require("game.sprites.bird")
Obstacle = require("game.sprites.obstacle")


IsPaused = false

Screen = {}
Obstacles = {}

function love.load()
    love.window.maximize()
    math.randomseed(os.time());
    Screen = UserInterface.windowResized()

    --Bird
    Bird.createBird()
    Bird.centerPos()
end

function love.update(dt)
    if IsPaused then return end

    Bird.update(dt)
end

function love.draw()
    UserInterface.drawFrame()
    Suit.draw()
end

function love.resize()
    Screen = UserInterface.windowResized()
    print("resize to " .. Screen.X ..", " .. Screen.Y)
end
