local RunService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local lp = players.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local ws = game:GetService("Workspace")
local cam = ws.CurrentCamera
local radius = 50
local function get2dDistance(a, b)
	return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2)
end

local function mousepos()
	return uis:GetMouseLocation()
end
local function tinmr()
	local name = nil
	local color = Color3.new(0, 1, 0)
	local mpos = uis:GetMouseLocation()
	for _, v in pairs(players:GetChildren()) do
		if v ~= lp then
			local tchar = v.Character
			if not tchar then continue end
			local root = tchar:FindFirstChild("HumanoidRootPart").Position
			if not root then continue end
			local screenpos = cam:WorldToScreenPoint(root)
			if get2dDistance(mpos, screenpos) <= radius + 10 then
				color = Color3.new(1, 0, 0)
				name = v.Name
				spos = screenpos
				worldpos = root
				break
			end
		end
	end
	return color, name, spos, worldpos
end
local lastUpdate = 0
RunService.Render:Connect(function()
    local color, name, spos, worldpos = tinmr()
    
    DrawingImmediate.Circle(mousepos(), radius, color, 1, 200, 2)
    
    if name and spos then
        DrawingImmediate.Text(spos, 10, color, 1, name, true)
        
        if isleftpressed() and worldpos then
            if tick() - lastUpdate >= 0.2 then
                lastUpdate = tick()
                local projf = ws:FindFirstChild("ProjectileContainer")
                if not projf then return end
                for _, proj in ipairs(projf:GetChildren()) do
                    if proj.Name == "DynamiteProjectile" or proj.Name == "MolotovProjectile" then
                        pcall(function()
                            proj.CFrame = CFrame.new(worldpos)
                            proj.AssemblyLinearVelocity = Vector3.zero
                        end)
                    end
                end
            end
        end
    end
end)
