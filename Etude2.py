#simple way of ,get cursor xy data
#niwantha33@gmail.com
from Tkinter import *
win=Tk()
win.geometry("200x300")
#img = Image.open("image2.jpg")



def xy(event):
    xm, ym = event.x, event.y
    xy_data = "x=%d  y=%d" % (xm, ym)
    lab=Label(win,text=xy_data)
    lab.grid(row=0,column=0)
 
win.bind("<Motion>",xy)
mainloop()
