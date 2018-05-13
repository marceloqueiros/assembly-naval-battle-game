ORG 100h
include emu8086.inc
                   
jmp inicio2        

linha DB  13, 10,'     A   B   C   D   E   F   G   H   I   J', 13, 10 
DB '   ',218,'---------------------------------------',191, 13, 10, ' 1' 
linha1 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10  
DB '   ',195,'---------------------------------------',180, 13, 10, ' 2'
linha2 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10   
DB '   ',195,'---------------------------------------',180, 13, 10, ' 3' 
linha3 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10   
DB '   ',195,'---------------------------------------',180, 13, 10, ' 4' 
linha4 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10    
DB '   ',195,'---------------------------------------',180, 13, 10, ' 5' 
linha5 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10   
DB '   ',195,'---------------------------------------',180, 13, 10, ' 6' 
linha6 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10    
DB '   ',195,'---------------------------------------',180, 13, 10, ' 7' 
linha7 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10    
DB '   ',195,'---------------------------------------',180, 13, 10, ' 8' 
linha8 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10    
DB '   ',195,'---------------------------------------',180, 13, 10, ' 9' 
linha9 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10     
DB '   ',195,'---------------------------------------',180, 13, 10, '10' 
linha10 DB ' | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ | ~ |', 13, 10    
DB '   ',192,'---------------------------------------',217, 13, 10, '$' 

pedenumero DB  'Linha de 1 a 10:   $'   
pedeletra DB   'Coluna de A a J:   $'   
falhou db      ' - FALHOU O ALVO!           $'
acertoub db    ' - ACERTOU NUM BARCO!       $'
acertousubm db ' - ACERTOU NUM SUBMARINO!   $'
acertoupavi db ' - ACERTOU NUM PORTA-AVIOES!$'
msmbarco db    ' - Repetido.                $'
ganhou db 'GANHOU! ACERTOU EM TODOS OS ALVOS!$'
ganhoutent db 'Numero de tentativas: $'
fimjogo2 db 'Jogo terminado.$'
fimjogo db 'Prima qualquer tecla para sair.$'

Legenda   db 218,'------------LEGENDA------------',191,'$'
legenda2  db    '|1 Porta-avioes                 |$'
legenda3  db    '|     ',218,'---',191,'                     |$'
legenda4  db    '|     | ',02h,' |       1 Submarino   |$'
legenda5  db    '| ',218,'-----------',191,'   ',218,'-----------',191,' |$'
legenda6  db    '| | ',02h,' | ',02h,' | ',02h,' |   | ',02h,' | ',02h,' | ',02h,' | |$'
legenda7  db    '| ',192,'-----------',217,'   ',192,'-----------',217,' |$' 
legenda8  db    '|                 ',218,'---',191,'         |$'
legenda9 db    '|       3 barcos: | ',02h,' |         |$'
legenda10 db    '|                 ',192,'---',217,'         |$'                             
legenda11 db 192,'-------------------------------',217,'$'

tentativas  db 218, '----------',191,'$'
tentativas1 db     '| CONTADOR |','$'                                        
tentativas2 db     '|   000    |','$'
tentativas3 db     '|TENTATIVAS|','$'
tentativas4 db 192, '----------',217, '$'

barco1 db '000'
barco2 db '000'
barco3 db '000'
submarino db '000','000','000'          ; os barcos teem de estar em letras maiusculas no aleatorio 
portaavioes db '000','000','000','000' 
verificabarcos db '000'     ;barco 1 /2 /3
verificasubs db '000'          ; partes sub        ;quando se acerta ficam a 1
verificapavioes db '0000'  ; partes porta-avioes            

batalhanaval db 10,13, 10,13
      db '       _|_|_|                _|                _|  _|                ', 10,13
      db '       _|    _|    _|_|_|  _|_|_|_|    _|_|_|  _|  _|_|_|      _|_|_|', 10,13
      db '       _|_|_|    _|    _|    _|      _|    _|  _|  _|    _|  _|    _|', 10,13
      db '       _|    _|  _|    _|    _|      _|    _|  _|  _|    _|  _|    _|', 10,13
      db '       _|_|_|      _|_|_|      _|_|    _|_|_|  _|  _|    _|    _|_|_|', 10,13
      db '                                                            '        , 10,13
      db '                                                            '        , 10,13
      db '                                                                    ' ,10,13
      db '               _|      _|                                  _|        ' ,10,13        
      db '               _|_|    _|    _|_|_|  _|      _|    _|_|_|  _|', 10,13                  
      db '               _|  _|  _|  _|    _|  _|      _|  _|    _|  _|' , 10,13
      db '               _|    _|_|  _|    _|    _|  _|    _|    _|  _|' , 10,13                            
      db '               _|      _|    _|_|_|      _|        _|_|_|  _|'    , 10,13, 10,13, 10,13, 10,13
      db '                                                                 ', 10,13
      db '                       Marcelo Queiros Pinto - Al60102 - Engenharia Informatica' , 10,13
      db '                                                    Arquitetura de Computadores',10,13,10,13     
      db ' Prima qualquer tecla para iniciar o jogo. (modo hacker prima h) $'
hack db 0 
INICIO2: 
                                   
MOV DI, 0      ; esta variavel diz quantos barcos acertou 
 
                                                   

ALEATORIOB1:               ;ALEATORIO PARA BARCO1 
mov barco1[2],'0'
                
mov AH,2Ch     ;LETRA:
INT 21h

cmp dl, 90
jg letraA
cmp dl, 80
jg letraB
cmp dl, 70
jg letraC
cmp dl, 60
jg letraD
cmp dl, 50
jg letraE
cmp dl, 40
jg letraF
cmp dl, 30
jg letraG
cmp dl, 20
jg letraH
cmp dl, 10
jg letraI

jmp letraJ

letraA:
mov barco1[1], 'A'
jmp fimletrab1 
letraB:
mov barco1[1], 'B'
jmp fimletrab1
letraC:
mov barco1[1], 'C'
jmp fimletrab1
letraD:
mov barco1[1], 'D'
jmp fimletrab1
letraE:
mov barco1[1], 'E'
jmp fimletrab1
letraF:
mov barco1[1], 'F'
jmp fimletrab1
letraG:
mov barco1[1], 'G'
jmp fimletrab1
letraH:
mov barco1[1], 'H'
jmp fimletrab1              
letraI:
mov barco1[1], 'I'
jmp fimletrab1
letraJ:
mov barco1[1], 'J'

