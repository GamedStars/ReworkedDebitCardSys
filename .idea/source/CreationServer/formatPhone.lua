function formatPhone(key)
    files = fs.list("disk/")
    for index, file in ipairs(files) do
        shell.run("delete", "disk/"..tostring(file))
    end

    file = io.open("disk/PhoneID.txt","w")
    file:write(key)
    file:close()

    shell.run("copy", "newshop", "/disk")
    shell.run("copy", "startupCopy.lua", "/disk")
    shell.run("rename", "/disk/startupCopy.lua", "/disk/startup.lua")

    print(username..", card added")
end
