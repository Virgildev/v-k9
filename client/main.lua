QBCore = exports['qb-core']:GetCoreObject()

local isActive = false

RegisterNetEvent('police-k9:activate', function()
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped, false) then
        TriggerEvent('ox_lib:notify', {
            description = 'You cannot activate the K9 from inside a vehicle.',
            type = 'error'
        })
        return
    end
    TriggerEvent('ox_lib:notify', {
        description = 'K9 mode activated. Use /k9menu to access features.',
        type = 'success'
    })
    isActive = true
end)

RegisterNetEvent('police-k9:menu', function()
    if not isActive then return end

    local playerPed = PlayerPedId()
    local isSmallDog = false
    local isLargeDog = false

    local model = GetEntityModel(playerPed)
    for _, dogModel in ipairs(Config.BigDogs) do
        if model == GetHashKey(dogModel) then
            isLargeDog = true
            break
        end
    end

    for _, dogModel in ipairs(Config.SmallDogs) do
        if model == GetHashKey(dogModel) then
            isSmallDog = true
            break
        end
    end

    local soundOptions = {}

    if isSmallDog then
        for _, soundData in ipairs(Config.SmallDogSounds) do
            table.insert(soundOptions, {
                title = soundData.label,
                description = 'Play the sound: ' .. soundData.sound,
                icon = 'fa-volume-up',
                event = 'police-k9:playSound',
                args = soundData
            })
        end
    elseif isLargeDog then
        for _, soundData in ipairs(Config.LargeDogSounds) do
            table.insert(soundOptions, {
                title = soundData.label,
                description = 'Play the sound: ' .. soundData.sound,
                icon = 'fa-volume-up',
                event = 'police-k9:playSound',
                args = soundData
            })
        end
    end

    lib.registerContext({
        id = 'police_k9_sounds',
        title = 'K9 Sounds',
        options = soundOptions
    })

    local options = {
        {
            title = 'Enter/Exit Vehicle',
            description = 'Command the K9 to enter or exit a nearby vehicle.',
            icon = 'fa-car-side',
            event = 'police-k9:enterExitVehicle'
        },
        {
            title = 'Search Player',
            description = 'Order the K9 to search the closest player for contraband.',
            icon = 'fa-solid fa-magnifying-glass',
            event = 'police-k9:searchPlayer'
        },
        {
            title = 'Search Vehicle',
            description = 'Command the K9 to search a nearby vehicle.',
            icon = 'fa-car',
            event = 'police-k9:client:searchVehicle'
        },
        {
            title = 'Sounds',
            description = 'Access various K9 sound effects.',
            icon = 'fa-dog',
            menu = 'police_k9_sounds'
        },
    }

    lib.registerContext({
        id = 'police_k9_menu',
        title = 'K9 Menu',
        options = options
    })

    lib.showContext('police_k9_menu')
end)

RegisterNetEvent('police-k9:playSound', function(soundData)
    local playerPed = PlayerPedId()
    local isSmallDog = false
    local isLargeDog = false

    local model = GetEntityModel(playerPed)
    for _, dogModel in ipairs(Config.BigDogs) do
        if model == GetHashKey(dogModel) then
            isLargeDog = true
            break
        end
    end

    for _, dogModel in ipairs(Config.SmallDogs) do
        if model == GetHashKey(dogModel) then
            isSmallDog = true
            break
        end
    end

    local sound = soundData.sound
    local emote = soundData.emote
    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 30.5, sound, 1.0)
    if isSmallDog and isActive then
        exports["rpemotes-reborn"]:EmoteCommandStart(emote, 0)
    elseif isLargeDog and isActive then
        exports["rpemotes-reborn"]:EmoteCommandStart(emote, 0)
    end
    Citizen.Wait(2500)
    exports["rpemotes-reborn"]:EmoteCancel()
end)

RegisterNetEvent('police-k9:searchPlayer', function()
    local player, distance = QBCore.Functions.GetClosestPlayer()
    if player and distance <= 2.0 and isActive then
        local playerPed = PlayerPedId()
        local isSmallDog, isLargeDog = IsDogType(playerPed)

        if isSmallDog then
            exports["rpemotes-reborn"]:EmoteCommandStart('sdogsit', 0)
        elseif isLargeDog then
            exports["rpemotes-reborn"]:EmoteCommandStart('bdogindicateahead', 0)
        end
        
        local result = lib.progressCircle({
            duration = 5000,
            label = 'K9 Searching Player...',
            canCancel = true,
            position = 'bottom'
        })
        
        if not result then return end
        local target = GetPlayerServerId(player)
        TriggerServerEvent('police-k9:searchInventory', target)
    else
        TriggerEvent('ox_lib:notify', {
            description = 'No players nearby.',
            type = 'error'
        })
    end
end)

RegisterNetEvent('police-k9:client:searchVehicle', function()
    local vehicle, distance = QBCore.Functions.GetClosestVehicle()
    if DoesEntityExist(vehicle) and distance <= 5.0 and isActive then
        local vehiclePlate = GetVehicleNumberPlateText(vehicle)
        local vehicleCoords = GetEntityCoords(vehicle)
        local playerPed = PlayerPedId()
        local isSmallDog, isLargeDog = IsDogType(playerPed)

        if isSmallDog then
            exports["rpemotes-reborn"]:EmoteCommandStart('sdogsit', 0)
        elseif isLargeDog then
            exports["rpemotes-reborn"]:EmoteCommandStart('bdogindicateahead', 0)
        end

        local result = lib.progressCircle({
            duration = 5000,
            label = 'K9 Searching Vehicle...',
            canCancel = true,
            position = 'bottom'
        })
        
        if not result then return end
        TriggerServerEvent('police-k9:server:searchVehicle', vehiclePlate, vehicleCoords)
    else
        TriggerEvent('ox_lib:notify', {
            description = 'No vehicles nearby.',
            type = 'error'
        })
    end
end)

RegisterNetEvent('police-k9:searchIndication', function(foundSomething)
    local playerPed = PlayerPedId()
    local isSmallDog, isLargeDog = IsDogType(playerPed)

    if isSmallDog and isActive then
        if foundSomething then
            exports["rpemotes-reborn"]:EmoteCommandStart("sdogbark", 0)
        else
            exports["rpemotes-reborn"]:EmoteCommandStart("sdogld", 0)
        end
    elseif isLargeDog and isActive then
        if foundSomething then
            exports["rpemotes-reborn"]:EmoteCommandStart("bdogindicatehigh", 0)
        else
            exports["rpemotes-reborn"]:EmoteCommandStart("bdoglayleft", 0)
        end
    end

    Citizen.Wait(5000)
    exports["rpemotes-reborn"]:EmoteCancel()
end)

function IsDogType(playerPed)
    local isSmallDog = false
    local isLargeDog = false

    local model = GetEntityModel(playerPed)
    
    for _, dogModel in ipairs(Config.BigDogs) do
        if model == GetHashKey(dogModel) then
            isLargeDog = true
            break
        end
    end

    for _, dogModel in ipairs(Config.SmallDogs) do
        if model == GetHashKey(dogModel) then
            isSmallDog = true
            break
        end
    end

    return isSmallDog, isLargeDog
end