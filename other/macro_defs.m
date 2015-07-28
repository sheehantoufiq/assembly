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

/*

scp toufiq4.m cs32581@solar.cs.gsu.edu:/class/cs32581/
YZpXVc3M

*/