fimletrab1:
                             
                   ;NUMERO
               
mov AH,2Ch
INT 21h 

cmp dl, 90
jg n1
cmp dl, 80
jg n2
cmp dl, 70
jg n3
cmp dl, 60
jg n4
cmp dl, 50
jg n5
cmp dl, 40
jg n6
cmp dl, 30
jg n7
cmp dl, 20
jg n8
cmp dl, 10
jg n9

jmp n10

n1:
mov barco1[0], '1'
jmp fimnumerob1
n2:
mov barco1[0], '2'
jmp fimnumerob1
n3:
mov barco1[0], '3'
jmp fimnumerob1
n4:
mov barco1[0], '4'
jmp fimnumerob1
n5:
mov barco1[0], '5'
jmp fimnumerob1
n6:
mov barco1[0], '6'
jmp fimnumerob1
n7:
mov barco1[0], '7'
jmp fimnumerob1
n8:
mov barco1[0], '8'
jmp fimnumerob1
n9:
mov barco1[0], '9'
jmp fimnumerob1
n10:
mov barco1[0], '1'
mov al, barco1[1]
mov barco1[2], al
mov barco1[1], '0'

fimnumerob1:



               
               
ALEATORIOB2:               ;ALEATORIO PARA BARCO2  
mov barco2[2],'0'               
mov AH,2Ch     ;LETRA:
INT 21h

cmp dl, 90
jg letraA2
cmp dl, 80
jg letraB2
cmp dl, 70
jg letraC2
cmp dl, 60
jg letraD2
cmp dl, 50
jg letraE2
cmp dl, 40
jg letraF2
cmp dl, 30
jg letraG2
cmp dl, 20
jg letraH2
cmp dl, 10
jg letraI2

jmp letraJ2

letraA2:
mov barco2[1], 'A'
jmp fimletrab2 
letraB2:
mov barco2[1], 'B'
jmp fimletrab2
letraC2:
mov barco2[1], 'C'
jmp fimletrab2
letraD2:
mov barco2[1], 'D'
jmp fimletrab2
letraE2:
mov barco2[1], 'E'
jmp fimletrab2
letraF2:
mov barco2[1], 'F'
jmp fimletrab2
letraG2:
mov barco2[1], 'G'
jmp fimletrab2
letraH2:
mov barco2[1], 'H'
jmp fimletrab2              
letraI2:
mov barco2[1], 'I'
jmp fimletrab2
letraJ2:
mov barco2[1], 'J'

fimletrab2:
                             
                   ;NUMERO
               
mov AH,2Ch
INT 21h 

cmp dl, 90
jg n1b2
cmp dl, 80
jg n2b2
cmp dl, 70
jg n3b2
cmp dl, 60
jg n4b2
cmp dl, 50
jg n5b2
cmp dl, 40
jg n6b2
cmp dl, 30
jg n7b2
cmp dl, 20
jg n8b2
cmp dl, 10
jg n9b2


jmp n10b2

n1b2:
mov barco2[0], '1'
jmp fimnumerob2
n2b2:
mov barco2[0], '2'
jmp fimnumerob2
n3b2:
mov barco2[0], '3'
jmp fimnumerob2
n4b2:
mov barco2[0], '4'
jmp fimnumerob2
n5b2:
mov barco2[0], '5'
jmp fimnumerob2
n6b2:
mov barco2[0], '6'
jmp fimnumerob2
n7b2:
mov barco2[0], '7'
jmp fimnumerob2
n8b2:
mov barco2[0], '8'
jmp fimnumerob2
n9b2:
mov barco2[0], '9'
jmp fimnumerob2
n10b2:
mov barco2[0], '1'
mov al, barco2[1]
mov barco2[2], al
mov barco2[1], '0'



fimnumerob2:
mov al, barco2[0]
cmp barco1[0], al  
jne fimALEATORIOB2

mov al, barco2[1]
cmp barco1[1],al
jne fimALEATORIOB2

mov al, barco2[2]
cmp barco1[2],al 
jne fimALEATORIOB2

jmp ALEATORIOB2    
    
fimaleatorioB2:
            


            
ALEATORIOB3:                     ;ALEATORIO PARA BARCO3  
mov barco3[2],'0'               
mov AH,2Ch           ;LETRA:
INT 21h

cmp dl, 90
jg letraA3
cmp dl, 80
jg letraB3
cmp dl, 70
jg letraC3
cmp dl, 60
jg letraD3
cmp dl, 50
jg letraE3
cmp dl, 40
jg letraF3
cmp dl, 30
jg letraG3
cmp dl, 20
jg letraH3
cmp dl, 10
jg letraI3

jmp letraJ3

letraA3:
mov barco3[1], 'A'
jmp fimletrab3 
letraB3:
mov barco3[1], 'B'
jmp fimletrab3
letraC3:
mov barco3[1], 'C'
jmp fimletrab3
letraD3:
mov barco3[1], 'D'
jmp fimletrab3
letraE3:
mov barco3[1], 'E'
jmp fimletrab3
letraF3:
mov barco3[1], 'F'
jmp fimletrab3
letraG3:
mov barco3[1], 'G'
jmp fimletrab3
letraH3:
mov barco3[1], 'H'
jmp fimletrab3              
letraI3:
mov barco3[1], 'I'
jmp fimletrab3
letraJ3:
mov barco3[1], 'J'

fimletrab3:
                             
                   ;NUMERO
               
mov AH,2Ch
INT 21h 

cmp dl, 90
jg n1b3
cmp dl, 80
jg n2b3
cmp dl, 70
jg n3b3
cmp dl, 60
jg n4b3
cmp dl, 50
jg n5b3
cmp dl, 40
jg n6b3
cmp dl, 30
jg n7b3
cmp dl, 20
jg n8b3
cmp dl, 10
jg n9b3

jmp n10b3

n1b3:
mov barco3[0], '1'
jmp fimnumerob3
n2b3:
mov barco3[0], '2'
jmp fimnumerob3
n3b3:
mov barco3[0], '3'
jmp fimnumerob3
n4b3:
mov barco3[0], '4'
jmp fimnumerob3
n5b3:
mov barco3[0], '5'
jmp fimnumerob3
n6b3:
mov barco3[0], '6'
jmp fimnumerob3
n7b3:
mov barco3[0], '7'
jmp fimnumerob3
n8b3:
mov barco3[0], '8'
jmp fimnumerob3
n9b3:
mov barco3[0], '9'
jmp fimnumerob3
n10b3:
mov barco3[0], '1'
mov al, barco3[1]
mov barco3[2], al
mov barco3[1], '0'

