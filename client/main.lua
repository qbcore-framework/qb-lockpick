local lockpickCallback = nil
local ped = PlayerPedId()

function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Wait(0)
    end
end

AddEventHandler('qb-lockpick:client:openLockpick', function(callback)
    lockpickCallback = callback
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local anim = "machinic_loop_mechandplayer"
    loadAnimDict(animDict)
    TaskPlayAnim(ped, animDict, anim, 8.0, 8.0, -1, 16, 0, false, false, false)
    openLockpick(true)
end)

RegisterNUICallback('callback', function(data, cb)
    openLockpick(false)
    if lockpickCallback then
        lockpickCallback(data.success)
    end
    cb('ok')
    ClearPedTasks(ped)
end)

RegisterNUICallback('exit', function(_, cb)
    openLockpick(false)
    cb('ok')
    ClearPedTasks(ped)
end)

openLockpick = function(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        toggle = bool,
    })
    SetCursorLocation(0.5, 0.2)
    lockpicking = bool
end
