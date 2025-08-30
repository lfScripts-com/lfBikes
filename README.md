# lfBikes

A free interactive bike system for ESX servers.

## Features

- Spawn bikes from inventory items
- Pick up bikes and store them back in inventory
- Automatic respawn if inventory is full
- Configurable bike models
- ox_target integration for seamless interaction
- Customizable animations and messages
- Support for multiple bike types (BMX, Cruiser, Fixter, etc.)

## Dependencies

- ESX Legacy
- ox_inventory
- ox_target

## Installation

1. Put script in your resources directory
2. Add `ensure lfBikes` in your server.cfg
3. Configure bike models in `config.lua`
4. Add bike items to your ox_inventory items.lua

## Configuration

### Bike Models
```lua
Config.BikeModels = {
    'bmx',
    'cruiser',
    'fixter',
    'scorcher',
    'tribike',
    'tribike2',
    'tribike3'
}
```

### Animations
```lua
Config.Animations = {
    Dict = 'mini@repair',
    Name = 'fixing_a_ped',
    Duration = {
        Spawn = 1000,
        Pickup = 1500
    }
}
```

### Messages
```lua
Config.Messages = {
    InventoryFull = "~r~Vous n'avez pas assez de place dans votre inventaire",
    BikeRespawned = "~r~Votre inventaire est plein.~s~ Le vélo a été replacé."
}
```

## Usage

- **Use bike item**: Use bike item from inventory to spawn it
- **Pick up bike**: Target bike with ox_target to pick it up
- **Automatic respawn**: Bike respawns if inventory is full

## Items Configuration

Copy the contents of `items/items.lua` to your ox_inventory items.lua file.
