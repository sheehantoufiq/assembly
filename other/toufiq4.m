define(arr_start, l0)
define(arr_size, l1)
define(count, l2)

define(arr, l3)
define(pre, l4)

define(index, l5)
define(pre_num, l6)

define(a_offset, 0)

.section ".data"

input: .word 0
nl: .asciz "\n"
format: .asciz "%d"

prompt1: .asciz "\nEnter starting element: "
prompt2: .asciz "\nEnter array size: "
prompt3: .asciz "\nInput array:\n"
prompt4: .asciz "\nPrefix Sum:\n"

promptA1: .asciz "<address of A[%d]>: "
promptA2: .asciz "%d\n"
promptP1: .asciz "<address of PrefixSum[%d]>: "
promptP2: .asciz "%d\n"

.align 4
.section ".text"
.global main

main:
	save %sp, (-96) & -8, %sp	
/*
	clr %arr_start
	clr %arr_size
	clr %count

	clr %arr
	clr %pre

	clr %index
	clr %pre_num
*/
	set prompt1, %o0
	call printf
	nop

	set format, %o0
	set input, %o1
	call scanf
	nop

	ld [%o1], %arr_start
	nop

	set prompt2, %o0
	call printf
	nop

	set format, %o0
	set input, %o1
	call scanf
	nop

	ld [%o1], %arr_size
	nop

	set prompt3, %o0
	call printf
	nop

	mov 0, %count

ARRAYLOOP:
	cmp %count, %arr_size
	bge PRINTARRAY

	ld [%count + a_offset], %index
	ld [%arr_start + a_offset], %arr

	cmp %count, 0
	bne ELSE
	nop

	ld [%pre], %arr_start

ELSE:

	set promptA1, %o0
	mov %count, %o1
	call printf
	nop

	set promptA2, %o0
	mov %arr_start, %o1
	call printf
	nop	

	add %arr_start, 1, %arr_start
	add %pre_num, %arr_start, %pre_num

	ld [%pre_num + a_offset], %pre
	!add a_offset, 4, a_offset

	ba ARRAYLOOP
	nop

PRINTARRAY:
	clr %count
PRINTLOOP:
	set prompt3, %o0
	call printf
	nop

	set promptP1, %o0
	mov %arr_size, %o1
	call printf
	nop

	set promptP2, %o0
	mov %arr_start, %o1
	call printf
	nop

	cmp %count, %arr_size
	ble PRINTLOOP
	nop

END:
  ret
  restore