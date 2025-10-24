Settings = require("game.settings")
UserInterface = require("game.ui")
Game = require("game.Game")
---------------------------------
Bird = require("game.sprites.bird")
Obstacle = require("game.sprites.obstacle")
BgLayer = require("game.sprites.BgLayer")
Cloud = require("game.sprites.cloud")

IsPaused = false
Player = {
    points = 0,
    gameRunning = false,
    gameStarted = false
}
Time = 0
Screen = {}

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
    if IsPaused then return end -- maybe a pause menu

    if Player.gameRunning == false then return end -- add menu here in future
    Time = Time + dt
    Game.spawnObstacles()
    Game.spawnCloudRandom()
    Bird.update(dt)
    Game.updateSprites(Obstacles, dt, true)
    Game.updateSprites(Clouds, dt, false)
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
    print("resize to " .. Screen.X ..", " .. Screen.Y)
end

function love.keypressed(key, scancode, isRepeat)
    if key == 'a' or key == 'left' then
        Bird.flap(-1)
    elseif key == 'd' or key == 'right' then
        Bird.flap(1)
    end

    if key == "return" and Player.gameStarted == false then --enter
        Player.gameStarted = true
        Player.gameRunning = true
        print("Start!")
    end
end