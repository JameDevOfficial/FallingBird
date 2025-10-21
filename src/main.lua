Suit = require("libs.suit")
Settings = require("game.settings")
UserInterface = require("game.ui")
Bird = require("game.bird")
DebugWorldDraw = require("libs.debugWorldDraw")


IsPaused = false

Screen = {}
World = {
    world = love.physics.newWorld(0, 100, true)
}

function love.load()
    love.window.maximize()
    math.randomseed(os.time());
    Screen = UserInterface.windowResized()
end

function love.update(dt)
    if IsPaused then return end

    World.world.update(World.world, dt)

end

function love.draw()
    
    Suit.draw()
    if Settings.DEBUG == true then
        DebugWorldDraw(World.world, ((Screen.X - Screen.minSize) / 2), ((Screen.Y - Screen.minSize) / 2), Screen.minSize,
            Screen.minSize)
    end

end