fimnumerob3:

mov al, barco3[0]
cmp barco1[0], al  
jne fimB1B3
mov al, barco3[1]
cmp barco1[1],al
jne fimB1B3
mov al, barco3[2] 
cmp barco1[2], al
jne fimB1B3

jmp ALEATORIOB3    
    
fimB1B3:

mov al, barco3[0]
cmp barco2[0], al  
jne fimALEATORIOB3
mov al, barco3[1]
cmp barco2[1], al
jne fimALEATORIOB3
mov al, barco3[2] 
cmp barco2[2], al
jne fimALEATORIOB3

jmp ALEATORIOB3    
    
fimaleatorioB3:



     
ALEATORIOS:                 ;ALEATORIO PARA SUBMARINO
mov submarino[2], '0' 
mov submarino[5], '0'
mov submarino[8], '0'
                
mov AH,2Ch       ;LETRA:
INT 21h                  
               ;MEIO DO SUBMARINO NAO PODE CALHAR EM A NEM J

cmp dl, 88
jg letraBS
cmp dl, 75
jg letraCS
cmp dl, 63
jg letraDS
cmp dl, 50
jg letraES
cmp dl, 38
jg letraFS
cmp dl, 25
jg letraGS
cmp dl, 13
jg letraHS

JMP letraIS

letraAS:
mov submarino[1], 'A'
jmp fimletraS 
letraBS:
mov submarino[1], 'B'
jmp fimletraS
letraCS:
mov submarino[1], 'C'
jmp fimletraS
letraDS:
mov submarino[1], 'D'
jmp fimletraS           
letraES:
mov submarino[1], 'E'
jmp fimletraS
letraFS:
mov submarino[1], 'F'
jmp fimletraS
letraGS:
mov submarino[1], 'G'
jmp fimletraS
letraHS:
mov submarino[1], 'H'
jmp fimletraS              
letraIS:
mov submarino[1], 'I'
jmp fimletraS
letraJS:
mov submarino[1], 'J'

fimletraS:
                             
                   ;NUMERO
               
mov AH,2Ch
INT 21h 

cmp dl, 90
jg n1S
cmp dl, 80
jg n2S
cmp dl, 70
jg n3S
cmp dl, 60
jg n4S
cmp dl, 50
jg n5S
cmp dl, 40
jg n6S
cmp dl, 30
jg n7S
cmp dl, 20
jg n8S
cmp dl, 10
jg n9S

jmp n10S

n1S:
mov submarino[0], '1'
jmp fimnumeroS
n2S:
mov submarino[0], '2'
jmp fimnumeroS
n3S:
mov submarino[0], '3'
jmp fimnumeroS
n4S:
mov submarino[0], '4'
jmp fimnumeroS
n5S:
mov submarino[0], '5'
jmp fimnumeroS
n6S:
mov submarino[0], '6'
jmp fimnumeroS
n7S:
mov submarino[0], '7'
jmp fimnumeroS
n8S:
mov submarino[0], '8'
jmp fimnumeroS
n9S:
mov submarino[0], '9'
jmp fimnumeroS
n10S:
mov submarino[0], '1'
mov al, submarino[1]
mov submarino[2], al
mov submarino[1], '0'

fimnumeroS:


;----------------------------------------------------------       

                                  ;CRIAR SUBMARINO
mov al, submarino[0] 
mov submarino[3], al        
         
mov al, submarino[1] 
mov submarino[4], al

mov al, submarino[2]         
mov submarino[5], al

cmp submarino[4], '0'          
je s1        
add submarino[4],1      ;aumentar letra    
jmp s2
s1:         
add submarino[5],1
s2:


mov al, submarino[0] 
mov submarino[6], al        
         
mov al, submarino[1] 
mov submarino[7], al

mov al, submarino[2]         
mov submarino[8], al

cmp submarino[7], '0'          
je as1        
sub submarino[7],1         
jmp as2
as1:         
sub submarino[8],1
as2:        
;----------------------------------------------         
   
                 
mov al, submarino[0]
cmp barco1[0], al          ;SE FOR IGUAL A COORDENADAS ANTERIORES REPETE ALEATORIO
jne fimB1S                
mov al, submarino[2]
cmp barco1[1], al
jne fimB1S         
mov al, submarino[2]
cmp barco1[2], al
jne fiMB1S

jmp ALEATORIOS    
    
fimB1S:

mov al, submarino[0]
cmp barco2[0], al    
jne fimB2S 
mov al, submarino[1]
cmp barco2[1], al
jne fimB2S 
mov al, submarino[2]
cmp barco2[2], al
jne fiMB2S

jmp ALEATORIOS    
    
fimB2S:

mov al, submarino[0]
cmp barco3[0], al    
jne fimB3S     
mov al, submarino[1]
cmp barco3[1], al
jne fimB3S 
mov al, submarino[2]
cmp barco3[2], al
jne fiMB3S

jmp ALEATORIOS    
    
fimB3S:

mov al, submarino[3]                           ;2o parte submarino
cmp barco1[0], al         
jne fimB1Sp2 
mov al, submarino[4]
cmp barco1[1], al
jne fimB1Sp2  
mov al, submarino[5]
cmp barco1[2], al
jne fiMB1Sp2

jmp ALEATORIOS    
    
fimB1Sp2:

mov al, submarino[3]
cmp barco2[0], al    
jne fimB2Sp2       
mov al, submarino[4]
cmp barco2[1], al
jne fimB2Sp2        
mov al, submarino[5]
cmp barco2[2], al
jne fiMB2Sp2

jmp ALEATORIOS    
    
fimB2Sp2:

mov al, submarino[3]
cmp barco3[0], al   
jne fimB3Sp2         
mov al, submarino[4]
cmp barco3[1], al
jne fimB3Sp2        
mov al, submarino[5]
cmp barco3[2], al
jne fiMB3Sp2

jmp ALEATORIOS    
    
fimB3Sp2:


mov al, submarino[6]                           ;3o parte submarino
cmp barco1[0], al         
jne fimB1Sp3  
mov al, submarino[7]
cmp barco1[1], al
jne fimB1Sp3        
mov al, submarino[8]
cmp barco1[2], al
jne fiMB1Sp3

