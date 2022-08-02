



-- Add qtarget trigger to all computers by hash
AddEventHandler('eventname', function(data)
	print(data.label, data.num, data.entity)
end)
computers = config.computer_models
exports.qtarget:AddTargetModel(computers, {
	options = {
		{
			event = "eventname",
			icon = "fas fa-box-circle-check",
			label = "action 1",
			num = 1
		},
		{
			event = "eventname",
			icon = "fas fa-box-circle-check",
			label = "action 2",
			num = 2
		},
	},
	distance = 2
})