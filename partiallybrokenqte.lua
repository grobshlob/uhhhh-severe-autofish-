send_notification("dont move once u execute: 38", "warning")
print("HI i updated38")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()

local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local lp = player.LocalPlayer
local char = lp.Character
local root = char:FindFirstChild("HumanoidRootPart")
local radius = 40
local vpos = nil
local ogpos = nil

local toggle = false
local toggle2 = false

local container = lp.PlayerGui.MashingSystem.Container
local qteLabel = container.Circle.KeyLabel

local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
end

local parts = {"SaintsRightArm", "SaintsRightLeg", "SaintsRibcage", "SaintsLeftArm", "SaintsLeftLeg", "SaintsHeart"}


local function textcheck()
    local found2 = false
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
            print("FOUND A NOTI")
            if text == "IT APPEARS ONCE AGAIN." then
                found2 = true
            end
        end
    end
    return found2
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
	if getDistance(root.Position, target) > 15 then
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
	reliabletp(Vector3.new(-6198.319336, 45.353798, -4826.008301))
	task.wait(1)
	keypress(0x57)
	task.wait(4)
	keyrelease(0x57)
	task.wait(0.5)
	reliabletp(ogpos)
	task.wait(1)
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
local radius2 = 1
local function watersplash()
    if getthebob() then
    	for _, b in pairs(ws:GetChildren()) do
        	if b:IsA("Part") and b:FindFirstChild("RippleWater") then
            	local ok, wpos = pcall(function()
					return b.Position
				end)
                if ok and wpos then
					local dist = getDistance(wpos, vpos)
					if dist <= radius2 then
						task.wait(.25)
	                	mouse1press()
	                    task.wait(0.25)
	                    mouse1release()
	                    task.wait(.5)
						mouse1click()
                	end
				end
			end
        end
    end
end
local time = 300
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
				send_notification("auto fish started, cast to begin", "info")
				task.spawn(function()
					while toggle do
						task.wait(0.2)
						if getthebob() then watersplash() end
					end
				end)
				task.spawn(function()
					while true do
						task.wait(1)
						time = time - 1
						if time == 0 then
							time = 300
							resetfish()
						end
					end	
				end)
			else
				send_notification("auto fish stopped", "info")
			end
		elseif current == "F2" and lastkey ~= "F2" then
			toggle2 = not toggle2
			running = true
			if toggle2 then
				send_notification("auto corpse part started, waiting for a corpse to spawn", "info")
				task.spawn(function()
					while toggle2 and running do
						local root = char:FindFirstChild("HumanoidRootPart")
						if not root then break end
						for _, v in pairs(ws:GetChildren()) do
							if v:IsA("BasePart") then
								if table.find(parts, v.Name) then
									print("corpse part found " .. v.Name .. " checking if its a honeypot")
									local vpos = v.Position
									task.wait(.2)
									if (vpos.Y >= 0 and vpos.Y <= 175) and textcheck() then
										print("teleporting to " .. v.Name)
										local ogpos = root.Position
										reliabletp(vpos)
										if getDistance(root.Position, vpos) < 20 then 
											task.wait(0.1)
											keypress(0x45)
											task.wait(5)
											keyrelease(0x45)
											reliabletp(ogpos)
											running = false
											send_notification("turn on desync and RUNNNN", "warning")
										end
									else
										print(v.Name .. " is a honeypot")
									end
								end
							end
						end
						task.wait(0.1)
					end
				end)
			else
				send_notification("auto corpse part is off", "info")
			end
		end
		lastkey = current
	end
end)



send_notification("fishing bot running,", "info")
task.wait(1)
ogpos = root.Position
root.CFrame = CFrame.new(ogpos)
send_notification("toggle autofish: f1", "info")
send_notification("toggle autocast: f2", "info")
