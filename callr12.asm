@ GNU Assembler version of callr12.asm
@ Converted from MASM syntax

.global CallR12
.type CallR12, @function

CallR12:
    @ Allocate stack space
    sub $0x100, %rsp

    @ Store non-volatile registers
    mov %rsi, 0x08(%rsp)
    mov %rdi, 0x10(%rsp)
    mov %r12, 0x18(%rsp)

    @ Set up registers for function and fixup handler
    mov %rcx, %r10                        @ R10 now holds the function to call
    lea Fixup(%rip), %r12                 @ R12 points to Fixup label for return address

    @ More stack space for arguments and spoofed return address
    sub $0x200, %rsp

    @ Place the gadget address as the return address
    mov %r8, (%rsp)                       @ Spoofed return address is now set to r12_gadget

    @ Check if there are any arguments
    cmp $0, %rdx
    je CallFunction                        @ If no arguments, jump to call the function directly

    @ Backup the number of arguments in R11
    mov %rdx, %r11                        @ R11 = nArgs

    @ Shift arguments if necessary (move arguments into appropriate registers for calling convention)
    cmp $4, %rdx
    mov %r9, %rcx                         @ First argument to RCX (from R9 if provided)
    mov 0x300+0x28(%rsp), %rdx
    mov 0x300+0x30(%rsp), %r8
    mov 0x300+0x38(%rsp), %r9
    jle CallFunction                       @ Jump if there are 4 or fewer arguments

    @ Move additional arguments from stack to align with calling convention
    mov %rcx, %rax
    mov %r11, %rcx
    sub $4, %rcx                          @ RCX = number of extra arguments to move
    lea 0x28+0x18+0x300(%rsp), %rsi      @ Source (additional arguments in original stack frame)
    lea 0x28(%rsp), %rdi                 @ Destination in stack frame
    rep movsq                             @ Move the arguments from RSI to RDI

    @ Restore RCX for function call
    mov %rax, %rcx

CallFunction:
    @ Call the target function
    jmp *%r10                             @ Jump to function (R10), with r12_gadget as return address

Fixup:
    @ Restore non-volatile registers and stack frame
    mov 0x200+0x08(%rsp), %rsi
    mov 0x200+0x10(%rsp), %rdi
    mov 0x200+0x18(%rsp), %r12
    add $0x300, %rsp                      @ Clean up the stack frame

    ret                                   @ Return to caller
