local Knit = require(game:GetService("ReplicatedStorage").Knit)

local SPRINT_SPEED = 30
local WALK_SPEED = 16

local MovementController = Knit.CreateController { Name = "MovementController" }

function MovementController:KnitStart()
    local character = Knit.Player.Character

    if not character then
        character = Knit.Player.CharacterAdded:Wait()
    end

    local humanoid = character:WaitForChild("Humanoid")

    -- Disable climbing by default
    humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)
end

function MovementController:KnitInit()
end

function MovementController:Sprint(isActive)
    local speed = WALK_SPEED

    if isActive then
        speed = SPRINT_SPEED
    end

    Knit.Player.Character.Humanoid.WalkSpeed = speed 
end

return MovementController