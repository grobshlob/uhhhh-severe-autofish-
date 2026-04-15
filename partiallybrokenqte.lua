send_notification("dont move once u execute: 25", "warning")
print("HI i updated25?")
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

local function getthebob()
    if ogpos == nil then
        ogpos = root.Position
        print("Original position saved:", ogpos)
    end
    for _, v in pairs(ws:GetChildren()) do
        if v:IsA("Part") and v:FindFirstChild("RopeConstraint") then
            local rpos = root.Position
            local ok, cpos = pcall(function()
				return v.Position
			end)
			if not ok and not cpos then mouse1click() end
			if ok and cpos then
				bpos = cpos
            	local distance = getDistance(rpos, bpos)
            	if distance < radius then
                	return true
            	end
        	end
    	end
	end
	return false
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
                    getthebob()
                    local clean = text:gsub("%s", ""):upper()
                    local keycode = string.byte(clean)
                    keypress(keycode)
                    task.wait(0.05)
                    keyrelease(keycode)
                    print("QTE pressed:", clean)
					if not reset then
						reset = true
						local dist2 = getDistance(root.Position, ogpos)
						if dist2 > 2 then
							task.wait(3)
							root.CFrame = CFrame.new(ogpos)
							ogpos = nil
							task.wait(1)
							mouse1click()
							task.wait(0.5)
							keyrelease(0x45)
							keypress(0x45)
						else
							print("recieved an item")
							mouse1click()
						end
						reset = false
                    end
                end
            end
        end)
    end
end)
local radius2 = 1
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
				end
            end
        end
    end
end
local function spookedfishcheck()
	local gui = game.Players.lp.PlayerGui.NotifierGui.MessageContainer
	local ok, noti = pcall(function()
		gui:FindFirstChild("Notification")
	end)
	if ok and noti then
		local text = noti.Text
		if text == "The fish here are spooked. Move to a new spot!" then
			keypress(0x20)
			task.wait(0.1)
			keypress(0x53)
			task.wait(3)
			keyrelease(0x53)
			task.wait(0.1)
			keypress(0x57)
			task.wait(3)
			keyrelease(0x57)
			task.wait(0.1)
			keypress(0x41)
			task.wait(3)
			keyrelease(0x41)
			task.wait(0.1)
			keypress(0x44)
			task.wait(3)
			keyrelease(0x44)
			root.CFrame = CFrame.new(ogpos)
		end
	end
end
task.spawn(function()
    while true do
        task.wait(0.2)
        if getthebob() then watersplash() end
    end
end)
send_notification("fishing bot running,", "info")
task.wait(1)
local rpos = root.Position
root.CFrame = CFrame.new(ogpos)
send_notification("hold out ur fishing rod and once u cast it will start. if u moved from where u tped it will not work", "info")
