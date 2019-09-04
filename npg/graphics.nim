
import tables

import nimpy

const
    green* =[0,255,0]
    red* =[255,0,0]
    white* =[255,255,255]

let pg= py_import("pygame")
var scr:PyObject

var resx= 800
var resy= 600
var float_resx= float(resx)
var float_resy= float(resy)

var fonts:Table[(string,int), PyObject]
var font_name= "Nimbus Sans"
var font_size= 20
var font_antialiasing= true

# setters

proc set_resolution*(x,y:int)=
    scr= pg.display.set_mode (x,y)
    resx= x
    resy= y
    float_resx= float(x)
    float_resy= float(y)
    
proc set_font*(new:string)=
    font_name= new
    
proc set_font_size*(new:int)=
    font_size= new
    
proc set_font_antialiasing*(new:bool)=
    font_antialiasing= new

# drawing

proc fill_screen*(color:array[3,int])=
    discard scr.fill color

proc update_screen=
    discard pg.display.flip()
    
# text

proc print*(txet:string, color:array[3,int], x,y:int, font=font_name, size=font_size, antialiasing=font_antialiasing)=
    once:
        discard pg.font.init()
    let name_and_size= (font,size)
    if likely(name_and_size in fonts):
        let cur_font= fonts[name_and_size]
        let text_surface= cur_font.render(txet, antialiasing, color)
        discard scr.blit(text_surface,(x,y))
    else:
        fonts[name_and_size] = pg.font.SysFont(font, size)
        

# square

proc raw_square(color:array[3,int], x,y,dx,dy:int)=
    discard pg.draw.rect(scr,color,(x,y,dx,dy))

proc square*(color:array[3,int], x,y,dx,dy:int)=
    let rx= (resx * x) div 1000
    let ry= (resy * y) div 1000
    let rdx= (resx * dx) div 1000
    let rdy= (resy * dy) div 1000
    raw_square color,rx,ry,rdx,rdy

proc square*(color:array[3,int], x,y:float, dx,dy:int)=
    let rx= int( (float_resx*x)/1000 )
    let ry= int( (float_resy*y)/1000 )
    let rdx= (resx*dx) div 1000
    let rdy= (resy*dy) div 1000
    raw_square color,rx,ry,rdx,rdy
    
proc square*(color:array[3,int], x,y,dx,dy:float)=
    let rx= int( (float_resx*x)/1000 )
    let ry= int( (float_resy*y)/1000 )
    let rdx= int( (float_resx*dx)/1000 )
    let rdy= int( (float_resy*dy)/1000 )
    raw_square color,rx,ry,rdx,rdy
