ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(30)
	end
end)

local options = {}
if GetResourceState('EJCS_Documents'):find('start') then
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
else
   options = {
      {
         event = "poweron",
         icon = "fas fa-power-off",
         label = "Power on Computer",
         num = 1
      }
   }
end


local display = false

local function toggleNuiFrame(shouldShow)
   SetNuiFocus(shouldShow, shouldShow)
   SendReactMessage('setVisible', shouldShow)
 end
 
 RegisterCommand('show-nui', function()
   toggleNuiFrame(true)
   debugPrint('Show NUI frame')
 end)
 
 RegisterNUICallback('hideFrame', function(_, cb)
   toggleNuiFrame(false)
   debugPrint('Hide NUI frame')
   cb({})
 end)
 
 RegisterNUICallback('getClientData', function(data, cb)
   debugPrint('Data sent by React', json.encode(data))
 
 -- Lets send back client coords to the React frame for use
   local curCoords = GetEntityCoords(PlayerPedId())
 
   local retData <const> = { x = curCoords.x, y = curCoords.y, z = curCoords.z }
   cb(retData)
 end)

-- SendPlayerDataToApp() -> example of sending data to the app and changing its corresponding state in the vuex store
function SendPlayerDataToApp()
   local playerID = PlayerPedId()
   -- print(playerID)
   local PlayerID = GetPlayerServerId(NetworkGetPlayerIndexFromPed(playerID))
   -- print(PlayerID)
   ESX.TriggerServerCallback('ejcscomp:getPlayerData', function(playerData)
      job = ESX.GetPlayerData().job.name
      jobLabel = ESX.GetPlayerData().job.label
      grade = ESX.GetPlayerData().job.grade
      label = ESX.GetPlayerData().job.grade_label
      rank = ESX.GetPlayerData().job.grade_name
      playerData.job.name = job
      playerData.job.grade = grade
      playerData.job.position = label
      playerData.job.rank = rank
      playerData.job.label = jobLabel
      print(jobLabel)
      playerData = json.encode(playerData)
      print(playerData)
      -- print(playerData.name)
      -- print(job)
      
      SendNUIMessage({
         type = 'setPlayerID',
         data = playerData
      })
   end,PlayerID)
   
end

-- SetDisplay() -> changes the toggle state of our vue app ( isVisible = !isVisible )
--              -> it can also be used to change the app view
function SetDisplay(bool)
   display = bool
   SendNUIMessage({
      type = 'toggleShow',
   })
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
   SetDisplay(true)
end)




-- Add qtarget trigger to all computers by hash
AddEventHandler('poweron', function(data)
   SendPlayerDataToApp()
	SetDisplay(true)
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

exports('openComputer', function()
   SendPlayerDataToApp()
	SetDisplay(true)
end)

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


