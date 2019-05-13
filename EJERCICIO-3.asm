  
  ;EJERCICIO: 4
  ;ELABORADO POR: HAU CUPUL LUIS MIGUEL           
  
  DATA SEGMENT
    
      CADENA1 DB 'MENU DE OPCIONES$'
      CADENA2 DB '[1]SUMA, RESTA, MULTIPLICACION Y DIVISION$'
      CADENA3 DB '[2]NUMERO MAYOR$'
      CADENA4 DB 'SELECCIONE UNA OPCION:$' 
      
      ;OPERACIONB 
       DATO1 DB 'NUMERO 1: ','$'
       DATO2 DB 13,10,'NUMERO 2: ','$'
       DATO3 DB 13,10,'SUMA: ','$'
       DATO4 DB 13,10,'RESTA: ','$'
       DATO5 DB 13,10,'MULTIPLICACION: ','$'
       DATO6 DB 13,10,'DIVISION: ','$'
       LINEA DB 13,10,'$'
       VAR1 DB 0
       VAR2 DB 0
      ;FIN DE OPERACIONB
      
      ;NUMERO MAYOR
       MSJ1 DB 'INGRESE TRES DIGITOS DEL 0 AL 9 : $'
       MAYOR DB 'EL DIGITO MAYOR ES: $'
       DIGITO1 DB 100 DUP(' $')
       DIGITO2 DB 100 DUP(' $')
       DIGITO3 DB 100 DUP(' $')
      ;FIN DEL NUMERO MAYOR
      
  DATA ENDS
     
 
  CODE SEGMENT
     PROJECT8:
     
     ASSUME DS:DATA, CS:CODE   
     
;---------------------------------------------------------
;---------------------------------------------------------    
     ;FONDO PRINCIPAL
     MOV AH,06H
     MOV AL,0 
     MOV BH,8AH ;FONDO PRINCIPAL GRIS Y TEXTO VERDE CLARO
     MOV CX,0000H
     MOV DX,184FH 
     INT 10H
     
;---------------------------------------------------------
;---------------------------------------------------------
    
     ;CUADRO1
     MOV AX, DATA
     MOV DS,AX
     MOV AH,06H
     MOV AL,0 
     MOV BH,09H ;CUADRO 1 FONDO NEGRO Y TEXTO AZUL CLARO
     MOV CX,020AH  ;inicio   COLUMNA,FILA
     MOV DX,0241H  ;final
     INT 10H
    
;---------------------------------------------------------
;--------------------------------------------------------- 
     
     ;CUADRO2
     MOV AX, DATA
     MOV DS,AX
     ;FUNCION PARA RECORRER PANTALLA
     ;FONDO GRIS, TEXTO VERDE CLARO
     MOV AH,06H
     MOV AL,0 
     ;MOV AX,0600H
     MOV BH,3EH ;FONDO CIAN Y TEXTO CIAN CLARO.
     MOV CX,050AH 
     MOV DX,1441H 
     INT 10H
         
;---------------------------------------------------------
;---------------------------------------------------------
      
        ;TITULO DE MENU
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 02H; 02
        MOV DL, 1EH; 30 
        INT 10H          
        
        MOV AH, 09H
        LEA DX, CADENA1
        INT 21H
        
;---------------------------------------------------------
;---------------------------------------------------------

        ;MENU DE OPCIONES
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 0AH; 06 NUMERO DE RECORRIDO HACIA ABAJO   
        MOV DL, 0CH; 0C NUMERO DE RECORRIDO HACIA LA DERECHA
        INT 10H             
        MOV AH, 09H
        LEA DX, CADENA2
        INT 21H
        
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 0CH; 08 RECORRIDO HACIA ABAJO  
        MOV DL, 0CH; 0C RECORRIDO A LA DERECHA
        INT 10H           
        MOV AH, 09H
        LEA DX, CADENA3
        INT 21H 
        
;---------------------------------------------------------
;---------------------------------------------------------
        
        ;SELECCION
        MOV AH, 02H
        MOV BH, 0
        MOV DH, 16H; 22 C. RECORRIDO HACIA ABAJO
        MOV DL, 28H; 40 RECORRIDO HACIA LA DERRECHA
        INT 10H      
        MOV AH, 09H
        LEA DX, CADENA4
        INT 21H          
        
