local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")

local delayBetweenMessages = 0.1
local MIN_DELAY = 0.1
local MAX_DELAY = 5

if game.CoreGui:FindFirstChild("PlayerListGUI") then
	game.CoreGui.PlayerListGUI:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "PlayerListGUI"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 420, 0, 500)
main.Position = UDim2.new(0.5, -210, 0.5, -250)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

local control = Instance.new("Frame")
control.Size = UDim2.new(0, 420, 0, 60)
control.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
control.BorderSizePixel = 0
control.Parent = gui
Instance.new("UICorner", control).CornerRadius = UDim.new(0, 10)

local function updateControlPos()
	control.Position = main.Position + UDim2.new(0, 0, 0, main.Size.Y.Offset + 10)
end
updateControlPos()

main:GetPropertyChangedSignal("Position"):Connect(updateControlPos)

local delayLabel = Instance.new("TextLabel")
delayLabel.Size = UDim2.new(1, -120, 1, 0)
delayLabel.Position = UDim2.new(0, 12, 0, 0)
delayLabel.BackgroundTransparency = 1
delayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayLabel.Font = Enum.Font.GothamBold
delayLabel.TextSize = 16
delayLabel.TextColor3 = Color3.new(1,1,1)
delayLabel.Parent = control

local function updateLabel()
	delayLabel.Text = string.format("Delay between commands: %.1fs", delayBetweenMessages)
end
updateLabel()

local minus = Instance.new("TextButton")
minus.Size = UDim2.new(0, 40, 0, 40)
minus.Position = UDim2.new(1, -90, 0.5, -20)
minus.Text = "-"
minus.Font = Enum.Font.GothamBold
minus.TextSize = 22
minus.TextColor3 = Color3.new(1,1,1)
minus.BackgroundColor3 = Color3.fromRGB(80,80,80)
minus.Parent = control
Instance.new("UICorner", minus).CornerRadius = UDim.new(0, 8)

minus.MouseButton1Click:Connect(function()
	delayBetweenMessages = math.max(MIN_DELAY, delayBetweenMessages - 0.1)
	updateLabel()
end)

local plus = Instance.new("TextButton")
plus.Size = UDim2.new(0, 40, 0, 40)
plus.Position = UDim2.new(1, -45, 0.5, -20)
plus.Text = "+"
plus.Font = Enum.Font.GothamBold
plus.TextSize = 22
plus.TextColor3 = Color3.new(1,1,1)
plus.BackgroundColor3 = Color3.fromRGB(80,80,80)
plus.Parent = control
Instance.new("UICorner", plus).CornerRadius = UDim.new(0, 8)

plus.MouseButton1Click:Connect(function()
	delayBetweenMessages = math.min(MAX_DELAY, delayBetweenMessages + 0.1)
	updateLabel()
end)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "⭐ RyanSkull's Epic AP Spammer Undetected ⭐"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.new(1,1,1)
title.Parent = main

local list = Instance.new("ScrollingFrame")
list.Position = UDim2.new(0, 0, 0, 45)
list.Size = UDim2.new(1, 0, 1, -45)
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollBarImageTransparency = 0.4
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.Parent = list

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

local function createEntry(player)
	local entry = Instance.new("Frame")
	entry.Size = UDim2.new(1, -12, 0, 70)
	entry.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	entry.BorderSizePixel = 0
	entry.Parent = list
	Instance.new("UICorner", entry).CornerRadius = UDim.new(0, 10)

	local avatar = Instance.new("ImageLabel")
	avatar.Size = UDim2.new(0, 50, 0, 50)
	avatar.Position = UDim2.new(0, 10, 0.5, -25)
	avatar.BackgroundTransparency = 1
	avatar.Parent = entry

	local thumb = Players:GetUserThumbnailAsync(
		player.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size100x100
	)
	avatar.Image = thumb

	local display = Instance.new("TextLabel")
	display.Position = UDim2.new(0, 70, 0, 10)
	display.Size = UDim2.new(1, -190, 0, 22)
	display.BackgroundTransparency = 1
	display.TextXAlignment = Enum.TextXAlignment.Left
	display.Text = player.DisplayName
	display.Font = Enum.Font.GothamBold
	display.TextSize = 16
	display.TextColor3 = Color3.new(1,1,1)
	display.Parent = entry

	local username = Instance.new("TextLabel")
	username.Position = UDim2.new(0, 70, 0, 34)
	username.Size = UDim2.new(1, -190, 0, 18)
	username.BackgroundTransparency = 1
	username.TextXAlignment = Enum.TextXAlignment.Left
	username.Text = "@" .. player.Name
	username.Font = Enum.Font.Gotham
	username.TextSize = 13
	username.TextColor3 = Color3.fromRGB(180,180,180)
	username.Parent = entry

	local button = Instance.new("TextButton")
	button.Size = UDim2.new(0, 90, 0, 36)
	button.Position = UDim2.new(1, -100, 0.5, -18)
	button.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
	button.Text = "SPAM AP"
	button.Font = Enum.Font.GothamBold
	button.TextSize = 14
	button.TextColor3 = Color3.new(1,1,1)
	button.Parent = entry
	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 8)

	local running = false
	local commands = {
		";morph ",
		";inverse ",
		";balloon ",
		";ragdoll ",
		";tiny ",
		";jumpscare ",
		";rocket ",
		";jail "
	}

	button.MouseButton1Click:Connect(function()
		if running then return end
		running = true

		button.Text = "RUNNING..."
		button.BackgroundColor3 = Color3.fromRGB(90,90,90)

		task.spawn(function()
			local channel = TextChatService.TextChannels.RBXGeneral
			if channel then
				for _, cmd in ipairs(commands) do
					channel:SendAsync(cmd .. player.Name)
					task.wait(delayBetweenMessages)
				end
			end

			button.Text = "SPAM AP"
			button.BackgroundColor3 = Color3.fromRGB(180,40,40)
			running = false
		end)
	end)
end

local function refresh()
	for _, c in ipairs(list:GetChildren()) do
		if c:IsA("Frame") then c:Destroy() end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		createEntry(p)
	end
end

refresh()
Players.PlayerAdded:Connect(refresh)
Players.PlayerRemoving:Connect(refresh)
