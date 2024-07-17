-- Checks for duplicates in the menu and then returns true if they are the same
-- Notice, the check is for the entire line and not just the item in case of bundle sales.
require("Helpers/split")
function checkMenuDupes(compare)
    file = io.open("ShopMenu.txt", "r")
    line = file:read()
    while line ~= nil do
        list = split(line, ",")
        line = line.."\n"
        if compare == line then
            return true
        end

        line = file:read()
    end
    return false
end