local bird = {}

bird.radius = 50
bird.scale = {X = .3, Y = .3}
bird.color = {0.2,1,0.2,1}
bird.position = {X=100, Y=100}

bird.createBird = function()
    bird.sprite= love.graphics.newImage("assets/franz.png" )
end

bird.getScaledDimensions = function ()
    local w, h = bird.sprite:getDimensions()
    return w * bird.scale.X, h*bird.scale.Y
end

bird.centerPos = function()
    local w, h = bird.getScaledDimensions()
    bird.position = {
        X = Screen.centerX - w / 2,
        Y = Screen.centerY - h / 2
    }
end

bird.render = function()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(bird.sprite, bird.position.X, bird.position.Y, 0, bird.scale.X, bird.scale.Y)
end


return bird;