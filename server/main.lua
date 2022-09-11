



-- Add qtarget trigger to all computers by hash
AddEventHandler('poweron', function(data)
	print('get fucked')
end)
computers = config.computer_models
exports.qtarget:AddTargetModel(computers, {
	options = {
		{
			event = "poweron",
			icon = "fas fa-power-off",
			label = "Power on Computer",
			num = 1
		},
	},
	distance = 2
})