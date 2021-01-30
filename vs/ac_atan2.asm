; Program: Implementation of atan2
; Team members:
;     Pablo Alberto Muñoz Hidalgo
;     Royner Arturo Miranda Segura
;     Fernando Vega Valerio
; Arquitectura de Computadores - Proyecto II

.386
.model flat,stdcall
.stack 4096


INCLUDE ac_atan2.inc

ExitProcess PROTO, dwExitCode:DWORD



.data
theta DWORD 0  ; Used to save the result of atan function
octant DWORD 0  ; Used to save the resultant octant
absx DWORD 0  ; Used to save the absolute of "x" coord
absy DWORD 0  ; Used to save the absolute of "y" coord
x2 DWORD 0  ; Used to save the x**2 operation
y2 DWORD 0  ; Used to save the y**2 operation
Q15_PI DWORD 102944  ; Used to save PI value
Q15_PI_MEDIOS DWORD 51472  ;Used to save PI/2 value
Q15_PI_CUARTOS DWORD 25736  ;Used to save PI/4 value
Q15_PI_TRESCUARTOS DWORD 77208  ;Used to save (PI/4)*3 value
numerador DWORD 0  ; Used to save the x * y operation value
denominador DWORD 0  ; Used to save the denominator operation value
denominador_invertido DWORD 0  ; Used to save the inverted denominator operation value

.code

PUBLIC ac_atan2

ac_atan2 PROC x:DWORD, y:DWORD ;Start of the atan function 
mov theta, 0
mov octant, 0
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
mov denominador_invertido, 0

;The next code lines obtains the absolute value from x, from here...
mov eax, x 
mov edx, 0
cdq 
xor eax, edx
sub eax, edx
mov absx, eax
; ... to here

;The next code lines obtains the absolute value from y, from here...
mov eax, y 
mov edx, 0
cdq 
xor eax, edx
sub eax, edx
mov absy, eax
; ... to here

;The next code lines obtains the x**2 operation result value, from here...
mov eax, absx
imul absx
mov x2, eax
; ... to here

;The next code lines obtains the y**2 operation result value, from here...
mov eax, absy
imul absy
mov y2, eax
; ... to here

;The next code lines obtains the numerator result value, from here...
mov edx, x
mov eax, y 
imul edx
mov numerador, eax
; ... to here

; The next code lines obtains the denominator result value, from here...
mov eax, x2
mov ebx, y2
shr ebx, 2
add eax, ebx
mov ebx, y2
shr ebx, 5
add eax, ebx
shr eax, 15
mov denominador, eax
; ... to here

; The next code lines obtains the inverted denominator result value, from here...
mov eax, y2
mov ebx, x2
shr ebx, 2
add eax, ebx
mov ebx, x2
shr ebx, 5
add eax, ebx
shr eax, 15
mov denominador_invertido, eax
; ... to here

;----------------------------------------------------------------------------------------------------------------------------------------------------
;Get special theta value

mov eax, x
mov edx, y
cmp eax, 0
je X_igual_cero1
jle X_menor_cero1
ja X_mayor_cero1


 X_igual_cero1:
	mov eax, y
	cmp eax, 0
	je Y_igual_cero1
	jle Y_menor_cero1
	ja Y_mayor_cero1
	jmp fin

 Y_igual_cero1:
	mov theta, -1
	ret

 Y_menor_cero1:
	mov eax, Q15_PI_MEDIOS
	mov edx, -1
	imul edx
	mov theta, eax
	ret

 Y_mayor_cero1:
	mov eax, Q15_PI_MEDIOS
	mov theta, eax
	ret

 Y_igual_cero2:
	mov eax, Q15_PI
	mov theta, eax 
	ret

 Y_igual_cero3:
	mov theta, 0
	ret

	
 X_igual_Y1:
	mov eax, Q15_PI_TRESCUARTOS
	mov edx, -1
	imul edx
	mov theta, eax
	ret

 X_igual_Y2:
	mov eax, Q15_PI_CUARTOS
	mov theta, eax
	ret
	
 X_igual_menosY:
	mov eax, Q15_PI_TRESCUARTOS
	mov theta, eax
	ret

 Y_igual_menosX:
	mov eax, Q15_PI_CUARTOS
	mov edx, -1
	imul edx
	mov theta, eax
	ret
	
 X_menor_cero1:
	mov eax, y
	cmp eax, 0
	je Y_igual_cero2
	mov edx, x
	cmp eax, edx
	je X_igual_Y1
	mov eax, y
	mov ebx, -1
	imul ebx
	mov edx, x
	cmp eax, edx
	je X_igual_menosY
	jmp fin

 X_mayor_cero1:
	mov eax, y
	cmp eax, 0
	je Y_igual_cero3
	mov edx, x
	cmp eax, edx
	je X_igual_Y2
	mov eax, x
	mov ebx, -1
	imul ebx
	mov edx, y
	cmp eax, edx
	je Y_igual_menosX
	jmp fin

 fin:

