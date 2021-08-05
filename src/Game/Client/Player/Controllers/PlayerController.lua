local Knit = require(game:GetService("ReplicatedStorage").Knit)
local UserInputService = game:GetService("UserInputService")

-- PlayerController keeps track of the current state of the player
-- Handles input based on current state
-- Possible states could be: isGathering, isBowEquipped, canSprint, isBuilding etc..
local PlayerController = Knit.CreateController { Name = "PlayerController" }

function PlayerController:KnitStart()
   local MovementController = Knit.Controllers.MovementController
   local MeleeController = Knit.Controllers.MeleeController

   UserInputService.InputBegan:Connect(function(input, isProcessed)
      if isProcessed then return end

      -- Handle keyboard input begins
      if input.UserInputType == Enum.UserInputType.Keyboard then
         if input.KeyCode == Enum.KeyCode.LeftShift then
            MovementController:Sprint(true)
         end
      end

      if input.UserInputType == Enum.UserInputType.MouseButton1 then
         MeleeController:Attack()
      end
   end)

   UserInputService.InputEnded:Connect(function(input, isProcessed)
      if isProcessed then return end

      -- Handle keyboard input ends
      if input.UserInputType == Enum.UserInputType.Keyboard then
         if input.KeyCode == Enum.KeyCode.LeftShift then
            MovementController:Sprint(false)
         end
      end

      -- if input.UserInputType == Enum.UserInputType.MouseButton1 then
      -- end
   end)
end

function PlayerController:KnitInit()
end

return PlayerController