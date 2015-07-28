define(letter, l0)
define(iter, l1)
define(total, l2)
define(rev_index, l3)
define(str_index, l4)

.section ".data"

/*Variables*/
input: .word 0
yesNo: .byte 0
nl: .asciz "\n"
prompt1: .asciz "\nPlease enter in a string of a maximum of 30 lower case characters:"
prompt2: .asciz "\nWould you like to enter in a nnother string(y/n)?:"

format1: .asciz "%d%c"
format2: .asciz "%c%c"
format3: .asciz "\nThe sorted string is:"
format4: .asciz "\nThe strin is a palindrom:"
format5: .asciz "\nThe strin is not a palindrom:"
format6: .asciz "\nGood bye:"
format7: .asciz "%d"

.align 4
.section ".text"
.global main

main:
save %sp, -96, %sp
repeat:

set prompt1, %o0 !ask fo a number
call printf
nop

set format2, %o0 !input needs 
set input, %o1 !address where input is stored
call scanf
nop

set input, %o1
ldub [%fp + -4], %l2
clr %str_index
clr %l1

loop:
stb %o0, [%l1]
add %o0, 1, %o0
add %l1, 1, %l1
cmp %l1, %l2
bl loop
nop

ld [%fp + -4], %l2
clr %rev_index
mov %l2, %str_index
sub %str_index, 1, %str_index

loop1:
ldub [%str_index], %o0
stb %o0, [%fp+%rev_index]
add %rev_index, 1, %rev_index
sub %str_index, 1, %str_index
cmp %rev_index, %l2
bl loop
nop

set prompt2, %o0
call printf
nop

set format2, %o0 !getting a character and a newline
set yesNo, %o1
set nl, %o2
call scanf
nop

set yesNo, %l0
ldub [%l0], %o0 !get the ys/no from memory
cmp %o0, 'y'
be repeat
nop !yes then try again

ret !get out
restore