include \masm64\include64\masm64rt.inc
.data       ;  ������ ������
a1 dq 1     ;  ���������� �������� a1  
c1 dq 10    ;  ���������� �������� c1
d1 dq 15    ;  ���������� �������� d1
temp1 dq 2  ;  ���������� �������� temp1
title1 db "��1. ������� ���������.",0                           ; �������� ���������
txt1 db "��������� 2d/�  � ad",10,                              ; �������������� �������
"���������: %d",10,"����� ���������� � ������: %ph",10,10,      ; ����� ����������
"�����: �������� �. �., ���-119�, ������� 1",0                  ; �����
buf1 dq 3 dup(0),0 ; ������� �������

.code            ; ������ ����
entry_point proc ; ����� ������ ���������
mov rax,d1       ; ��������� �������� d1 � rax
mul temp1        ; ��������� �������� rax �� �������� �������� temp1
                 ; ������������� rdx ��������� ��� ���������� ���������
div c1           ; ��������� � rax � ����� �����, � rdx � �������
mov rsi,rax      ; ��������� ��������� � �������� rsi
mov rax,a1       ; ��������� � rax �������� a1
mul d1           ;
sub rsi,rax      ; ��������� �������� � �������� rax �� �������� � �������� rsi

invoke wsprintf,ADDR buf1,ADDR txt1,rsi ; ������� ��������������
invoke MessageBox,0,ADDR buf1,ADDR title1,MB_ICONINFORMATION
invoke ExitProcess,0     ; ���������� ��������  �  ������������ ��������
entry_point endp         ; ���������� ��������� � ������
end                      ; ���������� ���������