monitor = peripheral.find("monitor")

function monitorUpdate()
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.setTextScale(0.5)
    monitor.setBackgroundColor(colors.black)
    counter = 3
    x,y = monitor.getSize()
    newx = x - 8
    quantitySize = math.floor(newx/6) --smaller
    priceSize = 1 + newx/3 + newx/3 + quantitySize --bigger
    quantitySize = 1 + newx/3 + newx/3
    while priceSize - quantitySize <= 8 do
        quantitySize = quantitySize - 1
    end


    monitor.write("Item Name")
    monitor.setCursorPos(quantitySize, 1)
    monitor.write("Quantity")
    monitor.setCursorPos(priceSize, 1)
    monitor.write("Price")
    monitor.setCursorPos(1,2)
    monitor.write(string.rep("-", x))
    monitor.setCursorPos(x-7,y)
    monitor.write("CHECKOUT")
    monitor.setCursorPos(1,y)
    monitor.write("CLEAR ALL")

    --check in stock
    inStock = checkStock()
    file = io.open("ShopMenu.txt","r")
    line = file:read()
    stockcounter = 1
    everyInStock = true
    while line ~= nil do
        if not inStock[stockcounter] then
            monitor.setTextColor(colors.red)
            everyInStock = false
        else
            monitor.setTextColor(colors.white)
        end

        list = split(line, ",")

        monitor.setCursorPos(1,counter)
        monitor.write(list[1])

        monitor.setCursorPos(quantitySize, counter)
        monitor.write(list[2])

        monitor.setCursorPos(priceSize,counter)
        monitor.write(list[3])

        monitor.setCursorPos(newx-1, counter)

        if #tostring(list[4]) == 1 then
            monitor.write("[+] 0"..list[4].." [-]")
        else
            monitor.write("[+] "..list[4].." [-]")
        end

        counter = counter + 1
        stockcounter = stockcounter + 1
        line = file:read()
    end
    monitor.setTextColor(colors.white)
    file:close()
end