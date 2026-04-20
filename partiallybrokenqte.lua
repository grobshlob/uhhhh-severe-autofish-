send_notification("version: 42", "warning")
print("HI i updated42")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()

local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local camera = ws.CurrentCamera
local npc = ws:FindFirstChild("NPC")
local dan = npc:FindFirstChild("Daniel")
local map = ws:FindFirstChild("Map")
local trees = map:FindFirstChild("ForestTrees")
local lp = player.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local radius = 40
local vpos = nil
local bpos = nil
local ogpos = nil

local toggle = false
local toggle2 = false

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

local function choptree()
	for i = 1, 26 do
		mouse1click()
		task.wait(1.25)
	end
end

local function gototree()
	for _, v in pairs(trees:GetDescendants()) do
		if v:IsA("BasePart") and v.Name == "TreeBark" then
			if v.Transparency ~= 0 then continue end
			v.CanCollide = false
			local tpos = v.Position
			reliabletp(tpos)
			task.wait(1)
			root = char:FindFirstChild("HumanoidRootPart")
			local rpos = root.Position
			if getDistance(rpos, tpos) <= 70 then
				root.CFrame = CFrame.lookAt(tpos, tpos)
				choptree()
				break
			end
		end
	end
end

local function resetfish()
	local place = game.Workspace.Map.OldCactus.CactusModel.Cactuh
	local placepos = place.Position
	keypress(0x30)
	task.wait(0.1)
	keyrelease(0x30)
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


local function autosellfish()
	local head = dan:FindFirstChild("Head")
	local hpos = head.Position
	local screenpos, visible = camera:WorldToScreenPoint(dan:FindFirstChild("HumanoidRootPart").Position)
	reliabletp(hpos)
	task.wait(1)
	root.CFrame = CFrame.new(hpos.X - 6, hpos.Y, hpos.Z)
	task.wait(1)
	print(screenpos)
	if visible then
		local screenpos, visible = camera:WorldToScreenPoint(dan:FindFirstChild("HumanoidRootPart").Position)
		mousemoveabs(screenpos.X, screenpos.Y)
		task.wait(0.4)
		mouse1click()
		task.wait(1)
		keypress(0xDC)
		task.wait(0.5)
		keyrelease(0xDC)
		for i = 1, 4 do
			keypress(0x44)
			task.wait(0.2)
			keyrelease(0x44)
		end
		task.wait(0.5)
		keypress(0x53)
		task.wait(0.25)
		keyrelease(0x53)
		task.wait(0.05)
		keypress(0x0D)
		task.wait(0.25)
		keyrelease(0x0D)
		task.wait(0.05)
		for i = 1, 2 do
			keypress(0xDC)
			task.wait(0.25)
			keyrelease(0xDC)
		end
		for i = 1, 3 do
			keypress(0x44)
			task.wait(0.25)
			keyrelease(0x44)
		end
		keypress(0x53)
		task.wait(0.25)
		keyrelease(0x53)
		keypress(0x0D)
		task.wait(0.25)
		keyrelease(0x0D)
		task.wait(0.05)
		for i = 1, 2 do
			keypress(0xDC)
			task.wait(0.25)
			keyrelease(0xDC)
		end
		for i = 1, 3 do
			keypress(0x44)
			task.wait(0.25)
			keyrelease(0x44)
		end
		keypress(0x0D)
		task.wait(0.25)
		keyrelease(0x0D)
		task.wait(0.05)
		keypress(0xDC)
	end
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
		vpos = nil
	end
	return found2
end

local function checkbait()
	local baitcheck = false
	local backpack = lp:FindFirstChild("Backpack")
	local bait = backpack:FindFirstChild("Bait")
	if bait then
		baitcheck = true
	end
	return baitcheck
end
		
		

local function cast()
	if getwater() then
		task.wait(.1)
		mouse1press()
		task.wait(0.2)
		mouse1release()
		task.wait(.5)
		local ok, vis = pcall(function()
            return container.Visible
        end)
		if checkbait() and not ok or not vis then
			keypress(0x39)
			task.wait(0.2)
			keyrelease(0x39)
			task.wait(0.75)
			mouse1click()
			keypress(0x39)
			task.wait(0.2)
			keyrelease(0x39)
			task.wait(0.5)
			keypress(0x30)
			task.wait(0.2)
			keyrelease(0x30)
		end
		mouse1press()
		task.wait(0.2)
		mouse1release()
		vpos = nil
		bpos = nil
	end
end

local time = 600
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
			elseif k == "F2" then
				current = "F2"
				break
			end		
		end	
		if current == "F1" and lastkey ~= "F1" then
			toggle = not toggle
			if toggle then
				send_notification("auto fish started", "info")
				ogpos = root.Position
				root.CFrame = CFrame.new(ogpos)
				keypress(0x30)
				task.wait(0.2)
				keyrelease(0x30)
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
							time = 600
							resetfish()
							task.wait(1)
						end
					end	
				end)
			else
				send_notification("auto fish stopped", "info")
			end
		elseif current == "F2" and lastkey ~= "F2" then
			toggle2 = not toggle2
			if toggle2 then
				send_notification("auto lumber on", "info")
				keypress(0x38)
				task.wait(0.2)
				keyrelease(0x38)
				task.spawn(function()
					while toggle2 do
						task.wait(0.2)
						gototree()
					end
				end)
			else
				send_notification("auto lumber turned off", "info")
			end		
		end
		lastkey = current
	end
end)



send_notification("fishing bot running", "info")
task.wait(1)
send_notification("toggle autofish: f1. Have your rod at 0 and your bait, if you are using any, at 9.", "info")
send_notification("toggle autolumber: f2. have your axe at 8", "info")
