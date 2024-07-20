path = "Packages/DataFiles/"

function findOutputChest()
    outputChest = nil
    file = io.open(path.."ChestInfo.txt","r")
    for line in file:lines() do
        if line ~= nil then
            outputChest = peripheral.wrap(line)
        end
    end
    file:close()
    return outputChest
end