local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

local Humanoid = Character:FindFirstChild("Humanoid") or Character:WaitForChild("Humanoid")
local playerScripts = Player:WaitForChild("PlayerScripts")
local playerModule = require(playerScripts:WaitForChild("PlayerModule"))
local Controls = playerModule:GetControls()

Controls:Disable()