--!optimize 2
send_notification("version: 45.5", "warning")
print("HI i updated45.5")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()
task.wait(3)
local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local uis = game:GetService("UserInputService")
local camera = ws.CurrentCamera
local npc = ws:FindFirstChild("NPC")
local dan = npc:FindFirstChild("Daniel")
local chuck = npc:FindFirstChild("ChuckB")
local chuckroot = chuck:FindFirstChild("HumanoidRootPart")
local chia = npc:FindFirstChild("chia")
local chiaroot = chia:FindFirstChild("HumanoidRootPart")
local map = ws:FindFirstChild("Map")
local trees = map:FindFirstChild("ForestTrees")
local lp = player.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local ammo = map:FindFirstChild("Moes Guns"):FindFirstChild("AmmoPack")
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

local guns = {"Taurus .357", "Schofield 6", "Dual Derringers", "Mauser", "Whitney Dragoon", "Colt Ocelot", "Winchester Repeater", "Maverick 88", "DB Shotgun", "Mares Leg"}
local function checkammo()
	local ammo2 = false
	local stored = true
	local backpack = lp:FindFirstChild("Backpack")
	for _, u in pairs(backpack:GetChildren()) do
		if table.find(guns, u.Name) then
			local storedammo = u:FindFirstChild("StoredAmmo")
			local ammoinclip = u:FindFirstChild("AmmoInClip")
			if storedammo.Value >= 8 then
				ammo2 = true
			end
			if ammoinclip.Value <= 2 then
				stored = false
				break
			end
		end
	end
	return ammo2, stored
end
local function newtp(target)
	local _, stored = checkammo()
	keypress(0x31)
	task.wait(0.5)
	keyrelease(0x31)
	task.wait(0.2)
	if not stored then
		keypress(0x52)
		task.wait(5)
		keyrelease(0x52)
	end
	task.wait(0.2)
	keypress(0x20)
	task.wait(0.75)
	local rpos = root.Position
	mouse1click()
	task.wait(0.2)
	for i = 1, 5 do
		root.CFrame = CFrame.new(target)
		task.wait(0.1)
		if getDistance(target, root.Position) < 10 then 
			break
		end
	end
	keyrelease(0x20)
	task.wait(0.3)
	keypress(0x31)
	task.wait(0.3)
	keyrelease(0x31)
end
local function safespot()
	task.wait(0.5)
	local safe = Vector3.new(-4881.71, 45, -2198.22)
	local cam = Vector3.new(-4896.62, 59.21, -2197.83)

	local lookat = Vector3.new(-4832.38, 21.72, -2199.70)
	newtp(safe)
	task.wait(0.4)
	camera.CFrame = CFrame.lookAt(cam, lookat)
	root.CFrame = CFrame.new(safe)
	task.wait(0.5)
	uis:SetMouseLocation(978, 461)
end

local function getammo()
	task.wait(0.5)
	keypress(0x32)
	task.wait(0.3)
	keyrelease(0x32)
	task.wait(0.2)
	local beforepos = root.Position
	local chiapos = chiaroot.Position
	newtp(chiapos)
	task.wait(0.25)
	root.CFrame = CFrame.new(chiapos.X, chiapos.Y, chiapos.Z - 7)
	task.wait(0.75)
	root.CFrame = CFrame.lookAt(root.Position, ammo.Position)
	task.wait(.4)
	camera.CFrame = CFrame.lookAt(camera.Position, ammo.Position)
	task.wait(.4)
	local screenpos = camera:WorldToScreenPoint(ammo.Position)
	mousemoveabs(screenpos.X, screenpos.Y)
	task.wait(0.75)
	for i = 1, 5 do
		mouse1click()
		task.wait(2.5)
	end
	keypress(0x33)
	task.wait(0.2)
	keyrelease(0x33)
	task.wait(0.2)
	local backpack = lp:FindFirstChild("Backpack")
	if backpack:FindFirstChild("AmmoPack") then
		for i = 1, 5 do
			keypress(0x33)
			task.wait(0.2)
			keyrelease(0x33)
			mouse1click()
			task.wait(1)
		end
		keypress(0x33)
		task.wait(0.2)
		keyrelease(0x33)
	end
end

local function findammo()
	local ammo = false
	local backpack = lp:FindFirstChild("Backpack")
	for _, u in pairs(backpack:GetChildren()) do
		if table.find(guns, u.Name) then
			local storedammo = u:FindFirstChild("StoredAmmo")
			local ammoinclip = u:FindFirstChild("AmmoInClip")
			if storedammo.Value <= 8 then
				getammo()
				ammo = true
				break
			end
		end
	end
	return ammo
end
local function choptree()
	for i = 1, 26 do
		mouse1click()
		task.wait(1.25)
	end
end

