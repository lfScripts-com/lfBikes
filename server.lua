local ESX = exports['es_extended']:getSharedObject()

RegisterServerEvent('bike:addItem')
AddEventHandler('bike:addItem', function(modelName)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local canCarry = exports.ox_inventory:CanCarryItem(source, modelName, 1)
    
    if canCarry then
        xPlayer.addInventoryItem(modelName, 1)
    else
        TriggerClientEvent('esx:showNotification', source, Config.Messages.InventoryFull)
        TriggerClientEvent('bike:respawnBike', source, modelName)
    end
end)

RegisterServerEvent('bike:removeItem')
AddEventHandler('bike:removeItem', function(modelName)
    local source = source
    exports.ox_inventory:RemoveItem(source, modelName, 1)
end)

for _, model in ipairs(Config.BikeModels) do
    ESX.RegisterUsableItem(model, function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(model, 1)
        TriggerClientEvent('bike:spawn', source, model)
    end)
end

ESX.RegisterServerCallback('bike:canCarryItem', function(source, cb, item)
    local canCarry = exports.ox_inventory:CanCarryItem(source, item, 1)
    cb(canCarry)
end) 