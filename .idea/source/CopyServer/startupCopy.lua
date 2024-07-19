modem = peripheral.find("modem",rednet.open)

-- MAIN --
while true do

    -- Prettyprinting
    io.write(string.rep("-",26))
    print("1. To transfer money, type transfer")
    print("2. To transfer money, type balance or bal")
    choice = string.lower(io.read())
    io.write(string.rep("-",26))
    print()

    -- Gets the ID
    file = io.open("PhoneID.txt","r")
    for line in file:lines() do
        if line ~= nil then
            idnumber = tostring(line)
        end
    end
    file:close()

    -- Transfers the money based on the name given
    if choice == "transfer" then
        print("Who do you wish to transfer the money to?")
        recipient = io.read()
        print()
        print("How much money?")
        amount = io.read()
        print()
        rednet.broadcast(idnumber..","..recipient..","..amount,"TransferMoney")

    -- Checks balance
    elseif choice == "bal" or choice == "balance" then
        rednet.broadcast(idnumber,"GetBalance")
    end

    -- If either option has been picked then we await a confirmation message
    if choice == "bal" or choice == "balance" or choice == "transfer" then
        id, message = rednet.receive("PhoneQueryResult")
        print(message)
        print()
    end
end

