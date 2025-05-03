local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local teleportService = game:GetService("TeleportService")

-- 25x Luck'lı Void Egg'lerin listesi
local luckText = "25x Luck"
local eggs = {}

-- HUD (Heads-Up Display) ekleme
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player.PlayerGui

local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(0, 300, 0, 50)  -- Ekranda görülecek boyut
infoLabel.Position = UDim2.new(0, 10, 0, 10)  -- Ekranın sol üst köşesine yerleştir
infoLabel.BackgroundTransparency = 1  -- Arkaplanı şeffaf yap
infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Yazı rengi beyaz
infoLabel.TextSize = 20  -- Yazı büyüklüğü
infoLabel.Text = "Yumurtalar aranıyor..."  -- Başlangıç mesajı
infoLabel.Parent = screenGui

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
    -- HUD'e mesaj yaz
    infoLabel.Text = "Yumurtalar aranıyor..."
    
    -- "25x Luck" yazılı yumurtaları bul
    findEggsWithLuck()

    -- Eğer yumurtalar bulunduysa, mesajı güncelle
    if #eggs > 0 then
        infoLabel.Text = "Işınlanmaya başlanıyor..."
    end

    -- Her bir "25x Luck" yumurtasına ışınlan
    for _, egg in pairs(eggs) do
        teleportToEgg(egg)
    end

    -- Her 2 saniyede bir tekrar kontrol et
    wait(5)
end
