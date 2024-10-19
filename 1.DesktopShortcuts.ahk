; Setup
#SingleInstance force
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.

; system tray
TrayIconFile:="D:\Pictures\! Ico icons\silly.ico" ; set this to the file with the icon
Menu,Tray,Icon,%TrayIconFile%

TrayTip:="Alt+Tab To Pause Desktop Shortcuts"
Menu,Tray,Tip,%TrayTip%

; click drag settings
swap := false
horiz := false 				; use horizontal movement as input
k := 1						; scroll speed coefficient (higher k means higher speed)

scrollsLimit := 36			; max amount of scroll at once
S := 18						; unit distance (higher S = lower speed)
T := 15					; scan frequency in MS (

dy := 0
dyTotal := 0
scrollsTotal := 0

running := 0

; #region mouse drag detection

loop ; #if running
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

; mouse drag detection

; RIGHT CLICK drag scroll

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

SetTitleMatchMode,2

return

!RButton:: ; Alt + Right click quick save 1


	Sleep, 80

	Send {rbutton}

	Sleep, 740
	send {v}
	WinWaitActive, Save, , 5

	ControlgetText, Filename, , Save

	ControlSetText, , O:\!023811737\LEAK6564561\!!bestleak\%FileName%, Save

	ControlClick , &Save, Save, , , , NA

return

!LButton:: ; Alt + Left click quick save 2

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

; other shortcuts

/*
LWIN middle mouse click
CTRL + SHIFT E open explorer window
CTRL + SHIFT W close explorer window
*/

~LShift:: ; Map left shift to Middle Click
	KeyWait LShift ;and use keywait on keys that autorepeat when held
	If (A_TimeSincePriorHotkey<365) and (A_PriorHotkey="~LShift")
		Send, {MButton Down}
	Sleep, 20
	Send, {MButton Up}
Return

#IfWinActive ahk_class CabinetWClass ; Ctrl + Shift + W to restart current Windows Explorer window
	^+w:: 
		WinClose, A

		Sleep, 20

		Run, explorer.exe
	return
#IfWinActive

^+e:: ; Ctrl + Shift + E to open a new window
	Run, explorer.exe
return

; --------------------------------------------------------

!Tab::Suspend  ; Alt+Tab