jmp ALEATORIOS    
    
fimB1Sp3:

mov al, submarino[6]
cmp barco2[0], al    
jne fimB2Sp3 
mov al, submarino[7]
cmp barco2[1], al
jne fimB2Sp3 
mov al, submarino[8]
cmp barco2[2], al
jne fiMB2Sp3

jmp ALEATORIOS    
    
fimB2Sp3:

mov al, submarino[6]
cmp barco3[0], al    
jne fimB3Sp3  
mov al, submarino[7]
cmp barco3[1], al
jne fimB3Sp3        
mov al, submarino[8]
cmp barco3[2], al
jne fiMB3Sp3

jmp ALEATORIOS    
    
fimB3Sp3:   
                 
                 
                 
                 
             ;---------------------------    
   
         
         
         
ALEATORIOP:                   ;ALEATORIO PARA PORTAAVIOES
mov portaavioes[2], '0' 
mov portaavioes[5], '0'
mov portaavioes[8], '0'
mov portaavioes[11], '0'

                
mov AH,2Ch         ;LETRA:
INT 21h
                ;EXCLUIR A E J
cmp dl, 88
jg letraBP
cmp dl, 75
jg letraCP
cmp dl, 63
jg letraDP
cmp dl, 50
jg letraEP
cmp dl, 38
jg letraFP
cmp dl, 25
jg letraGP
cmp dl, 13
jg letraHP

jmp letraIP          
          
letraAP:
mov portaavioes[1], 'A'
jmp fimletraP 
letraBP:
mov portaavioes[1], 'B'
jmp fimletraP
letraCP:
mov portaavioes[1], 'C'
jmp fimletraP
letraDP:
mov portaavioes[1], 'D'
jmp fimletraP
letraEP:
mov portaavioes[1], 'E'
jmp fimletraP
letraFP:
mov portaavioes[1], 'F'
jmp fimletraP
letraGP:
mov portaavioes[1], 'G'
jmp fimletraP
letraHP:
mov portaavioes[1], 'H'
jmp fimletraP              
letraIP:
mov portaavioes[1], 'I'
jmp fimletraP
letraJP:
mov portaavioes[1], 'J'

fimletraP:
                             
                   ;NUMERO
               
mov AH,2Ch         ;NAO PODE CALHAR EM 1
INT 21h 

cmp dl, 89
jg n2P
cmp dl, 78
jg n3P
cmp dl, 67
jg n4P
cmp dl, 56
jg n5P
cmp dl, 44
jg n6P
cmp dl, 33
jg n7P
cmp dl, 22
jg n8P
cmp dl, 11
jg n9P

jmp n10P



n2P:
mov portaavioes[0], '2'
jmp fimnumeroP
n3P:
mov portaavioes[0], '3'
jmp fimnumeroP
n4P:
mov portaavioes[0], '4'
jmp fimnumeroP
n5P:
mov portaavioes[0], '5'
jmp fimnumeroP
n6P:
mov portaavioes[0], '6'
jmp fimnumeroP
n7P:
mov portaavioes[0], '7'
jmp fimnumeroP
n8P:
mov portaavioes[0], '8'
jmp fimnumeroP
n9P:
mov portaavioes[0], '9'
jmp fimnumeroP
n10P:
mov portaavioes[0], '1'
mov al, portaavioes[1]
mov portaavioes[2], al
mov portaavioes[1], '0'

fimnumeroP:     
             
             
             
             
                       ;CRIAR PORTA-AVIOES  -------------------------------
mov al, portaavioes[0] 
mov portaavioes[3], al        
         
mov al, portaavioes[1] 
mov portaavioes[4], al

mov al, portaavioes[2]         
mov portaavioes[5], al
                      
                      

cmp portaavioes[4], '0'          
je a1        
add portaavioes[4],1         ;aumentar letra    
jmp a2
a1:         
add portaavioes[5],1
a2:


mov al, portaavioes[0] 
mov portaavioes[6], al        
         
mov al, portaavioes[1] 
mov portaavioes[7], al
                             
mov al, portaavioes[2]         
mov portaavioes[8], al

cmp portaavioes[7], '0'          
je ap1        
sub portaavioes[7],1          ;diminuir letra
jmp ap2
ap1:         
sub portaavioes[8],1
ap2:  
                  
   
   
   
mov al, portaavioes[0] 
mov portaavioes[9], al        
         
mov al, portaavioes[1] 
mov portaavioes[10], al
                             ;diminuir numero
mov al, portaavioes[2]         
mov portaavioes[11], al
            
            
cmp portaavioes[10], '0'     ;9 10 11     
je bp1        
sub portaavioes[9],1         
jmp bp2
bp1: 
mov portaavioes[9], '9'
mov al, portaavioes[11]         
mov portaavioes[10], al
mov portaavioes[11],'0'
bp2:          
   
   ;-------------------------------------------       
       
mov al, portaavioes[0]                          
cmp barco1[0], al         
jne fimB1P1   
mov al, portaavioes[1]
cmp barco1[1], al
jne fimB1P1           
mov al, portaavioes[2]
cmp barco1[2], al
jne fiMB1P1

jmp ALEATORIOP    
    
fimB1P1:

mov al, portaavioes[0]
cmp barco2[0], al   
jne fimB2P1           
mov al, portaavioes[1]
cmp barco2[1], al
jne fimB2P1           
mov al, portaavioes[2]
cmp barco2[2], al
jne fiMB2P1

jmp ALEATORIOP    
    
fimB2P1:

mov al, portaavioes[0]
cmp barco3[0], al    
jne fimB3P1           
mov al, portaavioes[1]
cmp barco3[1], al
jne fimB3P1           
mov al, portaavioes[2]
cmp barco3[2], al
jne fiMB3P1

jmp ALEATORIOP

fimB3P1:     

mov al, portaavioes[0]
cmp submarino[0], al    
jne fimS1P1                   
mov al, portaavioes[1]
cmp submarino[1], al
jne fimS1P1           
mov al, portaavioes[2]
cmp submarino[2], al
jne fiMS1P1

jmp ALEATORIOP    
    
fimS1P1:
 
mov al, portaavioes[0]
cmp submarino[3], al   
jne fimS2P1
mov al, portaavioes[1]
cmp submarino[4], al
jne fimS2P1           
mov al, portaavioes[2]
cmp submarino[5], al
jne fiMS2P1

