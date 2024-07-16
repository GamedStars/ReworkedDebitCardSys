require("split.lua")
require("edit.lua")

function transfer(senderID, recipient, amount, phoneID)

    if amount <= 0 then
        rednet.send(phoneID, "You cannot transfer a non-positive amount of money", "PhoneQueryResult")
        return "Someone tried to send a negative amount to "..recipient
    end

    -- Checks if sender exists and where the sender exists
    local senderExists = false
    file = io.open("disk/DebitCardInfo.txt","r")
    local senderIndex = 1
    for line in file:lines() do
        if line ~= nil then
            senderInfo = split(line)
            if tostring(senderInfo[2]) == senderID then
                senderExists = true
                break
            end
        end
        senderIndex = senderIndex + 1
    end
    file:close()

    -- Checks if recipient exists and where the recipient exists
    file = io.open("disk/DebitCardInfo.txt","r")
    local recipientExists = false
    local recipientIndex = 1
    for line in file:lines() do
        if line ~= nil then
            recipientInfo = split(line)
            if tostring(recipientInfo[1]) == recipient then
                recipientExists = true
                break
            end
        end
        recipientIndex = recipientIndex + 1
    end
    file:close()

    -- Based on the results of the previous searches this program will output an apporiate message
    if not recipientExists or not senderExists then
        rednet.send(phoneID, "Either you or the recipient does not have a debit card", "PhoneQueryResult")
        return "Someone does not have a credit card"
    elseif tonumber(amount) > tonumber(senderInfo[3]) then
        rednet.send(phoneID, "You do not have enough money", "PhoneQueryResult")
        return "Sender does not have "..tostring(amount)
    else
        -- Saves all the data
        --file = io.open("disk/DebitCardInfo.txt","r")
        --fileContent = {}
        --for line in file:lines() do
        --    table.insert(fileContent, line)
        --end
        --file:close()

        -- Replaces the information with new information
        edit(senderIndex, senderInfo[1]..","..senderInfo[2]..",".. senderNewBalance)
        edit(recipientIndex, recipientInfo[1]..","..recipientInfo[2]..",".. recipientNewBalance)
        --senderNewBalance = tostring(tonumber(senderInfo[3]) - tonumber(amount))
        --fileContent[senderIndex] = senderInfo[1]..","..senderInfo[2]..",".. senderNewBalance
        --recipientNewBalance = tostring(tonumber(recipientInfo[3]) + tonumber(amount))
        --fileContent[recipientIndex] = recipientInfo[1]..","..recipientInfo[2]..",".. recipientNewBalance

        -- Writes back all the information back into the disk
        --file = io.open("disk/DebitCardInfo.txt","w")
        --for x,y in pairs(fileContent) do
        --    file:write(y.."\n")
        --end
        --file:close()
        rednet.send(phoneID, "Successfully transfered "..tostring(amount).." to "..tostring(recipient), "PhoneQueryResult")

        return "Transfered "..amount.." to "..tostring(recipient)
    end
end