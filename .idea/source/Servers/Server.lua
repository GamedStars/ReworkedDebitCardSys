-- This code should run when we need to handle any operations
-- !!! This code needs to handle the protocols GetBalance, TransferMoney, ForNewShop

modem = peripheral.find("modem")
require("newShop.lua")
require("checkBalance.lua")
require("split.lua")

while true do
    print("Server Online: Waiting for next broadcast.")
    id, message, protocol = rednet.receive()
    if protocol == "GetBalance" then
        print()
    elseif protocol == "TransferMoney" then
        print()
    elseif protocol == "ForNewShop" then
        newShopInfo = split(message, ",")
        newShop(newShopInfo[1], newShopInfo[2], newShopInfo[3], id)
    else
        print(protocol.."Unknown protocol "..protocol.." caught, will let it pass.")
    end

end

