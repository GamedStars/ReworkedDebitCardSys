function split(inputstr)
    local t = {}
    for str in string.gmatch(inputstr, "([^,]+)") do
        table.insert(t,str)
    end
    return t
end