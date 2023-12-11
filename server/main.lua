local QBCore = exports['qb-core']:GetCoreObject()
local Accounts = {}

RegisterServerEvent("kopru-hgs:server:pay-bill")
AddEventHandler(
  "kopru-hgs:server:pay-bill",
  function(src, roadName)
    local Player = QBCore.Functions.GetPlayer(source)
	local societyName = "police"
    Player.Functions.RemoveMoney("bank", Config.Cost, "Bir gişeden geçtin: " .. roadName)
    TriggerClientEvent("kopru-hgs:client:SendBillEmail", source, Config.Cost)
    local result =  MySQL.Sync.fetchAll('SELECT `amount` FROM `management_funds` WHERE job_name = @society', {
        ['@society'] = societyName
    })

local balance = result[1]["amount"]
	Accounts[societyName] = balance + Config.Cost
	MySQL.update('UPDATE management_funds SET amount = ? WHERE job_name = ? and type = "boss"', { Accounts[societyName], societyName })
  end
)
