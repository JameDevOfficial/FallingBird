local M = {}

M.spawnObstacles = function ()
    table.insert(Obstacles, Obstacle:new { position = { X = 0, Y = Screen.Y }, align = "left" })
    table.insert(Obstacles, Obstacle:new { position = { X = 0, Y = Screen.Y }, align = "right" })
end

return M;