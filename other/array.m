.section ".data"

  prompt1: .asciz "%d, "
  prompt2: .asciz "%d\n"


.align 4
.section ".text"
.global main

main:
  save  %sp, -96, %sp
  clr   %l0
  clr   %l1
  clr   %l3
  clr   %l4
  mov   5, %l0
  mov   1, %l3
  mov   4, %l4

  sll   %l0, 2, %l1       !%o0 = i * 4
  add   %fp, %o0, %l1     !%o0 = %fp + i * 4

LOOP:
  ld    [%l1 + %l4], %l1   !%o0 = [%fp + a_offset + i * 4]
  add   %l4, 4, %l4

  set   prompt1, %o0
  mov   %l1, %o1
  call  printf
  nop

  set   prompt2, %o0
  mov   %l3, %o1
  call  printf
  nop

  add   %l3, 1, %l3
  cmp   %l3, 6
  bl    LOOP
  nop

END:
  ret
  restore