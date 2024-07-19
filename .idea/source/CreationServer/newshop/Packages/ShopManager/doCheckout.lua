require("Packages/ShopManager/doPurchase")
path = "Packages/DataFiles/"

monitor = peripheral.find("monitor")

function doCheckout()

    monitor.clear()
    monitor.setCursorPos(1,1)
    x, y = monitor.getSize()
    monitor.write("Item Name")
    newx = x - 8
    gap = 1 + newx/3 + newx/3
    monitor.setCursorPos(gap,1)
    monitor.write("Costs")
    monitor.setCursorPos(1,2)
    monitor.write(string.rep("-",x))
    monitor.setCursorPos(newx-3,1)
    monitor.write("Total")
    counter2 = 2
    total = 0
    basket = {}
    basketcounter = 1
    file = io.open(path.."ShopMenu.txt", "r")
    line = file:read()
    while line ~= nil do
        list = split(line, ",")
        if tonumber(list[4]) ~= 0 then
            counter2 = counter2 + 1
            monitor.setCursorPos(1,counter2)
            monitor.write(list[1])

            monitor.setCursorPos(gap,counter2)
            monitor.write(list[3].." * "..list[4])
            basket[basketcounter] = tonumber(list[4]) * tonumber(list[2])
            monitor.setCursorPos(newx-3,counter2)
            addend = tonumber(list[3]) * tonumber(list[4])
            monitor.write(tostring(addend))
            total = total + addend
            basketcounter = basketcounter + 1
        end
        line = file:read()
    end
    orgx,orgy = monitor.getSize()
    monitor.setCursorPos(newx-3,counter2+1)
    monitor.write(string.rep("-",orgx-(newx-4)))
    monitor.setCursorPos(newx-3,counter2+2)
    monitor.write(total)
    monitor.setCursorPos(1,orgy)
    monitor.write("BACK")
    monitor.setCursorPos(orgx-7,orgy)
    monitor.write("PURCHASE")
    run = true
    if total == 0 then
        run = false
        file:close()
    end
    while run do
        event, side, x, y = os.pullEvent("monitor_touch")
        -- This if statement is to go back
        if y == orgy and x >= 1 and x <= 4 then
            run = false
            file:close()

        -- This if statement is to purchase
        elseif y == orgy and x >= orgx-7 and x<= orgx then
            file:close()
            file = io.open("disk/PhoneID.txt","r")
            if file ~= nil then
                file:close()
                doPurchase(total)
                run = false
            end
        end
    end
end