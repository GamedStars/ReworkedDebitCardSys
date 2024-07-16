require("split.lua")

modem = peripheral.find("modem",rednet.open)

function checkBalance(clientID, phoneID)
    file = io.open("disk/DebitCardInfo.txt","r")

    -- Checks if the clientID exists
    for line in file:lines() do
        if line ~= nil then
            info = split(line)
            if tostring(info[2]) == clientID then
                break
            end
        end
    end

    -- If the client exists return the information
    if info ~= nil then
        rednet.send(phoneID, info[1]..", your balance is "..info[3], "PhoneQueryResult")
        return info[1].."'s balance is "..info[3]
    else
        rednet.send(phoneID, "Your card does not exist", "PhoneQueryResult")
        return "Someone is missing a card"
    end
    file:close()
end