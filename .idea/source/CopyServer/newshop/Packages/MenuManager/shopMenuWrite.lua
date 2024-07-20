require("Packages/MenuManager/checkMenuDupes")
require("Packages/ChestManager/findOutputChest")
path = "Packages/DataFiles/"

function shopMenuWrite()
    print(string.rep("-",51))
    print("Creating a shop menu")

    outputChest = findOutputChest()
    if outputChest == nil then
        error("Could not find output chest, please set the output chest using the ShopClient")
        return nil
    end

    file = io.open(path.."ShopMenu.txt","w")
    file:close()
    file = io.open(path.."ItemData.txt","w")
    file:close()
    run = true

    while run do
        print(string.rep("-",51))

        io.write("Item Name? ")
        itemname = io.read()
        io.write("How much are you selling per purchase? ")
        quantity = io.read()
        io.write("Price per purchase? ")
        price = io.read()
        print()
        print("Please put the item in the output chest, then press ENTER")
        io.read()
        file = io.open(path.."ChestInfo.txt", "r")
        for line in file:lines() do
            outputChest = peripheral.wrap(line)
        end
        for _,item in pairs(outputChest.list()) do
            if item ~= nil then
                itemtag = item["name"]
                if item["nbt"] == nil then
                    itemnbt = "nil"
                else
                    itemnbt = item["nbt"]
                end
                break
            end
        end
        file:close()
        writeLine2 = itemtag..","..itemnbt.."\n"
        writeLine = itemname..","..quantity..","..price..",0\n"
        if checkMenuDupes(writeLine) then
            print("You already have this exact menu item. ")
        else
            file = io.open(path.."ShopMenu.txt","a")
            file:write(writeLine)
            file:close()

            file = io.open(path.."ItemData.txt","a")
            file:write(writeLine2)
            file:close()
            print(itemtag.." has been added to the menu")
        end
        print()
        io.write("Do you wish to add more items? (Y or N) ")
        choice = string.lower(io.read())
        while choice ~= "n" and choice ~= "y" do
            io.write("Your choices must be (Y or N) ")
            choice = string.lower(io.read())
        end
        if choice == "n" then
            run = false
        end
    end
end