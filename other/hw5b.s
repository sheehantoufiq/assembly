	.data
	.align 4

		prompt: .asciz "Please enter in a string of at most 15 characters: "
		nopali: .asciz "\nThe string is a palindrome."
		yespali: .asciz "\nThe string is not a palindrome."
		format: .asciz "%s"
		printLength: .asciz "\nThe length of the string is %d characters."
		input: .asciz "                "
		pcontinue: .asciz "\nWould you like to try another entry? [y/n]: "
		input2:  .asciz"  "
		charString: .asciz "\nPlease enter a character: "
		respond: .asciz "\nThe character '%s' "
		printnum: .asciz "occurs %d times."
		goodbye: .asciz "\nGoodbye\n"

	.global main 
	.text
	.align 4

main:
	save %sp, (-96) & -8, %sp	
	set prompt, %o0				
	call printf				!"Enter a word"
	mov 0, %l0
	set format, %o0
	set input, %o1
	call scanf
	mov 0, %l2
	mov %o1, %l5

getLength:	
	add 	%o1, %l2, %o2 
	ldub 	[%o2], 	%l1
	cmp 	%g0, 	%l1				!comparing string to 0 bit 
	bne,a getLength
	inc %l2	
	set printLength, %o0
	call printf
	mov %l2, %o1
	set input, %o1

settingIndex:
	add %o1, %l2, %o3		!pointer to the end of the string
	sub %o3, 1, %o3			!fixing the fencepost error
	sll %l2, 2, %l2			!number of pointer shifts from each side of string 

isPalindrome:
	
	sub	%o3, %l0, %o3		!sub from end of string with number of shifts
	ldub [%o1], %l1			!grab the front end char
	ldub [%o3], %l3			!grab the back end char
	
	cmp %l1, %l3			! compare them for equality...
	
	bne,a NOPALI
	nop
	
	inc %l0
	cmp %l0, %l2
	bl,a isPalindrome
	add %o1, %l0, %o1
	
NOPALI:
	!or %o0, nopali, nopali
	set nopali, %o0
	call printf
	ba CHAR
	nop
	sethi %hi(charString), %o0 

YESPALI:
	!or %o0, yespali, yespali
	set yespali, %o0
	call printf
	ba CHAR
	nop
	sethi %hi(charString), %o0

CHAR:
	set charString, %o0
	call printf
	nop	
	set format, %o0
	set input2, %o1	
	call scanf
	nop
	set input2, %o1
	set respond, %o0
	call printf

HERE:nop
	set input, %l5
	set input2, %o1
	ldub [%o1], %l4	
	mov 0, %l0			!how many shifts have been done
	mov 0, %l1			!counter for number of occurrences

CHECKCHAR:
	cmp %l0, %l2
	be PRINTNUM
	nop	
	ldub[%l5], %l3 
	add %l5, 1,%l5 
	cmp %l3,%l4 
	be,a INCREMENT
	inc %l1
	ba CHECKCHAR
	inc %l0

INCREMENT:
	ba CHECKCHAR
	inc %l0

PRINTNUM:
	set printnum, %o0
	call printf	
	mov %l1, %o1			!number of time char occurs is stored in %l1, moved to %l2

PROMPTFORCONTINUE:
	set pcontinue, %o0
	call printf
	nop	
	set input2, %o1
	set format, %o0
	call scanf
	nop
	ldub [%o1], %l1
 	cmp %l1, 'y'
	be main
	nop					! would you like to continue?

END: 
	set goodbye, %o0
	call printf
	nop

	mov 1, %g1
	ta 0
