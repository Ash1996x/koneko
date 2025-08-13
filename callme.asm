/* GNU Assembler version of callme.asm */
/* Converted from MASM syntax */

.global CallMe
.type CallMe, @function

CallMe:
    mov %rcx, %r10
    mov dwSSN(%rip), %eax
    jmp *qwJMP(%rip)