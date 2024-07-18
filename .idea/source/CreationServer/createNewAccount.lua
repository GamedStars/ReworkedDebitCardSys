modem = peripheral.find("modem",rednet.open)

print(string.rep("-",51))
print("\nTHIS SCREEN SHOULD ONLY BE USED BY MODERATORS\n")

io.write("What is the client's username? ")
username = io.read()

rednet.broadcast(username..",".."0", "CreateAccount")
id, key = rednet.receive()

file = io.open("disk/PhoneID.txt","w")
file:write(key)
file:close()

shell.run("copy", "newshop", "/disk")
shell.run("copy", "startup.lua", "/disk")
