-- R6 Player Fling Tester
-- Intended for Delta Executor
-- For testing in your own Roblox environment

local Players = game:GetService("Players")

local tool = script.Parent
local RANGE = 10
local FLING_POWER = 90
local UPWARD_POWER = 45

tool.RequiresHandle = false
tool.CanBeDropped = false

tool.Activated:Connect(function()
local character = tool.Parent
local attacker = Players:GetPlayerFromCharacter(character)

if not attacker then  
    return  
end  

local attackerRoot =  
    character:FindFirstChild("HumanoidRootPart")  

if not attackerRoot then  
    return  
end  

local nearestPlayer = nil  
local nearestDistance = RANGE  

for _, player in ipairs(Players:GetPlayers()) do  
    if player ~= attacker then  
        local targetCharacter = player.Character  

        if targetCharacter then  
            local humanoid =  
                targetCharacter:FindFirstChildOfClass("Humanoid")  
            local root =  
                targetCharacter:FindFirstChild("HumanoidRootPart")  

            if humanoid and root and humanoid.Health > 0 then  
                local offset = root.Position - attackerRoot.Position  
                local distance = offset.Magnitude  

                if distance < nearestDistance then  
                    nearestDistance = distance  
                    nearestPlayer = root  
                end  
            end  
        end  
    end  
end  

if nearestPlayer then  
    local direction =  
        nearestPlayer.Position - attackerRoot.Position  

    if direction.Magnitude > 0 then  
        direction = direction.Unit  
    else  
        direction = attackerRoot.CFrame.LookVector  
    end  

    nearestPlayer.AssemblyLinearVelocity =  
        direction * FLING_POWER  
        + Vector3.new(0, UPWARD_POWER, 0)  
end

end)
