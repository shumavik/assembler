         .586
         .MODEL  flat
         
         .DATA
         i     dword 0
         position dword 0
         current dword 0
         glasn DB "aeiouy"
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
        mov position,-1
        CLD
        
cic1:   push EAX
        dec i
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
        mov AL,[EDI+ECX]
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
        JE  prod         ;���� ��������� - �������� ������ ������� ����
        JMP cic1
        



prod:;���������� � �������� �������
        push ESI  
        PUSH EBX
        push EDX
        push ECX
        
        mov ECX,0
        dec i
        mov EDX,position
        mov ESI,EDI      
        add ESI,EDX
        
        dec EDX
   
kont:   mov EBX,0
        inc EDX        
        mov AL,[glasn+EBX]
        
        cmp EDX,i
        je prepare
        
cycle1:  
        cmp AL,[EDI+EDX]
        je glas
        
        cmp EDX,i
        je prepare
        
        cmp EBX,5
        je kont   

        

             
cycle2:   inc EBX 
repcycle: mov AL,[glasn+EBX]
          jmp cycle1
        
        
                
glas:   
        mov AL,[EDI+EDX]
        cmp AL,[glasn+EBX]
        je glasafter
        dec i
        cmp i,EDX
        je prepare
        
        
        mov [EDI+EDX],AL
        cmp EDX,i
        je prepare
        inc i
        jmp glas

glasafter:   
               cmp EDX,i
        je prepare
             mov AL,' '
             mov [EDI+EDX],AL
            mov EBX,0
         
             inc EDX
             jmp repcycle
        
prepare:  
         mov AL,[EDI+EDX]
         cmp AL,[glasn+EBX]
         je lastzamena
         cmp EBX,5
         je final
         inc EBX
         jmp prepare
         
lastzamena: 
            mov AL,' '
            mov [EDI+EDX],AL
         
         
final:   pop ECX
         pop EDX
         pop EBX
         pop ESI
         add ESI,4
         inc i
           jmp cic1    
        
        
odin:  mov position,0 
       jmp prod
      


con:;�������� ���������� � �++ � ������
        
        cmp position,1
        je odin
        
        

        Invoke RESULT,[EBP+8]
        POP ESI
        POP EDI
        POP EBX
        POP EBP 
        ret
_GLASDEL endp
	End

