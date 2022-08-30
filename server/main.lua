

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
        print(xPlayer)
        playerData.id = PlayerID
        playerData.name = xPlayer.name
        playerData.job = {}

        if xPlayer.job then

            playerData.job.name = xPlayer.job.name
            playerData.job.rank = xPlayer.job.rank
        else
            playerData.job.name = 'Unemployed'
            playerData.job.rank = 'LazyAss'
        end

        print(playerData.id)
        cb(playerData)
    end)
end)