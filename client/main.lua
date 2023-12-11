local QBCore = exports['qb-core']:GetCoreObject()
local roadName = ""
local PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent("kopru-hgs:client:SendBillEmail")
AddEventHandler(
    "kopru-hgs:client:SendBillEmail",
    function()
        local Player = QBCore.Functions.GetPlayerData()

        SetTimeout(
            math.random(2500, 5000),
            function()
                local gender = "Bay"

                if Player.charinfo.gender == 1 then
                    gender = "Bayan"
                end

                TriggerServerEvent(
                    "qs-smartphone:server:sendNewMail",
                    {
                        sender = "Kara Yollar Genel Müdürlüğü",
                        subject = "HGS Geçiş Ücreti",
                        message = "Sayın " ..
                            gender ..
                                " " ..
                                    Player.charinfo.lastname ..
                                        ",<br /><br />Şuradaki bir gişeden geçtiniz:: " ..
                                            roadName ..
                                                "<br />Şu kadar ücret tahsis edildi: <strong>$" ..
                                                    Config.Cost .. "</strong><br /><br />Tekrar görüşmek üzere",
                        button = {}
                    }
                )
            end
        )
    end
)

function isEmergencyVehicle()
    local ped = GetPlayerPed(-1)
    local jobName = PlayerJob.name

    if jobName ~= 'police' or jobName ~= "ambulance" then
      if IsPedInAnyVehicle(ped) then
        if GetVehicleClass( GetVehiclePedIsIn(ped, false ) ) == 18 then
          return true
        else
            return false
        end
      end
    end
end

Config.combo:onPointInOut(
    PolyZone.getPlayerPosition,
    function(isPointInside, point)
        local jobName = PlayerJob.name
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        local isPedInVehicle = IsPedInVehicle(ped, vehicle, false)
        local isPedDriving = GetPedInVehicleSeat(vehicle, -1) == ped
        local coords = point

        if isPointInside and isPedDriving then
            local roadHashKey = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            roadName = GetStreetNameFromHashKey(roadHashKey)
            if Config.WhitelistEmergencyVehicles and isEmergencyVehicle() then
            else
                TriggerServerEvent("kopru-hgs:server:pay-bill", ped, roadName)
            end
        end
    end,
    100
)
