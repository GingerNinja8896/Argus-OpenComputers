GUI = {}

component = require("component")
event = require("event")
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
    table.insert(page.widgets,self)
    return self
end

function GUI.Bar(page,x,y,barWidth,barHeight,barSpace,vertical,bars,getValue)
    local self = {}
    self.draw = DrawBar
    self.x = x
    self.y = y
    self.barWidth = barWidth
    self.barHeight = barHeight
    self.barSpace = barSpace
    self.vertical = vertical
    self.bars = bars
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

function GUI.Border(pos1,pos2,width,colour)
    local self = {}
    self.draw = DrawBorder
    self.x = x
    self.y = y
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
    local filled = math.floor(bar.bars*bar.value+0.5);
    for i=1,filled,1 do
        if bar.vertical then
            gpu.fill(bar.x,(bar.y-i*(bar.barSpace+bar.barHeight))+bar.barHeight,bar.barWidth,bar.barHeight," ")
        else
            --gpu.fill(bar.x+i*(bar.barSpace+bar.barWidth),bar.y,bar.x+i*(bar.barSpace+bar.barWidth)+bar.barWidth,bar.y+bar.barHeight)
        end
    end

end

function DrawButton(button)
    gpu.setBackground(GUI.white)
    gpu.fill(button.x,button.y,button.width,button.height," ")
    if button.centered then x = button.x+(button.width - #button.text)*0.5 else x = button.x+1 end
    gpu.setForeground(GUI.black)
    gpu.set(x,button.y+button.height/2+0.5,button.text)
end

function OnClick(_,address,x,y,button)
    if button ~= 1 then return end
    for _,widget in ipairs(currentPage.widgets) do
        if widget.OnPress ~= nil then
            if x>=widget.x and y>= widget.y and x<=widget.x+widget.width and y <= widget.y + widget.height then
                widget.OnPress()
            end
        end
    end
end

function GUI.Draw()
    for _,widget in ipairs(currentPage.widgets) do
        if widget.getValue ~= nil then widget.value = widget.getValue() end
    end
    GUI.ClearScreen()
    for _,widget in ipairs(currentPage.widgets) do
        widget.draw(widget)
    end
end

function GUI.Close()
    event.cancel(touchEvent)
    gpu.setBackground(GUI.black)
    gpu.setForeground(GUI.white)
    GUI.ClearScreen()
end

touchEvent = event.listen("touch",OnClick)


return GUI
