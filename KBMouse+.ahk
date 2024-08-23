; AHK SCRIPT TO ALLOW THE USE OF LEFT SHIFT AS MIDDLE MOUSE CLICK AND THE USE OFRIGHT MOUSE CLICK TO SCROLL BY DRAGGING A CLICK.

; <------------------------------------------------------------------------------------------>

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

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

; +esc:: ExitApp

; Map left shift to Middle Click
LShift::
Send, {MButton Down}
KeyWait, LShift
Send, {MButton Up}
return

; <------------------------------------------------------------------------------------------>
