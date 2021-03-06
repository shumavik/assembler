; Template for console application
         .586
         .MODEL  flat, stdcall
         OPTION CASEMAP:NONE

Include kernel32.inc
Include masm32.inc

IncludeLib kernel32.lib
IncludeLib masm32.lib

         .CONST
MsgExit  DB    "Press Enter to Exit",0AH,0DH,0


         .DATA
A        sword  0,0,0,0
         sword  0,0,0,0
         sword  0,0,0,0
         
B        sword  0,0,0,0

index    sword    0

Perenos DB    13,10,0
Probel  DB  ' ',0
MsgInput DB "Enter a element the matrix",13,10,0
MsgOutput DB    "Output the matrix",13,10,0
buffer    DB    100 dup(?),0
check     DB    "Y",13,10,0 
         .DATA?
inbuf    DB    100 DUP (?)
min      sword    ?
max      sword    ?
         .CODE
Start:  
        
        mov EBX,0
        mov ECX,12
        
 InputCycle:
                push ECX
                Invoke StdOut, ADDR MsgInput
                Invoke StdIn, ADDR buffer,LengthOf buffer
                Invoke StripLF, ADDR buffer
                Invoke atol, ADDR buffer
                
                                
               mov A[EBX],AX
                add EBX,2
                pop ECX

                
                loop InputCycle
                
                Invoke StdOut, ADDR MsgOutput
                
                mov EBX,0  
                mov ECX,3
                
  OutputCycle1:              
                push ECX
                mov ECX,4
  OutputCycle2:              
                    push ECX
                    Invoke dwtoa,A[EBX*2],ADDR buffer
                    Invoke StdOut, ADDR buffer
                    Invoke StdOut,ADDR Probel
                    pop ECX
                    Inc EBX
                                   
                    loop OutputCycle2
                    pop ECX
                    push ECX
                    Invoke StdOut,ADDR Perenos
                    pop ECX                  
                 
                    loop OutputCycle1              

                mov EBX,0
                mov ECX,3
               
                
                
ActionCycle1:
                mov AX,A[EBX*2]
                mov max,AX
                mov min,AX
                XOR EAX,EAX
                
                
                
                
                
                push ECX
                mov ECX,3
ActionCycle2:
                Inc EBX
                mov AX,A[EBX*2]
                cmp AX,min
                
                jl minsearch
                
                jmp continue1
                
                
          minsearch:
                     mov min,AX
                     push ECX
                     Invoke StdOut, ADDR check
                     pop ECX   
continue1:      cmp AX,max                
                jg maxsearch
                
                jmp continue2
maxsearch:      mov max,AX
                                
continue2:     ; cmp min,0
               ; je zerofind          
                loop ActionCycle2
                
                
                mov AX,max
                cwd
                idiv sword PTR min
       zerofind:pop ECX
                push EBX
                mov BX,index
                mov B[EBX],AX
                add index,2
                pop EBX
          
                Inc EBX
                XOR EAX,EAX
                loop  ActionCycle1    

                mov EBX,0
                mov ECX,3
                
FinalCycle:   
              push ECX
              Invoke dwtoa,B[EBX],ADDR buffer
              Invoke StdOut,ADDR buffer
              Invoke StdOut,ADDR Probel
              pop ECX  
              add EBX,2
        loop FinalCycle
              
         XOR    EAX,EAX
         Invoke StdOut,ADDR MsgExit
         Invoke StdIn,ADDR inbuf,LengthOf inbuf		
	
         Invoke ExitProcess,0
         End    Start

