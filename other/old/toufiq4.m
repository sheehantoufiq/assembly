/*

toufiq4.m
Author: Sheehan Toufiq
Account: stoufig1
Class: CSC 3210
Program #4
Due date: July 17, 2014

Description:

The program will prompt the user for a number and then ask them to select one of two 
options: Extract or Set. If the user selects Extract, then the program will extract a field 
from the entered value. If Set is chosen, the program will set bits of a field to one within 
the entered value. The user will enter the position of the least significant bit of the field 
and the number of bits in the field. The program should then display the initial value in 
binary and the result in binary, as well as the parity of the result. The program should 
then ask the user if they want to quit the program. If the user selects not to quit, then the 
process is repeated.

*/

        define(rerun_r, l0)     !yesNo prompt goes here
        define(input_r, l1)     !input prompt goes here
        define(menu_r, l2)      !menu choice goes here
        define(lsb_r, l3)       !lsb num goes here
        define(length_r, l4)    !length num goes here
        define(mask_r, l5)      !mask goes here
        define(bit_r, l6)
        define(reg_r, l7)
        define(bool_r, l7)

.section ".data"
        input: .word 0                  !where the user input will be read in
        mChoice: .byte 0		!store menu choice character
        yesNo: .byte 0                  !store a character representing yes or no
        nl: .asciz "\n"                 !where we dump the trailing newline input
        format1: .asciz "%d%c"		!specify a decimal number (word) and a character
        format2: .asciz "%c%c"          !specify two characters

        prompt: .asciz "\nPlease enter in a number between 0 and 4095: "
        promptM: .asciz "\nPlease select one of the following functions: \ne : Extract bits of a field \ns : Set bits of a field\n"
        promptA: .asciz "\nPlease enter the lsb of the field: "
        promptB: .asciz "\nPlease enter in the length of the field: "
        promptC: .asciz "\nThe initial value in binary is: "
        binaryP: .asciz "%d"
        promptD: .asciz "\nThe result in binary is: "
        prompt2: .asciz "\nWould you like to quit (y/n)? "
        promptG: .asciz "\nGoodbye.\n"

.align 4
.global main
.section ".text"

main:
        save %sp, -96, %sp

repeat:

        mov 32, %reg_r
        set prompt, %o0         !prompt the user for an input number
        call printf
        nop

        set format1, %o0        !what kind of data we want to get
        set input, %o1          !location for the input number to be stored
        set nl, %o2             !location to dump the input newline
        call scanf
        nop                     !now, the user input must be in the data block
        ld [%o1], %input_r      !specified by the label input and nl
        nop

        set promptM, %o0	!print menu, prompt user for menuChoice
        call printf  		!call printf
        nop

        set format2, %o0	!set input format to r0
        set mChoice, %o1 	!set input menu choice to r1
        set nl, %o2
        call scanf   		!call scanf
        nop
        ldub [%o1], %menu_r     !load menu choice to local r3

        set promptA, %o0        !prompt the user for a lsb
        call printf
        nop

        set format1, %o0        !what kind of data we want to get
        set input, %o1          !location for the input number to be stored
        set nl, %o2             !location to dump the input newline
        call scanf
        nop                     !now, the user input must be in the data block
        ld [%o1], %lsb_r	!specified by the label input and nl
        nop

        set promptB, %o0        !prompt the user for length
        call printf
        nop

        set format1, %o0        !what kind of data we want to get
        set input, %o1          !location for the input number to be stored
        set nl, %o2             !location to dump the input newline
        call scanf
        nop                     !now, the user input must be in the data block
        ld [%o1], %length_r	!specified by the label input and nl

        set promptC, %o0
        call printf
        nop

toBinary:

        mov 1, %mask_r
        sll %mask_r, 31, %mask_r

testBit:

        btst %mask_r, %input_r
        be printBinary
        mov 0, %bit_r
        mov 1, %bit_r

printBinary:
        
        set binaryP, %o0
        mov %bit_r, %o1
        call printf
        nop

        deccc %reg_r
        bg testBit
        srl %mask_r, 1, %mask_r

        cmp %bool_r, 1
        be runAgain
        nop

runMenu:

        mov 1, %bool_r
        mov 32, %reg_r
        cmp %menu_r, 'e'        !compare menuNum to 3
        be runExtract           !if menuNum == to 3, go to runAnd
        cmp %menu_r, 'E'        !compare menuNum to 4
        be runExtract           !if menuNum == to 4, go to runTog
        cmp %menu_r, 's'        !compare menuNum to 3
        be runSet               !if menuNum == to 3, go to runAnd
        cmp %menu_r, 'S'        !compare menuNum to 4
        be runSet               !if menuNum == to 4, go to runTog
        nop

        ba done
        nop

runExtract:

        mov 1, %mask_r
        sll %mask_r, 31, %mask_r

        sub %length_r, 1, %o0
        sra %mask_r, %o0, %mask_r
        add %length_r, %lsb_r, %length_r

        sub %reg_r, %length_r, %length_r
        srl %mask_r, %length_r, %mask_r

        bclr %mask_r, %input_r

        set promptD, %o0
        call printf
        nop
        
runSet:

runAgain:

        mov 0, %bool_r
        set prompt2, %o0	!reprompt
        call printf
        nop

        set format2, %o0	!getting a character and a newline
        set yesNo, %o1          !location for yes/no
        set nl, %o2             !dummy newline
        call scanf
        nop

        set yesNo, %rerun_r      !get the address of yes/no memory
        ldub [%rerun_r], %o0     !get the yes/no response from memory
        nop
        cmp %o0, 'n'		!cmp r0 to n and N
        be repeat          	!if n, then try again

        cmp %o0, 'N'            !if N, then try again
        be repeat
        nop

done:
	set promptG, %o0	!else set Goodbye message to r0
	call printf		!print Goodbye message
	nop
        ret             	!get out
        restore			!end

