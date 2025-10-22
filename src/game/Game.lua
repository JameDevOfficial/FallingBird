local M = {}
M.lastTime = 0
M.spawnObstacles = function()
    if Time - M.lastTime > Settings.pipeDelay or M.lastTime == 0 then
        table.insert(Obstacles, Obstacle:new { position = { X = 0, Y = Screen.Y }, align = "left" })
        table.insert(Obstacles, Obstacle:new { position = { X = 0, Y = Screen.Y }, align = "right" })
        M.lastTime = Time
    end
end

function M.aabbIntersect(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

function M.checkCollisons(dt, o)
    local bx, by, bw, bh = Bird.getAABB()
    local ox, oy, ow, oh = o:getAABB()
    if M.aabbIntersect(bx, by, bw, bh, ox, oy, ow, oh) then
        print("collision with obstacle", o)
        return true
    end
    return false
end

return M;
