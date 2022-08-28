

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(30)
	end
	ESX.RegisterServerCallback('ejcscomp:getPlayerData', function(source, cb, PlayerID)
        playerData = {}
        local xPlayer = ESX.GetPlayerFromId(PlayerID)
        cb(playerData)
    end)
end)