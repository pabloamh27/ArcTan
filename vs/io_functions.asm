; Program: Implementation of multi function using logical shifts
; Team members:
;     Pablo Alberto Muñoz Hidalgo
;     Royner Arturo Miranda Segura
;     Fernando Vega Valerio
; Arquitectura de Computadores - Proyecto II

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
x DWORD 0 ; Used to save the x value
y DWORD 0 ; Used to save the y value

inputFileHandler DWORD ?
inputBufer DWORD TAM_BUFER DUP(?)
inputFileName BYTE "C:\Users\royne\OneDrive\Escritorio\TEC\II semestre\Arqui\input_data.txt",0


.code
io_functions PROC
;----------------------opening file----------------------
 mov edx, OFFSET inputFileName            ;for the OpenInputFile call (edx = input file name)
 call OpenInputFile                        ;open file (eax = file handler)
 mov inputFileHandler,eax                ;moves the file handler to its respective variable

 cmp eax,INVALID_HANDLE_VALUE            ;checks any error on the file opening
 je error

;----------------------reading file----------------------
 xor edx,edx                                ;clear edx
 mov edx,OFFSET inputBufer                ;for the ReadFromFile call (edx = input file information)
 mov ecx, TAM_BUFER                        ;size of the bufer with the info
 call ReadFromFile
 jc error                                ;checks any error on the file reading

 cmp eax,TAM_BUFER   

 INVOKE ExitProcess, 0

 io_functions ENDP

END io_functions