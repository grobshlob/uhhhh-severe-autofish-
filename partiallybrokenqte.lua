send_notification("dont move once u execute", "warning")
print("HI i updated2")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()

local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local lp = player.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local radius = 40
local bpos = nil
local ogpos = nil


local container = lp.PlayerGui.MashingSystem.Container
local qteLabel = container.Circle.KeyLabel


local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
end

local function holde()
	print("HI4")
	local chest = ws.Chests.ChestBox
	for _, v in pairs(chest:GetChildren()) do
		if v:IsA("MeshPart") and v.Name == "Main" then
			local part67 = v
			local ppos = part67.Position
			print(ppos)
			local dista = getDistance(root.Position, part67.Position)
			print(dista)
			if dista <=100 then
				print("HI5")
				for i = 1, 5 do
					root.CFrame = CFrame.new(ppos.X, ppos.Y, ppos.Z)
					task.wait(0.2)
				end
				print("HI1")
				keypress(0x45)
				task.wait(2.5)
				keyrelease(0x45)
				break
			end
		end
	end
end

local function getthebob()
    if ogpos == nil then
        ogpos = root.Position
        print("Original position saved:", ogpos)
    end
    for _, v in pairs(ws:GetChildren()) do
        if v:IsA("Part") and v:FindFirstChild("RopeConstraint") then
            local rpos = root.Position
            local ok, bpos = pcall(function()
				return v.Position
			end)
			if ok and bpos then
            	local distance = getDistance(rpos, bpos)
            	if distance < radius then
                	return true
            	end
        	end
    	end
    	return false
	end
end

task.spawn(function()
    while true do
        task.wait(0.05)
        task.spawn(function()
            local ok, vis = pcall(function()
                return container.Visible
            end)
            if ok and vis then
                local ok2, text = pcall(function()
                    return qteLabel.Text
                end)
                if ok2 and text and text ~= "" then
                    getthebob()
                    local clean = text:gsub("%s", ""):upper()
                    local keycode = string.byte(clean)
                    keypress(keycode)
                    task.wait(0.05)
                    keyrelease(keycode)
                    print("QTE pressed:", clean)
                    if root.Position ~= ogpos and ogpos ~= nil then
                    	print("HI3")
                    	task.wait(2.5)
                    	holde()
                    	task.wait(1)
                    	root.CFrame = CFrame.new(ogpos)
                    	task.wait(1)
                    	ogpos = nil
                    	mouse1press()
                    	task.wait(0.2)
                    	mouse1release()
                    	keypress(0x45)
                    	task.wait(2.5)
                    	keyrelease(0x45)
                    else 
                    	task.wait(.9)
                    	mouse1click()
                    end
                end
            end
        end)
    end
end)

local radius2 = .5
local function watersplash()
    if getthebob() then
        getthebob()
        for _, b in pairs(ws:GetChildren()) do
            if b:IsA("Part") and b:FindFirstChild("RippleWater") then
                local ok, wpos = pcall(function()
					return b.Position
				end)
				if not wpos or wpos == nil then mouse1click() end
                if ok and wpos then
					local dist = getDistance(wpos, bpos)
					if dist <= radius2 then
	                	print("HI2")
						task.wait(0.075)
	                    mouse1press()
	                    task.wait(0.3)
	                    mouse1release()
	                    task.wait(1)
	                    mouse1press()
						task.wait(0.05)
						mouse1release()
                	end
				else
					mouse1press()
					task.wait(0.3)
					mouse1release()
				end
            end
        end
    end
end

task.spawn(function()
    while true do
        task.wait(0.2)
        if getthebob() then watersplash() end
    end
end)


send_notification("fishing bot running, hold out ur fishing rod and once u cast it will start", "info")
