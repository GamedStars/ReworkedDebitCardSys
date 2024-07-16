function push(itemnumber, amount)

    -- Gets the outputChest
    file = io.open("ChestInfo.txt","r")
    for line in file:lines() do
        if line ~= nil then
            outputChest = peripheral.wrap(line)
        end
    end

    -- Gets all the storageChests
    storageChest = {}
    chests = peripheral.getNames()
    for _,chest in pairs(chests) do
        if string.len(chest) >= 15 then
            name = string.sub(chest,1,15)
            if name == "minecraft:chest" and chest ~= peripheral.getName(outputChest) then
                wrapChest = peripheral.wrap(chest)
                table.insert(storageChest, wrapChest)
            end
        end
    end

    -- Gets the itemdata
    file = io.open("ItemData.txt","r")
    index1 = 1
    for line in file:lines() do
        if line ~= nil then
            if index1 == itemnumber then
                itemline = line
            end
        end
        index1 = index1 + 1
    end

    local itemlist = split(itemline, ",")
    sent = 0
    local sentEnough = false

    -- As long as we didn't send enough
    while sent < amount do
        --Search each chest
        for _, chest in pairs(storageChest) do
            if sentEnough then break end -- If we have sent enough stop searching the chests
            -- And each slot
            for slot = 1, chest.size(), 1 do
                local iteminfo = chest.getItemDetail(slot)

                -- If there is nothing in the slot, carry on
                if iteminfo ~= nil then
                    if iteminfo["name"] == itemlist[1] and tostring(iteminfo["nbt"]) == itemlist[2] then
                        -- If it is the same item and we can push all the items now then just push the items
                        if iteminfo["count"] > (amount-sent) then
                            chest.pushItems(peripheral.getName(outputChest),slot,amount-sent)
                            sentEnough = true
                            break
                        else
                        -- If not then just push how much we can and keep searching
                            sent = sent + iteminfo["count"]
                            chest.pushItems(peripheral.getName(outputChest),slot)
                        end
                    end
                end
            end
        end
        break
    end
end