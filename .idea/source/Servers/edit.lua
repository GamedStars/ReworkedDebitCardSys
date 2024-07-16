function edit(linenumber, content)
    file = io.open("disk/DebitCardInfo.lua","r")
    fileContent = {}
    for line in file:lines() do
        table.insert(fileContent, line)
    end
    file:close()

    fileContent[linenumber] = content

    file = io.open("disk/DebitCardInfo.lua","w")
    for index, value in ipairs(fileContent) do
        file:write(value.."\n")
    end
    file:close()
end