.model small
.stack 100h
.const

strmax db 'Sorted: '

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


; print array
printarrayproc proc
                  mov   cx, wordslen
                  mov   bx, 0
printarray:       mov   ax, mywords[bx]
                  add   bx, type mywords
                  push  cx
                  push  bx
                  call  printproc
                  pop   bx
                  pop   cx
                  dec   cx
                  cmp   cx, 0
                  jne printarray
                  ret       
printarrayproc endp

start:            mov   ax, @data
                  mov   ds, ax
                  mov   dx, wordslen

bubbleloop:       mov   cx, wordslen
                  lea   si, mywords       ;lea gets effective address from mywords

innerloop:        mov   ax, mywords[si]   ;get array[counter] element
                  cmp   ax, mywords[si+1] ;compare array[counter] and array[counter+1] elements
                  jl    buubleloopcnt     ;if array[counter] < array[counter+1] do nothing
                  xchg  ax, mywords[si+1] ;else change elements
                  mov   mywords[si], ax

buubleloopcnt:    inc   si
                  loop  innerloop         ;loop decrements cx value and jumps to innerloop if cx > 0

                  dec   dx
                  jnz   bubbleloop

                  ; print string
                  mov   bx, 1
                  mov   cx, 8
                  mov   dx, offset strmax
                  mov   ah, 40h
                  int   21h

                  call printarrayproc

                  mov   ax, 4c00h         ;DOS exit
                  int   21h

end start
