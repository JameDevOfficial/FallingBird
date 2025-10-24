local BgLayer = {}

function BgLayer:initialize(image, dx)
    self.x = 0
    self.y = 0
    self.ox = 0
    self.dx = dx
    self.image = image
    self.width = image:getWidth()
    self.height = image:getHeight()
    self.loopAt = self.width
end

function BgLayer:update(dt)
    self.ox = (self.ox + self.dx * dt) % self.loopAt
end

function BgLayer:render()
    local G = love.graphics

    G.draw(self.image, self.x, self.y, 0, 1, 1, self.ox)
    G.draw(self.image, self.width, self.y, 0, 1, 1, self.ox)
end

return BgLayer;