local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local teleportService = game:GetService("TeleportService")

-- 25x Luck'lı Void Egg'lerin listesi
local luckText = "25x Luck"
local eggs = {}

-- Void Egg ve "25x Luck" tabelasının bulunduğu alanı tanımla
function findEggsWithLuck()
    -- Yumurtaların bulunduğu alanda gezinme
    for _, egg in pairs(workspace:GetChildren()) do
        -- Eğer nesne bir Model (yumurta) ise ve içerisinde "BillboardGui" varsa
        if egg:IsA("Model") and egg:FindFirstChild("BillboardGui") then
            local billboard = egg:FindFirstChild("BillboardGui")
            if billboard and billboard:FindFirstChild("TextLabel") then
                local textLabel = billboard.TextLabel
                -- Eğer yazı "25x Luck" ise, bu yumurtayı listeye ekle
                if textLabel.Text == luckText then
                    table.insert(eggs, egg)  -- Listeye bu yumurtayı ekle
                end
            end
        end
    end
end

-- Işınlanma fonksiyonu
function teleportToEgg(egg)
    if egg and egg.PrimaryPart then
        local eggPosition = egg.PrimaryPart.Position
        character:SetPrimaryPartCFrame(CFrame.new(eggPosition))
    end
end

-- Sürekli olarak ışınlanma işlemini gerçekleştiren döngü
while true do
    -- "25x Luck" yazılı yumurtaları bul
    findEggsWithLuck()

    -- Her bir "25x Luck" yumurtasına ışınlan
    for _, egg in pairs(eggs) do
        teleportToEgg(egg)
    end

    -- Her 2 saniyede bir tekrar kontrol et
    wait(2)
end
