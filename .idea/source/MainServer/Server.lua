-- This code should run when we need to handle any operations
-- !!! This code needs to handle the protocols GetBalance, TransferMoney, ForNewShop

modem = peripheral.find("modem", rednet.open)
require("Helpers/newShop")
require("Helpers/checkBalance")
require("Helpers/split")
require("Helpers/transfer")
require("Creation/addNewAccount")

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
    elseif protocol == "CreateAccount" then
        info = split(message, ",")
        key = addNewAccount(split[1], split[2])
        rednet.send(id, tostring(key))
    else
        print(protocol.."Unknown protocol "..protocol.." caught, will let it pass.")
    end
end

