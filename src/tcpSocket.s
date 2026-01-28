.global _start

_start:
    MOV x8, #64 
    MOV x0, #1 
    LDR x1, =msg 
    MOV x2, #8
    svc #0

    MOV x8, #93
    MOV x0, #0
    svc #0

.data
msg: .ascii "Hello!\n"
