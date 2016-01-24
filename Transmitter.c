/*
 * Project name:
     BEE Click Transmitter (Using mikroE's BEE click Board)
 * Copyright:
     (c) Mikroelektronika, 2012.
 * Revision History:
     20120521:
       - initial release (JK and DO)
 * Description:
     This project is a simple demonstration of working with the BEE click board.
     The transmitter sends the data and the receiver displays it on the TFT.
     The on-board MRF24J40MA is a 2.4 GHz IEEE 802.15.4 radio transceiver module
     and operates in the 2.4GHz frequency band.
     Detailed information about MRF24J40 module is availabe here:
     http://ww1.microchip.com/downloads/en/DeviceDoc/DS-39776b.pdf
 * Test configuration:
     MCU:             STM32F107VC
                      http://www.st.com/internet/com/TECHNICAL_RESOURCES/TECHNICAL_LITERATURE/DATASHEET/CD00220364.pdf
     Dev.Board:       EasyMx PRO v7 for STM32
                      http://www.mikroe.com/eng/products/view/852/easymx-pro-v7-for-stm32/
     Oscillator:      HS-PLL 72.0000 MHz, internal 8.0000 MHz RC
     Ext. Modules:    BEE Click Board  - ac:BEE_Click
                      http://www.mikroe.com/eng/products/view/810/bee-click/
     SW:              mikroC PRO for ARM
                      http://www.mikroe.com/mikroc/arm/
 * NOTES:
     - Place microSD click board in the mikroBUS socket 1.
 */

#include "resources.h"
#include "registers.h"
#include "ReadWrite_Routines.h"
#include "Reset_Routines.h"
#include "Misc_Routines.h"
#include "Init_Routines.h"

// BEE Click Board connections
sbit CS at GPIOD_ODR.B13;                // CS pin
sbit RST at GPIOC_ODR.B2;                // RST pin
sbit INT at GPIOD_ODR.B10;               // INT pin
sbit WAKE_ at GPIOA_ODR.B4;              // WAKE pin

// TFT module connections

// End TFT module connections
// modified by Aleksandar Fotev

extern short int DATA_TX[];   // array for transmiting data, writing to TFT display
extern short int DATA_RX[];   //array for receiving data

int oldstateA4;         // oldstateA(x) represent the state of a pressed button
int oldstateA5;		// (x) is the actual button
int oldstateA6;         // = 0 - button was not pressed in the previous loop, 
			// = 1-  was pressed

char txt[4];		//array that will contain the text to be written on the TFT display

int zvuk;	// sound, can have values: 
		// 0 (no sound), 
		// 1 (short signal),
		// 2 (long signal),
int k;
int stanje;	// state, can be:
		// sending / transmiting (0) 
		// receiving (1)
int bufferPointer;	//variable that represents the ID of the message

void DrawFrame() 			// MK routine for drawing on the TFT display
{
    TFT_Init_ILI9341_8bit(320,240);
    TFT_Fill_Screen(CL_WHITE);
    TFT_Set_Pen(CL_BLACK, 1);
    TFT_Line(20, 220, 300, 220);
    TFT_LIne(20,  46, 300,  46);
    TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
    TFT_Write_Text("BEE  Click  Board  Demo", 55, 14);
    TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
    TFT_Write_Text("EasyMx PRO v7", 19, 223);
    TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
    TFT_Write_Text("www.mikroe.com", 200, 223);
    TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
    TFT_Write_Text("Transmitted data : ", 90, 80);
}

void main()
{
//init

    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_ALL);         // Set board buttons as digital input
    GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_ALL);        // SET LED lamps as output
    Sound_Init(&GPIOE_ODR, 14);				   // init of the on-board speakers via MK library


    Initialize();                      // Initialize MCU and Bee click board
    DrawFrame();

    zvuk=0;			
    bufferPointer = -1;
    oldstateA4 = 0;
    oldstateA5 = 0;
    oldstateA6 = 0;
    k = 0;
