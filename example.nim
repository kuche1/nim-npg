
import npg/npg

import player_class


proc main* =
    set_resolution 800,600
    target_frame_rate 30.0
    set_font "Nimbus Sans"
    set_font_size 20
    set_font_antialiasing true
    
    var p= Player()
    p.dx= 20
    p.dy= 20
    p.speed= 200
    
    every_frame:
        for k in keydowns:
            case k
            of k_esc:
                send_quit_signal()
            else: discard
        
        if k_a in pressed: p.dec_x
        if k_d in pressed: p.inc_x
        
        if k_w in pressed: p.dec_y
        if k_s in pressed: p.inc_y
        
        
        
        fill_screen white
        p.draw()
        print($fps,red,0,0)
        print($p.center_x,red,0,20)
        print($mousex,red,0,40)

when is_main_module:
    main()
