/*

toufiq2.m
Author: Sheehan Toufiq
Account: stoufig1
Class: CSC 3210
Program #2
Due date: Sept 30, 2014

Description:

This assembly language program determines the maximum y for the
following equation:

y = x^3 - 14x^2 - 23x
for the values:
-4 <= x <= 5.

The program calculates each x within the equation, prints y for each x.
Then the program prints the maximum y and it's corresponding x.

*/

        define(a0, 14)          !define 14
        define(a1, 23)          !define 23

        define(x_r, l0)         !set x as the equation variable
        define(y_r, l1)         !set y as the answer
        define(mX_r, l2)        !set mX as maximum x
        define(mY_r, l3)        !set mY as maximum y

.section ".data"
outputY: .asciz "y = %d, "
outputX: .asciz "for the value x = %d \n"
final:   .asciz "The maximum for y is %d "
final2:  .asciz "when x = %d. \n"

.align 4
.section ".text"
.global main

main:
        save    %sp, -96, %sp
        mov     -4, %x_r                !set x = -4
        mov     -4096, %mX_r            !set maximum x as -4096 
        mov     -4096, %mY_r            !set maximum y as -4096

loop:
        cmp     %x_r, 5                 !if x > 5
        bg      done                    !then go to done
        mov     %x_r, %o0               !else move x to r0
        call    .mul                    !call multiply
        mov     %x_r, %o1               !r0 = x * x
        call    .mul                    !call multiply
        mov     %x_r, %o1               !r0 = x * x * x
        mov     %o0, %y_r               !move r0 to y
        mov     %x_r, %o0               !move x to r0
        call    .mul                    !call multiply
        mov     %x_r, %o1               !r0 = x * x
        call    .mul                    !call multiply
        mov     a0, %o1                 !r0 = x * x * 14
        subcc   %y_r, %o0, %y_r         !set new y = y - r0
        mov     %x_r, %o0               !move x to r0
        call    .mul                    !call multiply
        mov     a1, %o1                 !r0 = x * 23
        subcc   %y_r, %o0, %o1          !set new y = y - r0
        mov     %o1, %y_r               !set r1 = y
        set     outputY, %o0            !set outputY to r0)
        call    printf                  !call print
        nop

next:   cmp     %y_r, %mY_r             !if y > maxY
        bl      next2                   !go to next2, else
        nop
        mov     %y_r, %mY_r             !move %y_r to %mY_r
        mov     %x_r, %mX_r             !move %x_r to %mX_r

next2:  mov     %x_r, %o1               !move x to r1
        set     outputX, %o0            !set outputX to r0
        call    printf                  !call print
        nop
        inc     %x_r                    !increment %x_r
        ba      loop
        nop

done:   mov     %mY_r, %o1
        set     final, %o0              !set final to r0
        call    printf                  !call print
        nop
        mov     %mX_r, %o1
        set     final2, %o0             !set final2 to r0
        call    printf                  !call print
        nop
        
        ret
        restore                         !end program