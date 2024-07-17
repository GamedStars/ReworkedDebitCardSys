-- This function takes the shopMenu and edits the linenumber with the content
function edit(linenumber, content)
    file = io.open("ShopMenu.txt", "r")
    fileContent = {}
    for line in file:lines() do
        table.insert(fileContent, line)
    end
    file:close()

    fileContent[linenumber] = content

    file = io.open("ShopMenu.txt", "w")
    for index, value in ipairs(fileContent) do
        file:write(value.."\n")
    end
    file:close()
end