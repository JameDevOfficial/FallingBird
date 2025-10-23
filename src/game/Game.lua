local M = {}
M.lastTime = 0
M.spawnObstacles = function()
    if Time - M.lastTime > Settings.obstacles.delay or M.lastTime == 0 then
        Obstacle.createPair()
        M.lastTime = Time
    end
end

function M.aabbIntersect(x1, y1, w1, h1, x2, y2, w2, h2, tolerance)
    tolerance = tolerance or 0

    local x1T = x1 + tolerance
    local y1T = y1 + tolerance
    local w1T = w1 - (2 * tolerance)
    local h1T = h1 - (2 * tolerance)

    return x1T < x2 + w2 and
        x2 < x1T + w1T and
        y1T < y2 + h2 and
        y2 < y1T + h1T
end

function M.checkCollisons(dt, o)
    local bx, by, bw, bh = Bird.getAABB()
    local ox, oy, ow, oh = o:getAABB()
    if M.aabbIntersect(bx, by, bw, bh, ox, oy, ow, oh, Settings.bird.tolerance) then
        print("collision with obstacle", o)
        return true
    end
    return false
end

return M;
