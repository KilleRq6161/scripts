local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- Server Hop Fonksiyonu
function HopServer()
    local servers = {}
    local req = request({
        Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    })
    local body = HttpService:JSONDecode(req.Body)
    for i, v in pairs(body.data) do
        if v.playing < v.maxPlayers and v.id ~= game.JobId then
            table.insert(servers, v.id)
        end
    end
    if #servers > 0 then
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], game.Players.LocalPlayer)
    else
        warn("Uygun sunucu bulunamadı.")
    end
end

-- Ana Script
if game.PlaceId == 7606602544 then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/bbccdf75425332848ae0bf6d3068f0c1.lua"))()
elseif game.PlaceId == 16732694052 or game.PlaceId == 72907489978215 then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/cba17b913ee63c7bfdbb9301e2d87c8b.lua"))()
elseif game.PlaceId == 70876832253163 then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/df969469b8fd0d18b763a0fba7c700a0.lua"))()
elseif game.PlaceId == 116495829188952 then
    queue_on_teleport('loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/df969469b8fd0d18b763a0fba7c700a0.lua"))()')
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/df969469b8fd0d18b763a0fba7c700a0.lua"))()
elseif game.PlaceId == 7606564092 then
    queue_on_teleport('loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/bbccdf75425332848ae0bf6d3068f0c1.lua"))()')
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/bbccdf75425332848ae0bf6d3068f0c1.lua"))()
elseif game.PlaceId == 85896571713843 then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/f5d517c7a5fe691a69c4f0c33c3bc514.lua"))()
else
    warn("[Moon X] -> Game not supported.")
end

-- Örnek: 60 saniyede bir server hop denemesi
task.delay(60, function()
    HopServer()
end)
