local Obstacle = {}
Obstacle.__index = Obstacle

Obstacle._sharedSprite = nil

function Obstacle.createSprite()
    Obstacle._sharedSprite = love.graphics.newImage("assets/obstacle.png")
end

function Obstacle:new(opts)
    opts       = opts or {}
    local o    = setmetatable({}, self)
    o.scale    = opts.scale or { X = .5, Y = .5 }
    o.color    = opts.color or { 0.2, 1, 0.2, 1 }
    o.position = opts.position or { X = 100, Y = 100 }
    o.velocity = opts.velocity or { X = 0, Y = -100 }
    o.speed    = opts.speed or 1000
    o.sprite   = opts.sprite or Obstacle._sharedSprite
    o.align    = opts.align or "left"

    if o.align == "left" then
        o.position.X = 0
    elseif o.align == "right" then
        local w, h = o:getScaledDimensions()
        o.position.X = Screen.X - w
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

function Obstacle:getScaledDimensions()
    local w, h = self.sprite:getDimensions()
    return w * self.scale.X, h * self.scale.Y
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
    love.graphics.draw(self.sprite, self.position.X, self.position.Y, 0, self.scale.X, self.scale.Y)
end

function Obstacle:getAABB()
    local w, h = self:getScaledDimensions()
    return self.position.X, self.position.Y, w, h
end

return Obstacle;
