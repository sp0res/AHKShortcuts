; #region mouse drag detection

#SingleInstance force
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.

running := 0

; === User settings ===

swap := false

horiz := false 				; use horizontal movement as input

k := 1						; scroll speed coefficient (higher k means higher speed)

; === Internal settings ===
scrollsLimit := 36			; max amount of scroll at once
S := 18						; unit distance (higher S = lower speed)
T := 15					; scan frequency in MS (

; ==============

dy := 0
dyTotal := 0
scrollsTotal := 0

; #if running
loop
{
	sleep %T%

	if (running) {
		; mousegetpos, mx						; get current mouse position
		mousegetpos, mx, my						; get current mouse position
		if (horiz = 0) {
			dy := k * (my - myLast)						; relative mouse movement vertical
			myLast := my									; save position
		} else {
			dy := k * (mx - mxLast)						; relative mouse movement horizontal
			mxLast := mx									; save position
		}
		dyTotal := dyTotal + dy
		scrolls := dyTotal // S
		dyTotal := dyTotal - scrolls * S					; calculate remainder after division
		direction := (scrolls >= 0) ^ swap				; get direction
		scrollsN := abs(scrolls)
		scrollsTotal := scrollsTotal + scrollsN
		n := min(scrollsN, scrollsLimit)
		; tooltip,  %scrolls% -- %dy%
		if (direction = 1)
			send, {wheeldown %n%}
		if (direction = 0)
			send, {wheelup %n%}
	}
}
; #endregion mouse drag detection

; #region RIGHT CLICK drag scroll
rbutton::
	running := 1
	dyTotal := 0
	mousegetpos, mxLast, myLast
return

rbutton up::
	running := 0
	if (scrollsTotal = 0)
		send {rbutton}
	scrollsTotal := 0
return

; #endregion

; #region CTRL + RIGHT CLICK quick save

SetTitleMatchMode,2


return

^RButton::

	Sleep, 80

	Send {rbutton}

	Sleep, 400
	send {v}
	WinWaitActive, Save, , 5
	
	ControlgetText, Filename, , Save
	
	ControlSetText, , O:\!023811737\LEAK6564561\!!bestleak\%FileName%, Save
	
	ControlClick , &Save, Save, , , , NA
	
return

^LButton::

	Sleep, 80

	Send {rbutton}

	Sleep, 400
	send {v}
	WinWaitActive, Save, , 5
	
	ControlgetText, Filename, , Save
	
	ControlSetText, , O:\!023811737\!!\%FileName%, Save
	
	ControlClick , &Save, Save, , , , NA
	
return

return
; #endregion CTRL + RIGHT CLICK quick save

; #region other shortcuts 
/* 
LWIN middle mouse click
CTRL + SHIFT E open explorer window
CTRL + SHIFT W close explorer window
*/ 

; Map left shift to Middle Click
LWin::
	Send, {MButton Down}
	KeyWait, LShift
	Send, {MButton Up}
return

; Close the current Windows Explorer window
#IfWinActive ahk_class CabinetWClass
	^+w:: ; Ctrl + Shift + W to close the window
		WinClose, A
	return
#IfWinActive

; Open a new Windows Explorer window
^+e:: ; Ctrl + Shift + E to open a new window
	Run, explorer.exe
return

; #endregion other

