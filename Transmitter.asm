_DrawFrame:
;Transmitter.c,58 :: 		void DrawFrame(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Transmitter.c,59 :: 		TFT_Init_ILI9341_8bit(320,240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init_ILI9341_8bit+0
;Transmitter.c,60 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Transmitter.c,61 :: 		TFT_Set_Pen(CL_BLACK, 1);
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;Transmitter.c,62 :: 		TFT_Line(20, 220, 300, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Transmitter.c,63 :: 		TFT_LIne(20,  46, 300,  46);
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Transmitter.c,64 :: 		TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;Transmitter.c,65 :: 		TFT_Write_Text("BEE  Click  Board  Demo", 55, 14);
MOVW	R0, #lo_addr(?lstr1_Transmitter+0)
MOVT	R0, #hi_addr(?lstr1_Transmitter+0)
MOVS	R2, #14
MOVS	R1, #55
BL	_TFT_Write_Text+0
;Transmitter.c,66 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Transmitter.c,67 :: 		TFT_Write_Text("EasyMx PRO v7", 19, 223);
MOVW	R0, #lo_addr(?lstr2_Transmitter+0)
MOVT	R0, #hi_addr(?lstr2_Transmitter+0)
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;Transmitter.c,68 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Transmitter.c,69 :: 		TFT_Write_Text("www.mikroe.com", 200, 223);
MOVW	R0, #lo_addr(?lstr3_Transmitter+0)
MOVT	R0, #hi_addr(?lstr3_Transmitter+0)
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;Transmitter.c,70 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,71 :: 		TFT_Write_Text("Transmitted data : ", 90, 80);
MOVW	R0, #lo_addr(?lstr4_Transmitter+0)
MOVT	R0, #hi_addr(?lstr4_Transmitter+0)
MOVS	R2, #80
MOVS	R1, #90
BL	_TFT_Write_Text+0
;Transmitter.c,72 :: 		}
L_end_DrawFrame:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawFrame
_main:
;Transmitter.c,74 :: 		void main() {
;Transmitter.c,76 :: 		GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_ALL);         // Set PA0 as digital input
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_GPIO_Digital_Input+0
;Transmitter.c,77 :: 		GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_ALL);
MOVW	R1, #65535
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
BL	_GPIO_Digital_Output+0
;Transmitter.c,78 :: 		Sound_Init(&GPIOE_ODR, 14);
MOVS	R1, #14
MOVW	R0, #lo_addr(GPIOE_ODR+0)
MOVT	R0, #hi_addr(GPIOE_ODR+0)
BL	_Sound_Init+0
;Transmitter.c,81 :: 		Initialize();                      // Initialize MCU and Bee click board
BL	_Initialize+0
;Transmitter.c,82 :: 		DrawFrame();
BL	_DrawFrame+0
;Transmitter.c,83 :: 		zvuk=0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_zvuk+0)
MOVT	R0, #hi_addr(_zvuk+0)
STRH	R1, [R0, #0]
;Transmitter.c,84 :: 		bufferPointer = -1;
MOVW	R1, #65535
SXTH	R1, R1
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
STRH	R1, [R0, #0]
;Transmitter.c,85 :: 		oldstateA4 = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA4+0)
MOVT	R0, #hi_addr(_oldstateA4+0)
STRH	R1, [R0, #0]
;Transmitter.c,86 :: 		oldstateA5 = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA5+0)
MOVT	R0, #hi_addr(_oldstateA5+0)
STRH	R1, [R0, #0]
;Transmitter.c,87 :: 		oldstateA6 = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA6+0)
MOVT	R0, #hi_addr(_oldstateA6+0)
STRH	R1, [R0, #0]
;Transmitter.c,88 :: 		k = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
STRH	R1, [R0, #0]
;Transmitter.c,89 :: 		while(1) {                         // Infinite loop
L_main0:
;Transmitter.c,91 :: 		if (Button(&GPIOA_IDR, 4, 1, 1)) oldstateA4 = 1;
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main2
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA4+0)
MOVT	R0, #hi_addr(_oldstateA4+0)
STRH	R1, [R0, #0]
L_main2:
;Transmitter.c,92 :: 		if (Button(&GPIOA_IDR, 4, 1, 0)&&oldstateA4==1){                      // detect logical one on PA0 pin
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main35
MOVW	R0, #lo_addr(_oldstateA4+0)
MOVT	R0, #hi_addr(_oldstateA4+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__main34
L__main33:
;Transmitter.c,93 :: 		GPIOD_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Transmitter.c,94 :: 		GPIOD_ODR.HAINT1 = ~GPIOD_ODR.HAINT1;
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Transmitter.c,95 :: 		zvuk = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_zvuk+0)
MOVT	R0, #hi_addr(_zvuk+0)
STRH	R1, [R0, #0]
;Transmitter.c,96 :: 		stanje = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_stanje+0)
MOVT	R0, #hi_addr(_stanje+0)
STRH	R1, [R0, #0]
;Transmitter.c,97 :: 		oldstateA4=0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA4+0)
MOVT	R0, #hi_addr(_oldstateA4+0)
STRH	R1, [R0, #0]
;Transmitter.c,92 :: 		if (Button(&GPIOA_IDR, 4, 1, 0)&&oldstateA4==1){                      // detect logical one on PA0 pin
L__main35:
L__main34:
;Transmitter.c,100 :: 		if (Button(&GPIOA_IDR, 5, 1, 1)) oldstateA5 = 1;
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main6
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA5+0)
MOVT	R0, #hi_addr(_oldstateA5+0)
STRH	R1, [R0, #0]
L_main6:
;Transmitter.c,101 :: 		if (Button(&GPIOA_IDR, 5, 1, 0)&&oldstateA5==1){
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__main37
MOVW	R0, #lo_addr(_oldstateA5+0)
MOVT	R0, #hi_addr(_oldstateA5+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__main36
L__main32:
;Transmitter.c,102 :: 		GPIOD_ODR = 0;                      // detect logical one on PA0 pin
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Transmitter.c,103 :: 		GPIOD_ODR.HAINT2 =~GPIOD_ODR.HAINT2;
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Transmitter.c,104 :: 		zvuk =2;
MOVS	R1, #2
SXTH	R1, R1
MOVW	R0, #lo_addr(_zvuk+0)
MOVT	R0, #hi_addr(_zvuk+0)
STRH	R1, [R0, #0]
;Transmitter.c,105 :: 		stanje = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_stanje+0)
MOVT	R0, #hi_addr(_stanje+0)
STRH	R1, [R0, #0]
;Transmitter.c,106 :: 		oldstateA5=0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_oldstateA5+0)
MOVT	R0, #hi_addr(_oldstateA5+0)
STRH	R1, [R0, #0]
;Transmitter.c,101 :: 		if (Button(&GPIOA_IDR, 5, 1, 0)&&oldstateA5==1){
L__main37:
L__main36:
;Transmitter.c,109 :: 		if (Button(&GPIOA_IDR, 6, 1, 1)){                      // detect logical one on PA0 pin
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #6
MOVW	R0, #lo_addr(GPIOA_IDR+0)
MOVT	R0, #hi_addr(GPIOA_IDR+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_main10
;Transmitter.c,110 :: 		GPIOD_ODR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Transmitter.c,111 :: 		GPIOD_ODR.HAINT3 = ~GPIOD_ODR.HAINT3;
MOVW	R1, #lo_addr(GPIOD_ODR+0)
MOVT	R1, #hi_addr(GPIOD_ODR+0)
LDR	R0, [R1, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOD_ODR+0)
MOVT	R0, #hi_addr(GPIOD_ODR+0)
STR	R1, [R0, #0]
;Transmitter.c,112 :: 		zvuk = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_zvuk+0)
MOVT	R0, #hi_addr(_zvuk+0)
STRH	R1, [R0, #0]
;Transmitter.c,113 :: 		stanje = 1;
MOVS	R1, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_stanje+0)
MOVT	R0, #hi_addr(_stanje+0)
STRH	R1, [R0, #0]
;Transmitter.c,115 :: 		}
L_main10:
;Transmitter.c,117 :: 		if (zvuk!=0){
MOVW	R0, #lo_addr(_zvuk+0)
MOVT	R0, #hi_addr(_zvuk+0)
LDRSH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main11
;Transmitter.c,118 :: 		if (bufferPointer>200) bufferPointer = 0;
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
LDRSH	R0, [R0, #0]
CMP	R0, #200
IT	LE
BLE	L_main12
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
STRH	R1, [R0, #0]
L_main12:
;Transmitter.c,119 :: 		DATA_TX[0]=zvuk;
MOVW	R3, #lo_addr(_zvuk+0)
MOVT	R3, #hi_addr(_zvuk+0)
LDRSH	R1, [R3, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Transmitter.c,120 :: 		bufferPointer++;
MOVW	R2, #lo_addr(_bufferPointer+0)
MOVT	R2, #hi_addr(_bufferPointer+0)
LDRSH	R0, [R2, #0]
ADDS	R1, R0, #1
STRH	R1, [R2, #0]
;Transmitter.c,121 :: 		DATA_TX[1]=bufferPointer;
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Transmitter.c,122 :: 		zvuk=0;
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [R3, #0]
;Transmitter.c,123 :: 		stanje = 0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_stanje+0)
MOVT	R0, #hi_addr(_stanje+0)
STRH	R1, [R0, #0]
;Transmitter.c,126 :: 		for (k =0 ; k<50; k++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
STRH	R1, [R0, #0]
L_main13:
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
LDRSH	R0, [R0, #0]
CMP	R0, #50
IT	GE
BGE	L_main14
;Transmitter.c,128 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Transmitter.c,126 :: 		for (k =0 ; k<50; k++)
MOVW	R1, #lo_addr(_k+0)
MOVT	R1, #hi_addr(_k+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Transmitter.c,129 :: 		}
IT	AL
BAL	L_main13
L_main14:
;Transmitter.c,131 :: 		DATA_TX[0]=bufferPointer;
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
LDRSH	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Transmitter.c,132 :: 		}
IT	AL
BAL	L_main16
L_main11:
;Transmitter.c,134 :: 		if (bufferPointer>200) bufferPointer = 0;
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
LDRSH	R0, [R0, #0]
CMP	R0, #200
IT	LE
BLE	L_main17
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
STRH	R1, [R0, #0]
L_main17:
;Transmitter.c,135 :: 		read_RX_FIFO();
BL	_read_RX_FIFO+0
;Transmitter.c,138 :: 		if ((stanje==1) && (bufferPointer<DATA_RX[1])){
MOVW	R0, #lo_addr(_stanje+0)
MOVT	R0, #hi_addr(_stanje+0)
LDRSH	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__main39
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	GE
BGE	L__main38
L__main31:
;Transmitter.c,140 :: 		if (DATA_RX[0]==1) {
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_main21
;Transmitter.c,141 :: 		Sound_Play(500,500);
MOVW	R1, #500
MOVW	R0, #500
BL	_Sound_Play+0
;Transmitter.c,142 :: 		}
L_main21:
;Transmitter.c,145 :: 		if (DATA_RX[0]==2) {
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_main22
;Transmitter.c,146 :: 		Sound_Play(500,1000);
MOVW	R1, #1000
MOVW	R0, #500
BL	_Sound_Play+0
;Transmitter.c,147 :: 		}
L_main22:
;Transmitter.c,138 :: 		if ((stanje==1) && (bufferPointer<DATA_RX[1])){
L__main39:
L__main38:
;Transmitter.c,151 :: 		if (DATA_RX[0]==1 || DATA_RX[0]==2) {
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L__main41
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L__main40
IT	AL
BAL	L_main25
L__main41:
L__main40:
;Transmitter.c,153 :: 		if (bufferPointer<DATA_RX[1]){
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
LDRSH	R0, [R0, #0]
CMP	R0, R1
IT	GE
BGE	L_main26
;Transmitter.c,154 :: 		bufferPointer = DATA_RX[1];
MOVW	R2, #lo_addr(_DATA_RX+1)
MOVT	R2, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R2, #0]
MOVW	R0, #lo_addr(_bufferPointer+0)
MOVT	R0, #hi_addr(_bufferPointer+0)
STRH	R1, [R0, #0]
;Transmitter.c,155 :: 		DATA_TX[0] = DATA_RX[0];
MOVW	R0, #lo_addr(_DATA_RX+0)
MOVT	R0, #hi_addr(_DATA_RX+0)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Transmitter.c,156 :: 		DATA_TX[1]=DATA_RX[1];
MOV	R0, R2
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+1)
MOVT	R0, #hi_addr(_DATA_TX+1)
STRB	R1, [R0, #0]
;Transmitter.c,159 :: 		for (k =0 ; k<50; k++)
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
STRH	R1, [R0, #0]
L_main27:
MOVW	R0, #lo_addr(_k+0)
MOVT	R0, #hi_addr(_k+0)
LDRSH	R0, [R0, #0]
CMP	R0, #50
IT	GE
BGE	L_main28
;Transmitter.c,161 :: 		write_TX_normal_FIFO();          // Transmiting
BL	_write_TX_normal_FIFO+0
;Transmitter.c,159 :: 		for (k =0 ; k<50; k++)
MOVW	R1, #lo_addr(_k+0)
MOVT	R1, #hi_addr(_k+0)
LDRSH	R0, [R1, #0]
ADDS	R0, R0, #1
STRH	R0, [R1, #0]
;Transmitter.c,162 :: 		}
IT	AL
BAL	L_main27
L_main28:
;Transmitter.c,164 :: 		DATA_TX[0]=DATA_RX[1];
MOVW	R0, #lo_addr(_DATA_RX+1)
MOVT	R0, #hi_addr(_DATA_RX+1)
LDRSB	R1, [R0, #0]
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
STRB	R1, [R0, #0]
;Transmitter.c,165 :: 		}
L_main26:
;Transmitter.c,166 :: 		}
L_main25:
;Transmitter.c,167 :: 		}
L_main16:
;Transmitter.c,169 :: 		ByteToStr(DATA_TX[0],&txt);      // Convert byte to string
MOVW	R0, #lo_addr(_DATA_TX+0)
MOVT	R0, #hi_addr(_DATA_TX+0)
LDRSB	R0, [R0, #0]
MOVW	R1, #lo_addr(_txt+0)
MOVT	R1, #hi_addr(_txt+0)
BL	_ByteToStr+0
;Transmitter.c,170 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,171 :: 		TFT_Write_Text(txt, 215, 80);    // Display string on TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,172 :: 		TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Transmitter.c,173 :: 		TFT_Write_Text(txt, 215, 80);    // Delete string from TFT
MOVS	R2, #80
MOVS	R1, #215
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_TFT_Write_Text+0
;Transmitter.c,174 :: 		zvuk=0;
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_zvuk+0)
MOVT	R0, #hi_addr(_zvuk+0)
STRH	R1, [R0, #0]
;Transmitter.c,175 :: 		}
IT	AL
BAL	L_main0
;Transmitter.c,176 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
