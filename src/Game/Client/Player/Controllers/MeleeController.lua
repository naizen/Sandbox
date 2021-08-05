local Knit = require(game:GetService("ReplicatedStorage").Knit)

local debounce = false
local currTime = 0
local prevTime = 0
local comboCount = 0
local cooldown = 0.25

local rightPunchAnimation = Instance.new("Animation")
rightPunchAnimation.AnimationId = "rbxassetid://6914204243"

local leftPunchAnimation = Instance.new("Animation")
leftPunchAnimation.AnimationId = "rbxassetid://6916365716"

local humanoid
local punchAnimations = {}

local MeleeController = Knit.CreateController { Name = "MeleeController" }

function MeleeController:KnitStart()
    local character = Knit.Player.Character

    if not character then
        character = Knit.Player.CharacterAdded:Wait()
    end

    humanoid = character:WaitForChild("Humanoid")

    local rightPunchAnimationTrack = humanoid:LoadAnimation(rightPunchAnimation)
    local leftPunchAnimationTrack = humanoid:LoadAnimation(leftPunchAnimation)

    punchAnimations = {
        rightPunchAnimationTrack,
        leftPunchAnimationTrack
    }
end

function MeleeController:KnitInit()
end

function MeleeController:Attack()
    local MeleeService = Knit.GetService("MeleeService")

    if not debounce then
        debounce = true
        currTime = tick()

        local elapsedTime = prevTime - currTime;

        if elapsedTime < cooldown then
            -- Continue the combo
            comboCount = comboCount + 1
            
            if comboCount > 2 then
                comboCount = 1
            end
        else
            -- Restart combo
            comboCount = 1
        end
        
        local punchAnim = punchAnimations[comboCount]
        punchAnim:Play()

        MeleeService:Attack()

        prevTime = currTime
        wait(cooldown)
        debounce = false
    end
end

return MeleeController