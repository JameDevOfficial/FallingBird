local Obstacle = {}
Obstacle.__index = Obstacle

Obstacle._sharedSprite = love.graphics.newImage("assets/franz.png")

function Obstacle:new(opts)
    opts       = opts or {}
    local o    = setmetatable({}, self)
    o.scale    = opts.scale or { X = .3, Y = .3 }
    o.color    = opts.color or { 0.2, 1, 0.2, 1 }
    o.position = opts.position or { X = 100, Y = 100 }
    o.velocity = opts.velocity or { X = 0, Y = 0 }
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
 
end

function Obstacle:getScaledDimensions()
    local w, h = self.sprite:getDimensions()
    return w * self.scale.X, h * self.scale.Y
end

function Obstacle:update(dt)
    self.position.Y = self.position.Y + self.velocity.Y * dt
    self.velocity.Y = self.velocity.Y * self.damping

    local w, h = self:getScaledDimensions()

    if self.position.Y + self:getScaledDimensions()[1] < 0 then
        self.position.Y = 0
    end
end

function Obstacle:render()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.sprite, self.position.X, self.position.Y, 0, self.scale.X, self.scale.Y)
end

return Obstacle;
