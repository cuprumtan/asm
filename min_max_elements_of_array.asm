.model small
.stack 100h
.const

strmax db 'Max: '
strmin db 'Min: '

.data

mywords dw 100 dup(10d, 20d, 30d, 40d, 50d, 60d, 70d, 80d, 90d, 100d)
wordslen dw 100d


.286

.code

; from http://asm-book.ru/faq/0017.php
printproc proc
    printstart:   xor   cx, cx
                  mov   bx, 10
    printloopstr: xor   dx, dx
                  div   bx
                  push  dx
                  inc   cx
                  or    ax, ax
                  jnz   printloopstr
    printloopend: pop   ax
                  or    al, 30h
                  int   29h
                  loop  printloopend
                  mov   al, 13          ;to line start
                  int   29h
                  mov   al, 10          ;new line
                  int   29h
                  ret
printproc endp

start:            mov   ax, @data
                  mov   ds, ax

searchmax:        mov   dx, mywords[0]    ;max
                  mov   ax, 0 
                  mov   cx, wordslen      ;array counter ~ for i=wordslen..0
                  mov   bx, 0             
maxloop:          mov   ax, mywords[bx]
                  add   bx, type mywords
                  cmp   ax, dx            ;compare current element and current max
                  jg    setmax            ;if current element greater, then update dx
maxloopcont:      dec   cx                ;decrement counter
                  cmp   cx, 0             ;while counter != 0
                  jne   maxloop         
                  push  dx

                  ; print string
                  mov   bx, 1
                  mov   cx, 5
                  mov   dx, offset strmax
                  mov   ah, 40h
                  int   21h
    
                  pop   ax
                  call  printproc         ;print max word
                  jmp   searchmin

setmax:           mov   dx, ax
                  jmp   maxloopcont

searchmin:        mov   dx, mywords[0]    ;min
                  mov   ax, 0 
                  mov   cx, wordslen      ;array counter ~ for i=wordslen..0
                  mov   bx, 0             
minloop:          mov   ax, mywords[bx]
                  add   bx, type mywords
                  cmp   ax, dx            ;compare current element and current min
                  jl    setmin            ;if current element lower, then update dx
minloopcont:      dec   cx                ;decrement counter
                  cmp   cx, 0             ;while counter != 0
                  jne   minloop          
                  push  dx

                  ; print string
                  mov   bx, 1
                  mov   cx, 5
                  mov   dx, offset strmin
                  mov   ah, 40h
                  int   21h
    
                  pop   ax
                  call  printproc         ;print min word
                  jmp   dosexit

setmin:           mov   dx, ax
                  jmp   minloopcont

dosexit:          mov   ax, 4c00h         ;DOS exit
                  int   21h

end start
