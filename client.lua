local ESX = exports['es_extended']:getSharedObject()

exports('useItem', function(data, slot)
    TriggerServerEvent('bike:removeItem', slot.name)
    
    local playerPed = PlayerPedId()
    
    ESX.Streaming.RequestAnimDict(Config.Animations.Dict)
    TaskPlayAnim(playerPed, Config.Animations.Dict, Config.Animations.Name, 8.0, -8.0, -1, 1, 0, false, false, false)
    
    Wait(Config.Animations.Duration.Spawn)
    
    ClearPedTasks(playerPed)
    
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    
    ESX.Game.SpawnVehicle(slot.name, coords, heading, function(vehicle)
        SetVehicleOnGroundProperly(vehicle)
        Wait(Config.Delays.VehicleStabilization)
    end)
    
    return false
end)

local function isBike(vehicle)
    if not DoesEntityExist(vehicle) then return false end
    local model = GetEntityModel(vehicle)
    for _, bikeHash in ipairs(Config.BikeModels) do
        if model == GetHashKey(bikeHash) then
            return true
        end
    end
    return false
end

exports.ox_target:addGlobalVehicle({
    {
        name = Config.Target.Name,
        icon = Config.Target.Icon,
        label = Config.Target.Label,
        canInteract = function(entity)
            if not entity then return false end
            if not DoesEntityExist(entity) then return false end
            Wait(Config.Delays.EntityLoadCheck)
            local model = GetEntityModel(entity)
            if not model or model == 0 then return false end
            if IsVehicleSeatFree(entity, -1) == false then
                return false
            end
            return isBike(entity)
        end,
        onSelect = function(data)
            if IsPedInAnyVehicle(PlayerPedId(), false) then return end
            
            local vehicle = data.entity
            if not DoesEntityExist(vehicle) then return end
            
            local model = GetEntityModel(vehicle)
            if model == 0 then return end
            
            local modelName = nil
            for _, bikeName in ipairs(Config.BikeModels) do
                if GetHashKey(bikeName) == model then
                    modelName = bikeName
                    break
                end
            end
            
            if modelName then
                ESX.TriggerServerCallback('bike:canCarryItem', function(canCarry)
                    if canCarry then
                        DeleteEntity(vehicle)
                        TriggerServerEvent('bike:addItem', modelName)
                        local playerPed = PlayerPedId()
                        ESX.Streaming.RequestAnimDict(Config.Animations.Dict)
                        TaskPlayAnim(playerPed, Config.Animations.Dict, Config.Animations.Name, 8.0, -8.0, -1, 1, 0, false, false, false)
                        Wait(Config.Animations.Duration.Pickup)
                        ClearPedTasks(playerPed)
                    else
                        ESX.ShowNotification(Config.Messages.InventoryFull)
                    end
                end, modelName)
            end
        end
    }
})

local function SpawnBike(bikeModel, coords, heading)
    ESX.Game.SpawnVehicle(bikeModel, coords, heading, function(vehicle)
        SetVehicleOnGroundProperly(vehicle)
        Wait(Config.Delays.VehicleStabilization)
    end)
end

RegisterNetEvent('bike:spawn')
AddEventHandler('bike:spawn', function(bikeModel)
    if type(bikeModel) == 'string' then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        
        SpawnBike(bikeModel, coords, heading)
    end
end)

RegisterNetEvent('bike:respawnBike')
AddEventHandler('bike:respawnBike', function(bikeModel)
    if type(bikeModel) == 'string' then
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local forward = GetEntityForwardVector(playerPed)
        local newCoords = vector3(
            coords.x + forward.x * Config.Respawn.Distance,
            coords.y + forward.y * Config.Respawn.Distance,
            coords.z
        )
        local heading = GetEntityHeading(playerPed)
        
        SpawnBike(bikeModel, newCoords, heading)
        
        ESX.ShowNotification(Config.Messages.BikeRespawned)
    end
end) 