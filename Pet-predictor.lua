-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Pet Pool
local PET_POOL = {
    ["Bug Egg"] = {"Snail", "Caterpillar", "Giant Ant"},
    ["Night Egg"] = {"Hedgehog", "Frog", "Echo Frog", "Blood Hedgehog", "Blood Kiwi"},
    ["Mythical Egg"] = {"Squirrel", "Red Giant Ant", "Grey Mouse", "Brown Mouse"},
    ["Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Mimic Octopus"},
    ["Oasis Egg"] = {"Meerkat", "Sandsnake", "Oxolotl"},
    ["Primal Egg"] = {"Brontosaurus", "Spinosaurus", "Pterodactyl", "Raptor"},
    ["Dinosaur Egg"] = {"Brontosaurus", "Raptor", "Pterodactyl"}
}

-- GUI
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "EggRandomizerGUI"

-- Dropdown for Egg Types
local eggTypeDropdown = Instance.new("TextButton", screenGui)
eggTypeDropdown.Position = UDim2.new(0.05, 0, 0.1, 0)
eggTypeDropdown.Size = UDim2.new(0, 200, 0, 50)
eggTypeDropdown.Text = "Choose Egg Type"
eggTypeDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- Dropdown for Pet Names
local petNameDropdown = Instance.new("TextButton", screenGui)
petNameDropdown.Position = UDim2.new(0.05, 0, 0.2, 0)
petNameDropdown.Size = UDim2.new(0, 200, 0, 50)
petNameDropdown.Text = "Choose Pet"
petNameDropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

-- Randomize Button
local randomizeButton = Instance.new("TextButton", screenGui)
randomizeButton.Position = UDim2.new(0.05, 0, 0.3, 0)
randomizeButton.Size = UDim2.new(0, 200, 0, 50)
randomizeButton.Text = "Randomize Egg"
randomizeButton.BackgroundColor3 = Color3.fromRGB(150, 255, 150)

-- Fake Egg Part (for demonstration)
local eggPart = Instance.new("Part", workspace)
eggPart.Position = player.Character and player.Character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) or Vector3.new(0, 5, 0)
eggPart.Size = Vector3.new(2, 2, 2)
eggPart.Anchored = true
eggPart.Name = "VisualEgg"
eggPart.BrickColor = BrickColor.new("Bright yellow")

-- Billboard GUI to display pet name
local billboardGui = Instance.new("BillboardGui", eggPart)
billboardGui.Size = UDim2.new(0, 200, 0, 50)
billboardGui.StudsOffset = Vector3.new(0, 3, 0)
billboardGui.AlwaysOnTop = true

local petNameLabel = Instance.new("TextLabel", billboardGui)
petNameLabel.Size = UDim2.new(1, 0, 1, 0)
petNameLabel.Text = ""
petNameLabel.BackgroundTransparency = 1
petNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
petNameLabel.TextScaled = true

-- Logic
local selectedEgg = nil
local selectedPet = nil

-- Update pet dropdown when egg selected
eggTypeDropdown.MouseButton1Click:Connect(function()
    local eggList = {}
    for eggName, _ in pairs(PET_POOL) do
        table.insert(eggList, eggName)
    end
    selectedEgg = eggList[math.random(1, #eggList)]
    eggTypeDropdown.Text = selectedEgg
    selectedPet = nil
    petNameDropdown.Text = "Choose Pet"
end)

-- Update selected pet from selected egg
petNameDropdown.MouseButton1Click:Connect(function()
    if selectedEgg then
        local pets = PET_POOL[selectedEgg]
        selectedPet = pets[math.random(1, #pets)]
        petNameDropdown.Text = selectedPet
    end
end)

-- Show pet name above the egg
randomizeButton.MouseButton1Click:Connect(function()
    if selectedPet and selectedEgg then
        petNameLabel.Text = selectedPet
    else
        petNameLabel.Text = "Select Egg and Pet"
    end
end)
