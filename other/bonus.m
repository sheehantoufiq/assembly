divert(-1)
include(macro_defs.m)
.data
.align 4

startP: .asciz "Please enter an array of at most 20 positive integers:"
inputF: .asciz "%d%c"
input: .word 0
nL:	.byte 0
prLen: .asciz "The length of the array is %d elements\n"
noPali: .asciz "Your entry is not a palindrome\n"
yesPali: .asciz "Your entry is a palindrome\n"
pcontinue: .asciz "\nWould you like to try again? [y/n]\n"

.text
.align 4
.global main

local_var
var(arr_s, 4, 21*4)
define(i_r, l0)
divert(0)

main:
save %sp, (-96) & -8, %sp	
clr %i_r
clr %l2
add %l2, arr_s, %l5

INIT:
set startP, %o0
call printf
sll %i_r, 2, %l3
set inputF, %o0
set input, %o1
set nL, %o2
call scanf
add %fp, %l3, %l3
ld [%o1], %l1
st %l1, [%l5+%l3]
cmp %l1, 0
bne,a INIT
inc %i_r

getLength:
mov -1, %g2
add 	%o1, %l2, %o2 
ldub 	[%o2], 	%l1
cmp 	%g0, 	%l1
bne,a getLength
inc %l2	
set prLen, %o0
call printf
mov %l2, %o1
set input, %o1

COMPARE:
inc %g2
ld [%o0], %o1
cmp %o1, 0
bne,a COMPARE
add %o0, 4, %o0
ba DONE
nop

add %fp, arr_s, %o0		
set prLen, %o0
call printf
mov %g2, %o1
set input, %o1
set noPali, %o2
add %fp, arr_s, %g3

HERE:
call isPalindrome	
nop
call printf
nop

isPalindrome:	
mov %o2, %o4
clr %o5
sll %g2, 2, %g4
add %g3, %g4, %g4
sub %g4, 4, %o2
srl %g2, 1, %g2

LOOP:
ld [%g3], %o1
ld [%o2], %o3
cmp %o1, %o3
bne,a DONE
mov %o4, %o0
inc %o5
sub	%o3, 4, %o3
cmp %o5, %g2
bl,a LOOP
add %o1, 4, %o1
set yesPali, %o0

DONE:
ret
restore