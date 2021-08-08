local GUI = {}

local component = require("component")
local gpu = component.gpu
local w,h = gpu.getResolution()

widgets = {}


function GUI.Label(page,x,y,text,colour,updateFunc)
    local self = {}
    self.draw = DrawLabel
    self.x = x
    self.y = y
    self.text = text
    self.colour = colour
    self.updateFunc = updateFunc
    table.insert(page.labels,self)
    return self
end

function GUI.ClearScreen()
    gpu.setBackground(white)
    gpu.fill(1,1,w,h," ")
end

function DrawLabel()
    gpu.setBackground(white)
    gpu.setForeground(label.colour)
    gpu.set(label.x,label.y,label.text)

end

function GUI.Draw()
    for _,widget in ipairs(widgets) do
        widget.draw()
    end
end


return GUI
