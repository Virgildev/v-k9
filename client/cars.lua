-- To be rewrote once I figure out how I can make a dog not look like a furball sitting in a car, atm unsure if its even possible.

RegisterNetEvent('police-k9:enterExitVehicle', function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    ClearPedTasksImmediately(ped)
    TaskClearLookAt(ped)
    if DoesEntityExist(vehicle) then
        TaskLeaveVehicle(ped, vehicle, 0)

        Citizen.Wait(1000)

        exports["rpemotes-reborn"]:EmoteCancel()

    else
        local closestVehicle = QBCore.Functions.GetClosestVehicle()
        if DoesEntityExist(closestVehicle) then
            local vehicleCoords = GetEntityCoords(closestVehicle)
            local pedCoords = GetEntityCoords(ped)

            local distance = #(pedCoords - vehicleCoords)
            if distance <= 3.0 then
                if not IsPedInAnyVehicle(ped, false) then
                    TaskWarpPedIntoVehicle(ped, closestVehicle, 2)
                    if IsPedInVehicle(ped, closestVehicle, false) then
                        exports["rpemotes-reborn"]:EmoteCancel()
                    else
                        TaskWarpPedIntoVehicle(ped, closestVehicle, 2)
                    end
                end
            else
                TriggerEvent('ox_lib:notify', {
                    description = 'No nearby vehicle found within 3 meters.',
                    type = 'error'
                })
            end
        else
            TriggerEvent('ox_lib:notify', {
                description = 'No nearby vehicle found.',
                type = 'error'
            })
        end
    end
end)
