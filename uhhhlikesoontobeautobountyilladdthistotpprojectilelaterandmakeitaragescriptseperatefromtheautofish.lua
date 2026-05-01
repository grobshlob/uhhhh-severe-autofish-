local function text(source)
	local string = memory.readstring(source, 0xa60)
	--only for v390
	return string
end
local players = game:GetService("Players")
local lp = players.LocalPlayer
local char = lp.Character
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local cam = ws.CurrentCamera
local uis = game:GetService("UserInputService")
--semi automatic not effective as of 5/1
local speed = 10
local radius = 15
local angle = 0
local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
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
			if ammoinclip.Value <= 1 then
				stored = false
				break
			end
		end
	end
	return ammo2, stored
end
local tping = false
local function newtp(target)
	tping = true
	local _, stored = checkammo()
	keypress(0x31)
	task.wait(0.5)
	keyrelease(0x31)
	task.wait(1)
	if not stored then
		keypress(0x52)
		task.wait(5)
		keyrelease(0x52)
	end
	task.wait(0.2)
	keyrelease(0x20)
	task.wait(0.2)
	keypress(0x20)
	task.wait(0.75)
	local root = char:FindFirstChild("HumanoidRootPart")
	local rpos = root.Position
	mouse1click()
	task.wait(0.1)
	for i = 1, 3 do	
		root.CFrame = CFrame.new(target)
		mouse1click()
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
local function textcheck()
    local target = nil
    local ok, gui = pcall(function()
        local notifier = lp.PlayerGui:FindFirstChild("NotifierGui")
        if not notifier then return nil end
        return notifier:FindFirstChild("MessageContainer")
    end)
    if ok and gui then
        local noti2 = gui:FindFirstChild("Notification")
        if not noti2 then return nil end
        local ok2, text = pcall(function() return text(noti2) end)
        if ok2 and text then
			for _, v in pairs(players:GetChildren()) do
				local merging = "HAS STARTED MERGING WITH"
				local merged = "HAS SUCCESSFULLY MERGED"
				if string.find(text:lower(), v.Name:lower()) and not string.find(text:lower(), merging:lower()) and not string.find(text:lower(), merged:lower()) then
					target = v.Name
					print(target)
					break
				end
			end
		end
    end
    return target
end
local reloading = false
local function kill(person)
	local _, stored = checkammo()
	for _, v in pairs(players:GetChildren()) do
		if v.Name == person then
			local hum = v.Character:FindFirstChild("Humanoid")
			if hum and hum.Health ~= 0 then 
				keypress(0x31)
				task.wait(0.1)
				keyrelease(0x31)
				task.wait(1.75)
				if not reloading then
					mouse1click()
					task.wait(.75)
					if health == 0 then break end
				end
				if not stored and not reloading then 
					reloading = true
					task.spawn(function()	
						keypress(0x53) 
						task.wait(5) 
						keyrelease(0x53)
						reloading = false
					end)
				end
			end
		end
	end
end
local lasttarget = ""
local ctarget = nil
local killing = false
task.spawn(function()
	while true do
	    local char = lp.Character
	    local dt = task.wait(0.001)
	    local target = textcheck()
	    if target and target ~= lasttarget then
			local player = players:FindFirstChild(target)
			if player then
				ctarget = player
				lasttarget = target
				print("target found: " .. target)
			end
		end
		if ctarget and ctarget.Character and not tping then
		    local tchar = ctarget.Character
		    if char and tchar then
		        local root = char:FindFirstChild("HumanoidRootPart")
		        local head = char.Head
		        local troot = tchar:FindFirstChild("HumanoidRootPart")
		        if root and troot then
					local tpos = troot.Position
		        	if getDistance(tpos, root.Position) > 15 then 
						newtp(tpos) 
					else
						angle = angle + (dt * speed)
			            local x = math.cos(angle) * radius
			            local z = math.sin(angle) * radius
			            local newPos = tpos + Vector3.new(x, 4, z)
			            local screenpos = cam:WorldToScreenPoint(tpos)
			            root.CFrame = CFrame.lookAt(newPos, tpos)
			            local backOffset = 10 
						local upOffset = 3
						local camPos = root.CFrame.Position + (root.CFrame.LookVector * -backOffset) + (root.CFrame.UpVector * upOffset)
						cam.CFrame = CFrame.lookAt(camPos, troot.Position)
						if not killing then
							killing = true
							task.spawn(function()
								kill(lasttarget)
								killing = false
							end)
						end	
					end
		        end
		    else 
				ctarget = nil
				lasttarget = ""
			end
		end
	end
end)
