require("ChestManager/push")

function doPurchase(total)

    -- Getting the PhoneID
    file = io.open("disk/PhoneID.txt","r")
    for number in file:lines() do
        if number ~= nil then key = number end
    end
    file:close()

    -- Getting the ShopOwnerName
    file = io.open("DataFiles/ShopOwnerName.txt","r")
    for name in file:lines() do
        if name ~= nil then owner = name end
    end
    file:close()

    -- Combining and sending the information the information
    purchaseinfo = tostring(key)..","..owner..","..tostring(total)

    rednet.broadcast(purchaseinfo, "TransferMoney")
    id, message = rednet.receive("PhoneQueryResult", 10)

    if message == nil then
        print("There has been a error in your payment; Contact the owner of the shop or GamedStars")
        monitor.clear()
        monitor.setBackgroundColor(colors.red)
        monitor.clear()
        os.sleep(2)
    elseif string.sub(message,1,12) == "Successfully" then
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