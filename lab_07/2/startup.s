;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000200

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3	; 2*3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF


var				RN 		2
				AREA    dati, DATA, READWRITE, ALIGN=2
Calories_food_ordered		SPACE	28
Calories_sport_ordered		SPACE	12
Consumo						SPACE	28

                AREA    |.text|, CODE, READONLY
; Reset Handler
Days			DCB 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07
Calories_food   DCD 0x06, 1300, 0x03, 1700, 0x02, 1200, 0x04, 1900
                DCD 0x05, 1110, 0x01, 1670, 0x07, 1000
Calories_sport	DCD 0x02, 500, 0x05, 800, 0x06, 400

Num_days		DCB 7
Num_days_sport	DCB 3
Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]                                            
				
				LDRB R0, Num_days
				LDRB R9, Num_days
				LDR R2, =Calories_food+4
				LDR R10, =Calories_food+4
				LDR R11, =Calories_food_ordered
				BL ordinamento
				
				LDRB R0, Num_days_sport
				LDRB R9, Num_days_sport
				LDR R2, =Calories_sport+4
				LDR R10, =Calories_sport+4
				LDR R11, =Calories_sport_ordered
				BL ordinamento
				;verifico qual è il maggiore
				MOV R0, #0x7
                MOV R1, #0x0
                MOV R2, #4
                LDR R4, =Calories_food    ;inserisco in R4 l'indirizzo che puntava Calories_food

riempi			LDR R3, =Consumo	;prendo ogni volta il valore del primo giorno
				LDR R5, [R4]    	;inserisco in R5 il valore all'indirizzo che si trovava in R4
				LSL R6, R5, #2	 	;moltiplico il byte giorno per 4 e trovare l'indice in consumo
				SUB R6, R6, #4    	;sottraggo il primo giorno per trovare l'indice corretto del giorno
				ADD R3, R3, R6    	;vado all'indice di consumo corretto
				LDR R5, [R4, #4]!   ;metto in R5 il valore di calorie relative al giorno
				STR R5, [R3]    	;metto il valore nello spazio
				ADD R4, R4, #4  	;vado avanti nel vettore Calories_food
				SUBS R0, R0, #1 	;se faccio 6 iterazioni ho finito i giorni
				BNE riempi
		
				MOV R0, #0x3
				MOV R1, #0x0
				LDR R2, =Calories_sport
				
sottrai			LDR R4, [R2]		;Carico il primo valore in R4
				LSL R5, R4, #2	 	;moltiplico il byte giorno per 4 e trovare l'indice in consumo
				SUB R5, R5, #4    	;sottraggo il primo giorno per trovare l'indice corretto del giorno
				LDR R6, [R2, #4]!
				LDR R3, =Consumo	;Prendo il primo in consumo
				ADD R3, R3, R5		;aggiorno valore indirizzo vettore
				LDR R7, [R3]		;prendo il valore relativo al giorno
				SUB R7, R7, R6
				STR	R7, [R3]
				ADD R2, R2, #4  	;vado avanti nel vettore Calories_sport
				SUBS R0, R0, #1
				BNE sottrai

				MOV R0, #0x0FFFFFFF
				MOV R4, #0x7
				MOV R11, #0x0
				LDR R1, =Consumo
				LDR R2, =Consumo
				
min				LDR R3, [R2]
				ADD R2, R2, #4
				CMP R3, R0
				MOVLT R0, R3
				SUBLT R11, R2 ,R1
				LSRLT R11, #2
				SUBS R4, R4, #1
				BNE min

stop            BX      R0
                ENDP

; Dummy Exception Handlers (infinite loops which can be modified)
ordinamento   	PROC
				PUSH {LR}
ricomincia		LDR R3, [R2]			;carico in R3 il valore
				MOV R6, #0				;aggiorno variabili
				MOV R1, R9				;aggiorno variabili
				MOV R4, R10				;carica il primo indirizzo 
				
calcola			LDR R5, [R4]			;carica il valore
				CMP R5, R3				;verifica se il valore è più grande 
				ADD R4, R4, #8
				ADDGT R6, R6, #1				
				SUBS R1, R1, #1
				BNE calcola				;trova il numero dei valori più grandi
				
				MOV R7, R11				;metto nel registro R7 l'indirizzo del primo del vettore su cui iterare
				LSL R6, R6, #2			
				ADD R7, R7, R6			;trovo indirizzo corretto dove inserire valore
				
trovaposizione	LDR R8, [R7]			;trova la posizione corretta se ci sono due dati uguali
				CMP R8, #0
				ADDNE R7, R7, #4				
				BNE trovaposizione
				SUB R2, R2, #4			;prende il giorno
				LDR R8, [R2]
				STR R8, [R7]
				ADD R2, R2, #12			;si sposta la valore di calorie successive

				SUBS R0, R0, #1
				BNE ricomincia
				POP{PC}
				ENDP
					
					
					
NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                ; your code
				orr r0,r0,#1
				BX	r0
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit                

                END
