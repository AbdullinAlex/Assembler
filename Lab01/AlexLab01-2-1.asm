include \masm64\include64\masm64rt.inc ; ����������
count PROTO arg_a:QWORD,arg_b:QWORD,arg_c:QWORD,arg_d:QWORD, arg_e:QWORD,arg_f:QWORD
.data
_a1 dq 10
_b1 dq 9
_c1 dq 2
_d1 dq 3
_e1 dq 3
_f1 dq 15
_res1 dq 0
_title db "��1-2. ���������.",0
_text db "��������� ac + b/d + f/e",10,"���������: %d",10,"����� ���������� � ������: %p",10,10,
"�����: �������� �. �., ���-119�, ������� 1",0
buf1 dq 3 dup(0),0

.code
count proc arg_a:QWORD, arg_b:QWORD, arg_c:QWORD, arg_d:QWORD, arg_e:QWORD, arg_f:QWORD
mov rax, rdx    ; � rax ����� b
xor rdx,rdx     ; ��������� ��������
div r9          ; b/c
mov rsi, rax    ; �������� �������� � rsi
mov rax, rcx    ; � rex ����� a
mul r8          ; a*c
add rsi, rax    ;

mov rax, arg_f  ; ��������� f � rax
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