local gui = require("GUI")
local event = require("event")
local component = require("component")
local computer = require("computer")



page1 = gui.Page(true)

energy_upper_1 = component.proxy("e21f6ec8-78b3-4673-b3ef-98ca38081f2d")
energy_lower_1 = component.proxy("30e613f0-5712-4b07-bd6d-a3372b351510")
energy_upper_2 = component.proxy("4ad7a2a2-f65e-4ba4-8eac-6226f04d999c")
energy_lower_2 = component.proxy("0671c896-f06e-4fbd-a56a-fd95d5ac82ee")


local bar_upper1 = gui.Bar(page1,10,40,10,2,1,true,10,function() return energy_upper_1.getEnergyStored()/energy_upper_1.getMaxEnergyStored()  end)
local button_upper1 = gui.Button(page1,11,44,8,4,"I",true,function() button_upper1.text = "0"  end)

local bar_upper2 = gui.Bar(page1,30,40,10,2,1,true,10,function() return energy_upper_2.getEnergyStored()/energy_upper_2.getMaxEnergyStored()  end)

local bar_lower1 = gui.Bar(page1,120,40,10,2,1,true,10,function() return energy_lower_1.getEnergyStored()/energy_lower_1.getMaxEnergyStored()  end)
local bar_lower2 = gui.Bar(page1,140,40,10,2,1,true,10,function() return energy_lower_2.getEnergyStored()/energy_lower_2.getMaxEnergyStored()  end)

local x = event.listen("interrupted",function() running = false  end)

running = true
while running do
    gui.Draw()
    os.sleep(0.5)
end
gui.Close()
event.cancel(x)