;----------------------------------------------------------------------------------------------------------------------------------------------------
;Get Octant Value

mov eax, x
cmp eax, 0
je igual_que_cero
jle X_menor_que_cero
ja X_mayor_que_cero

 igual_que_cero:
	mov eax, x
	mov ebx, absy
	cmp eax, ebx
	ja octant8
	jmp octant7

 X_mayor_que_cero:
	mov eax, y
	cmp eax, 0
	ja Y_mayor_que_cero1

 Y_mayor_que_cero1:
	mov eax, x
	mov ebx, y
	cmp eax, ebx
	ja octant1
	jmp octant2

 X_menor_que_cero:
	mov eax, y
	cmp eax, 0
	jle Y_menor_que_cero3
	ja Y_mayor_que_cero2

 Y_mayor_que_cero2:
	mov eax, absx
	mov ebx, y
	cmp eax, ebx
	ja octant4
	jmp octant3

 Y_menor_que_cero3:
	mov eax, absx
	mov ebx, absy
	cmp eax, ebx
	ja octant5
	jmp octant6

 octant1:
	mov octant, 1
	jmp fin2

 octant2:
	mov octant, 2
	jmp fin2

 octant3:
	mov octant, 3
	jmp fin2

 octant4:
	mov octant, 4
	jmp fin2

 octant5:
	mov octant, 5
	jmp fin2

 octant6:
	mov octant, 6
	jmp fin2

 octant7:
	mov octant, 7
	jmp fin2

 octant8:
	mov octant, 8
	jmp fin2
 
 fin2:
	

;----------------------------------------------------------------------------------------------------------------------------------------------------
; Get Theta Value from octant

mov eax, octant
cmp eax, 1
je theta1
mov eax, octant
cmp eax, 2
je theta2
mov eax, octant
cmp eax, 3
je theta2
mov eax, octant
cmp eax, 4
je theta3
mov eax, octant
cmp eax, 5
je theta4

mov eax, octant
cmp eax, 8
je theta1

jmp theta5

 theta1:
	mov eax, numerador
	cdq
	mov ebx, denominador
	idiv ebx
	mov theta, eax
	ret

 theta2:
	mov eax, numerador
	cdq
	mov ebx, denominador_invertido
	idiv ebx
	mov ecx, Q15_PI_MEDIOS
	sub ecx, eax
	mov theta, ecx
	ret

 theta3:
	mov eax, numerador
	cdq
	mov ebx, denominador
	idiv ebx
	mov ecx, Q15_PI
	add eax, ecx
	mov theta, eax
	ret

 theta4:
	mov eax, numerador
	cdq
	mov ebx, denominador
	idiv ebx
	mov ecx, Q15_PI
	sub eax, ecx
	mov theta, eax
	ret

 theta5:
	mov eax, numerador
	cdq
	mov ebx, denominador_invertido
	idiv ebx
	mov ecx, Q15_PI_MEDIOS
	mov edx, -1
	imul edx
	sub ecx, eax
	mov theta, ecx
	ret


 INVOKE ExitProcess, 0

 ac_atan2 ENDP

END