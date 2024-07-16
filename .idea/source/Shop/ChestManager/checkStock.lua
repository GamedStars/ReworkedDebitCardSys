function checkStock()

    -- Gets the outputChest
    file = io.open("OutputChest.txt","r")
    for line in file:lines() do
        if line ~= nil then
            outputChest = peripheral.wrap(line)
        end
    end
    file:close()

    -- Gets how much we are selling of each item
    local quantity = {}
    file = io.open("ShopMenu.txt","r")
    for line in file:lines() do
        if line ~= nil then
            local number = split(line, ",")[4]
            table.insert(quantity,number)
        end
    end
    file:close()

    -- Gets the data of each of the items
    itemdata = {}
    file = io.open("ItemData.txt","r")
    for line in file:lines() do
        if line ~= nil then
            table.insert(itemdata, line)
        end
    end
    file:close()

    -- Gets all the chests except the outputChest
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

    -- Creates a dictionary where the key is the item true name and the value is how much we have of that stuff
    local total = {}
    for _,data in pairs(itemdata) do
        datalist = split(data,",")
        total[datalist[1]] = 0
    end

    -- Searches each chest, each slot, for each item in the menu and tallies them
    for _,chest in pairs(storageChest) do
        inv = chest.list()
        for _,item in pairs(inv) do
            for _,data in pairs(itemdata) do
                if tostring(item["name"]..","..item["nbt"]) == data then
                    total[datalist[1]] = total[datalist[1]] + item["count"]
                end
                --if item["name"] == datalist[1] and tostring(item["nbt"]) == datalist[2] then
                --    total[datalist[1]] = total[datalist[1]] + item["count"]
                --end
            end
        end
    end

    -- Finally checks if we have enough compared to the total the customer is asking for
    local counter = 1
    returnList = {}
    for itemname, number in pairs(total) do
        if tonumber(number) >= tonumber(quantity[counter]) then
            table.insert(returnList,true)
        else
            table.insert(returnList,false)
        end
        counter = counter + 1
    end
    return returnList
end