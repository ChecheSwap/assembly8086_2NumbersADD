

COMMENT!
MANS ACTIONS ARE THE PICTURE BOOK OF HIS CREEDS ~R.W.E [T:.A:.F]
!


org 100h

     VAR1 DB 4 DUP(?)
     
     VAR2 DB 4 DUP(?)
     
     RESX DB 5 DUP(?)
     
     PIVOTE DB 5,?,?,?,?,?,?
     
     
     START:    
     
     LEA DX,PIVOTE
     
     CAPTURA:
     
     MOV AH, 0AH
     INT 21H    
               
     LEA BX, PIVOTE
     LEA BP, VAR1
     
     XOR CX,CX 
     
     MOV CL,[BX+1]
     
     CICLO:  
     
     MOV SI,CX
     
     MOV DL, [BX+SI+1H]
     
     SUB DL,30H
     
     MOV [BP+3], DL
     
     DEC BP
     
     LOOP CICLO   
     
     XOR CX,CX
     
     
             
     CLEARPIVOTE:
     
     MOV CX , 07H
               
         CLEARNOW: 
         
         MOV SI,CX
         
         MOV PIVOTE[SI], 0H        
         
         LOOP CLEARNOW
         
         CMP BL, 33H
         
         JE SUMSTART
     
     
     NEXT:
     
     MOV DL,2BH
     
     MOV AH, 02H
     
     INT 21H
     
     
     LEA DX, PIVOTE
     
     MOV AH, 0AH
     
     INT 21H
               
     LEA BX, PIVOTE
     LEA BP, VAR2
     
     XOR CX,CX 
     
     MOV CL,[BX+1]     
     
     SECONDCICLO:  
     
     MOV SI,CX
     
     MOV DL, [BX+SI+1H]
     
     SUB DL,30H
     
     MOV [BP+3], DL
     
     DEC BP
     
     LOOP SECONDCICLO
     
         
         FIRSTSTEPAD:
         
         MOV BL, 33H
         
         JMP CLEARPIVOTE
                  
         
         SUMSTART: 
         
         LEA BP, RESX 
         
         MOV BX, OFFSET VAR1
         MOV SI, OFFSET VAR2 
         MOV DI, OFFSET PIVOTE
         
         MOV CX, 04H  
         XOR AX,AX
         
            INON:
            
             MOV AL,[BX+3]
             ADD AL,[SI+3]
             ADD AL,[DI+1]
             MOV [DI+1],0H
             
             CMP AL, 0AH
             JAE SUBCARRY
             
             SAVENOW:
             ADD AL, 30H
             MOV [BP+4H],AL
             DEC BP
             DEC BX
             DEC SI
             LOOP INON
             
             JMP ADDCARRY
             
             SUBCARRY:
             
             SUB AL, 0AH
             MOV [DI+1], 01H
             JMP SAVENOW
             
             ADDCARRY:
             XOR AL, AL
             MOV AL, [DI+1]
             ADD AL, 30H
             MOV [BP+4H],AL
             
                PRINTME:
                
                MOV DL,3DH
     
                MOV AH, 02H
     
                INT 21H
                
                LEA BX,RESX
                
                MOV CL,05H
                MOV DH,0H
                
                    PRINTING:
                    
                        
                        MOV AH, 02H
                        MOV DL, [BX]
                        
                        CMP DH,0H
                        JE PEXT
                        JNE ISVALID                                              
         
                            ZNEXT:
                            INC BX
                            LOOP PRINTING                      
                            JMP EXIT
                            
                        PEXT:
                        CMP DL, 30H                                                                       
                        JNE ISVALID
                        JE ZNEXT
                        
                        ISVALID:
                        MOV DH,01H
                        INT 21H
                        JMP ZNEXT 
                        
                        COMMENT!
                        "ES ILOGICO SUMAR 0 + 0, POR FAVOR, NO SUME 0 + 0"!
                        
EXIT:                    
         
HLT
RET