local function gototree()
	local ammo2, stored = checkammo()
	if findammo() then return end
	if ammo2 then
		for _, v in pairs(trees:GetDescendants()) do
			if v:IsA("BasePart") and v.Name == "TreeBark" then
				if v.Transparency ~= 0 then continue end
				v.CanCollide = false
				local tpos = v.Position
				newtp(tpos)
				task.wait(1)
				keypress(0x38)
				task.wait(0.5)
				keyrelease(0x38)
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
end
local function maxfish()
	local max = false
	local bp = lp:FindFirstChild("Backpack")
	for _, u in pairs(bp:GetChildren()) do
		if u.Name == "Bass" or u.Name == "Cod" or u.Name == "Snapper" then
			local quant = u:FindFirstChild("Quantity")
			if quant.Value == 50 then
				max = true
			end
		end	
	end
	return max
end
local function maxwood()
	local max2 = false
	local bp = lp:FindFirstChild("Backpack")
	if not bp then return end
	for _, i in pairs(bp:GetChildren()) do
		if i.Name == "Wood" then
			local quant = i:FindFirstChild("Quantity")
			if quant.Value >= 200 then
				max2 = true
			end
		end
	end
	return max2
end
local function keybinds(whichnpc)
	local root = char:FindFirstChild("HumanoidRootPart")
	local head = whichnpc:FindFirstChild("Head")
	local hpos = head.Position
	if getDistance(root.Position, hpos) >= 10 then
		newtp(hpos)
	end
	task.wait(.25)
	root.CFrame = CFrame.new(hpos.X - 6, hpos.Y, hpos.Z)
	task.wait(.25)
	camera.CFrame = CFrame.lookAt(camera.Position, hpos)
	task.wait(.25)
	local visible = camera:WorldToScreenPoint(whichnpc:FindFirstChild("HumanoidRootPart").Position)
	if visible then
		local screenpos, visible = camera:WorldToScreenPoint(whichnpc:FindFirstChild("HumanoidRootPart").Position)
		mousemoveabs(screenpos.X, screenpos.Y)
		task.wait(.75)
		mousemoveabs(screenpos.X + 1, screenpos.Y - 2)
		task.wait(1)
		mouse1click()
		task.wait(.75)
		keypress(0xDC)
		task.wait(0.1)
		keyrelease(0xDC)
		task.wait(0.3)
		for i = 1, 4 do
			keypress(0x44)
			task.wait(0.125)
			keyrelease(0x44)
		end
		task.wait(0.4)
		keypress(0x41)
		task.wait(0.1)
		keyrelease(0x41)
		task.wait(0.2)
		keypress(0x57)
		task.wait(0.1)
		keyrelease(0x57)
		task.wait(0.2)
		for i = 1, 2 do
			keypress(0x53)
			task.wait(0.1)
			keyrelease(0x53)
		end
		task.wait(1.75)
		keypress(0x0D)
		task.wait(0.2)
		keyrelease(0x0D)
		task.wait(0.1)
		for i = 1, 2 do
			keypress(0xDC)
			task.wait(0.125)
			keyrelease(0xDC)
		end
		for i = 1, 4 do
			keypress(0x44)
			task.wait(0.1)
			keyrelease(0x44)
		end
		task.wait(0.4)
		keypress(0x41)
		task.wait(0.1)
		keyrelease(0x41)
		task.wait(0.2)
		keypress(0x57)
		task.wait(0.1)
		keyrelease(0x57)
		task.wait(0.2)
		for i = 1, 2 do
			keypress(0x53)
			task.wait(0.1)
			keyrelease(0x53)
		end
		task.wait(0.3)
		keypress(0x0D)
		task.wait(0.1)
		keyrelease(0x0D)
		task.wait(0.1)
		for i = 1, 2 do
			keypress(0xDC)
			task.wait(0.125)
			keyrelease(0xDC)
		end
		task.wait(0.2)
		for i = 1, 4 do
			keypress(0x44)
			task.wait(0.125)
			keyrelease(0x44)
		end
		task.wait(0.4)
		keypress(0x41)
		task.wait(0.1)
		keyrelease(0x41)
		task.wait(0.2)
		keypress(0x57)
		task.wait(0.1)
		keyrelease(0x57)
		task.wait(0.2)
		keypress(0x53)
		task.wait(0.1)
		keyrelease(0x53)
		task.wait(1)
		keypress(0x0D)
		task.wait(0.1)
		keyrelease(0x0D)
		task.wait(0.1)
		keypress(0xDC)
		task.wait(0.1)
		keyrelease(0xDC)
	end
end



			
local function autosellfish()
	local ammo2, stored = checkammo()
	if maxfish() then
		if findammo() then return end
		if ammo2 and dan then
			keypress(0x30)
			task.wait(0.1)
			keyrelease(0x30)
			for i = 1, 3 do
				keybinds(dan)
			end
			task.wait(0.2)
			newtp(ogpos)
		end
	end
