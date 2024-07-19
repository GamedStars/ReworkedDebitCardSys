require("Packages/ShopManager/startService")

modem = peripheral.find("modem", rednet.open)
startService()
