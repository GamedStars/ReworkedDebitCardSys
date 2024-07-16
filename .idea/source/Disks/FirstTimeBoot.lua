--shell.run("cd", "..")
-- This copies all the info from the FirstTimeBoot.lua into the shop
shell.run("copy","/disk/SetupShop.lua", "/")
shell.run("copy","/disk/InventoryManager.lua","/")
shell.run("mkdir startup")
shell.run("copy", "/disk/OnBootup.lua", "/startup")
shell.run("copy","/disk/ShopClient.lua", "/")
shell.run("copy","/disk/runcomm.lua","/")

-- Finding the modem
require("InventoryManager")
peripheral.find("modem",rednet.open)
modem = peripheral.find("modem")

-- Asking the user for their username, it will be stored locally
print(string.rep("-",51))
io.write("Your username? ")
username = io.read()

io.write("Your shop name? ")
shopName = io.read()

io.write("Do you want a separate account for your business? (Y or N) ")
choice = string.lower(io.read())
while choice ~= "n" and choice ~= "y" do
    io.write("Your choices must be (Y or N) ")
    choice = string.lower(io.read())
end

file = io.open("Owner.txt","w")
if choice == "y" then
    isShell = true
    file:write(shopName)
else
    isShell = false
    file:write(username)
end

file:close()

newShopInfo = shopName..","..username..","..isShell.."\n"

rednet.broadcast(newShopInfo, "ForNewShop")
id, message = rednet.receive(nil, 10)

if not id then
    print("Server timeout; Speak to GamedStars")
else
    print(message)
end

