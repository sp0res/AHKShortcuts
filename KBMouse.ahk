; AHK SCRIPT TO ALLOW THE USE OF KEYBOARD KEYS ON THE LEFT SIDE OF THE KEYBOARD IN PLACE OF MOUSE BUTTONS

; <------------------------------------------------------------------------------------------>

; Variable for tracking Left Windows key presses
global winc_presses := 0
global is_dragging := false

; <------------------------------------------------------------------------------------------>

; Map LEFT WIN key to left click or middle click on triple press

LWin::
    ; Check if dragging is already in progress
    if (is_dragging)
    {
        Send, {LButton Down}
        KeyWait, LWin
        Send, {LButton Up}
        is_dragging := false
        return
    }

    ; Check for triple click, if yes, do a middle mouse click
    if (winc_presses > 0) ; SetTimer already started, so we log the keypress instead.
    {
        winc_presses += 1
        if (winc_presses = 3)
        {
            winc_presses := 0
            SetTimer, KeyWinC, Off
            Send, {MButton}
            return
        }
    }
    else
    {
        winc_presses := 1
        SetTimer, KeyWinC, -180 ; Wait 180 ms.
    }

    ; Check for dragging
    MouseGetPos, startX, startY
    KeyWait, LWin, D
    Sleep, 100 ; Allow some time for movement
    MouseGetPos, endX, endY
    if (startX != endX or startY != endY)
    {
        is_dragging := true
        Send, {LButton Down}
        KeyWait, LWin
        Send, {LButton Up}
        is_dragging := false
        winc_presses := 0
    }
return

KeyWinC:
    if (!is_dragging)
    {
        winc_presses := 0
        ; If no triple click, do normal left click
        Send, {LButton Down}
        KeyWait, LWin
        Send, {LButton Up}
    }
return

; <------------------------------------------------------------------------------------------>

; Map alt key to right click

LAlt::
Send, {RButton Down}
KeyWait, LAlt
Send, {RButton Up}
return

; <------------------------------------------------------------------------------------------>
