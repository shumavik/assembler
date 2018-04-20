; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit   DB    13,10,"Press Enter to Exit",0AH,0DH,0
Enter_Msg DB    "input your string",0AH,0DH,0
         .DATA
buffer     DB    8 dup(?)
Str_Enter  DB    38 dup(?) ;����� ��� ����� ������
Result     DD    37 dup(?)
Res_Str    DB    16 dup(?) ;����� ��� ������ ����������
no         DB    "no"
yes        DB    "yes"
Perenos     DB    13,10
         .DATA?
inbuf    DB    100 DUP (?)
kol      dword   ?
         .CODE
Start:
         
         cld
         mov ECX,0
         
         Invoke StdOut,ADDR Enter_Msg 
         Invoke StdIn, ADDR Str_Enter,LengthOf Str_Enter
         Invoke StripLF,ADDR Str_Enter
         
         lea EDI,Str_Enter
         mov ECX,38
         mov AL,0
         XOR EBX,EBX
         
         
         ;repne scasb            ; ����� ����� ������
         
         ;mov AX,38              ; � AX ������ ������
         ;sub AX,CX              ; � AX ������ ������ + 1
         ;mov CX,AX              
         ;dec CX                 ; � CX ����� ������
                 
         ;lea EDI,Str_Enter      ; ����� ������
         ;mov AL,' '             ; ����� AL ���� ��������� � �������� 
         ;mov EBX,0              ; ���������� ����
         ;cld
         
         ;cycle1: cmp CX,0       ; ����� ����� ������
          ;       je kon         ; ��������� � �����
           ;      mov DX,0       ; ������� ���������� �������� � �����
         
         ;cycle2: scasb          ; ����� �������
          ;       je consl       ; 
           ;      
            ;     inc DX         ; ����������� �����
             ;    dec CX         ; ��������� ����� ������
              ;   jmp cycle2     ; ��������� �� ����� ������� 
                                ; � DX ����� �����
                                ; � CX ���������� ���������� � ������ �������� 
         ;consl:  cmp DX,8       ; ����� �� 8 ����?
          ;       jg prod       ; ���� ���� > 8
           ;      inc BX         
            
         ;prod:   dec CX         ; ��������� �� 1 ��-�� ������� ����� �������
          ;       jmp cycle1     ; ��������� �� ������ ������ ����� ������ � ����
         
         
         
         
         
         
         
         lea EDI,Str_Enter      ; ����� ������
         mov AL,' '             ; ����� AL ���� ��������� � �������� 
         mov EBX,0              ; ���������� ����
         cld
         
         cycle1: cmp CX,0       ; ����� ����� ������
                 je kon         ; ��������� � �����
                 mov DX,0       ; ������� ���������� �������� � �����
         
         cycle2: 
                 
                 scasb          ; ����� �������
                 push AX
                 mov AL,DL
                 
                 
                 je consl       ; 
                 
                 inc DX         ; ����������� �����
                 dec CX         ; ��������� ����� ������
                 jmp cycle2     ; ��������� �� ����� ������� 
                                ; � DX ����� �����
                                ; � CX ���������� ���������� � ������ �������� 
         consl:  cmp DX,8       ; ����� �� 8 ����?
                 jg prod       ; ���� ���� > 8
                 inc BX         
            
         prod:   dec CX         ; ��������� �� 1 ��-�� ������� ����� �������
                 jmp cycle1     ; ��������� �� ������ ������ ����� ������ � ����
         
         
         
                        
               
         kon:  
         mov kol,EBX
                
               
            
         
         
         
         XOR    EAX,EAX
        
         
         
         Invoke dwtoa,kol,ADDR Result      
         Invoke StdOut,ADDR Result
         
         Invoke StdOut, ADDR Perenos
         Invoke StdOut,ADDR Str_Enter
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start
