Suit = require("libs.suit")
Settings = require("game.settings")
UserInterface = require("game.ui")
Bird = require("game.sprites.bird")
Obstacle = require("game.sprites.obstacle")
Game = require("game.Game")


IsPaused = false
Time = 0
Screen = {}
Obstacles = {}

function love.load()
    love.window.maximize()
    math.randomseed(os.time());
    Screen = UserInterface.windowResized()

    --Bird
    Bird.createBird()
    Bird.centerPos()
    Obstacle.createSprite()
end

function love.update(dt)
    if IsPaused then return end
    Time = Time + dt
    Game.spawnObstacles()
    Bird.update(dt)
    for i, v in ipairs(Obstacles) do
        if not v then
            table.remove(Obstacles, i)
        else
            v:update(dt)
            if Game.checkCollisons(dt, v) then
                break;
            end
        end

    end
end

function love.draw()
    UserInterface.drawFrame()
    Suit.draw()
end

function love.resize()
    Screen = UserInterface.windowResized()
    print("resize to " .. Screen.X ..", " .. Screen.Y)
end
