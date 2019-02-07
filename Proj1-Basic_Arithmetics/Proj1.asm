TITLE Program 1 Basic Arithmetic     (proj1.asm)

; Author: Zach Bishop
; Course / Project ID: CS 271 Program 1                 Date: 1/11/19
; Description: User provides two numbers that are added, multiplied, divided, and subtracted

INCLUDE Irvine32.inc

.data
programTitle			BYTE "Basic Arithmetic by Zach Bishop", 0
prompt					BYTE "Please provide two numbers and I will return the sum, difference, product, quotient, and remainder.", 0
firstNumberPrompt		BYTE "Number One: ", 0
secondNumberPrompt		BYTE "Number Two: ", 0
additionString			BYTE " + ", 0
subtractionString		BYTE " - ", 0
multiplicationString	BYTE " * ", 0
divisionString			BYTE " / ", 0
remainderString			BYTE " remainder ", 0
equalString				BYTE " = ", 0
repeatPrompt			BYTE "Would you like to run the program again? (Yes: 1, No: 0): ", 0 
EC1						BYTE "**EC: Program repeats until the user chooses to quit. ", 0
number1					DWORD ?
number2					DWORD ?
sum						DWORD ?
difference				DWORD ?
product					DWORD ?
quotient				DWORD ?
Result					DWORD ?

remainder				DWORD ?
goodbye					BYTE "Are you not entertained? Bye!"

.code
main PROC

;Program title and EC displayed
	mov  edx, OFFSET programTitle
	call WriteString
	call CrLf
	mov  edx, OFFSET EC1
	call WriteString
	call CrLf
	call CrLf

beginning:

;Intro
	mov  edx, OFFSET prompt
	call WriteString
	call CrLf
	call CrLf

;Collect first number
	mov  edx, OFFSET firstNumberPrompt
	call WriteString
	call ReadInt
	mov  number1, eax

;Collect second number
	mov  edx, OFFSET secondNumberPrompt
	call WriteString
	call ReadInt
	mov number2, eax
	call CrLf

;Calculate results
	;Addition
	mov  eax, number1
	add  eax, number2
	mov  sum, eax

	;Subtraction
	mov  eax, number1
	sub  eax, number2
	mov  difference, eax

	;Multiplication
	mov  eax, number1
	mul  number2
	mov product, eax

	;Division
	mov  eax, number1
	cdq
	div  number2
	mov quotient, eax
	mov  remainder, edx

;Display Results
	;Addition
	mov  eax, number1
	call WriteDec
	mov  edx, OFFSET additionString
	call WriteString
	mov  eax, number2
	call WriteDec
	mov  edx, OFFSET equalString
	call WriteString
	mov  eax, sum
	call WriteDec
	call CrLf

	;Subtraction
	mov  eax, number1
	call WriteDec
	mov  edx, OFFSET subtractionString
	call WriteString
	mov  eax, number2
	call WriteDec
	mov  edx, OFFSET equalString
	call WriteString
	mov  eax, difference
	call WriteDec
	call CrLf

	;Multiplication
	mov  eax, number1
	call WriteDec
	mov  edx, OFFSET multiplicationString
	call WriteString
	mov  eax, number2
	call WriteDec
	mov  edx, OFFSET equalString
	call WriteString
	mov  eax, product
	call WriteDec
	call CrLf

	;Division
	mov  eax, number1
	call WriteDec
	mov  edx, OFFSET divisionString
	call WriteString
	mov  eax, number2
	call WriteDec
	mov  edx, OFFSET equalString
	call WriteString
	mov  eax, quotient
	call WriteDec
	mov  edx, OFFSET remainderString
	call WriteString
	mov  eax, remainder
	call WriteDec
	call CrLf
	call CrLf

;Ask if the user would like to repeat the program
	mov  edx, OFFSET repeatPrompt
	call WriteString
	call ReadInt
	call CrLf
	cmp  eax, 1
	je   beginning

;Goodbye
	mov  edx, OFFSET goodbye
	call WriteString
	call CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
