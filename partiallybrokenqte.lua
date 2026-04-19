send_notification("version: 39.3", "warning")
print("HI i updated39")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()

local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local lp = player.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local radius = 40
local vpos = nil
local bpos = nil
local ogpos = nil

local toggle = false

local container = lp.PlayerGui.MashingSystem.Container
local qteLabel = container.Circle.KeyLabel

local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
end
local function get2dDistance(a, b)
	return math.sqrt((a.X - b.X)^2 + (a.Z - b.Z)^2)
end


local function reliabletp(target)
	local root = char:FindFirstChild("HumanoidRootPart")
	task.wait(1)
	keypress(0x51)
	task.wait(0.2)
	root.CFrame = CFrame.new(target + Vector3.new(0, 3, 0))
	task.wait(0.1)
	root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
	task.wait(0.1)
	task.wait(3.5)
	keyrelease(0x51)
	if getDistance(root.Position, target) > 30 then
		keypress(0x51)
		task.wait(0.2)
		root.CFrame = CFrame.new(target + Vector3.new(0, 3, 0))
		task.wait(1)
		root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		task.wait(0.1)
		keyrelease(0x51)
	end
	keyrelease(0x51)
end


local function resetfish()
	local place = game.Workspace.Map.OldCactus.CactusModel.Cactuh
	local placepos = place.Position
	keypress(0x37)
	task.wait(0.1)
	keyrelease(0x37)
	task.wait(1)
	reliabletp(placepos)
	task.wait(1)
	keypress(0x57)
	task.wait(4)
	keyrelease(0x57)
	task.wait(0.5)
	reliabletp(ogpos)
	task.wait(1)
		root = char:FindFirstChild("HumanoidRootPart")
	if getDistance(root.Position, ogpos) < 20 then
		reliabletp(ogpos)
		task.wait(1)
		mouse1click()
	end
	mouse1click()
end

local function getthebob()
	local found = false
    if ogpos == nil then
        ogpos = root.Position
        print("Original position saved:", ogpos)
    end
    for _, v in pairs(ws:GetChildren()) do
        if v:IsA("Part") and v:FindFirstChild("RopeConstraint") then
			local ok, currentpos = pcall(function()
				return v.Position
			end)
			if ok and currentpos then
				local dist = getDistance(currentpos, ogpos)
				if dist < radius then
					hi = currentpos
					found = true
				end
			end
		end
	end
	if found then
		vpos = hi
	else
		vpos = nil
	end
	return found
end


local reset = false

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
                    local clean = text:gsub("%s", ""):upper()
                    local keycode = string.byte(clean)
                    keypress(keycode)
                    task.wait(0.05)
                    keyrelease(keycode)
                    print("QTE pressed:", clean)
					if not reset then
						reset = true
						repeat 
    						task.wait(0.1) 
    						local _, currentVis = pcall(function() return container.Visible end)
						until currentVis == false
						local char = lp.Character
						if not char or char == nil then return end
						local croot = char and char:FindFirstChild("HumanoidRootPart")
						if croot then
							task.wait(3)
							local rpos = croot.Position
							local dist2 = getDistance(rpos, ogpos)
							if dist2 > 2 then
								task.wait(3)
								print("GOING")
								croot.CFrame = CFrame.new(ogpos)
								task.wait(1)
								print("ARRIVED")
								mouse1click()
								task.wait(0.5)
								keyrelease(0x45)
								keypress(0x45)
							else
								print("u recieved an item")
								mouse1click()
							end
						end
						reset = false
                    end
                end
            end
        end)
    end
end)
local radius2 = .5
local function getwater()
	local found2 = false
    if not vpos or typeof(vpos) ~= "Vector3" then 
        getthebob() 
    end
	for _, b in pairs(ws:GetChildren()) do
		if b:IsA("BasePart") and b.Name == "WaterSplashContainer" then
			if b:FindFirstChild("RippleWater") then
				local root = char:FindFirstChild("HumanoidRootPart")
				local ok, h = pcall(function() 
					return getDistance(b.Position, root.Position) >= 40
				end)
				if not ok or h then
					continue
				end
				local wpos = b.Position
				if wpos then
					print(vpos)
					print(wpos)
					local dist = get2dDistance(wpos, vpos)
					if dist <= radius2 then
						found2 = true
					end
				else
					found2 = false
				end
			end
		end
		if found2 then
			bpos = wpos
		end
	end
	return found2
end



local function cast()
	if getwater() then
		task.wait(.1)
		mouse1press()
		task.wait(0.2)
		mouse1release()
		task.wait(.5)
		mouse1press()
		task.wait(0.2)
		mouse1release()
		vpos = nil
		bpos = nil
	end
end

local time = 500
local lastkey = ""
local running = true
task.spawn(function()
	while true do
		task.wait(0.05)
		if not isrbxactive() then
			task.wait(0.3)
			continue
		end
		local pressed = getpressedkeys()
		local current = ""
		for _, k in pairs(pressed) do
			if k == "F1" then
				current = "F1"
				break
			end		
		end	
		if current == "F1" and lastkey ~= "F1" then
			toggle = not toggle
			if toggle then
				send_notification("auto fish started, cast to begin", "info")
				ogpos = root.Position
				root.CFrame = CFrame.new(ogpos)
				task.spawn(function()
					while toggle do
						task.wait(0.2)
						if getthebob() then 
							if getwater() then
								cast()
							end
						else
							mouse1click()
							task.wait(3.5)
						end	
					end
				end)
				task.spawn(function()
					while toggle do
						task.wait(1)
						time = time - 1
						if time == 0 then
							time = 500
							resetfish()
							task.wait(1)
						end
					end	
				end)
			else
				send_notification("auto fish stopped", "info")
			end
		end
		lastkey = current
	end
end)



send_notification("fishing bot running,", "info")
task.wait(1)
send_notification("toggle autofish: f1", "info")
