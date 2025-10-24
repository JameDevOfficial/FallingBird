Settings = require("game.settings")
UserInterface = require("game.ui")
Game = require("game.Game")
---------------------------------
Bird = require("game.sprites.bird")
Obstacle = require("game.sprites.obstacle")
Cloud = require("game.sprites.cloud")

IsPaused = false
Player = {
    points = 0,
    gameRunning = false,
    gameStarted = false
}
Time = 0
Screen = {}
local lastGCTime = 0

function love.load()
    --love.window.maximize()
    math.randomseed(os.time());
    Screen = UserInterface.windowResized()

    --Sprites
    Bird.createBird()
    Bird.centerPos()
    Obstacle.createSprite()
    Cloud.createSprite()

end

function love.update(dt)
    if IsPaused then return end                    -- maybe a pause menu
    if Player.gameRunning == false then return end -- add menu here in future
    Time = Time + dt
    lastGCTime = lastGCTime + dt
    Game.spawnObstacles()
    Game.spawnCloudRandom()
    Bird.update(dt)
    Game.updateSprites(Obstacles, dt, true)
    Game.updateSprites(Clouds, dt, false)

    if lastGCTime > 2 then
        collectgarbage("step", 100)
        print("Collected Garbage")
        lastGCTime = 0
    end
end

function love.draw()
    if Player.gameStarted == false then
        UserInterface.drawMenu()
        return
    end
    UserInterface.drawFrame()
end

function love.resize()
    Screen = UserInterface.windowResized()
    print("resize to " .. Screen.X .. ", " .. Screen.Y)
end

function love.keypressed(key, scancode, isRepeat)
    if (key == 'a' or key == 'left') and Player.gameRunning == true then
        Bird.flap(-1)
    elseif (key == 'd' or key == 'right') and Player.gameRunning == true then
        Bird.flap(1)
    end

    if key == "return" and Player.gameStarted == false then --enter
        Player.gameStarted = true
        Player.gameRunning = true
    end
    if key == "return" and Player.gameStarted == true and Player.gameRunning == false then     --enter
        Obstacles = {}
        Clouds = {}
        Time = 0
        lastGCTime = 0
        Game.lastTimeO = 0
        Game.lastTimeC = 0
        Player.points = 0
        Bird.velocity = {X=0,Y=0}
        Bird.rotation = 0
        Player.gameRunning = true
        collectgarbage("collect")
    end
    if key == "f5" then
        Settings.DEBUG = not Settings.DEBUG
    end
end