jmp ALEATORIOP    
    
fimS2P1:
 
mov al, portaavioes[0]
cmp submarino[6], al    
jne fimS3P1           
mov al, portaavioes[1]
cmp submarino[7], al
jne fimS3P1           
mov al, portaavioes[2]
cmp submarino[8], al
jne fiMS3P1

jmp ALEATORIOP    
    
fimS3P1: 


   ;--


mov al, portaavioes[3]
cmp barco1[0], al         
jne fimB1P2           
mov al, portaavioes[4]
cmp barco1[1], al
jne fimB1P2           
mov al, portaavioes[5]
cmp barco1[2], al
jne fiMB1P2           

jmp ALEATORIOP    
    
fimB1P2:

mov al, portaavioes[3]
cmp barco2[0], al    
jne fimB2P2           
mov al, portaavioes[4]
cmp barco2[1], al
jne fimB2P2           
mov al, portaavioes[5]
cmp barco2[2], al
jne fiMB2P2

jmp ALEATORIOP    
    
fimB2P2:

mov al, portaavioes[3]
cmp barco3[0], al    
jne fimB3P2           
mov al, portaavioes[4]
cmp barco3[1], al
jne fimB3P2           
mov al, portaavioes[5]
cmp barco3[2], al
jne fiMB3P2

jmp ALEATORIOP

fimB3P2:
  
mov al, portaavioes[3]
cmp submarino[0], al    
jne fimS1P2
mov al, portaavioes[4]
cmp submarino[1], al
jne fimS1P2           
mov al, portaavioes[5]
cmp submarino[2], al
jne fiMS1P2

jmp ALEATORIOP    
    
fimS1P2:

mov al, portaavioes[3]
cmp submarino[3], al    
jne fimS2P2           
mov al, portaavioes[4]
cmp submarino[4], al
jne fimS2P2           
mov al, portaavioes[5]
cmp submarino[5], al
jne fiMS2P2

jmp ALEATORIOP    
    
fimS2P2:

mov al, portaavioes[3]
cmp submarino[6], al    
jne fimS3P2           
mov al, portaavioes[4]
cmp submarino[7], al
jne fimS3P2           
mov al, portaavioes[5]
cmp submarino[8], al
jne fiMS3P2

jmp ALEATORIOP    
    
fimS3P2:  
        
      ;--- 
      
      
      
      
      
   ;--


mov al, portaavioes[6]
cmp barco1[0], al         
jne fimB1P3           
mov al, portaavioes[7]
cmp barco1[1], al
jne fimB1P3           
mov al, portaavioes[8]
cmp barco1[2], al
jne fiMB1P3

jmp ALEATORIOP    
    
fimB1P3:
                      
mov al, portaavioes[6]
cmp barco2[0], al   
jne fimB2P3           
mov al, portaavioes[7]
cmp barco2[1], al
jne fimB2P3           
mov al, portaavioes[8]
cmp barco2[2], al
jne fiMB2P3

jmp ALEATORIOP    
    
fimB2P3:

mov al, portaavioes[6]
cmp barco3[0], al    
jne fimB3P3           
mov al, portaavioes[7]
cmp barco3[1], al
jne fimB3P3           
mov al, portaavioes[8]
cmp barco3[2], al
jne fiMB3P3

jmp ALEATORIOP

fimB3P3:
                     
mov al, portaavioes[6]                     
cmp submarino[0], al    
jne fimS1P3           
mov al, portaavioes[7]
cmp submarino[1], al
jne fimS1P3           
mov al, portaavioes[8]
cmp submarino[2], al
jne fiMS1P3

jmp ALEATORIOP    
    
fimS1P3:

mov al, portaavioes[6]
cmp submarino[3], al    
jne fimS2P3          
mov al, portaavioes[7]
cmp submarino[4], al
jne fimS2P3           
mov al, portaavioes[8]
cmp submarino[5], al
jne fiMS2P3

jmp ALEATORIOP    
    
fimS2P3:

mov al, portaavioes[6]
cmp submarino[6], al    
jne fimS3P3           
mov al, portaavioes[7]
cmp submarino[7], al
jne fimS3P3           
mov al, portaavioes[8]
cmp submarino[8], al
jne fiMS3P3

jmp ALEATORIOP    
    
fimS3P3:


;----





mov al, portaavioes[9]
cmp barco1[0], al         
jne fimB1P4           
mov al, portaavioes[10]
cmp barco1[1], al
jne fimB1P4           
mov al, portaavioes[11]
cmp barco1[2], al
jne fiMB1P4                 

jmp ALEATORIOP    
    
fimB1P4:

mov al, portaavioes[9]
cmp barco2[0], al    
jne fimB2P4           
mov al, portaavioes[10]
cmp barco2[1], al
jne fimB2P4           
mov al, portaavioes[11]
cmp barco2[2], al
jne fiMB2P4

jmp ALEATORIOP    
    
fimB2P4:
                      
mov al, portaavioes[9]                      
cmp barco3[0], al   
jne fimB3P4           
mov al, portaavioes[10]
cmp barco3[1], al
jne fimB3P4           
mov al, portaavioes[11]
cmp barco3[2], al
jne fiMB3P4

jmp ALEATORIOP

fimB3P4:

mov al, portaavioes[9]
cmp submarino[0], al   
jne fimS1P4           
mov al, portaavioes[10]
cmp submarino[1], al
jne fimS1P4           
mov al, portaavioes[11]
cmp submarino[2], al
jne fiMS1P4

jmp ALEATORIOP    
      
fimS1P4:

mov al, portaavioes[9]
cmp submarino[3], al   
jne fimS2P4           
mov al, portaavioes[10]
cmp submarino[4], al
jne fimS2P4           
mov al, portaavioes[11]
cmp submarino[5], al
jne fiMS2P4

jmp ALEATORIOP    
    
fimS2P4:


mov al, portaavioes[9]
cmp submarino[6], al  
jne fimS3P4           
mov al, portaavioes[10]
cmp submarino[7], al
jne fimS3P4           
mov al, portaavioes[11]
cmp submarino[8], al
jne fiMS3P4

jmp ALEATORIOP    
    
fimS3P4:  
        
    
  ;------------------------------------------------   

       
mov ah, 9
lea dx, batalhanaval
int 21h

