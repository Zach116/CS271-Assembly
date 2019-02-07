TITLE Program 2 Fibonacci Calculation     (proj2.asm)

; Author: Zach Bishop
; Course / Project ID  CS 271 Program 2               Date: 1/18/19
; Description: User provides how many Fibonacci numbers they would like calculated and displayed. The program then calculates and displayes that many numbers in the Fibonacci sequence

INCLUDE Irvine32.inc

MAX_TERMS			equ	46		
MAX_USERNAME_SIZE	equ 80

.data

programTitle		BYTE	"Fibonacci Calculation by Zach Bishop", 0
namePrompt			BYTE	"Hi user! What is your name? ", 0
username			BYTE	81 DUP(?)
greeting			BYTE	"Nice to meet you ", 0
termsPrompt			BYTE	"Please enter how many Fibonacci numbers you would like to be displyed. (Must be between 1-46): ", 0
notValid			BYTE	"Sorry but that is not a valid input! Please make sure that you enter any number between 1 and 46!", 0
spaces				BYTE	"     ", 0
goodbye1			BYTE	"Are you not entertained ", 0
goodbye2			BYTE	"? Bye!",0
terms				DWORD	?
number1				DWORD	0
number2				DWORD	1
counter				DWORD	0

.code
main PROC

;Program title displayed
	mov		edx, OFFSET programTitle
	call	WriteString
	call	CrLf
	call	CrLf

;Collect user's name and greet
	mov		edx, OFFSET namePrompt
	call	WriteString
	mov		edx, OFFSET username
	mov		ecx, MAX_USERNAME_SIZE	;The size that the string can be (1 less than the buffer size)
	call	ReadString
	mov		edx, OFFSET greeting
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	CrLf
	call	CrLf

;Collect the number of Fibonacci terms to display
term_collection:
	mov		edx, OFFSET termsPrompt
	call	WriteString
	call	ReadInt
	mov		terms, eax	

;Validate the number of terms given
	cmp		terms, 1
	jl		not_valid
	cmp		terms, MAX_TERMS
	jg		not_valid
	jmp		pre_calculation

;Display the not valid message then jump back to collect a new number of Fibonacci numbers to display
not_valid:
	mov		edx, OFFSET notValid
	call	WriteString
	call	CrLf
	call	CrLf
	jmp		term_collection

;Calculate and display the requested number of Fibonacci numbers 
pre_calculation:
	mov		ecx, terms
calculation:
	;Calculates the "future number", the one that will be printed on the next iteration
	mov		eax, number1
	add		eax, number2

	;Stores the current number in the sequence that still needs to be displayed and is needed to calculate the next "future number""
	mov		ebx, number2
	mov		number1, ebx

	;Stores the "future number", the one that will be printed on the next iteration
	mov		number2, eax

	;Prints the current number
	mov		eax, number1
	call	WriteDec
	mov		edx, OFFSET spaces
	call	WriteString

	;Check if a new line is needed
	inc		counter
	cmp		counter, 5
	jne		no_new_line
	call	CrLf
	mov		counter, 0

no_new_line:
	loop	calculation

;Say goodbye
	call	CrLf
	mov		edx, OFFSET goodbye1
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	mov		edx, OFFSET goodbye2
	call	WriteString
	call	CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
