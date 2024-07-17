function addNewAccount(owner, balance)
    file = io.open("disk/DebitCardInfo.txt", "a")
    file:write(shopName..","..tostring(math.random(1000000000))..","..balance.."\n")
    file:close()
end