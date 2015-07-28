/*

toufiq2.m
Author: Sheehan Toufiq
Account: stoufig1
Class: CSC 3210
Program #2
Due date: Sept 30, 2014

Description:

This assembly language program determines how many results are negative for the
following equation:

y = x^3 - 14x^2 - 23x
for the values:
-4 <= x <= 5.

The program calculates each x within the equation, prints y for each x.
Then the program prints the number of negative numbers for each x.

*/

        define(a0, 14)          !define 14
        define(a1, 23)          !define 23

        define(x_r, l0)         !set x as the equation variable
        define(y_r, l1)         !set y as the answer
        define(a_r, l2)         !set a as how many negatives

.section ".data"
outputY: .asciz "y = %d, "
outputX: .asciz "for the value x = %d \n"
final:   .asciz "There are %d negatives for the values -4 through 5 \n"

.align 4
.section ".text"
.global main

main:
        save    %sp, -96, %sp
        mov     0, %a_r                 !set a = 0
        mov     -4, %x_r                !set x = -4

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
        mov     %x_r, %o1               !move x to r1
        set     outputX, %o0            !set outputX to r0
        call    printf                  !call print
        inc     %x_r                    !increment %x_r
next:
        cmp     %y_r, 0                 !if y > 0
        bg      loop                    !then go to loop
        nop
        inc     %a_r                    !else increment a
        ba      loop                    !go to loop
        nop
done:
        sub     %a_r, 1, %a_r
        mov     %a_r, %o1               !move a to r1
        set     final, %o0              !set final to r0
        call    printf                  !call print
        nop
        
        ret
        restore                         !end program