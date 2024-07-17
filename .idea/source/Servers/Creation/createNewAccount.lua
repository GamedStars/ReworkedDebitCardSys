require("addNewAccount")

print(string.rep("-",51))
print("\nTHIS SCREEN SHOULD ONLY BE USED BY MODERATORS\n")

io.write("What is the client's username? ")
username = io.read()

io.write("\nIs this a business account (Y or N)?")
choice = string.lower(io.read())
while choice ~= "n" and choice ~= "y" do
    io.write("Your choices must be (Y or N) ")
    choice = string.lower(io.read())
end

if choice == "y" then
    addNewAccount(username, "0")
else
    addNewAccount(username, "2000")
end