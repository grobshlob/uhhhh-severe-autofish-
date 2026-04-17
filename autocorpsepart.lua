loadstring(game:HttpGet("https://raw.githubusercontent.com/Sploiter13/severefuncs/refs/heads/main/merge2.lua"))()

local player = game:GetService("Players")
local ws = game:GetService("Workspace")
local lp = player.LocalPlayer
local char = lp.Character
if not char then return end
local ogpos = nil

local function textcheck()
	local found2 = false
	local ok, gui = pcall(function()
		lp.PlayerGui:FindFirstChild("NotifierGui"):FindFirstChild("MessageContainer")
	end)
	if ok and gui then
		local noti = gui:FindFirstChild("Notification")
		if not noti then return end
		print("hi")
		if noti then
			print("yoo")
			local text = noti.Text
			print("FOUND  A NOTI")
			if text == "IT APPEARS ONCE AGAIN." then
				found2 = true
			end
		end
		return found2
	end
end


local function getDistance(a, b)
    return math.sqrt((a.X - b.X)^2 + (a.Y - b.Y)^2 + (a.Z - b.Z)^2)
end
local parts = {"SaintsRightArm", "SaintsRightLeg", "SaintsRibcage", "SaintsLeftArm", "SaintsLeftLeg", "SaintsHeart"}

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
		root.Anchored = false
		keypress(0x51)
		task.wait(0.2)
		root.CFrame = CFrame.new(target + Vector3.new(0, 3, 0))
		task.wait(1)
		root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
		task.wait(0.1)
		keyrelease(0x51)
	else
	end
	keyrelease(0x51)
end
local running = true
task.spawn(function()
	while running do
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
							send_notification("SON RUNNNNNNNNNNNNNNNNNNNN", "warning")
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
