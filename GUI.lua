GUI = {}

local component = require("component")
gpu = component.gpu
w,h = gpu.getResolution()


GUI.black = 0x000000
GUI.white = 0xFFFFFF
GUI.red = 0xFF0000


pages = {}
currentPage = nil

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

function GUI.Bar(page,x,y,width,height,getValue)
    local self = {}
    self.draw = DrawBar
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.getValue = getValue
    table.insert(page.labels.widgets,self)
    return self
end

function GUI.SetPage(page)
    currentPage = page
end

function GUI.Page(set)
    local self = {}
    self.name = {}
    self.widgets = {}
    table.insert(pages,self)
    if set then SetPage(page) end
    return self
end
function GUI.ClearScreen()
    gpu.setBackground(black)
    gpu.fill(1,1,w,h," ")
end

function DrawLabel()
    gpu.setBackground(white)
    gpu.setForeground(label.colour)
    gpu.set(label.x,label.y,label.text)

end

function DrawBar(bar)
    gpu.setBackground(red)
    local value = bar.getValue()
    gpu.fill(bar.x,bar.y,bar.width*value,bar.height," ")
    gpu.setBackground(white)
    gpu.fill(bar.x + bar.width*value,bar.y,(1-value)*bar.width,bar.height," ")
end

function GUI.Draw()
    for _,widget in ipairs(widgets) do
        widget.draw(widget)
    end
end


return GUI