;---------------------------------------------------------
;---------------------------------------------------------
        
        PAG:
            ;LEER CARACTER
            MOV AH, 0H
            INT 16H
        
            CMP AL, "1"
            JE OPERACIONB
            CMP AL, "2"
            JE NMAYOR
            JMP FIN
            
;---------------------------------------------------------
;---------------------------------------------------------
        
        OPERACIONB:
            MOV AH, 05H
            MOV AL, 1
            INT 10H  
            
            MOV AH, 06H
            MOV AL, 0
            MOV BH, 1AH
            MOV CX, 0000H;0, 0
            MOV DX, 184FH;24,79
            INT 10H
            
            ;INICIO OPERACIOB
            
            CALL LIMPIA
            MOV AH,09H
            LEA DX, DATO1 ;desplegar numero 1:
            INT 21H
        
            CALL LEER ;lee primer numero
            SUB AL,30H ;restar 30h para obtener el numero
            MOV VAR1,al ;lo guardo en var1
            MOV AH,09h
            LEA DX, DATO2 ;desplegar numero 2:
            INT 21H
        
            CALL LEER ;lee segundo numero
            SUB AL,30H ;restar 30h para obtener segundo valor
            MOV VAR2,al ;guardar en var2
            MOV BL,VAR2 ;mover a bl
        
        ;------------SUMA---------------------
            ADD BL,VAR1 ; realizo la suma de var2(bl) y var1 y el resultado queda en bl
            MOV AH,09H
            LEA DX,DATO3 ;imprimir suma
            INT 21H
            MOV DL,BL ;pongo en dl el numero a imprimir var2(bl)
            ADD DL,30H ; agrego 30h para obtener el caracter    
            MOV AH,02H ;imprime un caracter
            INT 21H
        
        ;-----------RESTA------------------------------------
            MOV BL,VAR1
            SUB BL,VAR2
            MOV AH,09H
            LEA DX,DATO4 ;desplegar resta:
            INT 21H 
            
            MOV DL,BL ;mover resta a dl para imprimir
            ADD DL,30H ;sumar 30 para obtener caracter
            MOV AH,02H ;imprimir un caracter
            INT 21H
        
        ;-------------MULTIPLICACION--------------------
            MOV AH,09H
            LEA DX,DATO5 ;desplegar mult
            INT 21H
        
            MOV AL,VAR1 
            MOV BL,VAR2
            MUL BL ;mult al=al*bl
            MOV DL,AL ;mover al a dl para imprimir
            ADD DL,30H ;sumar 30 para obtener caracter
            MOV AH,02H ;imprimir caracter
            INT 21H
        
        ;--------------DIVISION-------------------------
            MOV AH,09H
            LEA DX,DATO6 ;desplegar div
            INT 21H 
            
            XOR AX,AX ;limpiamos el registro ax. 
            MOV AL,VAR2
            MOV BL,AL
            MOV AL,VAR1
            DIV BL ; divide AX/BX el resultado lo almacena en AX, el residuo queda en DX
            MOV BL,AL
            MOV DL,BL
            ADD DL,30H
            MOV AH,02H
            INT 21H 
            
             MOV AH, 0H
             INT 16H
             CMP AL, 008
             JE ATRAS
             JMP FIN
        
        ;-------------PROCEDIMIENTOS------------------
            SALTO PROC NEAR
            MOV AH,09H
            LEA DX,LINEA
            INT 21H
            MOV DL,00H
            RET
            SALTO ENDP
        
            LEER PROC NEAR
            MOV AH,01H;leer caracter desde el teclado
            INT 21H;lee primer caracter
            RET
            LEER ENDP
        
            LIMPIA PROC NEAR
            MOV AH,00H
            MOV AL,03H
            INT 10H
            RET 
            
        LIMPIA ENDP
        
        ;FIN DE OPERACIONB   
            
