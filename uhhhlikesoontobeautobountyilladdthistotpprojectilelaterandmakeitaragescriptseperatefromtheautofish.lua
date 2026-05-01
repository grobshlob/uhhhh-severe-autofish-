
local players = game:GetService("Players")
local lp = players.LocalPlayer
local char = lp.Character
local rs = game:GetService("RunService")
local ws = game:GetService("Workspace")
local cam = ws.CurrentCamera
local uis = game:GetService("UserInputService")
local target = "sirillsalot"
local speed = 3
local radius = 10
local angle = 0
--fixing
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
        if not noti2 then return false end
        print("hi")
        local ok2, text = pcall(function() return noti2.Text end)
        if ok2 and text then
			for _, v in pairs(players:GetChildren()) do
				if string.find(text:lower(), v.Name:lower()) then
					target = v.Name
					print(target)
					break
				end
			end
		end
    end
    return target
end
task.spawn(function()
	while true do
	    local char = lp.Character
	    local dt = task.wait(0.01)
	    local targetChar = players:FindFirstChild(target) and players:FindFirstChild(target).Character
	    if char and targetChar then
	        local root = char:FindFirstChild("HumanoidRootPart")
	        local head = char.Head
	        local troot = targetChar:FindFirstChild("HumanoidRootPart")
	        if root and troot then
	        	local tpos = troot.Position
	        	if getDistance(tpos, root.Position) > 40 then newtp(tpos) end
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
	        end
	    end
	end
end)
