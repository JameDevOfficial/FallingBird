local Obstacle = {}
Obstacles = {}
Obstacle.__index = Obstacle

Obstacle._sharedSpriteLeft = nil
Obstacle._sharedSpriteRight = nil

function Obstacle.createSprite()
    Obstacle._sharedSpriteLeft = love.graphics.newImage(Settings.obstacles.imageL)
    Obstacle._sharedSpriteRight = love.graphics.newImage(Settings.obstacles.imageR)
end

function Obstacle.createPair()
    local openRangeRandStart = math.random(Settings.obstacles.spawnBetween[1],
        Settings.obstacles.spawnBetween[2] - Settings.obstacles.gapWidth)
    local gapStartPx         = openRangeRandStart / 100 * Screen.X
    local gapEndPx           = (openRangeRandStart + Settings.obstacles.gapWidth) / 100 * Screen.X

    local leftPosX           = gapStartPx - Settings.obstacles.imageSize.W
    local rightPosX          = gapEndPx

    table.insert(Obstacles,
        Obstacle:new { position = { X = leftPosX, Y = Screen.Y }, size = { W = Settings.obstacles.imageSize.W, H = Settings.obstacles.imageSize.H }, align = "left" })
    table.insert(Obstacles,
        Obstacle:new { position = { X = rightPosX, Y = Screen.Y }, size = { W = Settings.obstacles.imageSize.W, H = Settings.obstacles.imageSize.H }, align = "right" })
end

function Obstacle:new(opts)
    opts       = opts or {}
    local o    = setmetatable({}, self)
    o.scale    = opts.scale or { X = 1, Y = 1 }
    o.size     = opts.size or { W = 0, H = 0 }
    o.color    = opts.color or { 0.2, 1, 0.2, 1 }
    o.position = opts.position or { X = 100, Y = 100 }
    o.velocity = opts.velocity or { X = 0, Y = -Settings.obstacles.speed }
    o.speed    = opts.speed or Settings.obstacles.speed
    if opts.align == "left" then
        o.sprite = opts.sprite or Obstacle._sharedSpriteLeft
    else
        o.sprite = opts.sprite or Obstacle._sharedSpriteRight
    end
    o.align  = opts.align or "left"
    o.offset = opts.offset or { X = 0, Y = 0 }

    -- if o.align == "left" then
    --     o.position.X = 0
    --     o.offset.X = 0
    -- elseif o.align == "right" then
    --     o.offset.X = 0
    -- end
    return o
end

function Obstacle:destroy()
    print("Destroyed")
    self.shape = nil
    self.sprite = nil
    self.position = nil
    self.velocity = nil
    self.scale = nil
    self.size = nil
    self.color = nil
    self.speed = nil
    self.align = nil
    setmetatable(self, nil)
end

function Obstacle:removeFrom(list)
    for i = #list, 1, -1 do
        if list[i] == self then
            table.remove(list, i)
            break
        end
    end
    self:destroy()
end

function Obstacle:update(dt)
    self.position.Y = self.position.Y + self.velocity.Y * dt

    local w, h = self:getScaledDimensions()

    if self.position.Y < Screen.Y / 2 and not self.gotPoints and self.align == "left" then
        Player.points = Player.points + 1
        self.gotPoints = true
    end

    if self.position.Y + h < 0 then
        self.position.Y = 0
        self:removeFrom(Obstacles)
        return -1
    end
    return 1
end

function Obstacle:render()
    love.graphics.setColor(1, 1, 1)
    local w, h = self.sprite:getDimensions()
    local xScale = (self.size.W / w) * self.scale.X
    local yScale = (self.size.H / h) * self.scale.Y
    love.graphics.draw(self.sprite, self.position.X, self.position.Y, 0, xScale, yScale, self.offset.X, self.offset.Y)
end

function Obstacle:getActualPostion()
    return
        self.position.X - (self.offset.X * self.scale.X),
        self.position.Y - (self.offset.Y * self.scale.Y)
end

function Obstacle:getScaledDimensions()
    local w, h = self.sprite:getDimensions()
    return w * self.scale.X, h * self.scale.Y
end

function Obstacle:getAABB()
    local px, py = self:getActualPostion()
    local sx, sy = self.size.W, self.size.H
    return px, py, sx, sy
end

return Obstacle;
