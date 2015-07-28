cs32581@solar.cs.gsu.edu
YZpXVc3M


divert(-1)
define(`align_d', `eval($2*( (($1 + 1)/$2)-1))')

define(`local_var', ` ! local variables

define(`last_sym', 0)')
  
define(var, `define(`last_sym',
	align_d(eval(last_sym- ifelse($3,,$2,$3)), $2)) $1 = last_sym ')

define(`begin_', `
main:	save	%sp, align_d(eval(-64-24 ifdef(`last_sym',`+ last_sym')),8), %sp')
define(`end_', `END:
	mov 1, %g1
ta 	0')
divert(0)

.data
.align 4
start: .asciz"Please enter in an array of at most 20 positive integers: "
thresHold: .asciz"Enter a threshold: "
inputF: .asciz"%d%c"
input:  .word 0
nL:	.byte 0
input2:  .asciz"  "
format: .asciz "%s"
prLen: .asciz"The length of the array is %d elements\n"
noPali: .asciz"Your entry is not a palindrome\n"
yesPali: .asciz"Your entry is a palindrome\n"
pcontinue: .asciz "\nWould you like to try again? [y/n]\n"

.text
.align 4
.global main
.global isPalindrome
.global newArray

local_var
var(arr_s, 4, 21*4)
var(arr2_s, 4, 21*4)
define(i_r, l0)
divert(0)
begin_
clr %i_r
clr %l2
add %l2, arr_s, %l5
INIT:
set start, %o0		! LOOP:prompt user to enter up to 20 numbers.
call printf

sll %i_r, 2, %l3

set inputF, %o0		! Store the numbers into the array in stack memory
set input, %o1
set nL, %o2
call scanf
add %fp, %l3, %l3
ld [%o1], %l1
st %l1, [%l5+%l3]
cmp %l1, 0
bne,a INIT
inc %i_r
call getLength			!call a function to print the length of the given array
add %fp, arr_s, %o0		!passing to getLength a pointer to the array
mov %o4, %l4			!moving length into non-volatile register			
set prLen, %o0
call printf
mov %l4, %o1
set input, %o1
set noPali, %o2
add %fp, arr_s, %o5
HERE2:
sll %l4, 2, %o4 	!length *4
add %o4, %o5, %o1
sub %o1, 4, %o3	!pointer to last element in array
HERE:
call isPalindrome		! call a function to determine if given array contains palindrome
srl %o4, 3, %o4
call printf
nop	
set thresHold, %o0					
call printf
nop
set inputF, %o0		! Store the numbers into the array in stack memory
set input, %o1
set nL, %o2
call scanf
nop
ld [%o1], %o2
add %fp, arr_s, %o0
mov %l4, %o3
call newArray
add %fp, arr2_s, %o1
mov %o3, %l1
set prLen, %o0
HERE3:
call printf
mov %l1, %o1
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
nop		


end_


newArray:

save %sp, -64, %sp
clr %l3
!array1 in %i0
!array2 in %i1
!tH in %i2
mov %i1, %l2
mov %i0, %l4
mov %l4, %l5
mov %i2, %l0
LOOP2:
cmp %l3, %i3
be DONE
nop
inc %l3
ld[%l5], %l1
cmp %l0, %l1

bge LOOP2
add %l5, 4, %l5
st %l1, [%l2]
ba LOOP2

DONE2:
mov %l4, %o0
call getLength

mov %o4, %i3

ret 
restore
isPalindrome:	
save %sp, -64, %sp


		!nopali string %i2
clr %l0!counter

LOOP:
	ld [%i5], %l1			!grab the front  char
	ld [%i3], %l2			!grab the back  char
	cmp %l1, %l2			! compare them for equality...
	bne,a DONE
	mov %i2, %i0			!delay slot
	inc %l0
	sub	%o3, 4, %o3
	cmp %l0, %i4
	bl,a LOOP
	add %o1, 4, %o1
	set yesPali, %i0
DONE:
ret
restore
getLength:

save %sp, -64, %sp


mov -1, %i4
COMPARE:
inc %i4
ld [%i0], %o1
cmp %o1, 0
bne,a COMPARE
add %i0, 4, %i0
 

ret
restore

