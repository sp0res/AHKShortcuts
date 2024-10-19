; system tray
TrayIconFile:="D:\Pictures\! Ico icons\silly.ico" ; set this to the file with the icon

Menu,Tray,Icon,%TrayIconFile%

#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

#IfWinActive ahk_class MozillaWindowClass

; Move to Next Tab (Ctrl + E)
^e::Send ^{Tab}

; Move to Previous Tab (Ctrl + Q)
^q::Send ^+{Tab}

; Reopen Last Closed Tab (Ctrl + Tab)
!Tab::Send ^+t


#IfWinActive
