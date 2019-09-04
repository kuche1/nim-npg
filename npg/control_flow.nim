
from times import epoch_time
import os

var target_fps= 30.0
var target_delay= 1/target_fps
var fps*:float
var dt*:float

proc get_time:float=
    epoch_time()

proc target_frame_rate*(new:float)=
    target_fps= new
    target_delay= 1 / new

template every_frame*(body:untyped)=
    var last_frame= get_time()
    while true:
        
        load_events()
        if quit_signal:
            break
        
        body
        
        update_screen()
        
        let now= get_time()
        let delay= now - last_frame
        if delay < target_delay:
            sleep int( (target_delay - delay)*1000 )
            let now2= get_time()
            let delay2= now2 - last_frame
            last_frame= now2
            fps= 1/delay2
            #dt= (delay2/target_delay)/fps
            dt= (delay2*delay2)/target_delay
        else:
            last_frame= now
            fps= 1/delay
            dt= (delay*delay)/target_delay
        
