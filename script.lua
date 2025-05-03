local allowedPlaceIds = {
    [1234567890] = true,
    [9876543210] = true,
    [1122334455] = true  -- Yeni oyun ID’lerini buraya ekleyebilirsin
}

if allowedPlaceIds[game.PlaceId] then
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local teleportService = game:GetService("TeleportService")

    local luckText = "25x Luck"
    local eggs = {}

    -- HUD oluştur
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(0, 300, 0, 50)
    infoLabel.Position = UDim2.new(0, 10, 0, 10)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    infoLabel.TextSize = 20
    infoLabel.Text = "Yumurtalar aranıyor..."
    infoLabel.Parent = screenGui

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 100, 0, 50)
    toggleButton.Position = UDim2.new(0, 10, 0, 70)
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextSize = 18
    toggleButton.Text = "HUD Aç"
    toggleButton.Parent = screenGui

    local isHUDVisible = true

    toggleButton.MouseButton1Click:Connect(function()
        isHUDVisible = not isHUDVisible
        infoLabel.Visible = isHUDVisible
        toggleButton.Text = isHUDVisible and "HUD Kapat" or "HUD Aç"
    end)

    function findEggsWithLuck()
        eggs = {}  -- Önceki listeyi temizle
        for _, egg in pairs(workspace:GetChildren()) do
            if egg:IsA("Model") and egg:FindFirstChild("BillboardGui") then
                local billboard = egg:FindFirstChild("BillboardGui")
                if billboard:FindFirstChild("TextLabel") and billboard.TextLabel.Text == luckText then
                    table.insert(eggs, egg)
                end
            end
        end
    end

    function teleportToEgg(egg)
        if egg and egg.PrimaryPart then
            local eggPosition = egg.PrimaryPart.Position
            character:SetPrimaryPartCFrame(CFrame.new(eggPosition))
        end
    end

    while true do
        infoLabel.Text = "Yumurtalar aranıyor..."
        findEggsWithLuck()

        if #eggs > 0 then
            infoLabel.Text = "Işınlanıyor..."
            for _, egg in pairs(eggs) do
                teleportToEgg(egg)
            end
        else
            infoLabel.Text = "25x Luck'lı yumurta bulunamadı."
        end

        wait(2)
    end
else
    warn("Bu script bu oyunda çalışmaz.")
end
