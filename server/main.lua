

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(30)
	end
	ESX.RegisterServerCallback('ejcscomp:getPlayerData', function(source, cb, PlayerID)
        print(PlayerID)
        local playerData = {}
        local xPlayer = ESX.GetPlayerFromId(PlayerID)
        -- print(xPlayer)
        playerData.id = PlayerID
        playerData.name = xPlayer.name
        playerData.job = {}
        cb(playerData)
    end)
end)