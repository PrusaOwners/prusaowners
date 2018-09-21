# MK2  to MK2E conversion:
TODO: Bed calibration fails with current firmware that I have been working on.
TODO: Backport gcodes M860 and M861 to MK2 firmware. Using MK3 firmware branch and modding it to work with MK2's bed points for calibration has proven to be very difficult. As it goes along the probing points in the X direction, it moves in the Y direction, even though all the points are in a straight line as defined in the firmware.

This guide explains how to retrofit a temperature compensating PINDA probe to the Prusa i3 MK2 (and MK2S). The probe triggering distance will drift a significant amount inside of a heated enclosure if no temperature compensation is fitted.


## Firmware:
We need to update the firmware to read the temperature sensor inside the PINDA V2 probe. Alternatively you can use the V1 probe, but you will have to add a thermistor in your own creative way, and you will also need to define the type of thermistor in the firmware if it is not type 1 (1 is 100k thermistor - best choice for EPCOS 100k (4.7k pullup)).

Install [this firmware](https://github.com/TTN-/Prusa-Firmware/blob/MK3/README.md).


# Hardware:

### PINDA V2 users:
Connect white wire, which is the thermistor lead on the PINDA V2 probe to T1 thermistor plug's signal pin on your rambo board. If its unclear, [see the pictures here](https://shop.prusa3d.com/forum/others-archive--f82/is-the-mk3-pinda-v2-compatible-with-the-mk2-rambo--t14786.html)

### PINDA V1 users:
If you're cheap like me, you attach a 100k thermistor to your pinda probe in some sort of thermally conductive manner. [Here is how I did it](https://imgur.com/a/XO0Dp0j)

Connect the thermistor to plug T1.

# Calibration:
Gcodes:
M860 - Wait for PINDA thermistor to reach target temperature.
M861 - Set / Read PINDA temperature compensation offsets
G75  - display current calibration

The LCD menu has a PINDA autocalibration entry under Menu -> Calibration -> Temp. calibration

Alternatively you can follow [Crzcrz's calibration guide](https://github.com/crzcrz/prusaowners/blob/master/First_layer_and_PINDA_temperature_calibration_with_calipers.md)