;---------------------------------------------------------
;---------------------------------------------------------
            
        NMAYOR:
            MOV AH, 05H
            MOV AL, 2
            INT 10H
            MOV AH, 06H
            MOV AL, 0
            MOV BH, 2AH
            MOV CX, 0000H;0, 0
            MOV DX, 184FH;24,79
            INT 10H
        ;INICIO NUMERO MAYOR
              MOV SI,0
              MOV AX,@DATA    
              MOV DS,AX
              
              ;FONDO PRINCIPAL
              MOV AH,06H
              MOV AL,0 
              ;MOV AX,0600H
              MOV BH,4AH ;FONDO PRINCIPAL GRIS Y TEXTO VERDE CLARO
              MOV CX,0000H
              MOV DX,184FH 
              INT 10H
             
              
              MOV AH,02H
              MOV BH,0
              MOV DH,0BH
              MOV DL,08H
              INT 10H 
              
              MOV AH,09
              MOV DX,OFFSET MSJ1 ;Imprimimos el msj1  
              INT 21H
              
              CALL SALTODELINEA;llamamos el metodo saltodelinea.
              CALL PEDIRCARACTER ;llamamos al metodo 
              
              MOV DIGITO1,AL ;lo guardado en AL a digito1  
              
              CALL SALTODELINEA
              
              CALL PEDIRCARACTER 
              
              MOV DIGITO2,AL
              
              CALL SALTODELINEA  
              
              CALL PEDIRCARACTER 
              
              MOV DIGITO3,AL 
              
              CALL SALTODELINEA
              
        ;---------------------------------------------------------------
              MOV AH,DIGITO1
              MOV AL,DIGITO2 
              
              CMP AL,AL ;compara primero con el segundo
              JA COMPARA-1-3 ;si es mayor el primero, ahora lo compara con el tercero 
              JMP COMPARA-2-3 ;si el primero no es mayor,ahora compara el 2 y 3 digito 
              COMPARA-1-3:   
              
              MOV AL,DIGITO3 ;ah=primer digito, al=tercer digito 
              CMP AH,AL ;compara primero con tercero 
              
              JA MAYOR1 ;si es mayor que el tercero, entonces el primero es mayor que los 3  
              
              COMPARA-2-3:
              MOV AH,DIGITO2
              MOV AL,DIGITO3  
              
              CMP AH,AL ;compara 2 y 3, YA NO es necesario compararlo con el 1,porque ya sabemos que el 1 no es mayor que el 2
              JA MAYOR2 ;Si es mayor el 2,nos vamos al metodo para imprimirlo 
              
              JMP MAYOR3 ;Si el 2 no es mayor, obvio el 3 es el mayor
              
        
              MAYOR1: 
              CALL MENSAJEMAYOR ;llama al metodo que dice: El digito mayor es: 
              MOV DX, OFFSET DIGITO1 ;Imprir El Digito 1 es mayor 
              MOV AH, 9
              INT 21H
              JMP EXIT
              
              MAYOR2:
              CALL MENSAJEMAYOR 
              
              MOV DX, OFFSET DIGITO2 ;Salto de linea 
              MOV AH, 9
              INT 21H
              JMP EXIT
              
              MAYOR3:
              CALL MENSAJEMAYOR
              
              MOV DX, OFFSET DIGITO3 ;Salto de linea
              MOV AH, 9
              INT 21H
              JMP EXIT
              
              
              ;METODOS
              MENSAJEMAYOR:
              MOV DX, OFFSET MAYOR ;El digito Mayor es:
              MOV AH, 9
              INT 21H 
              
              RET
              PEDIRCARACTER:
              MOV AH,01H; pedimos primer digito
              INT 21H
              RET
              
              SALTODELINEA:
              MOV DX,OFFSET SALTODELINEA ;Salto de linea
              MOV AH,9
              INT 21H
              RET
              
              EXIT:
              MOV AX, 4C00H;utilizamos el servicio 4c de la interrupcion 21h
              INT 21H ;para termianr el programa
 
        ;FIN DE NUMERO MAYOR
            MOV AH, 0H
            INT 16H
            CMP AL, 008
            JE ATRAS
            JMP FIN
            
;---------------------------------------------------------       
;---------------------------------------------------------
        
        ATRAS:
            MOV AH, 05H
            MOV AL, 0
            INT 10H
            JMP PAG
            
;---------------------------------------------------------
;---------------------------------------------------------
            
        
        FIN:
            INT 21H
            
CODE ENDS
 END PROJECT8
                                     
                                     
                                     