/*

toufiq5.m
Author: Sheehan Toufiq
Account: stoufig1
Class: CSC 3210
Assignment #5

*/
.data
.align 4
prompt: .asciz "Enter in a string of maximum 30 characters: \n"
nopali: .asciz "The string is not a palindrome\n"
yespali: .asciz "The string is a palindrome\n"  
cformat: .asciz "%c"
format: .asciz "%s"
printLength: .asciz "The string has %d characters\n"
input: .asciz "                "
respond: .asciz "Your word is %s\n"
continue: .asciz "\nWould you like to try another entry? [y/n]\n"
input2: .asciz " "
charString: .asciz "Please enter a character: \n"
printnum: .asciz "The character occurs %d times\n"
strlength_s=-4
.text

	.align 4
	.global main 
	
main:
	save %sp, (-96) & -8, %sp
	
	set prompt, %o0				
	call printf				!"Enter a word"
	mov 0, %l0!delete this

	set format, %o0
	sethi %hi(input), %o1
	call scanf
	or %o1, input, %o1
	call CountChar
	nop

settingIndex:
	add %o1, %l2, %o3		!pointer to the end of the string: points to 0 byte
	sub %o3, 1, %o3			!fixing the fencepost error, now points to last char in string
	ld [%fp + strlength_s], %o4
			 

	call Palindrome
	sll %l2, 2, %o2			!number of pointer shifts from each side of string


CHAR:
	or %o0, charString, %o0
	call printf
	sethi %hi(input2), %o1
	set cformat, %o0
	call scanf
	or %o1, input2, %o1

	mov 0, %l0
	mov 0, %l1
	set input, %o0
	
	add %l0, %o0, %o0
CHECKCHAR:
	cmp %l0, %l2
	be,a PRINTNUM
	sethi %hi(printnum), %o0

	ldub[%o0], %o2
	subcc %o1, %o2, %g0
	be,a INCREMENT
	inc %l1
	ba CHECKCHAR
	inc %l0
INCREMENT:
	ba CHECKCHAR
	inc %l0
PRINTNUM:
	
	call printf
	or %o0, printnum, %o0
	call printf
	mov %l1, %o1			!number of time char occurs is stored in %l1, moved to %l2
PROMPTFORCONTINUE:

	set input2, %o1
	set continue, %o0
	call printf
	nop
	
	

	set cformat, %o0
	call scanf
	nop

	cmp %o1, 'y'
	be,a main
	nop								! would you like to continue?

END: 
	ta 0
	mov 1, %g1



Palindrome:
	
	save %sp, (-96) & -8, %sp
	mov 0, %l0
LOOP:							!add beginning of string with number of shifts
	sub	%i3, %l0, %o3		!sub from end of string with number of shifts
	ldub [%i1], %l1			!grab the front end char
	ldub [%i3], %l3			!grab the back end char
	
	cmp %l1, %l3			! compare them for equality...
	
	bne,a NOPALI
	sethi %hi(nopali), %o0
	
	inc %l0
	cmp %l0, %i4
	bl,a LOOP
	add %o1, %l0, %o1
	
	sethi %hi(yespali), %o0
YESPALI:
	or %o0, yespali, %o0
	call printf
NOPALI:
	or %o0, nopali, %o0
	call printf
	nop
	retl 
	restore


CountChar:			
	
	save %sp, (-96) & -8, %sp
	mov 0, %l2
LOOP2:	
	add 	%i1, %l2, %o2 
	ldub 	[%o2], 	%l1						
	cmp 	%g0, 	%l1				!comparing string to 0 bit 
	bne,a LOOP2
	inc %l2

	
	set printLength, %o0
	call printf
	mov %l2, %o1
	st  %l2, [%fp + strlength_s]
	

	retl 
	restore


												! set the continue prompt

