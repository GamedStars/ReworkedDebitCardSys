require("split")

function contains(name)
    file = io.open("disk/DebitCardInfo.txt", "r")
    for thisLine in file:lines() do
        list = split(thisLine, ",")
        compare = list[1]
        if name == compare and compare ~= nil then
            print("There is a dupe "..compare)
            file:close()
            return true
        elseif compare ~= nil then
            print("No dupe on "..compare)
        end
    end
    io.close(file)
    return false
end