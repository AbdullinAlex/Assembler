include \masm64\include64\masm64rt.inc
count PROTO arg_a:QWORD
.data
mas1 dq 12, 14, 5, 7, 42        ; ������ 
m1 dq 5                         ; ��������� M
l1 dq 2                         ; ��������� L
zero1 dq 0                      ; ����������� 0
len1 dq 5                       ; ����������� ������� 
resmas1 dq 3 dup(?),0           ; �������������� ������
title1 db "������� ������.",0
ifmt1 db "������ ����������� ����� �, �2��n. ������� �� �� ���, � ������� ������� �� ������� �� M ����� ��������� L (0 <= L <= M � 1)",10,
"���������:",10,
"resmas[0] = %d ",10,
"resmas[1] = %d ",10,
"resmas[2] = %d ",10,
"�����: �������� �.�.",0
buf1 dq 3 dup(0),0              ; ����� ������ ���������

.code
entry_point proc

mov r15, len1                    ; � r15 ������� ��������� � �������
lea rbx, byte ptr mas1           ; ��������� ��������� � rbx �� ����� ������� ������� 
lea rsi, byte ptr resmas1        ; ��������� ��������� � rsi �� ����� �������  ��������������� �������
mov rcx, m1                      ; � rcx ��������� M

@1:
xor rax, rax            ; ��������� �������� rax
xor rdx, rdx            ; ��������� �������� rdx
mov rax,[rbx]           ; � rax ������� ������ ������� ������� 
div rcx                 ; ����� ������� ������� �� ��������� M
cmp rdx, l1             ; ���������� ������ �� ������� � ��������� l1
je equel                ; �������, ���� �������� ������������ 
add rbx, 8              ; ����������� �� ��������� ������� �������
dec r15                 ; ��������� ��������� ��������� � �������
cmp r15, zero1          ; ��������� ��������� ��������� � ������� � 0
je zero                 ; �������, ���� �������� ��������� ��������� (r15) ����� 0
jmp @1                  ; ���� ���, �� ������� � ������

equel:
xor r8, r8              ; ��������� �������� r8
mov r8,[rbx]            ; ������ �������� �������� ������� � r8
mov [rsi],r8            ; ������ �� r8 � �������������� ������
add rbx, 8              ; ������ �� ������� 
add rsi, 8              ; ������ �� ��������������� �������
dec r15                 ; ��������� ������� �� ����
cmp r15, zero1          ; ��������� ��������� ��������� � ������� � 0
je zero                 ; �������, ���� �������� ��������� ��������� (r15) ����� 0
jmp @1                  ; ���� ���, �� ������� � ������
equelEnd:

zero:
mov r10, resmas1         ; ������ ���������� ������� �������� ������� � r10
mov r11, resmas1[8]      ; ������ ���������� ������� �������� ������� � r11
mov r12, resmas1[16]     ; ������ ���������� ������� �������� ������� � r12
                   
invoke wsprintf, ADDR buf1, ADDR ifmt1, r10, r11, r12;
invoke MessageBox,0,ADDR buf1, ADDR title1, MB_ICONINFORMATION
invoke ExitProcess, 0
entry_point endp
end