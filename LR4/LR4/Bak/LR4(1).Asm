; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    13,10,"Press Enter to Exit",0AH,0DH,0

         .DATA
;Zapros DB 13,10,'Input a',13,10,0
;Zapros2 DB 13,10,'Input m',13,10,0
RequestA DB "Input matrix 5x5=25: ",0AH,0DH,0

    
    
    ;    NxN 
    ;   i<=N-j+i 
    ;
    ;
    ;
            A sword 0,0,0,0,0
              sword 0,0,0,0,0
              sword 0,0,0,0,0
              sword 0,0,0,0,0   
              sword 0,0,0,0,0
           N sword 5
           i sword 1   
           j sword 1
    
;ResTrue DB 13,10,'Find:m-5',13,10,0
;ResFalse DB 131,10,'Find:m+a/2',13,10,0
 
Result DB 'summa = '
ResStr DB 16 DUP (' '),0
ResMatrix DB 16 DUP (' '),0


         .DATA?
;Buffer DB 10 DUP (?)
inbuf    DB    100 DUP (?)
;a       sWord      ?
;m       sword      ?
;b       sword      ?
sum     sword    ?
res     sword    ?
InOutBuf       DB    100 DUP (?) ; ����� ����� / ������
          current sword ?
         .CODE
Start:
        ;Invoke StdOut,ADDR Zapros
        ;Invoke StdIn,ADDR Buffer,LengthOf Buffer
        ;Invoke StripLF,ADDR Buffer
        
        ;Invoke atol,ADDR Buffer
        ;mov dword PTR a,EAX
        
            ;���� �������
          Invoke StdOut, ADDR RequestA
          mov EBX,0
          mov ECX,25
    
  CycleInput:
                push ECX
                Invoke StdIn,ADDR InOutBuf,LengthOf InOutBuf
                Invoke StripLF, ADDR InOutBuf
                Invoke atol, ADDR InOutBuf
                mov  A[EBX],AX            
                pop ECX
               add EBX,2
                
           
                loop CycleInput
      

        
        ; ����� ������������� ��������� ��� �������� ����������    
                
          mov EBX,0    ;� EBX ����� �������� ������������ ����
          
          mov ECX,5   ;ECX ���������� ��������          
          cycle1: push ECX
                        mov ECX,5
          cycle2:
                    
                    XOR EDX,EDX  ;������� EDX
                    
                   mov DX,N     ;DX:=N
                   mov  current,DX ;current:=N
                   mov DX,j   ;DX:=j
                      sub current,DX ;current:=N-j
                      inc current  ;current:=N-j+1
                    
                      ;��������� N-j+1 ������������ "������"
                      ;��� �������� ����������
                    mov DX,current ;DX:=N-j+1
                    cmp i,DX   ;i<=N-j+1 
                      
                    jle metka1 ;������� ���������
                    
                    jmp continue ;������� �����
          
         metka1:    cmp A[EBX*2],0 ;���������� ������������� �������
                    
                    jg metka2  ;������� ������� �����������
                    
                    jmp continue ;������� ������� �����������
                    
         metka2:    mov AX,A[EBX*2]  
                    add res,AX      ;������� ����� ������������� ���������
          
          
       
        continue:       
                    
                   inc EBX
                   inc j 
                   loop cycle2
                    
                    pop ECX
                    sub j,5 ;j:=j-5=N+1-5 � j ����� 1
                    inc i
                    loop cycle1              
                 

         XOR    EAX,EAX
         ;����� �������
         
          mov EBX,0    ;� EBX ����� �������� ������������ ����
          
          mov ECX,5   ;ECX ���������� ��������          
          cycleOutput1: 
                        push ECX
                        mov ECX,5
          cycleOutput2:
                       Invoke dwtoa,A[EBX*2],ADDR ResMatrix
                          
                   inc EBX 
                   loop cycleOutput2 
                    pop ECX
                    loop cycleOutput1              
         XOR    EAX,EAX
         
         
         Invoke dwtoa,res, ADDR ResStr
         Invoke StdOut,ADDR Result 
         
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start
