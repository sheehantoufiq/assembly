
.section ".data"
prompt:.asciz"\nPlease enter a string of at most 15 characters:\n"
userInput:.asciz"%s"
format3:.asciz"\nThe length of the string is:%d\n"
format2:.asciz"\nPlease enter a character:"
letterInput:.asciz"%s"
input:.asciz"                "
inputc:.asciz" "
format4:.asciz"\nThe character '%s' appears %d times\n"

.section ".text"
.global main
main:
save %sp,-96 & 4,%sp
set prompt, %o0
call printf 
nop
set userInput, %o0
set input,%o1
call scanf
mov %o1,%g2
nop

clr %l1
mov %g2, %l0
loop:
ldub[%l0], %o2
cmp %o2, 0
be break
inc %l0
inc %l1
ba loop
nop

break:
set format3,%o0
call printf 
mov %l1,%o1
nop
sub %l1,1,%l1


character:
set format2, %o0
call printf
nop
set letterInput, %o0
set inputc, %o1
call scanf
nop
mov %o1, %l2

clr %g3
clr %l4
mov %g2, %l0
ldub[%l2], %l2

characterloop:
ldub[%l0],%o3
inc %l0
cmp %l2,%o3
be characterloop2
nop
inc %l4
ba characterloop
nop

characterloop2:
inc %g3
ba characterloop
nop

characterprint:
set format4,%o0
call printf
mov %g3,%o1
nop

done:
ret
restore