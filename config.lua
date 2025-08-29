Config = {}

Config.BikeModels = {
    'bmx',
    'cruiser',
    'fixter',
    'scorcher',
    'tribike',
    'tribike2',
    'tribike3'
}

Config.Animations = {
    Dict = 'mini@repair',
    Name = 'fixing_a_ped',
    Duration = {
        Spawn = 1000,
        Pickup = 1500
    }
}

Config.Target = {
    Name = 'pickup_bike',
    Icon = 'fas fa-bicycle',
    Label = 'Ramasser le vélo'
}

Config.Delays = {
    VehicleStabilization = 500,
    EntityLoadCheck = 0
}

Config.Messages = {
    InventoryFull = "~r~Vous n'avez pas assez de place dans votre inventaire",
    BikeRespawned = "~r~Votre inventaire est plein.~s~ Le vélo a été replacé."
}

Config.Respawn = {
    Distance = 1.0
}
