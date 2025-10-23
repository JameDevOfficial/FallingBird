local Obstacle = {}
Obstacle.__index = Obstacle

Obstacle._sharedSprite = nil

function Obstacle.createSprite()
    Obstacle._sharedSprite = love.graphics.newImage("assets/obstacle.png")
end

function Obstacle.createPair()
    local openRangeRand = math.random(Settings.obstacles.spawnBetween[1], Settings.obstacles.spawnBetween[2])
    local openRange = { start = openRangeRand, ending = openRangeRand }
    table.insert(Obstacles, Obstacle:new { position = { X = 0, Y = Screen.Y }, align = "left" })
    table.insert(Obstacles, Obstacle:new { position = { X = 0, Y = Screen.Y }, align = "right" })
end

function Obstacle:new(opts)
    opts       = opts or {}
    local o    = setmetatable({}, self)
    o.scale    = opts.scale or { X = 1, Y = 1 }
    o.size     = opts.size or { W = 600, H = 80 }
    o.color    = opts.color or { 0.2, 1, 0.2, 1 }
    o.position = opts.position or { X = 100, Y = 100 }
    o.velocity = opts.velocity or { X = 0, Y = -100 }
    o.speed    = opts.speed or 1000
    o.sprite   = opts.sprite or Obstacle._sharedSprite
    o.align    = opts.align or "left"
    o.offset = opts.offset or {X = 0, Y = 0}

    if o.align == "left" then
        o.position.X = 0
    elseif o.align == "right" then
        local w, h = o:getScaledDimensions()
        o.offset.X = o.sprite:getWidth()
        o.position.X = Screen.X
    end
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
    self.velocity.Y = self.velocity.Y

    local w, h = self:getScaledDimensions()

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
    print(w.. ", " .. h)
end

function Obstacle:getActualPostion()
    return 
        self.position.X - (self.offset.X or 0),
        self.position.Y - (self.offset.Y or 0)
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
