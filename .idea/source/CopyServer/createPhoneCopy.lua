require("formatPhone")

modem = peripheral.find("modem",rednet.open)

print(string.rep("-",51))
print("THIS SCREEN SHOULD ONLY BE USED BY MODERATORS")
print()
io.write("What is the client's username? ")
username = io.read()

rednet.broadcast(username, "CreateCopy")
id, key = rednet.receive(10)

-- There is optimazation here where the return is false and not nil
if key == false  then
    print("This person does not have a card registered!")
elseif key == nil then
    print("Request timeout")
else
    formatPhone(key)
end
