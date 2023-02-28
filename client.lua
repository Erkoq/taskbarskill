local chance, skillGap, factor, taskInProcess, calm, activeTasks = 0, 20, 1.0, false, true, 0

function openGui(sentLength, taskID, namesent, chancesent, skillGapSent)
    SetNuiFocus(true, false)
    SendNUIMessage({ runProgress = true, Length = sentLength, Task = taskID, name = namesent, chance = chancesent, skillGap = skillGapSent })
end

function updateGui(sentLength, taskID, namesent, chancesent, skillGapSent)
    SendNUIMessage({ runUpdate = true, Length = sentLength, Task = taskID, name = namesent, chance = chancesent, skillGap = skillGapSent })
end

function closeGuiFail()
    SetNuiFocus(false, false)
    SendNUIMessage({ closeFail = true })
end

function closeGui()
    SetNuiFocus(false, false)
    SendNUIMessage({ closeProgress = true })
end

function closeNormalGui()
    SetNuiFocus(false, false)
end

RegisterNUICallback('taskCancel', function(data, cb)
    closeGui()
    activeTasks = 2
    FactorFunction(false)
end)

RegisterNUICallback('taskEnd', function(data, cb)
    closeNormalGui()
    activeTasks = 3
    factor = 1.0
end)

function FactorFunction(pos)
    if not pos then
        factor = factor - 0.1
        if factor < 0.1 then
            factor = 0.1
        end
        if factor == 0.5 and calm then
            calm = false
        end
        Wait(15000)
        FactorFunction(true)
    else
        if factor > 1.0 or factor == 0.9 then
            if not calm then
                calm = true
            end
            factor = 1.0
            return
        end
        factor = factor + 0.1
    end
end

function taskBar(difficulty, skillGapSent)
    local name = 'E'
    local taskIdentifier = 'taskid' .. math.random(1000000)
    local length = math.ceil(difficulty * factor)
    skillGap = skillGapSent

    if skillGap < 5 then
        skillGap = 5
    end

    if taskInProcess then
        return 100
    end

    FactorFunction(false)
    chance = math.random(15, 90)
    taskInProcess = true
    openGui(length, taskIdentifier, name, chance, skillGap)
    activeTasks = 1

    while activeTasks == 1 do
        Wait(1)
    end

    if activeTasks == 2 then
        closeGui()
        taskInProcess = false
        return 0
    end

    closeGui()
    taskInProcess = false
    return 100
end