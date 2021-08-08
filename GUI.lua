GUI = {}

local component = require("component")
gpu = component.gpu
w,h = gpu.getResolution()

GUI.black = 0x000000
GUI.white = 0xFFFFFF


pages = {}

function GUI.Label(page,x,y,text,colour,updateFunc)
    local self = {}
    self.draw = DrawLabel
    self.x = x
    self.y = y
    self.text = text
    self.colour = colour
    self.updateFunc = updateFunc
    table.insert(page.labels.widgets,self)
    return self
end

function GUI.Page()
    local self = {}
    self.name = {}
    self.widgets = {}
    table.insert(pages,)
    return self
end
function GUI.ClearScreen()
    gpu.setBackground(GUI.black)
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
