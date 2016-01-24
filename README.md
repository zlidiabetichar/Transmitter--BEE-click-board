# Transmitter--BEE-click-board
RTC project
@@ -1,14 +1,15 @@
By Aleksandar Fotev,

Originaly a MikroElektronika project:

That shows an example how to write something on a TFT displey on a development board.

 This project is a simple demonstration of working with the BEE click board.
     The transmitter sends the data and the receiver displays it on the TFT.
     The on-board MRF24J40MA is a 2.4 GHz IEEE 802.15.4 radio transceiver module
     and operates in the 2.4GHz frequency band.
     Detailed information about MRF24J40 module is availabe here:
     http://ww1.microchip.com/downloads/en/DeviceDoc/DS-39776b.pdf

The example was modified to use: 

- Wifi Connection as input/output
- Buttons on the board toggle different behavior modes
- Buttons as input to apply actions / serve as input
- changed the way how the Wifi protocol works, but within the same storage limitation
- added a custom made debounce mechanism that ignores messages with the same ID (ignores reflections/rebounce of the WiFi signal)

Transmitter.c:
Everything above except the WiFi protocol change

ReadWrote_Routines.c
WiFi protocol change, separation of the default value array into 2 arrays:
where one is used to contain signal value 
the other one is used to contain the signal ID value

Adjustment of the rest of the code to work as intended with the previous modification
WiFi protocol change


Misc_Routines.c
Added a note that the default debounce routine/function does not work as intended in the provided library (that was provided by MikroElektronika).


The project (with my modifications) was tested by an assistent from Ra?unarski Fakultet (RAF) and evaluated as fully functional for the required assigment which was in short:

A transmitter/relay/reciever system that can send short and long signals via WiFi and represent the signal in a video and audio manner. 
For the video,the on-board TFT display was used, 
for audio, the on-board speaker system was used.
The board mode (transmitter/receiver/relay) is changed in real time via pressing of specific buttons on the board, with a visual cue via LED lamps switching on/off.
Added a note that the default debounce routine/function does not work as intended in the provided library (that was provided by MikroElektronika)
