require("formatPhone")
modem = peripheral.find("modem",rednet.open)

print(string.rep("-",51))

io.write("What is the client's username? ")
username = io.read()

rednet.broadcast(username..",".."0", "CreateAccount")
id, key = rednet.receive(10)
if key == false then
    print("Card not added, username already there!")
else
    formatPhone(key)
end


