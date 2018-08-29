Configuring Klipper is actually very easy to do. All changes happen on the host computer (such as the Pi) inside of the printer.cfg file in your home directory. An example config file would look like this:

```
# This file contains pin mappings for Prusa i3 MK3 printers. To use
# this config, the firmware should be compiled for the AVR atmega2560.

# See the example.cfg file for a description of available parameters.

[probe]
pin: PB4
# TODO: Just an estimate/test z_offset.  The offset will increase as the temperature
# increases.  The thermistor in the PINDA can be used to calibrate a set of values
# to change the offset based on PINDA temperature
z_offset: .15 
speed: 5.0
#activate_gcode:
#deactivate_gcode:

[stepper_x]
step_pin: PC0
dir_pin: !PL0
enable_pin: !PA7
step_distance: .005
endstop_pin: tmc2130_stepper_x:virtual_endstop
position_endstop: 0
position_max: 255
homing_speed: 50.0
homing_retract_dist: 5.0


[tmc2130 stepper_x]
cs_pin: PG0
microsteps: 32
run_current: .282
hold_current: .1
sense_resistor: 0.220
diag1_pin: !PK2

interpolate: True
#stealthchop_threshold: 50 
driver_SGT: 3
driver_IHOLDDELAY: 8 
driver_TPOWERDOWN: 30 
driver_BLANK_TIME_SELECT: 2 
driver_TOFF: 3 
driver_HEND: 1 
driver_HSTRT: 5
driver_PWM_AUTOSCALE: True
driver_PWM_FREQ: 2
driver_PWM_GRAD: 2
driver_PWM_AMPL: 230

# TODO: Check the endstop and min position. The build area may be more than 4mm away
# from where the y-axis actually homes to
[stepper_y]
step_pin: PC1
dir_pin: PL1
enable_pin: !PA6
step_distance: .005
endstop_pin: tmc2130_stepper_y:virtual_endstop
position_endstop: -2.2
position_max: 212.5
position_min: -4.0
homing_speed: 50.0
homing_retract_dist: 5.0


[tmc2130 stepper_y]
cs_pin: PG2
microsteps: 32
run_current: .348
hold_current: .1
sense_resistor: 0.220
diag1_pin: !PK7
interpolate: True
#stealthchop_threshold: 50 
driver_SGT: 3
driver_IHOLDDELAY: 8 
driver_TPOWERDOWN: 30 
driver_BLANK_TIME_SELECT: 2 
driver_TOFF: 3 
driver_HEND: 1 
driver_HSTRT: 5
driver_PWM_AUTOSCALE: True
driver_PWM_FREQ: 2
driver_PWM_GRAD: 2
driver_PWM_AMPL: 235

[stepper_z]
step_pin: PC2
dir_pin: !PL2
enable_pin: !PA5
step_distance: .0025
endstop_pin: probe:z_virtual_endstop
#endstop_pin: tmc2130_stepper_z:virtual_endstop
position_endstop: 0.75
position_min: -0.5
position_max: 210
homing_speed: 13.3333

[tmc2130 stepper_z]
cs_pin: PK5
microsteps: 16
run_current: .53
hold_current: .15
sense_resistor: 0.220
diag1_pin: !PK6
interpolate: True
#stealthchop_threshold: 50 
#driver_SGT: 4
driver_IHOLDDELAY: 8 
driver_TPOWERDOWN: 30 
driver_BLANK_TIME_SELECT: 2 
driver_TOFF: 3 
driver_HEND: 3 
driver_HSTRT: 6
driver_PWM_AUTOSCALE: True
driver_PWM_FREQ: 2
driver_PWM_GRAD: 4
driver_PWM_AMPL: 200

[extruder]
step_pin: PC3
dir_pin: PL6
enable_pin: !PA4
step_distance: .00357142857143
nozzle_diameter: 0.400
filament_diameter: 1.750
# TODO: The max extrude cross section is increased for the purge line, but in theory
# its probably a bad idea to have it this large, as its purpose is to catch poorly sliced
# objects that extrude way too much for small moves
max_extrude_cross_section: 50.0
# Allows to load filament and purge up to 500mm
max_extrude_only_distance: 500.0
max_extrude_only_velocity: 120.0
max_extrude_only_accel: 1250.0
pressure_advance: 0.04
pressure_advance_lookahead_time: 0.01
# Pressure advance
heater_pin: PE5
sensor_type: ATC Semitec 104GT-2
sensor_pin: PF0
control: pid
pid_Kp: 16.13
pid_Ki: 1.1625
pid_Kd: 56.23
min_temp: 0
max_temp: 305

[tmc2130 extruder]
cs_pin: PK4
microsteps: 32
run_current: .514
hold_current: 0.1
sense_resistor: 0.220
diag1_pin: !PK3
interpolate: True
#stealthchop_threshold: 50 
#driver_SGT: 3
linearity_correction: 1.06
# This is linearity correction, similar hopefully same as prusa firmware.
driver_IHOLDDELAY: 8 
driver_TPOWERDOWN: 30 
driver_BLANK_TIME_SELECT: 2 
driver_TOFF: 3 
driver_HEND: 2 
driver_HSTRT: 5
driver_PWM_AUTOSCALE: True
driver_PWM_FREQ: 2
driver_PWM_GRAD: 4
driver_PWM_AMPL: 240

[heater_bed]
heater_pin: PG5
sensor_type: EPCOS 100K B57560G104F
sensor_pin: PF2
control: pid
pid_Kp: 126.13
pid_Ki: 4.3
pid_Kd: 924.76
min_temp: 0
max_temp: 125

[heater_fan nozzle_cooling_fan]
pin: PH5
heater: extruder
heater_temp: 50.0
fan_speed: 1.0

# Part Cooling Fan
[fan]
pin: PH3

[mcu]
serial: /dev/ttyACM0

[display]
lcd_type: hd44780
rs_pin: PD5
e_pin: PF7
d4_pin: PF5
d5_pin: PG4
d6_pin: PH7
d7_pin: PG3

[printer]
kinematics: cartesian
max_velocity: 200
max_accel: 1500
max_z_velocity: 15
max_z_accel: 750

# Keeps Debug LED off / not floating
[static_digital_output debug_led]
pins: !PB7 
```

The config file is broken up into sections by \[\]. Under each of these sections is relevant configurations. For example, under \[tmc2130 stepper_x\] you can change settings such as running current, microstepping, distance per step, and homing speeds.

To apply changes made in the config file, issue the following command to Octoprint under the Terminal tab: RESTART

<Category:Klipper>