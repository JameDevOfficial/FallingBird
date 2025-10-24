Settings = require("game.settings")
UserInterface = require("game.ui")
Bird = require("game.sprites.bird")
Obstacle = require("game.sprites.obstacle")
Game = require("game.Game")
BgLayer = require("game.sprites.BgLayer")

IsPaused = false
Player = {
    points = 0,
    gameRunning = false
}
Time = 0
Screen = {}
Obstacles = {}

function love.load()
    Player.gameRunning = true
    --love.window.maximize()
    math.randomseed(os.time());
    Screen = UserInterface.windowResized()

    --Bird
    Bird.createBird()
    Bird.centerPos()
    Obstacle.createSprite()
end

function love.update(dt)
    if IsPaused then return end -- maybe a pause menu
    if Player.gameRunning == false then return end -- add menu here in future
    Time = Time + dt
    Game.spawnObstacles()
    Bird.update(dt)
    for i = #Obstacles, 1, -1 do 
        local v = Obstacles[i]
        if v:update(dt) ~= -1 then
            if Game.checkCollisons(dt, v) then
                Player.gameRunning = false
                break;
            end
        end
    end
end

function love.draw()
    UserInterface.drawFrame()
end

function love.resize()
    Screen = UserInterface.windowResized()
    print("resize to " .. Screen.X ..", " .. Screen.Y)
end
