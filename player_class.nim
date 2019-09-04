
import npg/npg

type Player* = object
    x*,y*:float
    dx*,dy*:float
    center_x*,center_y*:float
    speed*:float
# movement
proc dec_x*(s:var Player)=
    s.x -= dt*s.speed
    if s.x < 0: s.x= 0
    s.center_x= s.x + (s.dx/2)
proc inc_x*(s:var Player)=
    s.x += dt*s.speed
    if s.x + s.dx > 1000: s.x= 1000.0 - s.dx
    s.center_x= s.x + (s.dx/2)
proc dec_y*(s:var Player)=
    s.y -= dt*s.speed
    if s.y < 0: s.y= 0
    s.center_y= s.y + (s.dy/2)
proc inc_y*(s:var Player)=
    s.y += dt*s.speed
    if s.y + s.dy > 1000: s.y= 1000.0 - s.dy
    s.center_y= s.y + (s.dy/2)
# drawing
proc draw*(s:var Player)= 
    square green,s.x,s.y,s.dx,s.dy

