local M = {}

M.DEBUG = true
M.verticalMovement = true

M.bird = {}
M.bird.speed = 350
M.bird.tolerance = 15

M.obstacles = {}
M.obstacles.gapWidth = 20
M.obstacles.spawnBetween = {20,80}
M.obstacles.delay = 4
M.obstacles.speed = 1000

return M;