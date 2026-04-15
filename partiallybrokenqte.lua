send_notification("dont move once u execute: 30", "warning")
print("HI i updated30")
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

local function spookedfishcheck()
	local gui = game.Players.LocalPlayer.PlayerGui.NotifierGui.MessageContainer
	local ok, noti = pcall(function()
		gui:FindFirstChild("Notification")
	end)
	if ok and noti then
		local text = noti.Text
		print("FOUND")
		if text == "The fish here are spooked. Move to a new spot!" then
			return true
		else return false
		end
	end
	task.wait(0.01)
end

local function resetfish()
	local rpos = root.Position
	keypress(0x51)
	task.wait(0.25)
	root.CFrame = CFrame.new(rpos.X + 100, rpos.y + 10, rpos.Z + 100)
	task.wait(5)
	keyrelease(0x51)
	task.wait(0.5)
	keypress(0x51)
	task.wait(0.25)
	root.CFrame = CFrame.new(ogpos)
	task.wait(0.5)
	keyrelease(0x51)
	task.wait(1)
	mouse1click()
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
							print("HI67")
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
local radius2 = 1
local function watersplash()
    if getthebob() then
    	getthebob()
    	for _, b in pairs(ws:GetChildren()) do
        	if b:IsA("Part") and b:FindFirstChild("RippleWater") then
            	local ok, wpos = pcall(function()
					return b.Position
				end)
				if not wpos or wpos == nil then print("CLICKING") mouse1click() end
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
task.spawn(function()
    while true do
        task.wait(0.2)
        if getthebob() then watersplash() end
		if spookedfishcheck() then resetfish() end
    end
end)
send_notification("fishing bot running,", "info")
task.wait(1)
local rpos = root.Position
root.CFrame = CFrame.new(ogpos)
send_notification("hold out ur fishing rod and once u cast it will start. if u moved from where u tped it will not work", "info")