// end of init


    while(1)                           // Infinite loop
    {

        if (Button(&GPIOA_IDR, 4, 1, 1)) oldstateA4 = 1; 	  // when we press a button, we set the oldState to 1, to rembember in the next loop that the button is still pressed
        if (Button(&GPIOA_IDR, 4, 1, 0)&&oldstateA4==1)		// when the button is not pressed (0) but we know it was pressed in the previous loop (oldstate=1), we execute the command
        {
            GPIOD_ODR = 0;					// turn off all the LED lamps in the block
            GPIOD_ODR.HAINT1 = ~GPIOD_ODR.HAINT1;             // invert one lamp in the block (it will be on now), represents the state of the board, in this case, transmiting
            zvuk = 1;						// sound, short signal
            stanje = 0;                                       // save the value of the mode we are in, transmiting
            oldstateA4=0;					// reset the oldstate to 0, so we know it wasn't pressed in the last loop
        }

        if (Button(&GPIOA_IDR, 5, 1, 1)) oldstateA5 = 1;        // same as above for the long signal
        if (Button(&GPIOA_IDR, 5, 1, 0)&&oldstateA5==1) 	  
        {
            GPIOD_ODR = 0;                      		  
            GPIOD_ODR.HAINT2 =~GPIOD_ODR.HAINT2;		  
            zvuk =2;						  
            stanje = 0;
            oldstateA5=0;
        }

        if (Button(&GPIOA_IDR, 6, 1, 1))                       // entering the receiver mode
        {
            GPIOD_ODR = 0;					 // LED Lamps 
            GPIOD_ODR.HAINT3 = ~GPIOD_ODR.HAINT3;		 // 
            zvuk = 0;					 	// not sending any sound now, we are just receiving 
            stanje = 1;					 	// save the value so we know we are in receiver mode 

        }

        if (zvuk!=0)                                         // (transmit mode, 1 or 2)
        {
            if (bufferPointer>200) bufferPointer = 0;         // buffer value check, so we don't pass a certain limit
            DATA_TX[0]=zvuk;				 // DATA_TX[0], value of the signal(1 short signal, 2 long signal)
            bufferPointer++;				 // iterate the signal ID 
            DATA_TX[1]=bufferPointer;			 // set the signal ID
            zvuk=0;					 // reset "local" signal value to 0
            stanje = 0;					 // stay in transmit mode

            for (k =0 ; k<50; k++)			 // sending the same message mutliple times to be sure it will be received (it will be ignored if we receive it more then once)
            {
                write_TX_normal_FIFO();                    // transmiting
            }

            DATA_TX[0]=bufferPointer;                      // saving the signal ID to the array that will be later used for writing to TFT displey
        }

        else						// no sound sending, which means we are in reciever or relay mode
        {
            if (bufferPointer>200) bufferPointer = 0;	
            read_RX_FIFO();				// read the WiFi default channel



            if ((stanje==1) && (bufferPointer<DATA_RX[1]))  // are we in the receiver mode and is the last signal ID we received newer then the newly received one?
            {
                if (DATA_RX[0]==1)   			//  the signal is new and it's short
                {
                    Sound_Play(500,500);			// play it (frequency, duration)
                }

                if (DATA_RX[0]==2)  			// the signal is new and it's long
                {
                    Sound_Play(500,1000);
                }
            }

            // relay the signal
            if (DATA_RX[0]==1 || DATA_RX[0]==2)   // check if the received signal is 1 or 2
            {
                if (bufferPointer<DATA_RX[1])  	// signal ID check
                {
                    bufferPointer = DATA_RX[1];	// new signal, set the new signal ID value as a check, prepare for transmiting
                    DATA_TX[0] = DATA_RX[0];	// set the signal value 
                    DATA_TX[1]=DATA_RX[1];	// set the signal ID

                    // sending
                    for (k =0 ; k<50; k++)
                    {
                        write_TX_normal_FIFO();          // Transmiting
                    }

                    DATA_TX[0]=DATA_RX[1];		// save for later use on the TFT
                }
            }
        }

        ByteToStr(DATA_TX[0],&txt);      // Convert byte to string
        TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
        TFT_Write_Text(txt, 215, 80);    // Display string on TFT
        TFT_Set_Font(&TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
        TFT_Write_Text(txt, 215, 80);    // Delete string from TFT
        zvuk=0;
    }
}
