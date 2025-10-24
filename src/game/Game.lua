local M = {}
M.lastTimeO = 2
M.lastTimeC = Settings.obstacles.delay

M.updateSprites = function(Sprites, dt, checkCollision)
    for i = #Sprites, 1, -1 do
        local v = Sprites[i]

        if v:update(dt) ~= -1 and checkCollision then
            if M.checkCollisons(dt, v) then
                Player.gameRunning = false
                break;
            end
        end
    end
end
M.spawnObstacles = function()
    if Time - M.lastTimeO > Settings.obstacles.delay then
        Obstacle.createPair()
        M.lastTimeO = Time
    end
end

local function sortCloudsBySpeed()
    table.sort(Clouds, function(a, b)
        -- Sort by speed (slower clouds first, so they're drawn behind)
        -- Since velocity.Y is negative, smaller absolute value = slower
        return math.abs(a.velocity.Y) < math.abs(b.velocity.Y)
    end)
end

M.spawnCloudRandom = function()
    if Time - M.lastTimeC < Settings.clouds.delay then
        return
    end
    M.lastTimeC = Time
    local spawn = math.random(1, 1000)
    if spawn < Settings.clouds.spawnChance * 10 then
        print("Spawned cloud at " .. (Settings.clouds.spawnChance / spawn) * Screen.X)
        local randScale = (math.random() / 2 + 0.75)
        Cloud.spawnCloud(Cloud:new({
            position = {
                X = math.random(Settings.clouds.imageSize.W / 2, Screen.X - Settings.clouds.imageSize.W / 2),
                Y = (Screen.Y)
            },
            size = {
                W = Settings.clouds.imageSize.W * randScale,
                H = Settings.clouds.imageSize.H * randScale
            },
            velocity = {Y=-Settings.clouds.speed * randScale, X=0}
        }))
        sortCloudsBySpeed()
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
