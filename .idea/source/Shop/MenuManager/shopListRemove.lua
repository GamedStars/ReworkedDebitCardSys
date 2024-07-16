function shopListRemove()
    print(string.rep("-",51))
    print("Removing Items from the shop")
    file = io.open("ShopMenu.txt", "r")
    file2 = io.open("ItemData.txt","r")
    line = file:read()
    line2 = file2:read()
    print("The items will be printed as such")
    print("S.no) Item Name, Quantity, Price")
    print(string.rep("-",51))
    counter4 = 1
    linelist = {}
    linelist2 = {}
    while line ~= nil do
        list = split(line, ",")
        print(tostring(counter4)..") "..list[1]..", "..list[2]..", "..list[3])
        counter4 = counter4 + 1
        table.insert(linelist,line)
        table.insert(linelist2,line2)
        line = file:read()
        line2 = file2:read()
    end
    file:close()
    file2:close()
    counter4 = counter4 - 1
    print(string.rep("-",51))
    io.write("Which number to remove? (1 to "..tostring(counter4)..") ")
    numberchoice = tonumber(io.read())
    while numberchoice < 1 or numberchoice > tonumber(counter4) do
        io.write("Your choice must be between (1 to "..tostring(counter4)..") ")
        numberchoice = tonumber(io.read())
    end
    file = io.open("ShopMenu.txt","w")
    file2 = io.open("ItemData.txt","w")
    for index, value in pairs(linelist2) do
        if index ~= numberchoice then
            file2:write(value.."\n")
        end
    end
    file2:close()
    for index, value in pairs(linelist) do
        if index ~= numberchoice then
            file:write(value.."\n")
        else memory = value
        end
    end
    templist = split(memory,",")
    print("Successfully removed "..templist[1].." from the menu")
    file:close()
end