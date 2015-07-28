divert(-1)
define(yMax, %l3)
define(x, %l0)
define(y, %l1)
define(temp, %l2)
define(temp2, %l4)

divert(0)

	.global main


main:
	save %sp, -64, %sp

	set -2, x

	
	
loop:	
		
	mov x, %o0
	call .mul
	mov x, %o1		! x^2 in %o0
	mov %o0, temp		! x^2 in temp register %l2
	call .mul
	mov x, %o1		! x^3 in %o0
	mov %o0, temp2		! x^3 in temp2
	set 14, %o0
	call .mul
	mov temp, %o1		! 14x^2 in %o0
	sub temp2, %o0, temp	! x^3-14x^2 in temp
	mov x, %o0
	call .mul
	set 56, %o1		! 56x in %o0
	add %o0, temp, temp	! x^3-14x^2+56x in temp
	sub temp, 64, y		! x^3-14x^2+56x-64 in y
	cmp x, -2		! checks to see if in first x value
	be,a setYmax		! if x==-2, branch to setYmax and set yMax to f(-2)
	mov y, yMax	
	ba test	
	cmp y, yMax		
test: 	
	
	
	bg,a setYmax
	mov y, yMax
	
	
	cmp x, 8
	ble,a loop
	inc x
	
	ba end 
	set 1, %g1
		
setYmax:
	
	ba loop
	inc x

end:   

	ta 0
	



	
	
	
	
