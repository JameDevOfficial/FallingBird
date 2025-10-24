local M = {}

M.DEBUG = false
M.verticalMovement = false 

M.bird = {}
M.bird.speed = 500
M.bird.tolerance = 15
M.bird.image = "assets/stylish_franz.png"

M.obstacles = {}
M.obstacles.gapWidth = 20 -- %
M.obstacles.spawnBetween = {10,90}
M.obstacles.delay = 2
M.obstacles.speed = 200
M.obstacles.imageL = "assets/pipeLeft.png"
M.obstacles.imageR = "assets/pipeRight.png"
M.obstacles.imageSize = {W = 1000, H=100}

M.clouds = {}
M.clouds.spawnChance = 50 -- in %
M.clouds.speed = 125
M.clouds.delay = 0.35
M.clouds.image = "assets/cloud.png"
M.clouds.imageSize = { W = 135, H = 100 }

return M;