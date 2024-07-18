function addNewAccount(owner, balance)
    file = io.open("disk/DebitCardInfo.txt", "a")
    key = tostring(math.random(1000000000))
    file:write(shopName..","..key..","..balance.."\n")
    file:close()
    return key
end