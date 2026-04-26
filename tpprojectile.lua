local RunService = game:GetService("RunService")
local uis = game:GetService("UserInputService")
local players = game:GetService("Players")
local lp = players.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local ws = game:GetService("Workspace")
local cam = ws.CurrentCamera
local radius = 150
local function get2dDistance(a, b)
	return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2)
end
local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
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
			for _, parts in pairs(tchar:GetChildren()) do
				if parts:IsA("BasePart") then
					local tpos = parts.Position
					local screenpos = cam:WorldToScreenPoint(tpos)
					local screenpos2 = cam:WorldToScreenPoint(root)
					if get2dDistance(mpos, screenpos) <= radius + 10 then
						color = Color3.new(1, 0, 0)
						name = v.Name
						spos = screenpos2
						worldpos = root
					end
				end
			end
		end
	end
	return color, name, spos, worldpos
end

local function getproj()
  local gotdyna = false
  local gotmolo = false
  local tmolo, tdyna = nil, nil
  local _, name, _, worldpos = tinmr()
  local projf = ws:FindFirstChild("ProjectileContainer")
  local children = projf:GetChildren()
  if #children > 0 then
    for _, i in pairs(projf:GetChildren()) do
      print("Checking object in folder: " .. i.Name)
      if i.Name == "DynamiteProjectile" then
        if getDistance(root.Position, i.Position) < 30000 then
          tdyna = i
          gotdyna = true
        end
      elseif i.Name == "MolotovProjectile" then
        if getDistance(root.Position, i.Position) < 30000 then
          tmolo = i
          gotmolo = true
        end
      end
    end
    return gotdyna, gotmolo, tmolo, tdyna
  end
end

RunService.Render:Connect(function()
	
	local color, name, spos, worldpos = tinmr()
  local hasdyna, hasmolo, molotov, dynamite = getproj()
	DrawingImmediate.Circle(
		mousepos(), 
		radius, 
		color,
		1, 
		200,
		2
	)
	if name and spos then
		DrawingImmediate.Text(
			spos,
			25,
			color,
			1,
			name,
			true
		)
    if isleftpressed() and worldpos then
      print("checking")
      local projf = ws:FindFirstChild("ProjectileContainer")
      local children = projf:GetChildren()
      if #children > 0 then
        for _, i in pairs(projf:GetChildren()) do
          if i.Name == "DynamiteProjectile" or i.Name == "MolotovProjectile" then
              i.CFrame = CFrame.new(worldpos)
          end
        end 
      end
    end
	end
end)
