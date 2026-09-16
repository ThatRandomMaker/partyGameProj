local replicatedStorage = game:GetService("ReplicatedStorage")
local startGame = replicatedStorage:WaitForChild("remoteEvents"):WaitForChild("startGame")

local Player = game.Players.LocalPlayer
local playerGui = Player:WaitForChild("PlayerGui")

local tweenService = game:GetService("TweenService")
local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

local function startGameFunc()
	local transitionFrame = playerGui:WaitForChild("ScreenGui"):WaitForChild("Frame")
	
	local Tween = tweenService:Create(transitionFrame, tweenInfo, {BackgroundTransparency = 1})
	Tween:Play()
	Tween.Completed:Wait()
end

startGame.OnClientEvent:Connect(startGameFunc)