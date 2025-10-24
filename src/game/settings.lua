local M = {}

M.DEBUG = true
M.verticalMovement = false 

M.bird = {}
M.bird.speed = 500
M.bird.tolerance = 15
M.bird.image = "assets/stylish_franz.png"

M.obstacles = {}
M.obstacles.gapWidth = 20 -- %
M.obstacles.spawnBetween = {20,80}
M.obstacles.delay = 2
M.obstacles.speed = 200
M.obstacles.imageL = "assets/pipeLeft.png"
M.obstacles.imageR = "assets/pipeRight.png"

return M;