mov ah, 1
int 21h
mov hack, al


mov AX, 03h    ;limpar o ecra            
int 10h
 
 
 
INICIO: 

 
gotoxy 0, 0
mov ah, 9
lea dx, linha
int 21h

gotoxy 68, 0 
mov ah, 9
lea dx, tentativas
int 21h
gotoxy 68, 1
mov ah, 9
lea dx, tentativas1
int 21h
gotoxy 68, 2
mov ah, 9
lea dx, tentativas2
int 21h
gotoxy 68, 3
mov ah, 9
lea dx, tentativas3
int 21h
gotoxy 68, 4
mov ah, 9
lea dx, tentativas4
int 21h
        



cmp hack, 'h'
jne fimhacker 

gotoxy 45,12
mov ah, 2
mov dl, barco1[0]
int 21h
mov ah, 2
mov dl, barco1[1]
int 21h 
mov ah, 2
mov dl, barco1[2]
int 21h
mov ah, 2

mov ah, 2
mov dl, ' '
int 21h 

mov dl, barco2[0]
int 21h
mov ah, 2
mov dl, barco2[1]
int 21h 
mov ah, 2
mov dl, barco2[2]
int 21h  

mov ah, 2
mov dl, ' '
int 21h 

mov ah, 2
mov dl, barco3[0]
int 21h
mov ah, 2
mov dl, barco3[1]
int 21h 
mov ah, 2
mov dl, barco3[2]
int 21h       
      
mov ah, 2
mov dl, ' '
int 21h 

mov ah, 2
mov dl, submarino[0]
int 21h
mov ah, 2
mov dl, submarino[1]
int 21h 
mov ah, 2
mov dl, submarino[2]
int 21h
        
mov ah, 2
mov dl, ' '
int 21h 

mov ah, 2
mov dl, portaavioes[0]
int 21h
mov ah, 2
mov dl, portaavioes[1]
int 21h 
mov ah, 2
mov dl, portaavioes[2]
int 21h 

fimhacker:
               
        
        
        
        
gotoxy 45, 13
mov ah, 9
lea dx, legenda
int 21h  
gotoxy 45, 14             
mov ah, 9                  
lea dx, legenda2
int 21h
gotoxy 45, 15
mov ah, 9
lea dx, legenda3
int 21h
gotoxy 45, 16
mov ah, 9
lea dx, legenda4
int 21h
gotoxy 45, 17
mov ah, 9
lea dx, legenda5
int 21h
gotoxy 45, 18 
mov ah, 9
lea dx, legenda6
int 21h
gotoxy 45, 19
mov ah, 9
lea dx, legenda7
int 21h
gotoxy 45, 20
mov ah, 9
lea dx, legenda8
int 21h
gotoxy 45, 21
mov ah, 9
lea dx, legenda9
int 21h 
gotoxy 45, 22
mov ah, 9
lea dx, legenda10
int 21h      
gotoxy 45, 23
mov ah, 9
lea dx, legenda11
int 21h

gotoxy 62, 3      
mov ah, 2
mov dl, ' '
int 21h 


mov ch, 5  ;apenas para inicializar ch com um numero diferente de 0
numero: 
gotoxy 45, 2
mov ah, 9
lea dx, pedenumero
int 21h 
gotoxy 62, 2
mov ah, 1
int 21h
mov cl, al        ;linha - cl  

cmp cl, '1' 
jb numero
je numero2         
cmp cl, '9'       ;se numero invalido pede novamente
jg numero

jmp letra


numero2:          ;porque o numero pode ser 10 ou 1
mov ah, 1
int 21h
mov ch, al
cmp ch, '0' 
je letra        
cmp ch, 13        ;o segundo algarismo tem de ser 0 ou enter(numeros de 0 a 9)
je letra

jmp numero

                  ;-----

letra:
gotoxy 45, 3
mov ah, 9
lea dx, pedeletra
int 21h
gotoxy 62, 3 
mov ah, 1
int 21h                  ;letra - bl
mov bl, al

      cmp bl, 'a' 
      jb frente         
      cmp bl, 'j'        
      jg frente
      sub bl, 20h        ;se letra minuscula passa a maiuscula
      
      frente:
      cmp bl, 'A' 
      jb letra         
      cmp bl, 'J'        ;se nao for letra de A a J volta a pedir
      jg letra                                                     
       
      
                 
            
            
                       
            ;CL-NUMERO ch-algarismo2  BL-LETRA
            ;VERIFICAR SE ACERTOU OU FALHOU

  

B1:                                 ;BARCO1
cmp ch, '0'                   ;VER SE 10 LINHAS
je algarismosB1
                 
cmp cl, barco1[0]   
jne B2
cmp bl, barco1[1]
jne B2 

add verificabarcos[0], 1
cmp verificabarcos[0], '1'
je acertoubarco                  
   
jmp mesmobarco

algarismosB1:
cmp cl, barco1[0]   
jne B2
cmp bl, barco1[2]
jne B2

add verificabarcos[0], 1
cmp verificabarcos[0], '1'
je acertoubarco                  
   
jmp mesmobarco 
 
       
       
                 
B2:                                   ;BARCO2
cmp ch, '0'     ;VER SE 10 LINHAS
je algarismosB2
                 
cmp cl, barco2[0]   
jne B3
cmp bl, barco2[1]
jne B3 

add verificabarcos[1], 1
cmp verificabarcos[1], '1'
je acertoubarco                  
   
jmp mesmobarco

algarismosB2:
cmp cl, barco2[0]   
jne B3
cmp bl, barco2[2]
jne B3
                     
add verificabarcos[1], 1
cmp verificabarcos[1], '1'
je acertoubarco                  
   
jmp mesmobarco 
 
 

B3:                             ;BARCO3
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismosB3
                 
cmp cl, barco3[0]   
jne sp1
cmp bl, barco3[1]
jne sp1 

add verificabarcos[2], 1
cmp verificabarcos[2], '1'
je acertoubarco                  
   
jmp mesmobarco

algarismosB3:
cmp cl, barco3[0]   
jne sp1
cmp bl, barco3[2]
jne sp1

add verificabarcos[2], 1
cmp verificabarcos[2], '1'
je acertoubarco                  
   
jmp mesmobarco                     
   
   
   
         
         
   
sp1:                             ;submarino parte meio
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismossp1
                 
