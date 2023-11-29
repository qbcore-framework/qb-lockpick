local lockpickCallback = nil

AddEventHandler('qb-lockpick:client:openLockpick', function(callback)
    lockpickCallback = callback
    openLockpick(true)

end)

RegisterNUICallback('callback', function(data, cb)
    openLockpick(false)
    if lockpickCallback then
        lockpickCallback(data.success)
    end
    cb('ok')
end)

RegisterNUICallback('exit', function(_, cb)
    openLockpick(false)
    cb('ok')
end)

openLockpick = function(bool, options)
    --[[
        valid options:
        - pinDamageMaxHealth = 0, //Recommended: 5, default: 0
        - pinRegenPerSecond = 0, //Recommended: 10, default: 0
        - solvePadding = 4, //Default: 4. Recommendations; Beginner: 10, Normal: 8, Tough: 6, Advanced: 4, Expert: 2
        - pinHealth = 100, //Default: 100. Just keep this the same as max health.
        - IFramesMS = 150 //Default: 150. Recommendation; 500, and change things like regen and max health.
        - IncorrectTryDamage = 20 //Default: 20. Reccomendation; leave it and increase regen.
        - pinMaxHealth = 100 //Default: 100. Reccomendation; leave this. If you don't set pinHealth to this value, too
    ]]

    if options then
        options["action"] = "option"
        SendNUIMessage(options)
    else
        options = {
            action = "option",
            reset = true
        }
    end
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
    lockpicking = bool
end

AddEventHandler('qb-lockpick:client:openLockpickAdvanced', function(callback, options)
    lockpickCallback = callback
    
    openLockpick(true, options)
end)