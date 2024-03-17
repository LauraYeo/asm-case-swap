    SYS_READ   equ     0          ; read text from stdin
    SYS_WRITE  equ     1          ; write text to stdout
    SYS_EXIT   equ     60         ; terminate the program
    STDIN      equ     0          ; standard input
    STDOUT     equ     1          ; standard output
; --------------------------------
section .bss
    MaxLength equ     24         ; 24 bytes for user input
    UserInput     resb    MaxLength ; buffer for user input
; --------------------------------
section .data
    prompt     db      "Please input some text (max 23 characters): "
    prompt_len equ     $ - prompt
    text       db      10, "When swapped you get: "
    text_len   equ     $ - text
; --------------------------------
section .text
    global _start
    global swapcase

_start:
    ;; Output a prompt to user
    mov     rdx, prompt_len
    mov     rsi, prompt
    mov     rdi, STDOUT
    mov     rax, SYS_WRITE
    syscall

    ;; Read a string from console into UserInput
    mov     rdx, MaxLength
    mov     rsi, UserInput
    mov     rdi, STDIN
    mov     rax, SYS_READ
    syscall                      ; -> RAX
    mov     byte [rsi + rax - 1], 0 ; Replace newline with null terminator

    ;; Call procedure to swap the string case
    mov     rsi, rax             ; Move length of string to RSI
    dec     rsi                  ; Adjust for null terminator
    mov     rdi, UserInput       ; Move address of string to RDI
    call    swapcase

    ;; Write out prompt to console
    mov     rdx, text_len
    mov     rsi, text
    mov     rdi, STDOUT
    mov     rax, SYS_WRITE
    syscall

    ;; Write out string that was swapcased
    mov     rdx, MaxLength
    mov     rsi, UserInput
    mov     rdi, STDOUT
    mov     rax, SYS_WRITE
    syscall

    ;; Exit the program with exit code 0
    xor     edi, edi             ; successful exit
    mov     rax, SYS_EXIT
    syscall

swapcase:
    push    rbp                  ; Save the base pointer of the previous frame on the stack
    mov     rbp, rsp             ; Create a new stack frame for swapcase function
    mov     rcx, rsi             ; RCX is the counter for the string length
    mov     rdi, rdi             ; RDI is the pointer to the string

.loop:
    test    rcx, rcx             ; Test if RCX (the remaining length of the string) is zero
    jz      .end                 ; If RCX is zero, all characters have been processed; exit loop

    mov     al, [rdi]            ; Load the current character from the string into AL
    cmp     al, 'a'              ; Compare the character to 'a' to check if it's lowercase
    jl      .check_upper         ; If the character is less than 'a', jump to check if it's uppercase
    cmp     al, 'z'              ; Compare the character to 'z' to confirm it's lowercase
    jg      .check_upper         ; If the character is greater than 'z', it's not lowercase; check uppercase
    sub     al, 32               ; Subtract 32 from the character to convert lowercase to uppercase (ASCII value)
    jmp     .store               ; Jump to store the converted character

.check_upper:
    cmp     al, 'A'              ; Compare the character to 'A' to check if it's uppercase
    jl      .next_char           ; If the character is less than 'A', it's not a letter, move to the next character
    cmp     al, 'Z'              ; Compare the character to 'Z' to confirm it's uppercase
    jg      .next_char           ; If the character is greater than 'Z', it's not a letter, move to the next character
    add     al, 32               ; Add 32 to the character to convert uppercase to lowercase (ASCII value)

.store:
    mov     [rdi], al            ; Store the converted character back into the string at the current position

.next_char:
    inc     rdi                  ; Increment the string pointer to move to the next character
	dec     rcx                  ; Decrement the length counter, indicating one less character to process
    jmp     .loop                ; Jump back to the beginning of the loop to process the next character

.end:
    pop     rbp                  ; Restore the previous frame's base pointer from the stack
    ret                          ; Return from the swapcase function