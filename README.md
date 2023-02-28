# taskbarskill
Minigame for RedM Standalone for all frameworks

Credits to: https://github.com/firestix77/taskbarskill (Me only edit css like RedM Style)
EXPORT EXAMPLE:
RegisterCommand("minigame", function()
    local finished = exports["taskbarskill"]:taskBar(3700, 1)
    if finished == 100 then 
        print('done')
    else 
        print('none')    
    end
end)
