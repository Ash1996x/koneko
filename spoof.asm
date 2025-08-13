@ GNU Assembler version of spoof.asm
@ Converted from MASM syntax

.global Spoof
.type Spoof, @function

@   A function can be called like so
@   
@   Spoof(arg1, arg2, arg3, arg4, &param, function, (PVOID)0);
@   
@   Param is a struct containing some necessary information for the call to have fake frames added.
@   The 6th argument is a pointer to the function to execute
@   The 7th argument specifies the number of args to pass to the stack. It has to be at an 8 byte size.

Spoof:
    pop    %rax                         @ Real return address in rax

    mov    %rdi, %r10                   @ Store OG rdi in r10
    mov    %rsi, %r11                   @ Store OG rsi in r11

    mov    0x20(%rsp), %rdi             @ Storing struct in rdi
    mov    0x28(%rsp), %rsi             @ Storing function to call

    @ ---------------------------------------------------------------------
    @ Storing our original registers
    @ ---------------------------------------------------------------------

    mov %r10, 0x18(%rdi)                @ Storing OG rdi into param
    mov %r11, 0x58(%rdi)                @ Storing OG rsi into param
    mov %r12, 0x60(%rdi)                @ Storing OG r12 into param
    mov %r13, 0x68(%rdi)                @ Storing OG r13 into param
    mov %r14, 0x70(%rdi)                @ Storing OG r14 into param
    mov %r15, 0x78(%rdi)                @ Storing OG r15 into param

    mov %rax, %r12                       @ OG code used r12 for ret addr

    @ ---------------------------------------------------------------------
    @ Prepping to move stack args
    @ ---------------------------------------------------------------------

    xor %r11, %r11                       @ r11 = # of args pushed
    mov 0x30(%rsp), %r13                @ r13 = total args to push

    mov $0x200, %r14                     @ Initial offset
    add $8, %r14
    add 0x38(%rdi), %r14                @ Add RUTS stack size
    add 0x30(%rdi), %r14                @ Add BTIT stack size
    add 0x20(%rdi), %r14                @ Add gadget frame size
    sub $0x20, %r14                      @ Adjust for first stack arg

    mov %rsp, %r10           
    add $0x30, %r10                      @ Stack args base address

looping_label:
    xor %r15, %r15           
    cmp %r11, %r13           
    je finish_label
    
    @ ---------------------------------------------------------------------
    @ Calculate target stack position
    @ ---------------------------------------------------------------------
    sub $8, %r14          
    mov %rsp, %r15        
    sub %r14, %r15        
    
    @ ---------------------------------------------------------------------
    @ Move stack argument
    @ ---------------------------------------------------------------------
    add $8, %r10
    push (%r10)
    pop (%r15)     

    @ ---------------------------------------------------------------------
    @ Increment counter and loop
    @ ---------------------------------------------------------------------
    add $1, %r11
    jmp looping_label
    
finish_label:

    @ ----------------------------------------------------------------------
    @ Create working space and setup fake frames
    @ ----------------------------------------------------------------------
    sub    $0x200, %rsp
    push   $0

    @ RtlUserThreadStart frame
    sub    0x38(%rdi), %rsp
    mov    0x40(%rdi), %r11
    mov    %r11, (%rsp)

    @ BaseThreadInitThunk frame
    sub    0x20(%rdi), %rsp
    mov    0x28(%rdi), %r11
    mov    %r11, (%rsp)

    @ Gadget frame -- `jmp QWORD PTR [rbx]`
    sub    0x30(%rdi), %rsp
    mov    0x50(%rdi), %r11
    mov    %r11, (%rsp)

    @ ----------------------------------------------------------------------
    @ Prepare for function call and fixup
    @ ----------------------------------------------------------------------
    mov    %rsi, %r11                    @ Function to call
    mov    %r12, 0x08(%rdi)              @ Store real return address
    mov    %rbx, 0x10(%rdi)              @ Store original RBX
    lea    fixup_label(%rip), %rbx       @ Get fixup address
    mov    %rbx, (%rdi)                  @ Store fixup in struct
    mov    %rdi, %rbx                    @ Param struct pointer

    @ Prepare syscall (if needed)
    mov    %rcx, %r10
    mov    0x48(%rdi), %rax
    
    jmp    *%r11                         @ Jump to target function

fixup_label: 
    mov    %rbx, %rcx                    @ Restore param struct

    @ Cleanup stack frames
    add    $0x200, %rsp
    add    0x30(%rbx), %rsp
    add    0x20(%rbx), %rsp
    add    0x38(%rbx), %rsp

    @ Restore original registers
    mov    0x10(%rcx), %rbx
    mov    0x18(%rcx), %rdi
    mov    0x58(%rcx), %rsi
    mov    0x60(%rcx), %r12
    mov    0x68(%rcx), %r13
    mov    0x70(%rcx), %r14
    mov    0x78(%rcx), %r15

    jmp    *0x08(%rcx)                   @ Jump to original return address
