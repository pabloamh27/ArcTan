; Program: Implementation of multi function using logical shifts
; Team members:
;     Pablo Alberto Muñoz Hidalgo
;     Royner Arturo Miranda Segura
;     Fernando Vega Valerio
; Arquitectura de Computadores - Proyecto I

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

INCLUDE irvine32.inc

.data

thetar DWORD 0 ; Used to save the result of atan function
octantr DWORD 0 ; Used to save the resultant octant
absx DWORD 0  ; Used to save the absolute of "x" coord
absy DWORD 0  ; Used to save the absolute of "y" coord
x2 DWORD 0  ; Used to save the x**2 operation
y2 DWORD 0  ; Used to save the y**2 operation
Q15_PI DWORD 102944  ;Used to save PI value
Q15_PI_MEDIOS DWORD 51472 ;Used to save PI/2 value
Q15_PI_CUARTOS DWORD 25736 ;Used to save PI/4 value
Q15_PI_TRESCUARTOS DWORD 77208  ;Used to save (PI/4)*3 value
numerador DWORD 0  ; Used to save the x * y operation value
denominador DWORD 0  ; Used to save the denominator operation value
denominador_invertido DWORD 0  ; Used to save the inverted denominator operation value

.code

PUBLIC ac_atan2

ac_atan2 PROC x:DWORD, y:DWORD ; Start of function
mov thetar, 0
mov octantr, 0
mov absx, 0
mov absy, 0
mov x2, 0
mov y2, 0
mov Q15_PI, 102944
mov Q15_PI_MEDIOS, 51472
mov Q15_PI_CUARTOS, 25736
mov Q15_PI_TRESCUARTOS, 77208
mov numerador, 0
mov denominador, 0
mov demoniador_invertido, 0





 INVOKE ExitProcess, 0

ac_atan2 ENDP

END