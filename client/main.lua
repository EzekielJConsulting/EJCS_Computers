options = {
    {
        event = "poweron",
        icon = "fas fa-power-off",
        label = "Power on Computer",
        num = 1
    },
    {
        event = "scandoc",
        icon = "fas fa-paperclip",
        label = "Scan Document",
        num = 2
    }
}



local display = false

-- SendPlayerDataToApp() -> example of sending data to the app and changing its corresponding state in the vuex store
function SendPlayerDataToApp()
   local playerID = PlayerPedId()
   SendNUIMessage({
      type = 'setPlayerID',
      data = playerID
   })
end

-- SetDisplay() -> changes the toggle state of our vue app ( isVisible = !isVisible )
--              -> it can also be used to change the app view
function SetDisplay(bool, view)
   display = bool
   if (not view) then
      SendNUIMessage({
         type = 'toggleShow',
      })
   else
      SendNUIMessage({
         type = 'toggleShow',
         payload = { view }
      })
   end
   SetNuiFocus(bool, bool)
end

-- This callback is used as an example of receiving data from the app
RegisterNUICallback('receiveData', function(data)
   local username = data.userName
   local msg = data.message
   local type = data.typeOfMessage

   local color = {}
   if (type == "success") then
      color = { 100, 255, 100 }
   elseif (type == "error") then
      color = { 255, 100, 100 }
   elseif (type == "warning") then
      color = { 255, 165, 0 }
   else
      color = { 100, 100, 255 }
   end

   TriggerEvent("chat:addMessage", {
      color = color,
      multiline = true,
      args = { username, msg }
   })

   SetDisplay(false)
end)


-- This callback handles closing the app window within our app
RegisterNUICallback('exitMenu', function()
   SetDisplay(false)
end)

-- This callback triggers only if an error occurs
RegisterNUICallback('error', function(data)
   TriggerEvent("chat:addMessage", {
      color = { 255, 100, 100 },
      multiline = true,
      args = { data.error }
   })
   SetDisplay(false)
end)

-- Command used to open the view ( you can make the view open on any condition of your choice )
RegisterCommand("openview", function()
   SendPlayerDataToApp()
   SetDisplay(not display, "base")
end)




-- Add qtarget trigger to all computers by hash
AddEventHandler('poweron', function(data)
    SendPlayerDataToApp()
	SetDisplay(true, 'base')
    -- openComputer()
end)
AddEventHandler('scandoc', function(data)
	-- scandoc()
end)

computers = Config.computer_models
print(computers)
exports.qtarget:AddTargetModel(computers,{
	options = options,
	distance = 2,
})

manualComputers = Config.manualComputers
for i, computer in ipairs(manualComputers) do
    exports.qtarget:AddBoxZone(computer.name, computer.coords, computer.length, computer.width, {
        name = computer.label,
        heading = computer.heading,
        debugPoly = computer.debug,
        minZ = computer.minZ,
        maxZ = computer.maxZ
      }, {
            options = options,
            distance = 3.5
        }
    )
end

-- exports.qtarget:AddBoxZone("DavisPC1", vector3(375.9, -1603.08, 30.06), 0.6, 0.6, {
--     name = "davis pc 1",
--     heading = 330,
--     debugPoly = true,
--     minZ = 26.66,
--     maxZ = 30.66
--   }, {
-- 		options = options,
-- 		distance = 3.5
--     }
-- )


