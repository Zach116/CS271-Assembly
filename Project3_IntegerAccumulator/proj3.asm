TITLE Program 3 Integer Accumulator     (proj3.asm)

; Author: Zach Bishop
; Course / Project ID  CS 271 Program 3               Date: 1/25/19
; Description: Sum all negative numbers entered by the user and calculate the rounded average

INCLUDE Irvine32.inc

LOWER_BOUND		equ -100
MAX_USERNAME_SIZE	equ 80

.data

programTitle		BYTE	"Integer Accumulator by Zach Bishop", 0
namePrompt			BYTE	"Hi user! What is your name? ", 0
username			BYTE	81 DUP(?)
greeting			BYTE	"Nice to meet you ", 0
instructions		BYTE	"Please enter as many negative numbers as you want. Must be between [-100, -1] inclusive. Enter a non-negative number to stop: ", 0
numberPrompt		BYTE	". Enter number: ", 0
notValid			BYTE	"Sorry but that is not a valid input! Please make sure that you enter any number between -100 and -1 inclusive!", 0
countMessage1		BYTE	"You entered ", 0
countMessage2		BYTE	" valid numbers", 0
sumMessage			BYTE	"The sum of all valid numbers is ", 0
averageMessage		BYTE	"The rounded average of all valid numbers is ", 0
specialMessage		BYTE	"You never entered any negative numbers! That means there are no results to display!", 0
goodbye1			BYTE	"Are you not entertained ", 0
goodbye2			BYTE	"? Bye!",0
EC1					BYTE    "**EC: Lines numbered during user input", 0
count				SDWORD	0
sum					SDWORD	0

.code
main PROC

; Display program title and name
	mov		edx, OFFSET programTitle
	call	WriteString
	call	CrLf
	mov		edx, OFFSET EC1
	call	WriteString
	call	CrLf
	call	CrLf

; Collect user's name and greet
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

; Give the user instructions
	mov		edx, OFFSET instructions
	call	WriteString
	call	CrLf

; Collect numbers
number_collection:
	mov		eax, count
	inc		eax
	call	WriteDec
	mov		edx, OFFSET numberPrompt
	call	WriteString
	call	ReadInt

; Check if the number entered is between -100 and -1. Collect more numbers if it is, display an error and ask for more numbers if its less than -100, or stop asking if it is non-negative
	cmp		eax, -1				
	jg		display_results		; Jump if non-negative
	cmp		eax, LOWER_BOUND			
	jl		invalid_number		; Jump if less than -100
	inc		count				; Otherwise up count and add the number to sum, then jump to ask for a new number
	add		sum, eax
	jmp		number_collection

; Display an error for invalid_number
invalid_number:
	mov		edx, OFFSET notValid
	call	WriteString
	call	CrLf
	jmp		number_collection

; Display the results
display_results:
	call	CrLf
	cmp		count, 0	; If no negative numbers were entered, display a special message
	je		special_message

	; Display number of valid numbers entered
	mov		edx, OFFSET countMessage1
	call	WriteString
	mov		eax, count
	call	WriteDec
	mov		edx, OFFSET countMessage2
	call	WriteString
	call	CrLf

	; Display sum results
	mov		edx, OFFSET sumMessage
	call	WriteString
	mov		eax, sum
	call	WriteInt
	call	CrLf

	; Display average results
	mov		edx, OFFSET averageMessage
	call	WriteString
	mov		eax, sum
	cdq
	idiv	count
	call	WriteInt
	call	CrLf

	jmp		goodbye

special_message:
	mov		edx, OFFSET	specialMessage
	call	WriteString
	call	CrLf

; Say goodbye
goodbye:
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
