; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit   DB     13,10,"Press Enter to Exit",0AH,0DH,0
Enter_Msg DB    "Your string",0AH,0DH,0                 
mystr     DB    "aveaveme ggwwppxe yesbesit kekdzlol ",0  ; ������ ������ �� �������
res       DB     0AH,0DH,'Chislo razlichnix slov ',0AH,0DH,0  
         .DATA
Perenos     DB    13,10
         .DATA?
inbuf    DB    100 DUP (?)
rezstr   db      0AH,0DH,22 DUP (' '),0AH,0DH,0
kol           sword   ?
letters       sword    ?   ; ���������� ��������� ���� � �����
help          sdword    ?   ; ���������� ��� �������� � ���������� � ����� ������, �������� �� ������ � �����
         .CODE
Start:
         
         Invoke StdOut,ADDR Enter_Msg
         Invoke StdOut,ADDR mystr
         Invoke StdOut,ADDR Perenos  ; ��� ������� ������
         
         lea EDI,[mystr-1]  ; � EDI ������ �� �������
         lea ESI,[mystr-1]  ; � ESI �������� ������
         
         mov EBX,4 ; ���������� ���� � ������
         cld       ; ����� ����� DF-��������� �� ������ � ����� ������

  cycle1:   cmp BX,0  ; ����� ����?
                je conec  ; ��� ����� ����������, ������� �� �����
            dec BX      ; ��������� ���������� ����
            mov DX,8    ; ���������� ���� � ����� � DX
            mov letters,8 ; � ���������� letter ���������� ��������� ���� � �����, �������� ��� ��� ��� ������
            ; ���� �� ������ �� ����� �������� �� letters
            mov help,0    ; ��������� �������� �� ������ � �����
            add edi,1     ; �������� ������ �� ������ ������
            add esi,1     ; �������� ������ �� ������ ������

            cycle2:
                      cmp DX,0 ; �������� �� ����� � �����? 
                      je vivod     ; ������� �� viv, ���� �� �������� ���� � �����
                      mov EDI,ESI ; ��������������� � EDI ������ ��� ������� �� ���������� ������
                      dec DX     ; ��������� ���������� ���������� ���� � �����
                      lodsb      ; ��������� �� ESI ������ � ������� � ������� A0L ��� ����������� ������
                      mov ECX,7   ; � ECX ���������� ���������� ����
                      sub ECX,help ; �������� �� CX "���������� �����"
                      add EDI,1   ; ������� EDI �� 1 ������
                     cycle: cmp ECX,0  ; �������� �� ����� ����� ��������� "���������� ����"
                      je cycle3        ; ���� ���� �� �������� ������� �� cycle3
                      repne  scasb     ; ���� ������ � EDI=AL, ���� �� ����� �� � ECX 0
                        je equal       ; ������� ���������
                         jmp cycle     ; ���� ��� �������� �� ������� � ������, ����� 
                     equal: dec letters  ; ��������� ���������� ��������� ���� � ������� �����
                    cycle3: add help,1   ; ����������� �������� ����
                       jmp cycle2
            
            
            
            
              ; ������� ���������� ������ ���� � �����
              vivod:   push ECX
                    Invoke StdOut,ADDR res
                    Invoke dwtoa,letters,ADDR rezstr
                    Invoke StdOut,ADDR rezstr
                     pop ECX
                     
                      jmp cycle1

            
            
            
            
            
            
                     
   
         
         
         
  conec: XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

