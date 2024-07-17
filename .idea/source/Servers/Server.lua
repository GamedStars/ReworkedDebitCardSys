-- This code should run when we need to handle any operations
-- !!! This code needs to handle the protocols GetBalance, TransferMoney, ForNewShop

modem = peripheral.find("modem", rednet.open)
require("newShop")
require("checkBalance")
require("split")
require("transfer")

print(string.rep("-",51))
while true do
    print("Server Online: Waiting for next broadcast.")
    id, message, protocol = rednet.receive()
    print("Received "..protocol)
    if protocol == "GetBalance" then
        checkBalance(message, id)
    elseif protocol == "TransferMoney" then
        info = split(message, ",")
        transfer(info[1], info[2], info[3], id)
    elseif protocol == "ForNewShop" then
        newShop(message, id)
    else
        print(protocol.."Unknown protocol "..protocol.." caught, will let it pass.")
    end
end