cmp cl, submarino[0]   
jne sp2
cmp bl, submarino[1]
jne sp2 

add verificasubs[0], 1
cmp verificasubs[0], '1'
je acertousub                  
   
jmp mesmobarco

algarismossp1:
cmp cl, submarino[0]   
jne sp2
cmp bl, submarino[2]
jne sp2

add verificasubs[0], 1
cmp verificasubs[0], '1'
je acertousub                  
   
jmp mesmobarco
     
     
     
     
sp2:                             ;submarino parte 2
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismossp2
                 
cmp cl, submarino[3]   
jne sp3
cmp bl, submarino[4]
jne sp3 

add verificasubs[1], 1
cmp verificasubs[1], '1'
je acertousub                  
   
jmp mesmobarco

algarismossp2:
cmp cl, submarino[3]   
jne sp3
cmp bl, submarino[5]
jne sp3  

add verificasubs[1], 1
cmp verificasubs[1], '1'
je acertousub                  
   
jmp mesmobarco        
  
  
  
  
        
sp3:                             ;submarino parte 3
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismossp3
                 
cmp cl, submarino[6]   
jne pavioesp1
cmp bl, submarino[7]
jne pavioesp1 

add verificasubs[2], 1 
cmp verificasubs[2], '1'
je acertousub                  
   
jmp mesmobarco

algarismossp3:
cmp cl, submarino[6]   
jne pavioesp1
cmp bl, submarino[8]
jne pavioesp1

add verificasubs[2], 1
cmp verificasubs[2], '1'
je acertousub                  
   
jmp mesmobarco  

      
      
                  ;porta avioes ------------------------
pavioesp1:                             ;parte1
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismospp1
                 
cmp cl, portaavioes[0]   
jne pavioesp2
cmp bl, portaavioes[1]
jne pavioesp2 

add verificapavioes[0], 1 
cmp verificapavioes[0], '1'
je acertouavi                  
   
jmp mesmobarco

algarismospp1:
cmp cl, portaavioes[0]   
jne pavioesp2
cmp bl, portaavioes[2]
jne pavioesp2

add verificapavioes[0], 1
cmp verificapavioes[0], '1'
je acertouavi                  
   
jmp mesmobarco  
  
        
        
        
pavioesp2:                             ;parte2
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismospp2
                 
cmp cl, portaavioes[3]   
jne pavioesp3
cmp bl, portaavioes[4]
jne pavioesp3 

add verificapavioes[1], 1
cmp verificapavioes[1], '1'
je acertouavi                  
   
jmp mesmobarco

algarismospp2:
cmp cl, portaavioes[3]   
jne pavioesp3
cmp bl, portaavioes[5]
jne pavioesp3

add verificapavioes[1], 1
cmp verificapavioes[1], '1'
je acertouavi                  
   
jmp mesmobarco  


pavioesp3:                             ;parte3
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismospp3
                 
cmp cl, portaavioes[6]   
jne pavioesp4
cmp bl, portaavioes[7]
jne pavioesp4 

add verificapavioes[2], 1
cmp verificapavioes[2], '1'
je acertouavi                  
   
jmp mesmobarco

algarismospp3:
cmp cl, portaavioes[6]   
jne pavioesp4
cmp bl, portaavioes[8]
jne pavioesp4

add verificapavioes[2], 1
cmp verificapavioes[2], '1'
je acertouavi                  
   
jmp mesmobarco  

                                             
pavioesp4:                             ;parte4
cmp ch, '0'      ;VER SE 10 LINHAS
je algarismospp4
                 
cmp cl, portaavioes[9]   
jne falhoubarco
cmp bl, portaavioes[10]
jne falhoubarco 

add verificapavioes[3], 1
cmp verificapavioes[3], '1'
je acertouavi                  
   
jmp mesmobarco

algarismospp4:
cmp cl, portaavioes[9]   
jne falhoubarco
cmp bl, portaavioes[11]
jne falhoubarco

add verificapavioes[3], 1
cmp verificapavioes[3], '1'
je acertouavi                  
   
jmp mesmobarco          




                 
acertoubarco:                     ;--------acertoubarco
    ;contador de tentativas                     
                         
                         
cmp tentativas2[6], '9'
je igual9             
add tentativas2[6], 1
jmp fimtentativas

igual9:
mov tentativas2[6], '0'
cmp tentativas2[5], '9'
je maior99    
add tentativas2[5], 1 
jmp fimtentativas

maior99:
mov tentativas2[5], '0'
add tentativas2[4], 1
                                  
fimtentativas:

gotoxy 45, 5

mov ah, 2
mov dl, cl
int 21h

cmp ch, '0'
jne fret       
mov ah, 2
mov dl, ch
int 21h

fret:

mov ah, 2
mov dl, bl
int 21h 

mov ah, 2
mov dl, ' '
int 21h      
       
gotoxy 48, 5
mov ah, 9
lea dx, acertoub
int 21h
mov bp, 1 
jmp fimverifica     




acertousub:                     ;--------acertousub
    ;contador de tentativas                     
                         
                         
cmp tentativas2[6], '9'
je igual9s             
add tentativas2[6], 1
jmp fimtentativass

igual9s:
mov tentativas2[6], '0'
cmp tentativas2[5], '9'
je maior99s    
add tentativas2[5], 1 
jmp fimtentativass

maior99s:
mov tentativas2[5], '0'
add tentativas2[4], 1
                                  
fimtentativass:
gotoxy 45, 5
mov ah, 2
mov dl, cl
int 21h

cmp ch, '0'
jne fret2       
mov ah, 2
mov dl, ch
int 21h

fret2:

mov ah, 2
mov dl, bl
int 21h

mov ah, 2
mov dl, ' '
int 21h


gotoxy 48, 5
mov ah, 9
lea dx, acertousubm
int 21h
mov bp, 1 
jmp fimverifica




acertouavi:                     ;--------acertou porta avioes
    ;contador de tentativas                     
                         
                         
cmp tentativas2[6], '9'
je igual9a             
add tentativas2[6], 1
jmp fimtentativasa

igual9a:
mov tentativas2[6], '0'
cmp tentativas2[5], '9'
je maior99a    
add tentativas2[5], 1 
jmp fimtentativasa

maior99a:
mov tentativas2[5], '0'
add tentativas2[4], 1
                                  
fimtentativasa:

gotoxy 45, 5
mov ah, 2
mov dl, cl
int 21h

