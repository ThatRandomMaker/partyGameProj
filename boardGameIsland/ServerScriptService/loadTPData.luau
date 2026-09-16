local Players = game:GetService("Players")
local teleportService = game:GetService("TeleportService")

local replicatedStorage = game:GetService("ReplicatedStorage")
local startGame = replicatedStorage:WaitForChild("remoteEvents"):WaitForChild("startGame")
local moduleScripts = replicatedStorage:WaitForChild("moduleScripts")
local matchData = require(moduleScripts:WaitForChild("matchData"))

local function tpBack(Player)
	local placeID = 11200329320
	local maxRetry = 3
	local success = false
	local result = nil

	for i = 1, maxRetry do
		success, result = pcall(function()
			local teleportOptions = Instance.new("TeleportOptions")
			teleportOptions.ShouldReserveServer = (i == maxRetry)

			return teleportService:TeleportAsync(placeID, {Player}, teleportOptions)
		end)
		if success then break end
		task.wait(1.5)
	end
	if not success then
		warn("teleport failed with " .. maxRetry .. " attempts, error " .. tostring(result))
	end
end

Players.PlayerAdded:Connect(function(Player)
	local teleportData = nil
	
	for i = 1, 10 do
		local joinData = Player:GetJoinData()
		if joinData and joinData.TeleportData then
			teleportData = joinData.TeleportData
			break
		end
		
		task.wait(1)
	end
	
	if teleportData then
		print(teleportData.characterSelected)
		print(teleportData.gameDifficulty)
		
		matchData.playerCharacter = tostring(teleportData.characterSelected)
		matchData.cpuDifficulty = tonumber(teleportData.gameDifficulty)
		
		startGame:FireClient(Player)
	else
		warn("loading failed")
		task.wait(1)
		tpBack(Player)
	end
end)