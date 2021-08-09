local gui = require("GUI")

page1 = gui.Page(true)

gui.Label(page1,1,1,"hey",gui.black)
gui.Bar(page1,10,10,10,4,function() return 0.6  end)
test = gui.Button(page1,20,20,8,4,"click",true,function()  test.text = "good" end)
gui.Draw()