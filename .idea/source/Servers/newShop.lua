require("split")

function newShop(phoneID, shopID)
    file = io.open("disk/DebitCardInfo.txt","r")

    -- Checks if the clientID exists
    found = false
    for line in file:lines() do
        if line ~= nil then
            info = split(line)
            if tostring(info[2]) == tostring(phoneID) then
                found = true
                break
            end
        end
    end

    if found then
        rednet.send(shopID, info[1], "FoundPhoneID")
    else
        rednet.send(shopID, "Your ID is not registered ask one of the mods to create you a card")
    end

    file:close()
end
