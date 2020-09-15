;The program asks for a string in a loop.
;If the string contains sequences of 3 or more digits, then the program outputs 1 (True), otherwise 0 (False).
;If user entered 'EXIT', then exit the program.

.model small
.stack 100h
.data

.286

.code

userinput proc
                  mov   ah, 01h
                  int   21h
                  ret
userinput endp


start:            ;mov   ax, @data
                  ;mov   ds, ax

next_str:         mov   dl, 01h           ;digits counter
                  mov   bh, 01h

isdigit:          call  userinput
                  cmp   al, '0'
                  jl    isletter
                  cmp   al, '9'
                  jg    isletter
                  inc   dl                ;increment digits counter and check new input
                  inc   bh
                  jmp   isdigit

isletter:         cmp   al, 'E'
                  je    isEletter
                  dec   bh
                  cmp   al, 13
                  je    countDigits
                  jmp   isdigit



;to check if word is 'EXIT':
isEletter:        call  userinput
                  cmp   al, 'X'
                  je    isXletter
                  jmp   isdigit

isXletter:        call  userinput
                  cmp   al, 'I'
                  je    isIletter
                  jmp   isdigit

isIletter:        call  userinput
                  cmp   al, 'T'
                  je    isTletter
                  jmp   isdigit

isTletter:        call  userinput
                  cmp   al, 13
                  je    dosexit
                  jmp   isdigit



countDigits:      cmp   dl, 3
;                  jg    checkSequence
                  jg    returnTrue
                  jmp   returnFalse

;checkSequence:    cmp   bh, 0
;                  jg    returnTrue
;                  jmp   returnFalse

returnTrue:       mov   al, '1'
                  int   29h
                  jmp   next_line

returnFalse:      mov   al, '0'
                  int   29h
                  jmp   next_line

next_line:        mov   al, 13
                  int   29h
                  mov   al, 10
                  int   29h
                  jmp   next_str        

dosexit:          mov   ax, 4c00h         ;DOS exit
                  int   21h

end start
