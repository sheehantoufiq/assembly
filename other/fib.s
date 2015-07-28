






  











 ! local variables


 fib_struct = -4 
.global 	main
main:	save	%sp, -72, %sp

	mov 2, %l4	!initializing i=2
	mov 0, %l0	!init 1st fib number
	mov 1, %l1!init 2nd fib number
	
	add fib_struct, %fp, %l5	
	st %l0, [%fp+fib_struct] 
	st %l1,	[%fp+fib_struct+4]
	
	LOOP:

	add %l0, %l1, %l2
	sll %l4, 2, %o0
	
	sub %l5, %o0, %o0
	st %l2, [%o0]
	cmp %l4, 20
	bl,a LOOP
	inc %l4

	mov 1, %g1
	ta 0