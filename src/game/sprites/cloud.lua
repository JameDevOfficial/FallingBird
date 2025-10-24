local Cloud = {}
Clouds = {}
Cloud.__index = Cloud

Cloud._sharedSpriteLeft = nil
Cloud._sharedSpriteRight = nil

function Cloud.createSprite()
    Cloud._sharedSprite = love.graphics.newImage(Settings.clouds.image)
end

function Cloud.spawnCloud(cloud)
    table.insert(Clouds, cloud)
end

function Cloud:new(opts)
    opts       = opts or {}
    local o    = setmetatable({}, self)
    o.scale    = opts.scale or { X = 1, Y = 1 }
    o.size     = opts.size or { W = 0, H = 0 }
    o.color    = opts.color or { 0.2, 1, 0.2, 1 }
    o.position = opts.position or { X = 100, Y = 100 }
    o.velocity = opts.velocity or { X = 0, Y = -Settings.clouds.speed }
    o.sprite = opts.sprite or Cloud._sharedSprite
    o.offset = opts.offset or { X = 0, Y = 0 }

    -- if o.align == "left" then
    --     o.position.X = 0
    --     o.offset.X = 0
    -- elseif o.align == "right" then
    --     o.offset.X = 0
    -- end
    return o
end

function Cloud:destroy()
    self.position = nil
    self.velocity = nil
    self.scale = nil
    self.size = nil
    self.color = nil
    self.offset = nil
end

function Cloud:removeFrom(list)
    for i = #list, 1, -1 do
        if list[i] == self then
            self:destroy()
            table.remove(list, i)
            return
        end
    end
end

function Cloud:update(dt)
    self.position.Y = self.position.Y + self.velocity.Y * dt

    local w, h = self:getScaledDimensions()

    if self.position.Y + h < 0 then
        self.position.Y = 0
        self:removeFrom(Clouds)
        return -1
    end
    return 1
end

function Cloud:render()
    love.graphics.setColor(1, 1, 1)
    local w, h = self.sprite:getDimensions()
    local xScale = (self.size.W / w) * self.scale.X
    local yScale = (self.size.H / h) * self.scale.Y
    love.graphics.draw(self.sprite, self.position.X, self.position.Y, 0, xScale, yScale, self.offset.X, self.offset.Y)
end

function Cloud:getActualPostion()
    return
        self.position.X - (self.offset.X * self.scale.X),
        self.position.Y - (self.offset.Y * self.scale.Y)
end

function Cloud:getScaledDimensions()
    local w, h = self.sprite:getDimensions()
    return w * self.scale.X, h * self.scale.Y
end

return Cloud;
