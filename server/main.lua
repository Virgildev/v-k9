QBCore = exports['qb-core']:GetCoreObject()

local discordWebhookURL = 'https://discord.com/api/webhooks/1308963002669858856/1ZpG1WvYg53hOnH2xnIytJ8x4XlWaaBaKwXOLnkODVP9Onb_2cWIHJTIeraGcBU86n2W' -- Replace with your Discord webhook URL

local function isDogPed(ped)
    local model = GetEntityModel(ped)

    for _, dog in pairs(Config.BigDogs) do
        if model == GetHashKey(dog) then
            return true
        end
    end

    for _, dog in pairs(Config.SmallDogs) do
        if model == GetHashKey(dog) then
            return true
        end
    end

    return false
end

QBCore.Commands.Add('k9activate', 'Activate K9 mode.', {}, false, function(source, args)
    local discordID = ""
    local playerName = ""
    local Player = QBCore.Functions.GetPlayer(source)

    local identifiers = GetNumPlayerIdentifiers(source)
    for i = 0, identifiers - 1 do
        local identifier = GetPlayerIdentifier(source, i)
        if identifier then
            if string.match(identifier, "discord") then
                discordID = string.sub(identifier, 9)
            end
        end
    end

    if Player then
        playerName = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    end

    local ped = GetPlayerPed(source)
    if Player and table.contains(Config.PoliceJobs, Player.PlayerData.job.name) and isDogPed(ped) then
        TriggerClientEvent('police-k9:activate', source)

        local message = {
            content = "**K9 Mode Activated**",
            embeds = {
                {
                    title = "K9 Mode Activation",
                    description = "**Player**: <@" .. discordID .. ">\n**Name**: " .. playerName .. "\n**Action**: Clocked in and activated K9 mode.",
                    color = 3066993,
                    timestamp = os.date("!%Y-%m-%dT%H:%M:%S"),
                }
            }
        }

        PerformHttpRequest(discordWebhookURL, function(err, text, headers)
            if err ~= 200 then
                print('Error sending webhook to Discord')
            end
        end, 'POST', json.encode(message), { ['Content-Type'] = 'application/json' })
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Access Denied',
            description = 'You must be a police or K9 officer and have a valid dog ped to use this command.',
            type = 'error',
        })
    end
end)

QBCore.Commands.Add('k9menu', 'Open K9 menu.', {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)

    if Player and table.contains(Config.PoliceJobs, Player.PlayerData.job.name) then
        TriggerClientEvent('police-k9:menu', source)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Access Denied',
            description = 'You must be a police or K9 officer to use this command.',
            type = 'error',
        })
    end
end)

function table.contains(table, element)
    for _, value in ipairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

RegisterNetEvent('police-k9:searchInventory', function(target)
    local k9Officer = source
    local items = exports.ox_inventory:GetInventoryItems(target)

    if type(items) == "table" then
        local foundItem = false

        for _, item in pairs(items) do
            local label = getItemLabel(item.name)
            if label then
                TriggerClientEvent('ox_lib:notify', k9Officer, {
                    description = 'K9 found: ' .. label,
                    type = 'success',
                })
                foundItem = true
                TriggerClientEvent('police-k9:searchIndication', k9Officer, true)
                break
            end
        end

        if not foundItem then
            TriggerClientEvent('ox_lib:notify', k9Officer, {
                description = 'K9 found nothing.',
                type = 'inform',
            })
            TriggerClientEvent('police-k9:searchIndication', k9Officer, false)
        end
    else
        TriggerClientEvent('ox_lib:notify', k9Officer, {
            description = 'Error fetching inventory.',
            type = 'error',
        })
    end
end)

RegisterNetEvent('police-k9:server:searchVehicle', function(vehiclePlate, vehicleCoords)
    local k9Officer = source
    local plate = string.upper(vehiclePlate)
    local gloveboxInventory = 'glove' .. plate
    local trunkInventory = 'trunk' .. plate
    local officerCoords = GetEntityCoords(GetPlayerPed(k9Officer))
    local distance = #(officerCoords - vehicleCoords)
    
    if distance <= 5.0 then
        local gloveboxItems = exports.ox_inventory:GetInventoryItems(gloveboxInventory, true) or {}
        local trunkItems = exports.ox_inventory:GetInventoryItems(trunkInventory, true) or {}
        local foundItems = {}

        for _, item in ipairs(gloveboxItems) do
            local label = getItemLabel(item.name)
            if label then
                foundItems[label] = true
            end
        end
        for _, item in ipairs(trunkItems) do
            local label = getItemLabel(item.name)
            if label then
                foundItems[label] = true
            end
        end

        if next(foundItems) then
            local foundItemLabels = {}
            for label in pairs(foundItems) do
                table.insert(foundItemLabels, label)
            end
            TriggerClientEvent('ox_lib:notify', k9Officer, {
                description = "K9 detected: " .. table.concat(foundItemLabels, ", "),
                type = 'success',
            })
            TriggerClientEvent('police-k9:searchIndication', k9Officer, true)
        else
            TriggerClientEvent('ox_lib:notify', k9Officer, {
                description = 'K9 found nothing suspicious.',
                type = 'inform',
            })
            TriggerClientEvent('police-k9:searchIndication', k9Officer, false)
        end
    else
        TriggerClientEvent('ox_lib:notify', k9Officer, {
            description = 'Vehicle is too far away to search.',
            type = 'inform',
        })
    end
end)

function getItemLabel(itemName)
    for _, item in ipairs(Config.SearchableItems) do
        if item.name == itemName then
            return item.label
        end
    end
    return nil
end