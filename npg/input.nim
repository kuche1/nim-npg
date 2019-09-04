
import strutils

const
    k_esc* =27
    k_a* =97
    k_d* =100
    k_s* =115
    k_w* =119
    k_z* =122
    k_up* =273
    k_down* =274
    k_right* =275
    k_left* =276

var keydowns*, keyups*, pressed*: seq[int]
var mousex*,mousey*:int
var quit_signal= false

proc send_quit_signal* =
    quit_signal= true

proc load_events=
    keydowns = @[]
    keyups= @[]
    for event in pg.event.get():
        let eve= ($event)[7 .. ^4]
        case eve[0]
        of '1':
            case eve[1]
            of '-':#active event
                discard
            of '2':#quit
                send_quit_signal()
            else:
                echo eve
        of '2':#key down
            let e= eve[32 .. ^1]
            let start= e.find(' ')
            if unlikely(start == -1):
                echo eve
                quit()
            let end_at= e.find(',')
            if unlikely(end_at == -1):
                echo eve
                quit()
            let key= parse_int e[(start+1) ..< end_at]
            keydowns.add key
            pressed.add key
        of '3':#key up
            let e= eve[16 .. ^1]
            let end_at= e.find(',')
            if unlikely(end_at == -1):
                echo eve
                quit()
            let key= parse_int e[0 ..< end_at]
            keyups.add key
            pressed.del pressed.find key
        of '4':#mouse motion
            let e= eve[23 .. ^50]
            let x_end= e.find(',')
            if unlikely(x_end == -1):
                echo eve
                quit()
            mousex= parse_int e[0 ..< x_end]
            let e2= e[(x_end+2) .. ^1]
            let y_end= e2.find(')')
            if unlikely(y_end == -1):
                echo eve
                quit()
            mousey= parse_int e2[0 ..< y_end]
        of '5':#mouse button down
            discard
        of '6':#mouse button up
            discard
        else:
            echo eve