end

local function autosellwood()
	local ammo2, stored = checkammo()
	if maxwood() then
		if findammo() then return end
		if ammo2 and chuck then
			keypress(0x38)
			task.wait(0.1)
			keypress(0x38)
			keybinds(chuck)
		end
	end
end

local function resetfish()
	task.wait(0.2)
	keypress(0x30)
	task.wait(0.1)
	keyrelease(0x30)
	task.wait(0.75)
	keypress(0x20)
	task.wait(1)
	keypress(0x30)
	task.wait(0.2)
	keyrelease(0x30)
	task.wait(0.5)
	keypress(0x57)
	task.wait(10)
	keyrelease(0x57)
	task.wait(0.5)
	keypress(0x44)
	task.wait(10)
	keyrelease(0x44)
	task.wait(0.5)
	keypress(0x53)
	task.wait(10)
	keyrelease(0x53)
	task.wait(0.5)
	keypress(0x41)
	task.wait(10)
	keyrelease(0x41)
	task.wait(0.5)
	safespot()
	task.wait(0.2)
	keypress(0x30)
	task.wait(0.1)
	keyrelease(0x30)
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
	local bait = false
	local backpack = lp:FindFirstChild("Backpack")
	task.wait(0.5)
	if backpack and backpack:FindFirstChild("Bait") then
		bait = true end
	return bait
end
		
	

local function cast()
	if getwater() then
		task.wait(.1)
		mouse1press()
		task.wait(0.2)
		mouse1release()
		task.wait(.5)
		local vis = container.Visible
		if checkbait() and not vis then
			print("Found bait")
			keypress(0x39)
			task.wait(0.2)
			keyrelease(0x39)
			task.wait(0.3)
			mouse1click()
			keypress(0x39)
			task.wait(0.2)
			keyrelease(0x39)
			task.wait(0.2)
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

local function goplant()
	if findammo() then return end
	local place = Vector3.new(-7857.3037109375, 67.37139892578125, -2060.570556640625)
	task.wait(0.5)
	newtp(place)
end

local function autoroka()
	local ammo2, _ = checkammo()
	if findammo() then return end
	goplant()
	task.wait(0.5)
	keypress(0x37)
	task.wait(0.1)
	keyrelease(0x37)
	task.wait(0.75)
	mouse1click()
	task.wait(0.5)
	local safe2 = Vector3.new(-5233.71484375, 82.72335815429688, -4119.47607421875)
	newtp(safe2)
	task.wait(60)
end

local function grabroka()
	if not ammo2 then getammo() end
	goplant()
	task.wait(0.75)
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
			elseif k == "F3" then
				current = "F3"
				break
			end		
		end	
		if current == "F1" and lastkey ~= "F1" then
			toggle = not toggle
			if toggle then
				send_notification("auto fish started", "info")
				safespot()
				task.wait(0.1)
				ogpos = root.Position
				root.CFrame = CFrame.new(ogpos)
				keypress(0x30)
				task.wait(0.2)
				keyrelease(0x30)
				task.spawn(function()
					while toggle do
						task.wait(0.2)
						if maxfish() then autosellfish() 
						else
							if getthebob() then 
								if getwater() then
									cast()
								end
							else
								mouse1click()
								task.wait(3.5)
							end	
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
						task.wait(0.8)
						if maxwood() then autosellwood()
						else
							gototree()
						end
						local hum = char:FindFirstChild("Humanoid")
						if hum.Health == 0 then
							task.wait(10)
							keypress(0x38)
							task.wait(0.2)
							keyrelease(0x38)
						end
					end
				end)	
			else
				send_notification("auto lumber turned off", "info")
			end
		elseif current == "F3" and lastkey ~= "F3" then
			toggle3 = not toggle3
			if toggle3 then
				send_notification("waiting for roka fruit", "info")
				task.spawn(function()
					while toggle3 do
						task.wait(0.8)
						local bp = lp:FindFirstChild("Backpack")
						for _, j in pairs(bp:GetChildren()) do
							if j.Name == "Rokakaka Seed" then
								for i = 1, 2 do
									keypress(0x32)
									task.wait(0.2)
									keypress(0x32)
								end
								autoroka()
								task.wait(0.2)
								grabroka()
							end
						end
					end
				end)
			else
				send_notification("stopped looking for roka", "info")
			end			
		end
		lastkey = current
	end
end)

task.wait(1)
send_notification("toggle autofish: f1. Have your rod at 0 and your bait, if you are using any, at 9.", "info")
send_notification("toggle autolumber: f2. Have your gun at 1 and your axe at 8.", "info")
send_notification("!!!NOTE:THERE MUST BE AN ITEM IN UR SECOND SLOT AND NO ITEM IN UR 3RD SLOT!!!", "warning")
