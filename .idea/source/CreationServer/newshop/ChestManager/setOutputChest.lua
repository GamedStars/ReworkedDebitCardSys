function setOutputChest()

    -- Finds all the attached chests
    chestFound = {}
    chests = peripheral.getNames()
    for _,chest in pairs(chests) do
        if string.len(chest) >= 15 then
            name = string.sub(chest,1,15)
            if name == "minecraft:chest" then
                wrapChest = peripheral.wrap(chest)
                table.insert(chestFound, wrapChest)
            end
        end
    end

    -- Searches for the chest where all the items will be outputed by looking for a paper
    outputChest = nil
    for _,chest in pairs(chestFound) do
        list = chest.list()
        for _,item in pairs(list) do
            if item["name"] == "minecraft:paper" then
                outputChest = chest
                file = io.open("DataFiles/ChestInfo.txt","w")
                file:write(peripheral.getName(chest))
                file:close()
            end
        end
    end


    if outputChest == nil then
        print("Could not find output chest")
        return false
    else
        print("Found output chest")
        return true
    end
end