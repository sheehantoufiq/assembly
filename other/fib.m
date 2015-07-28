


include(macro_defs.m)

define(i_r, l4)
define(fib_addr, l5)

local_var
var(fib_struct, 4, 80)
begin

	mov 2, %i_r	!initializing i=2
	mov 0, %l0	!init 1st fib number
	mov 1, %l1!init 2nd fib number
	
	add fib_struct, %fp, %fib_addr	
	st %l0, [%fib_addr] 
	st %l1,	[%fib_addr+4]
	
	LOOP:

	add %l0, %l1, %l2
	sll %i_r, 2, %o0
	
	add %fib_addr, %o0, %o0
	st %l2, [%o0]
	cmp %i_r, 20
	mov %l1, %l0
	mov %l2, %l1	
	bl,a LOOP
	inc %i_r
	END:
	mov 1, %g1
	ta 0