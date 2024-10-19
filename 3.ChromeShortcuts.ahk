#IfWinActive ahk_class MozillaWindowClass

; Move to Next Tab (Ctrl + E)
^E::	

	Send !+E

return

; Move to Previous Tab (Ctrl + Q)	
^Q::	

	Send !+Q

return

#IfWinActive
	