path = "Packages/DataFiles/"

function clearAll()
    file = io.open(path.."ShopMenu.txt","r")
    line = file:read()
    counter3 = 1
    linelist = {}
    indexlist = {}
    while line ~= nil do
        list = split(line,",")
        if tonumber(list[4]) ~= 0 then
            newline = list[1]..","..list[2]..","..list[3]..",0"
            table.insert(linelist, newline)
            table.insert(indexlist, counter3)
        end
        counter3 = counter3 + 1
        line = file:read()
    end
    for index = 1,#linelist,1 do
        edit(indexlist[index], linelist[index])
    end
end