function getAccountInformation(name)
    file = io.open("disk/DebitCardInfo.txt","r")

    key = false
    -- Checks if the clientID exists
    for line in file:lines() do
        if line ~= nil then
            info = split(line)
            if tostring(info[1]) == name then
                key = info[2]
                break
            end
        end
    end
    file:close()

    return key
end
