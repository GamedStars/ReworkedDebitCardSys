require("Packages/MenuManager/shopMenuWrite")
require("Packages/MenuManager/shopMenuRemove")
require("Packages/MenuManager/shopMenuAdd")
require("Packages/ChestManager/setOutputChest")
require("Packages/ShopManager/startService")

run = true
while run do
    io.write(string.rep("-",19))
    io.write(" MENU OPTIONS ")
    print(string.rep("-",18))
    print("1. Write a new menu")
    print("2. Remove an item from the menu")
    print("3. Add an item to the menu")
    print("4. Set new output chest")
    print("5. Start shop service")
    print("6. Exit")

    print()
    io.write("Which option do you want? ")
    choice = tostring(io.read())
    print()

    while tonumber(choice) > 6 or tonumber(choice) < 1 do
        io.write("Your choice must be (1 to 6 inclusive) ")
        choice = string.lower(io.read())
    end

    if choice == "1" then
        shopMenuWrite()
    elseif choice == "2" then
        shopMenuRemove()
    elseif choice == "3" then
        shopMenuAdd()
    elseif choice == "4" then
        setOutputChest()
    elseif choice == "5" then
        startService()
    else
        run = false
    end
    print()
end