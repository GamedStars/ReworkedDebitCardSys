-- Finding the modem
require("Packages/ChestManager/setOutputChest")
peripheral.find("modem",rednet.open)
modem = peripheral.find("modem")

-- This copies all the info from the firstboot.lua into the shop
shell.run("copy","/disk/newshop/Packages/", "/")
shell.run("copy","/disk/newshop/startup.lua", "/")
shell.run("copy","/disk/newshop/ShopClient.lua", "/")

file = io.open("disk/PhoneID.txt","r")
for line in file:lines() do
    if line ~= nil then
        phoneID = tonumber(line)
        break
    end
end
file:close()

rednet.broadcast(phoneID, "ForNewShop")

id, message, protocol = rednet.receive()
if protocol == "FoundPhoneID" then
    file = io.open("Packages/DataFiles/ShopOwnerName.txt","w")
    file:write(message)
    file:close()
    print("Shop created successfully!")
    result = setOutputChest()
    while not result do
        print("Trying again...")
        result = setOutputChest()
    end
else
    print(message)
end


