  ; Programa que COMPARA CADENAS,DE DOS EN DOS, USO DE CMPSB Y CMPSW
  .model small
  .stack 100h
  .data
  MEN1 DB 'ENSAMBLADOR$'
  MEN2 DB  'ENSAMBLADOR$'
  MEN3 DB  'Ensamblador$'
  MEN4 DB 'MEN1 ES IGUAL A MEN2$'
  MEN5 DB 'MEN1 ES IGUAL A MEN3$'
  MEN6 DB 'NO SON IGUALES$'
  SALTA DB 13,10,'$'
  BANDERA1 DB 0
  BANDERA2 DB 0
  .code
  inicio proc far
  ;PROTOCOLO
    PUSH DS
    SUB AX,AX
    PUSH AX
    MOV AX,@data
    MOV DS,AX ; DS=ES
    MOV ES,AX   ;***********

    CLD
    MOV CX,06
    LEA DI,MEN1
    LEA SI,MEN2
    REPE CMPSW
    JNE OTRA  ;SALTA A COMPARAR CON LA OTRA CADENA (si son distintas)
    MOV BANDERA1,01 ; BANDERA ACTIVADA
OTRA:
    MOV CX,12
    LEA DI,MEN1
    LEA SI,MEN3
    REPE CMPSB
    JNE EDO1   ; SALTA A COMPARAR ESTADO DE LAS BANDERAS
    MOV BANDERA2,01
EDO1:
    CMP BANDERA1,01
    JNE MAL1
    LEA DI,MEN4
    MOV DX,DI
    CALL MENSAJE
    LEA DX,SALTA
    CALL MENSAJE
    JMP EDO2
MAL1:
    LEA DI,MEN6
    MOV DX,DI
    CALL MENSAJE
    LEA DX,SALTA
    CALL MENSAJE
EDO2:
    CMP BANDERA2,01
    JNE MAL2
    LEA DI,MEN5
    MOV DX,DI
    CALL MENSAJE
    JMP EXIT
  MAL2:
    LEA DX,MEN6
    CALL MENSAJE
    EXIT: CALL FIN
  INICIO endp
  FIN proc
    push ax
    mov ah,4ch
    int 21h
    pop ax
  FIN endp
  MENSAJE PROC
    PUSH AX
    MOV AH,09H
    INT 21H
    POP AX
    RET
    MENSAJE ENDP
  end  inicio