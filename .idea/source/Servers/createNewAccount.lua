function createNewAccount(owner, shopName, isShell)
    file = io.open("DebitCardInfo.txt", "a")
    if isShell then
        file:write(shopName..","..tostring(math.random(1000000000)).."0")
    else
        file:write(owner..","..tostring(math.random(1000000000)).."2000")
    end
    file:close()
end