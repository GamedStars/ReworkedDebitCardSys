-- Finding the modem
require("Packages/ChestManager/setOutputChest")
peripheral.find("modem",rednet.open)
modem = peripheral.find("modem")
path = "Packages/DataFiles/"

-- This copies all the info from the firstboot.lua into the shop

files = fs.list("")
for index, file in ipairs(files) do
    if file ~= "rom" and file ~= "/disk" then
        shell.run("delete "..tostring(file))
    end
end

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

id, message, protocol = rednet.receive(10)
if protocol == "FoundPhoneID" then
    file = io.open(path.."ShopOwnerName.txt","w")
    file:write(message)
    file:close()
    print("Shop created successfully!")
    print("Now that you have created your shop, you will need to setup your shop by setting up an output chest and creating your menu!")
    print("All of this can be done via the ShopClient")
elseif message == nil then
    print("Server Timedout!")
else
    print(message)
end


