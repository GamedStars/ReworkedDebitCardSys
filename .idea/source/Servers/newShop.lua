require("contains.lua")
require("createNewAccount.lua")

function newShop(shopName, owner, isShell, shopID)
    if isShell and ~contains("DebitCardInfo.txt", shopName) then
        rednet.send(shopID, "There is a shop with this exact name!")
    else

        createNewAccount(shopName, owner, isShell)

        rednet.send(shopID, "Your shop has been added!")
        print("Added "..shopName)
    end
end
