         .586
         .MODEL  flat
         
         .DATA
         i     dword 0          ; ����� ��������
         position dword 0       ; �������� �� ������ ������ ����� 
         current dword 0
         glasn DB "aeiouy"      ; ������ � ��������
         .CODE
		 RESULT  proto c str2:ptr byte;�������� ������� ��������� ������ ����������         
    public  _GLASDEL;���������� ����������� ����� ���������
_GLASDEL proc
	  ;������ �������
        PUSH EBP
        MOV  EBP,ESP
        PUSH EBX
        PUSH EDI
        PUSH ESI
        ;����� �������
      
        
        
        MOV EDI,[EBP+8]    ;��������� ����� ������ � edi
        MOV ESI,[EBP+12]    ;��������� ����� ������� � �������� ������ ����
        MOV ECX,[EBP+16]   ; ��������� ����� ������
        MOV EBX,0       ;�������� ������� ������ �����
        MOV EDX,0       ;�������� ������� ������� ����� �����
        mov position,-1  ;position ������ ����� ��������� �� ������ ������ �����
        CLD         
        
cic1:   push EAX        ; ������������ position �� ����� �����
        dec i               ; ���������� � position ������������ 0
        mov EAX,i
        inc i       
        mov position,EAX
        inc position
        pop EAX
        CMP ECX,0       ;���� � ������������ ����� ������ ���������?
        JE  con         ;���� ��, ������� �� ����� �����������
        MOV EAX,' '     ;��������� � al ������ ��� ������
        MOV EDX,0       ;�������� ������� ������� ����� �����
        INC EBX         ;����������� ������� ������ �����
        
cic2:   dec ECX         ;��������� ������� ���������� ����� �����
        push ECX
        mov ECX,i
        mov AL,[EDI+ECX]        ; � i ����������� ������� �������� ��� ���� ������
        inc i
        pop ECX
        cmp AL,' '           ;��������� ��������� ������ �� ������
        JE  consl       ;���� ������ - ��������� �� ��������� ����� � �������
        INC EDX         ;���� ��� - ����������� ����� �����
        CMP ECX,0       ;����� ������ ���������?
        JE  consl2      ;���� ��, ��������� ��������� �����
        JMP cic2        ;������� �� ��������� �������� ����� ������ �������
              
consl2: DEC EDX;���������� �������� ����� ����� (������� ������)                   
consl:  
        CMP [ESI],EBX    ;���������� ����� ����� � ������� � �������
        JE  prod         ;���� ��������� - �������� ������� �������
        JMP cic1
        



prod:;���������� � �������� �������
        push ESI  
        PUSH EBX
        push EDX
        push ECX
        
        mov ECX,0           
        dec i               ; � i �������� ��� ����� �����
        mov EDX,position      ; � EDX �������� ��� ������ ������ �����
        mov ESI,EDI             ; � ESI ��������� �������� ������ 
        add ESI,EDX               ; ������� ESI ��� �� ������ ������ �����  
        
        dec EDX                 
   
kont:   mov EBX,0               ; � EBX �������� ��� ������ ������� 
        inc EDX                     ; � ������ glasn
        mov AL,[glasn+EBX]       ; � AL ������ ������� �� ������ glasn
        
        cmp EDX,i               ; �������� �� ��������� ����� � ������
        je prepare              ;���� ������� �� ������� �� ��������
        
cycle1:  
        cmp AL,[EDI+EDX]        ; ��������� �������� ������� � �������
        je glas                 ; ���� ������� �� ��������� ��������������� � ��������
        
        cmp EDX,i               ; �������� �� ��������� ����� � ������
        je prepare
        
        cmp EBX,5               ; ���� ��������� ����� � ������ glasn
        je kont                 ; �������� ��������� �� ��������� �������� � EDI

        

             
cycle2:   inc EBX               ; ����������� �������� � ������ glasn
repcycle: mov AL,[glasn+EBX]    ; � AL ����� ������� ��� ��������� � ������� �������� EDI
          jmp cycle1            ; ��������� ������� ��������� � �������
        
        
                
glas:   
        mov AL,[EDI+EDX]      ; � AL ������� ������  
        cmp AL,[glasn+EBX]     ; �������� ���������� � �������
        je glasafter             ; ���� ������� �� �������
        dec i                       ; ���� ����� ����� �� �������
        cmp i,EDX
        je prepare
        
        
        mov [EDI+EDX],AL        ; ���� �� ������� �������� ������ � EDI
        cmp EDX,i               ; �������� �� ����� �����
        je prepare
        inc i                   
        jmp glas                ; ������������ �� ����� glas

glasafter:   ; �������� � �������� �� ������ ������ �������
               cmp EDX,i        
        je prepare
             mov AL,' '
             mov [EDI+EDX],AL   ; �������� ������ ������ �������
            mov EBX,0           ; �������� �� ������ ������ glasn
         
             inc EDX            ; ����������� �������� ��� EDI
             jmp repcycle       ; ��������� ���� ��������� �������
        
prepare:                    
         mov AL,[EDI+EDX]   
         cmp AL,[glasn+EBX] ; ������� �� ��������� ������
         je lastzam
         cmp EBX,5          ; ���� ����� � ������ glasn, �� �������
         je final
         inc EBX            ; ��������� � ��������� �������
         jmp prepare        ; ���������� � ����� �������
         
lastzam: 
            mov AL,' '          ; ������� �������
            mov [EDI+EDX],AL
         
         
final:   pop ECX       ; ���������� � ������ �� ��������
         pop EDX
         pop EBX
         pop ESI
         add ESI,4      ; � ESI ����� �����, � ������� ������� ������� �������
         inc i
           jmp cic1     ; ������������ �� ����� ����� ������ �����
        
        
odin:  mov position,0   ; ���� ����� ���� ������
       jmp prod
      


con:;�������� ���������� � �++ � ������
        
        cmp position,1   ; ��� �������� �� ������� 
        je odin             ; ���� ����� ����� ����
        
        

        Invoke RESULT,[EBP+8]
        POP ESI
        POP EDI
        POP EBX
        POP EBP 
        ret
_GLASDEL endp
	End

