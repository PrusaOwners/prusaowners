Hoodloader2
================
Why Hoodloader2?
----------------
USB serial communication problems are common on the Einsy Rambo, affecting users both on stock Prusa Firmware using Octoprint and users that have migrated to Klipper. There are various factors involved with connection issues, however the most glaring culprit is the firmware running on the Atmega 32u2 processor that serves as a bridge for USB communication between the host machine (likely Raspberry Pi) and the Einsy's main processor, an Atmega 2560.

Hoodloader2 has functionality that goes beyond simple serial communications, however its primary benefit is vastly improved stability for USB and support for up to 2M baud full duplex serial communications.

Caveats
-------
* Because Hoodloader2 supports uploading sketches to the 32u2 in addition to the Atmega 2560, a baud rate of 57600 is reserved.  Thus you cannot connect to USB serial using this baud rate.  But really, why would you want to do that?

* Your Einsy will no longer enumerate using Prusa's Vendor and Product IDs.  It will show up as either "Hoodloader2 Mega" or as "Arduino Mega", depending on your platform.

Installing Hoodloader2
-----------------------
There are two methods that can be used to install Hoodloader2 on an Einsy rambo, both will be covered in this document.  However first you will need to clone the Hoodloader2 on your local machine:
```git clone https://github.com/NicoHood/HoodLoader2.git```

Method 1: Installing using an Arduino Uno
------------------------------
This method uses an installation sketch uploaded to a secondary Arduino to flash the Atmega 32u2.  This method outlines how to use an Uno, however other Arduino's, such as a Nano, should work.  You will need 3 dupont male to female jumpers, and 3 dupont female to female jumpers.

1) Download the latest version of the Arduino IDE.
2) Open the sketch in the Hoodloader2 repo located at `/avr/examples/Installation_Sketch/Installation_Sketch.ino`
3) Change line 11 to the following:
`#define HEXFILE HEXFILE_HoodLoader2_0_5_Mega_atmega32u2_hex`
4) Save and upload the sketch to your Uno
5) Disconnect your Einsy from USB and Power.  Disconnect your Uno from USB.
6) Use the following diagram to make your connections:
![<File:einsy> uno.png](images/einsy_uno.png "File:einsy_uno.png")

| Uno Pin | Einsy ICSP Pin | Color |
|---------|-----------|-------|
| MISO | Pin 1 (MISO) | Blue |
| +5v | Pin 2 (USBVCC) | Red |
| SCK | Pin 3(SCK) | Green |
| MOSI | Pin 4(MOSI) | Yellow |
| Pin 10  | Pin 5 (Reset)| Purple |
| Ground | Pin 6 (Ground) | Black |

7) Connect your secondary Arduino to your PC via USB.  Open the Arduino IDE's serial console at 115200 baud.  Watch as the firmware upload completes.
8) Disconnect everything.  Connect power and USB back to your Einsy.  Run the following command if connected to a linux based system such as a Raspberry Pi:
`ls /dev/serial/by-id/`
The output should be:
`usb-NicoHood_HoodLoader2_Mega-if00`
9) You are now ready to print with improved communication stability.

Method 2: Installing using a programmer
----------------------------------------
602 Wasteland community leader Zbrozek has contributed a simple method for programming with a USBasp.

1) Disconnect USB and Power from the Einsy
2) Connect the USBasp:

| USBasp | | Einsy ICSP|
|--------|-|-----------|
| Pin 1 | MOSI | Pin 4 |
| Pin 2 | VCC | Pin 2 |
| Pin 4 | GND | Pin 6 |
| Pin 5 | Reset  | Pin 5 |
| Pin 7 | SCK | Pin 3 |
| Pin 9 | MISO | Pin 1|

You may also refer to the image in the previous section to see the pinout for the Einsy's 32u2 ICSP header.

3) Run the following commands:

```shell
wget https://raw.githubusercontent.com/NicoHood/HoodLoader2/master/avr/bootloaders/HexFiles/HoodLoader2_0_5_Mega_atmega32u2.hex
avrdude -c usbasp -p m32u2 -U lfuse:w:0xEF:m -U hfuse:w:0xD8:m -U efuse:w:0xFC:m -U flash:w:HoodLoader2_0_5_Mega_atmega32u2.hex:i
```
Presumably this can be adapted to other programmers by changing the avrdude command.

4) Disconnect everything.  Connect power and USB back to your Einsy.  Run the following command if connected to a linux based system such as a Raspberry Pi:
`ls /dev/serial/by-id/`
The output should be:
`usb-NicoHood_HoodLoader2_Mega-if00`
5) You are now ready to print with improved communication stability.

