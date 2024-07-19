require("Helpers/split")

function addNewAccount(owner, balance, id)

    run = nil
    while run == nil do
        key = tostring(math.random(1000000000))
        run = validateAccount(owner, key)
        if not run then
            rednet.send(id, false)
            return
        end
    end

    file = io.open("disk/DebitCardInfo.txt", "a")

    file:write(owner..","..key..","..balance.."\n")
    file:close()
    rednet.send(id, tostring(key))
end

function validateAccount(owner, key)
    file = io.open("disk/DebitCardInfo.txt", "a+")
    fileContent = file:lines()
    if fileContent ~= nil then
        for line in fileContent do
            if line ~= nil then
                info = split(line, ",")
                if info[1] == owner then
                    file:close()
                    return false
                elseif info[2] == key then
                    file:close()
                    return nil
                end
            end
        end
    end
    file:close()
    return true
end