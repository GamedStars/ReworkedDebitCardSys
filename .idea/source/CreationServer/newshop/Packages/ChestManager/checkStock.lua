require("Packages/Helpers/split")

path = "Packages/DataFiles/"

function checkStock()

    -- Gets the outputChest
    file = io.open(path.."ChestInfo.txt","r")
    for line in file:lines() do
        if line ~= nil then
            outputChest = peripheral.wrap(line)
        end
    end
    file:close()

    -- Gets how much we are selling of each item
    local quantity = {}
    file = io.open(path.."ShopMenu.txt","r")
    for line in file:lines() do
        if line ~= nil then
            stockInfo = split(line, ",")
            local number = tonumber(stockInfo[4]) * tonumber(stockInfo[2])
            table.insert(quantity,number)
        end
    end
    file:close()

    -- Creates a dictionaries with the item as the key and their NBT tags and the item with the amount stored


    itemsInMenu = {}
    itemdata = {}
    local total = {}
    counter = 1
    file = io.open(path.."ItemData.txt","r")
    for line in file:lines() do
        if line ~= nil then
            itemInformation = split(line, ",")
            itemdata[itemInformation[1]] = itemInformation[2]
            total[itemInformation[1]] = 0
            table.insert(itemsInMenu, itemInformation[1])
            counter = counter + 1
        end
    end
    file:close()

    demand = {}
    for _,item in ipairs(itemsInMenu) do
        demand[item] = 0
    end

    for index,item in ipairs(itemsInMenu) do
        demand[item] = demand[item] + quantity[index]
    end

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

    -- Searches each chest, each slot, for each item in the menu and tallies them
    for _,chest in pairs(storageChest) do
        inv = chest.list()
        for _,item in pairs(inv) do
            for key,nbt in pairs(itemdata) do
                if tostring(item["name"]) == key and tostring(item["nbt"]) == nbt then
                    total[item["name"]] = total[item["name"]] + item["count"]
                end
            end
        end
    end

    -- Finally checks if we have enough compared to the total the customer is asking for
    local counter = 1
    returnList = {}
    for _, itemName in ipairs(itemsInMenu) do
        if tonumber(total[itemName]) >= tonumber(demand[itemName]) then
            table.insert(returnList,true)
        else
            table.insert(returnList,false)
        end
        counter = counter + 1
    end

    return returnList
end