cmp ch, '0'
jne fret3       
mov ah, 2
mov dl, ch
int 21h

fret3:

mov ah, 2
mov dl, bl
int 21h

mov ah, 2
mov dl, ' '
int 21h

gotoxy 48, 5
mov ah, 9
lea dx, acertoupavi
int 21h
mov bp, 1 
jmp fimverifica   
   
   
   
   
   
   

 
falhoubarco:                           ;falhou barco
    ;contador de tentativas                     
                         
                         
cmp tentativas2[6], '9'
je igual9f             
add tentativas2[6], 1
jmp fimtentativasf

igual9f:
mov tentativas2[6], '0'
cmp tentativas2[5], '9'
je maior99f    
add tentativas2[5], 1 
jmp fimtentativasf

maior99f:
mov tentativas2[5], '0'
add tentativas2[4], 1
                                  
fimtentativasf:
gotoxy 45, 5
mov ah, 2
mov dl, cl
int 21h

cmp ch, '0'
jne fret4       
mov ah, 2
mov dl, ch
int 21h

fret4:

mov ah, 2
mov dl, bl
int 21h

mov ah, 2
mov dl, ' '
int 21h

gotoxy 48, 5
mov ah, 9
lea dx, FALHOU
int 21h
mov bp, 0 

jmp fimverifica




mesmobarco:
gotoxy 45, 5
mov ah, 2
mov dl, cl
int 21h

cmp ch, '0'
jne fret5
       
mov ah, 2
mov dl, ch
int 21h

mov ah, 2
mov dl, ' '
int 21h

fret5:

mov ah, 2
mov dl, bl
int 21h


gotoxy 48, 5                 ;mesmobarco
mov ah, 9
lea dx, msmbarco
int 21h
jmp inicio


fimverifica:     
      
             
             
             
             
             
      
                    
;descobrir a coluna:    
cmp bl, 'A'              
je C1

cmp bl, 'B'
je C2 
         
cmp bl, 'C'
je C3

cmp bl, 'D'
je C4
   
cmp bl, 'E'
je C5

cmp bl, 'F'
je C6

cmp bl, 'G'
je C7
         
cmp bl, 'H'
je C8
 
cmp bl, 'I'
je C9

cmp bl, 'J'
je C10

;os valores a modificar sao: (multiplos de 4) -1

C1: mov SI, 3         
jmp seguir
C2: mov SI, 7
jmp seguir
C3: mov SI, 11
jmp seguir
C4: mov SI, 15
jmp seguir
C5: mov SI, 19                                                        
jmp seguir
C6: mov SI, 23
jmp seguir
C7: mov SI, 27
jmp seguir
C8: mov SI, 31
jmp seguir
C9: mov SI, 35
jmp seguir
C10:mov SI, 39
seguir:

;descobrir e alterar a linha correspondente
cmp bp, 1
je acert

;falhou:

cmp cl, '2'
je L2 
         
cmp cl, '3'
je L3

cmp cl, '4'
je L4

cmp cl, '5'
je L5

cmp cl, '6'
je L6

cmp cl, '7'
je L7
         
cmp cl, '8'
je L8

cmp cl, '9'
je L9

cmp ch, '0'
je L10


L1: mov linha1[SI], 04h
jmp fim
L2: mov linha2[SI], 04h
jmp fim
L3: mov linha3[SI], 04h
jmp fim
L4: mov linha4[SI], 04h
jmp fim
L5: mov linha5[SI], 04h
jmp fim
L6: mov linha6[SI], 04h
jmp fim
L7: mov linha7[SI], 04h
jmp fim
L8: mov linha8[SI], 04h
jmp fim
L9: mov linha9[SI], 04h
jmp fim
L10:mov linha10[SI], 04h
JMP fim

            
            ;ACERTOU:
             
acert:
cmp cl, '2'
je aL2 
         
cmp cl, '3'
je aL3

cmp cl, '4'
je aL4

cmp cl, '5'
je aL5

cmp cl, '6'
je aL6

cmp cl, '7'
je aL7
         
cmp cl, '8'
je aL8

cmp cl, '9'
je aL9

cmp ch, '0'
je aL10


aL1: mov linha1[SI], 02h
jmp fim
aL2: mov linha2[SI], 02h
jmp fim
aL3: mov linha3[SI], 02h
jmp fim
aL4: mov linha4[SI], 02h
jmp fim
aL5: mov linha5[SI], 02h
jmp fim
aL6: mov linha6[SI], 02h
jmp fim
aL7: mov linha7[SI], 02h
jmp fim
aL8: mov linha8[SI], 02h
jmp fim
aL9: mov linha9[SI], 02h
jmp fim
aL10:mov linha10[SI], 02h

fim:
cmp bp, 1            ; se bp = 1 acertou logo vai incrementar DI e verificar se ganhou
je acr
 
jmp INICIO 

acr:
inc di

cmp di, 10        ;numero de barcos 
je FIMPROGRAMA

jmp INICIO

FIMPROGRAMA:
gotoxy 0, 0
mov ah, 9
lea dx, linha
int 21h
 
 
 
gotoxy 68, 0 
mov ah, 9
lea dx, tentativas
int 21h
gotoxy 68, 1
mov ah, 9
lea dx, tentativas1
int 21h
gotoxy 68, 2
mov ah, 9
lea dx, tentativas2
int 21h
gotoxy 68, 3
mov ah, 9
lea dx, tentativas3
int 21h
gotoxy 68, 4
mov ah, 9
lea dx, tentativas4
int 21h 



gotoxy 45, 6
mov ah, 9
lea dx, GANHOU
int 21h
gotoxy 45, 7
mov ah, 9
lea dx, GANHOUTENT
int 21h      
            



CMP tentativas2[4], '0'
je f1  
mov ah, 2
mov dl, tentativas2[4]
int 21h
jmp g1

f1:
cmp tentativas2[5], '0'
je f2
g1:
mov ah, 2
mov dl, tentativas2[5]
int 21h

f2:
mov ah, 2
mov dl, tentativas2[6]
int 21h 
          
         

             
gotoxy 45, 9
mov ah, 9
lea dx, fimjogo2
int 21h                          
             
gotoxy 45, 10
mov ah, 9
lea dx, fimjogo
int 21h 

mov ah, 1
int 21h 



FIMJOGOTOTAL: 
MOV AH, 4Ch
int 21h

RET 

END 