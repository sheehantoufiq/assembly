.data
.align 4
prompt: .asciz "Enter a word: \n"

  
cformat: .asciz"%c"
format: .asciz "%s"
input: .asciz "                "
respond: .asciz "Your word is %s\n"

.text
strlength_s= -4
	.align 4
	.global main 
	.global isPalindrome



main:
	save %sp, (-64) & -8, %sp
	
	set prompt, %o0				
	call printf	
	mov 0, %l0

	set format, %o0
	set input, %o1
	call scanf
	
	nop					
	call isPalindrome
	nop

	
END: 
	ta 0
	mov 1, %g1	
	
	
getLength:
	save %sp, (-96) & -8, %sp
	mov 0, %l2
	ldub 	[input+%l2], 	%l1
	cmp 	%g0, 	%l1
	bne,a getLength
	inc %l2
	st %l2, [%fp+strlength_s]	
	retl
	restore
isPalindrome:

	save %sp, (-96) & -8, %sp  	! saving space for subroutine
	set respond, %o0			! setting the text 'respond' to reg %o0
	set input, %o1				! setting the user input to %o1
	ldub[%o1], %l1
	ldub[%01+]			! word minus the first character in %o1
	call printf					! printing 'Your word is %s\n'
	nop	
	retl						! window alignment and register restore to calling routine
	restore
