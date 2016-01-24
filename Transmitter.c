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

extern short int DATA_TX[];   //niz za transmitovanje, pisanje, i ispisivanje na displej
extern short int DATA_RX[];   //niz niza za primanje, citanje

int oldstateA4;         // oldstateA(x) prestavlja stanje dugmeta iz prethodnog loop-a
int oldstateA5;		// (x) je konkretno dugme
int oldstateA6;

char txt[4];		//tekst koji upisujemo

int zvuk;    // zvuk moze imati vrednosti: 0 (nema signala), 1(kratak signal) ili 2 (dug signal)
int k;
int stanje;  // stanje moze biti: pustam signal (0) ili primam signal (1)
int bufferPointer;  // Cuva id poruke na osnovu kojeg znamo da li je primljeni signal ranije vec primljen

void DrawFrame() 			// MK funkcija za crtanje frejma na LCD displey
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

    GPIO_Digital_Input(&GPIOA_IDR, _GPIO_PINMASK_ALL);         // Set PA0 as digital input
    GPIO_Digital_Output(&GPIOD_ODR, _GPIO_PINMASK_ALL);        // registrujemo lampice kao output
    Sound_Init(&GPIOE_ODR, 14);				   // inicijalizacija zvuka/speaker-a na ploci


    Initialize();                      // Initialize MCU and Bee click board
    DrawFrame();

    zvuk=0;			//
    bufferPointer = -1;
    oldstateA4 = 0;
    oldstateA5 = 0;
    oldstateA6 = 0;
    k = 0;
// kraj inita


    while(1)                           // Infinite loop
    {

        if (Button(&GPIOA_IDR, 4, 1, 1)) oldstateA4 = 1; 	  // kada pritisnemo taster za selekciju moda, pamtimo da je dugme pritisnuto
        if (Button(&GPIOA_IDR, 4, 1, 0)&&oldstateA4==1)        // detektujemo kada smo otpustili taster (0), a znamo da je dugme bilo pritisnuto (oldstate)
        {
            GPIOD_ODR = 0;					                   // gasimo sve lampice na ploci u bloku
            GPIOD_ODR.HAINT1 = ~GPIOD_ODR.HAINT1;             // invertujemo stanje jedne lampice u bloku
            zvuk = 1;					                        // pustamo kratak signal
            stanje = 0;                                       // prelazimo u mod transmitera (saljemo signal)
            oldstateA4=0;					  // pamtimo da dugme otpusteno

        }

        if (Button(&GPIOA_IDR, 5, 1, 1)) oldstateA5 = 1;        // detektujemo da li je pritisnuto dugme za dugi signal
        if (Button(&GPIOA_IDR, 5, 1, 0)&&oldstateA5==1) 	  // detektujemo kada je dugme otpusteno
        {
            GPIOD_ODR = 0;                      		  // gasimo sve lampice u bloku
            GPIOD_ODR.HAINT2 =~GPIOD_ODR.HAINT2;		  // invertujemo jednu lampicu (razlicitu od kratkog signala)
            zvuk =2;						  // dug signal
            stanje = 0;
            oldstateA5=0;
        }

        if (Button(&GPIOA_IDR, 6, 1, 1))                       // detektujemo kada je pritisnuto dugme za prelazak u mod receivera
        {
            GPIOD_ODR = 0;					 // gasimo lampice u bloku
            GPIOD_ODR.HAINT3 = ~GPIOD_ODR.HAINT3;		 // invertujemo jednu u bloku
            zvuk = 0;					 // ne saljemo zvuk
            stanje = 1;					 // pamtimo da smo u modu receivera

        }

        if (zvuk!=0)                                         // ako pustamo zvuk (transmit mode)
        {
            if (bufferPointer>200) bufferPointer = 0;         // ako smo presli buffer, resetujemo ga
            DATA_TX[0]=zvuk;				 // setujemo bit 0 za slanje na vrednost zvuka koji saljemo (1 kratak signal, 2 dug)
            bufferPointer++;				 // povecavamo ID signala
            DATA_TX[1]=bufferPointer;			 // setujemo bit 1 za slanje na ID signala
            zvuk=0;					 // resetujemo signal na 0
            stanje = 0;					 // ostajemo u stanju transmitera

            for (k =0 ; k<50; k++)			 // Saljemo 50 puta isti signal da bismo bili sigurni da je signal poslat, ali sa istim ID-om
            {
                write_TX_normal_FIFO();                    // Transmitovanje preko WiFi-a
            }

            DATA_TX[0]=bufferPointer;                      // stavljamo ID signala u bit za slanje vrednosti zvuka jer koristimo DATA_TX[0] za ispisivanje an displej
        }

        else
        {
            if (bufferPointer>200) bufferPointer = 0;	// zvuk je 0, odnosno u stanju smo relej-a ili recievera
            read_RX_FIFO();				// citamo preko WiFi-a na defaultnom kanalu



            if ((stanje==1) && (bufferPointer<DATA_RX[1]))  // Da li smo u stanju slusanja i da li je primljeni signal vec stigao ranije
            {
                if (DATA_RX[0]==1)   			// primljeni signal u bit za vrednost zvuka ima 1 (kratak signal)
                {
                    Sound_Play(500,500);			// pustam kratak signal na ploci (frekvencija, trajanje)
                }

                if (DATA_RX[0]==2)  			// dug signal
                {
                    Sound_Play(500,1000);
                }
            }

            // Prosledi signal
            if (DATA_RX[0]==1 || DATA_RX[0]==2)   // proveravamo da li je vrednost primljenog signala 1 ili 2
            {
                if (bufferPointer<DATA_RX[1])  	// Provera da li je primljeni signal ranije primljen
                {
                    bufferPointer = DATA_RX[1];	//nije primljen ranije, setujemo test ID na ID iz signala
                    DATA_TX[0] = DATA_RX[0];	// setujemo primljen ID signala u bit za slanje ID signala
                    DATA_TX[1]=DATA_RX[1];		// setujemo primeljnu vrednost signala u bit za slanje vrednosti signala

                    // Saljemo 50 puta isti signal da bismo bili sigurni da je signal poslat
                    for (k =0 ; k<50; k++)
                    {
                        write_TX_normal_FIFO();          // Transmitujemo tj saljemo preko defaultnog kanala
                    }

                    DATA_TX[0]=DATA_RX[1];		// stavljamo u DATA_TX[0] jer koristimo ovo za ispisivanje na displej
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
