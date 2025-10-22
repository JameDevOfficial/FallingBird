local bird = {}

bird.radius = 50
bird.scale = { X = .3, Y = .3 }
bird.color = { 0.2, 1, 0.2, 1 }
bird.position = { X = 100, Y = 100 }
bird.velocity = { X = 0, Y = 0 }
bird.damping = 0.98
bird.speed = 1000

bird.createBird = function()
    bird.sprite = love.graphics.newImage("assets/franz.png")
end

bird.getScaledDimensions = function()
    local w, h = bird.sprite:getDimensions()
    return w * bird.scale.X, h * bird.scale.Y
end

bird.centerPos = function()
    local w, h = bird.getScaledDimensions()
    bird.position = {
        X = Screen.centerX - w / 2,
        Y = Screen.centerY - h / 2
    }
end

bird.update = function(dt)
    bird.position.X = bird.position.X + bird.velocity.X * dt
    bird.position.Y = bird.position.Y + bird.velocity.Y * dt

    bird.velocity.X = bird.velocity.X * bird.damping
    bird.velocity.Y = bird.velocity.Y * bird.damping

    local w, h = bird.getScaledDimensions()

    if bird.position.X < 0 then
        bird.position.X = 0; bird.velocity.X = 0
    end
    if bird.position.Y < 0 then
        bird.position.Y = 0; bird.velocity.Y = 0
    end
    if bird.position.X + w > Screen.X then
        bird.position.X = Screen.X - w; bird.velocity.X = 0
    end
    if bird.position.Y + h > Screen.Y then
        bird.position.Y = Screen.Y - h; bird.velocity.Y = 0
    end

    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        bird.velocity.X = bird.velocity.X - bird.speed * dt
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        bird.velocity.X = bird.velocity.X + bird.speed * dt
    end
end

bird.render = function()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(bird.sprite, bird.position.X, bird.position.Y, 0, bird.scale.X, bird.scale.Y)
end


return bird;
