-- Finding the modem
peripheral.find("modem",rednet.open)
modem = peripheral.find("modem")

-- This copies all the info from the FirstTimeBoot.lua into the shop
shell.run("copy","/disk/SetupShop.lua", "/")
shell.run("copy","/disk/InventoryManager.lua","/")

shell.run("mkdir startup")
shell.run("copy", "/disk/OnBootup.lua", "/startup")
shell.run("copy","/disk/ShopClient.lua", "/")
shell.run("copy","/disk/runcomm.lua","/")

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
    file = io.open("DataFiles/ShopOwnerName.txt","w")
    file:write(message)
    file:close()
    print("Shop created successfully!")
else
    print(message)
end


