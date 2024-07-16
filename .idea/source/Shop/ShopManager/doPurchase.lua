function doPurchase(total)
    file = io.open("disk/CardInfo","r")
    for number in file:lines() do
        if number ~= nil then key = number end
    end
    file:close()
    file = io.open("Owner.txt","r")
    for name in file:lines() do
        if name ~= nil then owner = name end
    end
    customer = disk.getLabel(peripheral.getName(drive))
    purchaseinfo = customer..","..owner..","..tostring(total)..","..tostring(key)
    rednet.broadcast(purchaseinfo, "MakePayment")
    id, message = rednet.receive(nil, 10)
    if message == nil then
        print("There has been a error in your payment; Contact the owner of the shop or GamedStars")
        monitor.clear()
        monitor.setBackgroundColor(colors.red)
        monitor.clear()
        os.sleep(2)
    elseif message == true then
        print("Payment Successful!")
        clearAll()
        monitor.clear()
        monitor.setBackgroundColor(colors.green)
        monitor.clear()
        for itemname1, amount1 in pairs(basket) do
            push(itemname1,amount1)
        end
        os.sleep(2)
    else
        print(message)
        monitor.clear()
        monitor.setBackgroundColor(colors.red)
        monitor.clear()
        os.sleep(2)
    end
end