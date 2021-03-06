/*

toufiq3.m
Author: Sheehan Toufiq
Account: stoufig1
Class: CSC 3210
Program #3
Due date: July 10, 2014

Description:

This assembly language program prompts the user for 2 numbers. Then the program gives the user a menu of choices where the user can either

1: Perform an OR function between the first and second numbers
2: Perform a XOR function between the first and second numbers 
3: Perform a AND function between the first and second numbers
4: Toggle bit position 0 and 3 for the first number

Once the user makes a choice, the first and second number will print out, the specified function will carry out, then the result will be 
displayed. 

After the program has run, it will prompt the user if they want to run the program again.
If the user enters a 'y' or 'Y', the program will run again. If the user enters any other character, the program will end.

*/


.section ".data"

pInput:  .word  0	!user inputs will be read in here
pChar:   .byte	0	!stores the y/n character the user enters when prompted to rerun 
nl:	 .asciz "\n" 	!trailing newlines will be dumped here
prompt1: .asciz "\nPlease enter in a number between 0 and 4095: "		!prompts user for num1
prompt2: .asciz "\nPlease enter in a second number between 0 and 4095: "	!prompts user fot num2

!prompts user for menu choice
pMenu:   .asciz "Select one of the following options (enter 1, 2, 3, or 4): \n1: Perform the OR function between num1 and num2  \n2: Perform the XOR function between num1 and num2 \n3: Perform the AND function between num1 and num2 \n4: Toggle bits 3 and 0 of num1 \n"

pFormat: .asciz "%d" 		!format of inputs num1, num2, and menu number
fFormat: .asciz "%c%c"		!format of input y/n character 

pOutput1: .asciz "\nThe value for num1 is 0x%08x "		!outputs value for num1
pOutput2: .asciz "and the value for num2 is 0x%08x "		!outputs value for num2
pOutput3: .asciz "\nThe result for option %d is "		!outputs menu number
pResult:  .asciz "0x%08x"					!outputs result
pAgain:   .asciz "\nDo you want to repeat the program (y/n)? "	!prompts user if they want to rerun program
pGoodbye: .asciz "Goodbye. \n"		!outputs Goodbye message

.align 4
.section ".text"
.global main

main:
        save    %sp, -96, %sp
runProg:
        set     prompt1, %o0	!prompt user for num1
        call    printf  	!call printf
        nop

        set     pFormat, %o0	!set input format to r0
        set     pInput, %o1	!set input num1 to r1
        call    scanf		!call scanf
        nop
        ld      [%o1], %l1	!load num1 to local r1

        set     prompt2, %o0	!prompt user for num2
        call    printf  	!call printf
        nop

        set     pFormat, %o0	!set input format to r0
        set     pInput, %o1	!set input num2 to r1
        call    scanf   	!call scanf
        nop
        ld      [%o1], %l2	!load num2 to local r2

        set     pMenu, %o0	!print menu, prompt user for menuNum
        call    printf  	!call printf
        nop

        set     pFormat, %o0	!set input format to r0
        set     pInput, %o1	!set input menuNum to r1
        call    scanf   	!call scanf
        nop
        ld      [%o1], %l3	!load menuNum to local r3

        set     pOutput1, %o0	!set output for num1 to r0
        mov     %l1, %o1	!set num1 to r1
        call    printf  	!print num1
        nop

        set     pOutput2, %o0	!set output for num2 to r0
        mov     %l2, %o1	!set num2 to r1
        call    printf  	!print num2
        nop

        set     pOutput3, %o0	!set output for menuNum to r0
        mov     %l3, %o1	!set menuNum to r1
        call    printf  	!print menuNum
        nop

        cmp     %l3, 1  	!compare menuNum to 1
        be      runOr   	!if menuNum == to 1, go to runOr
        cmp     %l3, 2   	!compare menuNum to 2
        be      runXor		!if menuNum == to 2, go to runXor
        cmp     %l3, 3   	!compare menuNum to 3
        be      runAnd   	!if menuNum == to 3, go to runAnd
        cmp     %l3, 4   	!compare menuNum to 4
        be      runTog   	!if menuNum == to 4, go to runTog
	nop

	ba	done    	!else go to done
	nop
runOr:	
	or	%l1, %l2, %o1	!or num1 & num2, set to r1
	set	pResult, %o0	!set result output to r0
	call	printf  	!print result
	nop
	
	ba	runAgain	!go to runAgain
	nop	
runXor:
	xor	%l1, %l2, %o1	!xor num1 & num2, set to r1
	set	pResult, %o0	!set result output to r0
	call	printf  	!print result
	nop
	
	ba	runAgain	!go to runAgain
	nop
runAnd:
	and	%l1, %l2, %o1	!and num1 & num2, set to r1
	set	pResult, %o0	!set result output to r0
	call    printf  	!print result
	nop

	ba      runAgain	!go to runAgain
	nop
runTog:
	btog	5, %l1  	!toggle location 3 & 0 (0101) of num1
	mov	%l1, %o1	!move num1 of r1
	set	pResult, %o0	!set result output to r0 
	call	printf  	!print result
	nop
runAgain:
        set     pAgain, %o0	!prompt user to run program again
        call    printf  	!call printf
        nop

        set     fFormat, %o0	!set input char format to r0
        set     pChar, %o1	!set input char to r1
	set	nl, %o2  	!set newline char to r2
        call    scanf   	!call scanf
        nop

	set 	pChar, %l0
        ldub	[%l0], %o0  	!load input char to local r0

	cmp 	%o0, 'Y'	!compare input char to char Y
	be	runProg  	!if input == to Y, go to runProg
	cmp	%o0, 'y'	!compare input char to char y
	be	runProg  	!if input == to y, go to runProg
	nop
done:
        set     pGoodbye, %o0	!else set Goodbye message to r0
        call    printf  	!print Goodbye message
        nop

        ret
        restore   	  	!end

