
function startService()
    file = io.open("ShopMenu.txt","r")
    line = file:read()
    counter1 = 2
    while line ~= nil do
        counter1 = counter1 + 1
        line = file:read()
    end
    file:close()
    while true do
        monitorUpdate()
        event, side, x, y = os.pullEvent("monitor_touch")
        sizex, sizey = monitor.getSize()
        if ((x <= sizex-7 and x >= sizex-9) or (x <= sizex and x>=sizex-2)) and y >= 3 and y <= counter1 then
            linenumber = y - 2
            file = io.open("ShopMenu.txt","r")
            for _ = 1, linenumber, 1 do
                line = file:read()
            end
            file:close()
            list = split(line, ",")
            if x <= sizex-7 and x >= sizex-9 and tonumber(list[4]) < 99 then
                --add stock check here
                for index, status in pairs(inStock) do
                    if index + 2 == y and status == false then
                    elseif index + 2 == y and status == true then
                        newnumber = tostring(tonumber(list[4]) + 1)
                    end
                end
            elseif x <= sizex and x >= sizex-2 and tonumber(list[4]) > 0 then
                newnumber = tostring(tonumber(list[4]) - 1)
            end
            if newnumber ~= nil then
                newline = list[1]..","..list[2]..","..list[3]..","..newnumber
                edit(linenumber, newline)
            end
        elseif everyInStock == true and x <= sizex and x >= sizex-7 and y == sizey then
            doCheckout()
        elseif x <= 9 and x >= 1 and y == sizey then
            clearAll()
        end
        monitorUpdate()
    end
end