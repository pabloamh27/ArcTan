; Program: Implementation of atan2
; Team members:
;     Pablo Alberto Muñoz Hidalgo
;     Royner Arturo Miranda Segura
;     Fernando Vega Valerio
; Arquitectura de Computadores - Proyecto II

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE ac_atan2.inc

.data
; Shows the welcome message
welcome BYTE "---------Welcome to arctan function program---------",0Ah
BYTE 0dh,0Ah
BYTE " This program returns a theta value from an x and y coordinate", 0Ah
BYTE 0dh,0Ah
BYTE 0dh,0

x DWORD 0  ; Used to save the x value
y DWORD 0  ; Used to save the y value
option1 DWORD 0

; Shows the options Menu
message1 BYTE " Select the option you want to do: ",0Ah
BYTE "   1. To get theta from x and y values ",0Ah
BYTE "   2. To exit ",0Ah
BYTE 0dh,0Ah
BYTE ">>> ",0

; Request a x value
msgx BYTE "Enter the x value: ", 0

; Request a y value
msgy BYTE "Enter the y value: ", 0


; Shows the result message
msgresult BYTE "The theta value is: ", 0

;Enter for aesthetic
msgenter BYTE " ", 0Ah
BYTE 0dh,0Ah
BYTE 0dh,0

; Exit box messages
title1 BYTE "Exit message",0
question BYTE "Do you really want to exit?"
BYTE 0dh,0
result DWORD 0

; Error message in case that any valid option is selected
errormenu BYTE " The option selected isn't valid ", 0Ah
BYTE 0dh,0
;---------------------------------------------------------------------------------------------------------


.code
main PROC

mov x,-7094
mov y,4096

; Start of the Menu
 Menu:

	 call ClrScr

	 ;Calls the welcome message
	 mov edx, OFFSET welcome
	 call WriteString 

	 ;Calls the options Menu
	 mov edx, OFFSET message1
	 call WriteString 
	 call ReadDec
	 mov option1, eax

	 ;Compares the selected option with the Menu
	 cmp option1, 1
	 jz Atan2
	 cmp option1, 2
	 jz Exitprogram

	 ;Calls the menu error in case that any option is selected
	 mov edx, OFFSET errormenu
	 call WriteString 
	 call WaitMsg
	 jmp Menu
	 ;In case that user selects exit option on menu
	 Exitprogram:

		
		 ;Exit message box in case that option1 isn´t 1
		 mov  ebx,OFFSET title1
		 mov  edx,OFFSET question
		 call MsgBoxAsk
		 mov result, eax

		 ;If the user select "No" option in the box it jumps to the Menu again
		 cmp result, 7
		 jz Menu
		 INVOKE ExitProcess,0
	


	 ;Arctan segment
	 Atan2:
		call ClrScr
		;Calls the atan2 function
		INVOKE ac_atan2, x, y
		; Aesthetic Enter
		mov edx, OFFSET msgenter
		call WriteString 
		
		;Calls the result message
		mov edx, OFFSET msgresult
		call WriteString 
		call WriteInt
		
		; Aesthetic Enter
		mov edx, OFFSET msgenter
		call WriteString 
		call WriteString
		call WaitMsg

		
		;Returns to the Menu
		jmp Menu


main ENDP

END main