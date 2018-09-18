# MK2  to MK2E conversion:

This guide explains how to retrofit a temperature compensating PINDA probe to the Prusa i3 MK2 (and MK2S). The probe triggering distance will drift a significant amount inside of a heated enclosure for some time if no temperature compensation is fitted.


## Firmware:
We need to update the firmware to read the temperature sensor inside the PINDA V2 probe. Alternatively you can use the V1 probe, but you will have to add a thermistor in your own creative way, and you will also need to define the type of thermistor in the firmware if it is not type 1 (1 is 100k thermistor - best choice for EPCOS 100k (4.7k pullup)).

Build and update the firmware from here: https://github.com/galagithub/Prusa-Firmware
If you need help, see this guide: http://zaribo.org/blog/how-to-compile-and-modify-prusa-firmware-part-i-setting-up-the-environment/
Alternatively, find the precompiled .hex binary in this repository.


## Hardware:

### PINDA V2 users:
Connect white wire, which is the thermistor lead on the PINDA V2 probe to T1 thermistor plug's signal pin on your rambo board. If its unclear, see the pictures here:
https://shop.prusa3d.com/forum/others-archive--f82/is-the-mk3-pinda-v2-compatible-with-the-mk2-rambo--t14786.html

### PINDA V1 users:
If you're cheap like me, you attach a thermistor to your pinda probe in some sort of thermally conductive manner. Here is how I did it: https://imgur.com/a/XO0Dp0j

Define the thermistor type you used here at this line: https://github.com/galagithub/Prusa-Firmware/blob/MK2SE/Firmware/Configuration_prusa.h#L457 And upload the firmware. Connect the thermistor to plug T1. If you need help building the firmware, follow this guide: http://zaribo.org/blog/how-to-compile-and-modify-prusa-firmware-part-i-setting-up-the-environment/ If you're still stuck, there's a few more guides that you can find via google that you could try.


# TODO:

Backport temperature compensation to latest release of MK2 firmware - current firmware is quiet old.
Add `M860 Sxx` gcode command. Wait until pinda probe reaches `xx` degrees.
