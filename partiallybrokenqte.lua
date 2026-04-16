send_notification("dont move once u execute: 36.4", "warning")
print("HI i updated36")
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
	local noti = gui:FindFirstChild("Notification")
	if not noti then return end
	if noti then
		print("yoo")
		local text = noti.Text
		print("FOUND")
		if text == "The fish here are spooked. Move to a new spot!" then
			return true
		else return false
		end
	end
end

local function resetfish()
	local char = lp.Character
    local croot = char and char:FindFirstChild("HumanoidRootPart")
    if not croot then return end
	local rpos = croot.Position
	keypress(0x51)
	task.wait(0.25)
	croot.CFrame = CFrame.new(rpos.X + 100, rpos.y, rpos.Z + 100)
	task.wait(0.25)
	keyrelease(0x51)
	task.wait(0.5)
	keypress(0x57)
	task.wait(5)
	keyrelease(0x57)
	task.wait(0.5)
	keypress(0x51)
	task.wait(0.25)
	if ogpos then
		croot.CFrame = CFrame.new(ogpos)
		task.wait(1)
		croot.CFrame = CFrame.new(ogpos)
	end
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
				task.wait(1)
            	if distance < radius then
                	return true
				else return false
				end
			end
		end
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
				print("YO5")
                if ok and wpos then
					local dist = getDistance(wpos, bpos)
					if dist <= radius2 then
	                	print("HI2")
						task.wait(.25)
	                	mouse1press()
	                    task.wait(0.25)
	                    mouse1release()
	                    task.wait(.5)
						mouse1click()
						print("YO6")
						task.spawn(function()
							task.wait(1.5)
							print("YO7--negligible")
							if spookedfishcheck() then 
								resetfish()
							end
						end)
                	end
				end
			end
        end
    end
end
task.spawn(function()
    while true do
        task.wait(0.5)
        if getthebob() then watersplash() end
        if isleftpressed() or isleftclicked() then 
        	if spookedfishcheck() then
        		resetfish()
        	end
        end
    end
end)
send_notification("fishing bot running,", "info")
task.wait(1)
local rpos = root.Position
root.CFrame = CFrame.new(ogpos)
send_notification("hold out ur fishing rod and once u cast it will start. if u moved from where u tped it will not work", "info")
