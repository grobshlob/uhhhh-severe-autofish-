loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()
--this will get you banned if u pick up a part
local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local lp = player.LocalPlayer
local char = lp.Character
if not char then return end
local ogpos = nil

local parts = {"SaintsRightArm", "SaintsRightLeg", "SaintsRibcage", "SaintsLeftArm", "SaintsLeftLeg", "SaintsHeart"}
local checkedparts = {}


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

local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
end
local parts = {"SaintsRightArm", "SaintsRightLeg", "SaintsRibcage", "SaintsLeftArm", "SaintsLeftLeg", "SaintsHeart"}
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
	keyrelease(0x20)
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
			if k == "F2" then
				current = "F2"
				break
			end		
		end	
		if current == "F2" and lastkey ~= "F2" then
			toggle2 = not toggle2
			running = true
			if toggle2 then
				send_notification("auto corpse part started, waiting for a corpse to spawn", "info")
				task.spawn(function()
					while toggle2 and running do
						task.wait(1)
						local root = char:FindFirstChild("HumanoidRootPart")
						if not root then break end
						for _, v in pairs(ws:GetChildren()) do
							if v:IsA("BasePart") then
								if table.find(parts, v.Name) then
									local ok, cpos = pcall(function()
										return v.Position
									end)
									
									if not ok or not cpos then continue end
									local honeypos = math.floor(cpos.X) .. "," .. math.floor(cpos.Y) .. "," .. math.floor(cpos.Z)
									if checkedparts[honeypos] then continue end
									local alreadyChecked = false
									for _, entry in pairs(checkedparts) do
									    if type(entry) == "table" and entry.name == v.Name then
									        alreadyChecked = true
									        break
									    end
									end
									if alreadyChecked then 
										continue 
									else
										checkedparts = {}
										print("corpse part found " .. v.Name .. " checking if its a honeypot")
										task.wait(.2)
										if (cpos.Y >= 0 and cpos.Y <= 300) and textcheck() then
											print("teleporting to " .. v.Name)
											local ogpos = root.Position
											reliabletp(cpos)
											if getDistance(root.Position, cpos) < 20 then 
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
											checkedparts[honeypos] = {name = v.Name}
										end		
									end
								end
							end
						end
					end
				end)
			else
				send_notification("auto corpse part is off", "info")
			end
		end
		lastkey = current
	end
end)
