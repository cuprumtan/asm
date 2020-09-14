.model small
.stack 100h
.data

mydata db 100

.286

.code

start:       mov ax,@data
             mov ds,ax
             mov bx,0
loopstart:   cmp bx,99 			; eq for i=0..99
             je loopend 		; if i eq 99 end loop
             xor mydata[bx],'X' 	; encrypting
             add mydata[bx], 50     ; readable output
             mov dl,mydata[bx]	; write to data register
             mov ah,2h 			; print symbol
             int 21h
             inc bx
             jmp loopstart
loopend:     mov ax,4c00h 		; DOS exit
             int 21h
end start
