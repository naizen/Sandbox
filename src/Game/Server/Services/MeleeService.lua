local Knit = require(game:GetService("ReplicatedStorage").Knit)

local MeleeService = Knit.CreateService {
    Name = "MeleeService";
    Client = {};
}

function MeleeService.Client:Attack(player)
    print("Attack from server: ", player)
end

function MeleeService:KnitStart()
end

function MeleeService:KnitInit()
end

return MeleeService