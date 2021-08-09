GUI = {}

local component = require("component")
gpu = component.gpu
w,h = gpu.getResolution()


GUI.black = 0x000000
GUI.white = 0xFFFFFF
GUI.red = 0xFF0000


pages = {}
currentPage = nil

e

function GUI.Label(page,x,y,text,colour,updateFunc)
    local self = {}
    self.draw = DrawLabel
    self.x = x
    self.y = y
    self.text = text
    self.colour = colour
    self.updateFunc = updateFunc
    table.insert(page.widgets,self)
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
    table.insert(page.widgets,self)
    return self
end

function GUI.Button(page,x,y,width,height,text,centered,OnPress)
    local self = {}
    self.draw = DrawButton
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
    self.OnPress = OnPress
    self.centered = centered
    table.insert(page.widgets,self)
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
    if set then GUI.SetPage(self) end
    print(self)
    return self
end
function GUI.ClearScreen()
    gpu.setBackground(GUI.black)
    gpu.fill(1,1,w,h," ")
end

function DrawLabel(label)
    gpu.setBackground(GUI.white)
    gpu.setForeground(label.colour)
    gpu.set(label.x,label.y,label.text)

end

function DrawBar(bar)
    gpu.setBackground(GUI.red)
    local value = bar.getValue()
    gpu.fill(bar.x,bar.y,bar.width*value,bar.height," ")
    gpu.setBackground(GUI.white)
    gpu.fill(bar.x + bar.width*value,bar.y,(1-value)*bar.width,bar.height," ")
end

function DrawButton(button)
    gpu.setBackground(GUI.white)
    gpu.fill(button.x,button.y,button.width,button.height," ")
    if button.centered then local x = (button.width - #button.text)*0.5 else local x = button.x+1 end
    gpu.set(x,button.y/2+0.5,button.text)
end

function OnClick(address,x,y,button)
    if button == nil then return end

    for _,widget in ipairs(widgets) do
        if widget.OnPress ~= nil then
            if x>=widget.x and y>= widget.y and x<=widget.x+widget.width and y <= widget.y + widget.height then
                widget.OnPress()
            end
        end
    end
end

function GUI.Draw()
    UI.ClearScreen()
    for _,widget in ipairs(currentPage.widgets) do
        widget.draw(widget)
    end
end


return GUI
