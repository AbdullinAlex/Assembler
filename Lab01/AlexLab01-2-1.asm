include \masm64\include64\masm64rt.inc ; библиотеки
count PROTO arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD, arg_e:QWORD,arg_f:QWORD
.data
_a1 dq 10
_b1 dq 9
_c1 dq 2
_d1 dq 3
_e1 dq 3
_f1 dq 15
_res1 dq 0
_title db "ЛР1-2. Процедуры.",0
_text db "Уравнение ac + b/d + f/e",10,"Результат: %d",10,"Адрес переменной в памяти: %p",10,10,
"Автор: Абдуллин А. Р., КИТ-119а, Вариант 1",0
buf1 dq 3 dup(0),0

.code
count proc arg_a:QWORD, arg_b:QWORD, arg_c:QWORD, arg_d:QWORD, arg_e:QWORD, arg_f:QWORD
mov rax, rdx    ; в rax число b
xor rdx,rdx     ; обнуление регистра
div r9          ; b/c
mov rsi, rax    ; схраняем значение в rsi
mov rax, rcx    ; в rex число a
mul r8          ; a*c
add rsi, rax    ;

mov rax, arg_f  ; переносим f в rax
xor rdx, rdx    ;
mov rbx, arg_e  ;
div rbx         ; f/e
add rsi, rax    ;
mov _res1, rsi  ;

ret
count endp
entry_point proc
invoke count,_a1,_b1,_c1,_d1,_e1,_f1
invoke wsprintf,ADDR buf1,ADDR _text,_res1,ADDR _res1
invoke MessageBox,0,addr buf1, addr _title, MB_ICONINFORMATION
invoke ExitProcess,0
entry_point endp
end