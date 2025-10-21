local M = {}

local bird = {
    radius = 50,
    color = {},
    position = {}
}

M.createBird = function(screen, world )
    bird.shape = love.physics.newCircleShape(bird.radius);
    bird.body = love.physics.newBody(world.world, bird.position.X, bird.position.Y, "dynamic")
    bird.fixture = love.physics.newFixture(bird.body, bird.shape, 1) 
end

return M;