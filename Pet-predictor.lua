-- Pet Pool local PET_POOL = { ["Bug Egg"] = {"Snail", "Caterpillar", "Giant Ant"}, ["Night Egg"] = {"Hedgehog", "Frog", "Echo Frog", "Blood Hedgehog", "Blood Kiwi"}, ["Mythical Egg"] = {"Squirrel", "Red Giant Ant", "Grey Mouse", "Brown Mouse"}, ["Paradise Egg"] = {"Ostrich", "Peacock", "Capybara", "Mimic Octopus"}, ["Oasis Egg"] = {"Meerkat", "Sandsnake", "Oxolotl"}, ["Primal Egg"] = {"Brontosaurus", "Spinosaurus", "Pterodactyl", "Raptor"}, ["Dinosaur Egg"] = {"Brontosaurus", "Raptor", "Pterodactyl"} }

-- GUI Setup local eggDropdown = script.Parent:WaitForChild("EggDropdown") local petDropdown = script.Parent:WaitForChild("PetDropdown") local randomizeEggButton = script.Parent:WaitForChild("RandomizeEgg")

-- Randomize Egg Logic randomizeEggButton.MouseButton1Click:Connect(function() local selectedEggType = eggDropdown.Text local petList = PET_POOL[selectedEggType]

if not petList then return end

local selectedPet = petDropdown.Text
if selectedPet == "" or not table.find(petList, selectedPet) then
    selectedPet = petList[math.random(1, #petList)]
end

-- 🥚 Find the egg model in workspace
local eggModel = workspace:FindFirstChild("Egg") -- Change name if needed

if eggModel then
    -- Remove old ESP if it exists
    local oldBillboard = eggModel:FindFirstChild("PetESPBillboard")
    if oldBillboard then oldBillboard:Destroy() end

    -- 📛 Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PetESPBillboard"
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = eggModel

    -- 📝 Create TextLabel inside BillboardGui
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Font = Enum.Font.FredokaOne
    label.TextScaled = true
    label.Text = selectedPet
    label.Parent = billboard
end

end)

