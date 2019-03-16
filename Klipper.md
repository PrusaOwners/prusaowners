About Klipper
-------------

Klipper is a 3D printer firmware system which utilizes an external processor such as a Raspberry Pi or other computer to compute kinematic equations and send the processed information to the MCU on the printer, usually a ATMega 2560. Klipper's main fork is available at <https://github.com/KevinOConnor/klipper>, however, if you want the experimental features outlined in this wiki it is recommended to clone our community repository at <https://github.com/PrusaOwners/klipper>.

Installing and Configuring Klipper on the MK3
---------------------------------------------

If you are installing Klipper on a Raspberry Pi, follow the instructions [Adafruit's put together here](https://learn.adafruit.com/octoprint-on-m3d/octoprint-set-up) to install Octoprint, or use a preconfigured octopi image.

First, SSH into the Pi (Windows: use PuTTY; Linux/Mac, use the terminal). If you don’t know what it is, try octopi.local or install something like Advanced IP Scanner to find it out. Username is pi, password raspberry

Run the following commands:

    git clone https://github.com/PrusaOwners/klipper
    ./klipper/scripts/install-octopi.sh
    cd ~/klipper/
    make menuconfig

Leave everything as stock, and click save, then exit.

Run the following command:

    make

Ensure that the Raspberry Pi is physically connected to the printer, and that Octoprint is not connected to the printer by navigating to <http://octopi.local> or your pi’s IP address on a web browser (the "Connect" button should be displayed).

Next is finding the USB serial port.  The general way to find a USB serial port is to run ls -l /dev/serial/by-id/ from an ssh terminal on the host machine. It will likely produce output similar to the following:

    lrwxrwxrwx 1 root root 13 Jun  1 21:12 usb-1a86_USB2.0-Serial-if00-port0 -> ../../ttyUSB0
The name found in the above command (minus the -> ../../ttyACM0 portion) is stable and it should be used in the config file and while flashing the micro-controller code. For example, a flash command might look similar to:

    sudo service klipper stop
    make flash FLASH_DEVICE=/dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0
    sudo service klipper start

Next, copy the file ~/klipper/config/printer-prusa-i3-mk3-2017.cfg to your home directory and rename it printer.cfg:

    cd ~
    cp ~/klipper/config/printer-prusa-i3-mk3-2017.cfg printer.cfg

This file contains a default configuration for the Prusa i3 MK3 and enables all of the experimental features outlined in this wiki.  The config must be updated with the updated USB information.  Open up printer.cfg in a text editor and change the line listed below:

    [mcu]
    serial: /dev/ttyACM0

to match the the USB device from the ls -l command.  Be sure to copy-and-paste the name from the "ls" command (minus the -> ../../ttyACM0 portion) that you ran above as the name will be different for each printer.  The line in the updated config might look like:

    [mcu]
    serial: /dev/serial/by-id/usb-1a86_USB2.0-Serial-if00-port0

Next, restart Klipper with the following command:

    sudo service klipper restart

Finally, connect Klipper to Octoprint:

Go to the setting wrench at the top.

Under **“Serial Connection”** in **“Additional serial ports”** add **“/tmp/printer”**. Then click **“Save”**.

Enter the Settings tab again and under **“Serial Connection”** change the **“Serial Port”** setting to **“/tmp/printer”**. Navigate to the **“Behavior”** sub-tab and select the **“Cancel any ongoing prints but stay connected to the printer”** option. Click **“Save”**.

From the main page, under the **“Connection”** section (at the top left of the page) make sure the **“Serial Port”** is set to **“/tmp/printer”** and baudrate is **250000** and click **“Connect”**. (If **“/tmp/printer”** is not an available selection then try reloading the page.)

Once connected, navigate to the **“Terminal”** tab and type **“status”** (without the quotes) into the command entry box and click **“Send”**. If you see this, you’re good: **“Recv: // Printer is ready”**

Special considerations for installing on a non-raspberry-pi
-----------------------------------------------------------

If you follow the above instructions and it doesn't work, try running this:

cat /etc/default/klipper

You should get an output like this:

    # Configuration for /etc/init.d/klipper

    KLIPPY_USER=server

    KLIPPY_EXEC=/home/server/klippy-env/bin/python

    KLIPPY_ARGS="/home/server/OctoPrint/klipper/klippy/klippy.py /home/server/printer.cfg -l /tmp/klippy.log"

If KLIPPY_ARGS's path is different than your klipper path (e.g. this example shows Klipper under the Octoprint folder, and I had it in /home/server), correct with a mv command like so: mv /home/YourUserName/klipper /home/YourUserName/OctoPrint/klipper

Calibrating your Z-Endstop
--------------------------

The Prusa i3 MK3 uses the Pinda probe as a Z-Endstop, and the endstop height needs to be calibrated prior to printing. Proceed with the following steps for initial calibration:

1.  Set the following properties under [stepper_z] in your printer.cfg:

        position_min: -2
    and under [probe]:

        z_offset: 0

2.  Restart klipper from the shell to load the new config:

        sudo service klipper restart

    Alternatively, you can issue a restart command from Octoprint's terminal if you are connected.

3.  Home the Z-axis using Octoprint.
4.  Use Octoprint or the Printer Menu to move the Z-axis down in .1mm to .01mm increments until the nozzle is just above the bed
5.  The current Z position will likely be somewhere between -0.4 and -1.0 It will be displayed on the printer, you can also retrieve the current position by issuing the GET_POSITION command in Octoprint's terminal.
6.  The absolute value of the current Z position will be your endstop position and probe offset. For example, if your Z position is -.6, enter the following under [probe]:

        z_offset: .6

7.  Restart Klipper again and you are ready to print. You may have to make slight changes to get a good first layer. Increasing the endstop position will bring the nozzle closer to the bed when printing, decreasing the endstop will raise it. Make sure you update both the endstop position and probe offset when making changes.

Prusa GCode Support
--------------------

Currently the following prusa specific gcodes are supported:

-   TIMED_GCODE
-   TRAM_Z

To enable these gcodes, add the following to your printer.cfg:

    [prusa_gcodes]

TIMED_GCODE allows the user to execute a gcode with a specific delay.  This is, for example, useful for resetting the display after a M117 message.  It is used in the following manner:

    TIMED_GCODE GCODE=M117 DELAY=5

The example above will send an empty M117 with a delay of 5 seconds.  Note that if you want to execute a more complex gcode, spaces should be replaced underscores.  For example, if you want to send M117 Hello on a with a delay of 10 seconds, you could enter the following:

     TIMED_GCODE GCODE=M117_Hello DELAY=5

TRAM_Z functions in a manner similar to Prusa's Calibrate-Z functionality. It will use the TMC2130 driver to home to the top of the printer, then move an extra 10mm to “tram” the Z-Axis.

Note for previous users:
LOAD_FILAMENT, UNLOAD_FILAMENT, SET_BEEPER, and M900 have been deprecated.  It is recommend to use gcode macros to replace the functionality of these gcodes.

Configuring Mesh Bed Leveling
-----------------------------

### About Klipper Mesh Bed Leveling

Mesh Bed Leveling is now available in upstream Klipper: <https://github.com/KevinOConnor/klipper>

You may also pull it from the PrusaOwners repo: <https://github.com/PrusaOwners/klipper/>

### Things to Note Before Implementing

There are a few things to keep in mind with this implementation that may be subject to change:

1.  By default each probe point is only sampled once, unlike Prusa Firmware which samples twice. After testing this doesn't seem to create an issue, as the Pinda produces fairly repeatable results. Functionality has been added to multi-sample points, with the tradeoff being that there is a small pause between samples unlike stock firmware.
2.  <b>Those transitioning from ALPHA versions of bed_mesh should be aware of the following:</b>
    1.  The probe_offset option of [bed_mesh] has now moved to the [probe] section as x_offset and y_offset.
    2.  In the [bed_mesh] section probe_min and probe_max have been renamed to min_point and max_point.
    3.  G80 and G81 aliases are no longer hardcoded. Instructions for how to add aliases via gcode_macros are provided later in this document.
    4.  After probing the tool no longer returns to (0,0), as this is not suitable for every printer. This can be added in a gcode_macro or in your slicer's start gcode.

### Pre-requisites

Before proceeding, make sure [bed_tilt] is not in your printer.cfg. It will present a conflict with Mesh Leveling. You also need [probe] in your printer.cfg:

    [probe]
    pin: PB4
    x_offset: 24.
    y_offset: 5.
    z_offset: .0
    speed: 10.0

The z_offset is the distance between the nozzle and the print surface when the probe triggers.  When a probe is used as an endstop for the z axis, the value for z_offset will be used as the endstop position.  Thus, if you have position_endstop in [stepper_z] defined, remove it.  The x_offset and y_offset options refer to the distance between the nozzle and the probe on their respective axis.

It is also a good idea to make sure position_min under [stepper_z] is a negative number. Its likely that you will need to move below Z0 if your bed is significantly warped.

Finally, I recommend adding a homing override to to home to the center of the bed:

    [homing_override]
    gcode:
     G1 Z3
     G28 X0 Y0
     G1 X101 Y100 F5000
     G28 Z0
    set_position_z: 0

This will lift Z 3mm prior to homing, making sure that it doesn't crash into the bed if its location is close to the build plate. It will then home X and Y, move X and Y so that the probe is at the center of the build plate, then home Z.

### Configuration

Mesh Leveling is fully parametric. As a result it is possible to configure it for any printer, and a varying number of probe points. Probe points are generated dynamically. To get started with Mesh Leveling, the bare minimum is required in printer.cfg:

    [bed_mesh]
    speed: 100
    min_point: 11,1
    max_point: 215,193

Below is what a Mesh Bed Leveling configuration would look like with all options set:

    [bed_mesh]
    speed: 100
    horizontal_move_z: 5
    samples: 1
    sample_retract_dist: 2.0
    min_point: 11,1
    max_point: 215,193
    probe_count: 3,3
    fade_start: 1.0
    fade_end: 10.0
    move_check_distance: 5.0
    split_delta_z: .025
    mesh_pps: 2,2
    algorithm: lagrange
    bicubic_tension: .2

Be aware that when dynamically generating points the distance between each point is calculated. If the distance is not a whole number, the value will be floored to the last hundredth. This will result in your maximum points being adjusted inward slightly. Also keep in mind that the min and max points refer to the position of the nozzle, not the probe. Make sure you do not choose points that will move the probe off of the bed.

Below is a detailed explanation of each option:

-   speed:

The speed at which the bed is probed.

-   horizontal_move_z:

The distance to raise the toolhead between probes. Default is 5mm.

-   samples:

The number of samples to take for each probe point.

-   sample_retract_dist:

The distance to retract the tool between samples.  Only applies when samples > 1.

-   min_point:

The minimum start point (x,y) on the grid to generate. This parameter must be provided.

-   max_point:

The maximum start point (x,y) on the grid to generate. Note that this may not be the 'last' point if probing an even number of Y values on the grid. This parameter must be provided.

-   probe_count:

A comma separated pair of integers (x,y) indicating the number of points to probe on each axis. It is possible to enter a single integer value for this parameter, in which case it will be applied to both axes. Default is 3,3.

-   fade_start:

The z position in which to start fading out z_adjustment. Default is 1.0

-   fade_end:

The z position in which fading will complete. If fade_end is less than or equal to fade_start then fading will be disabled. Be careful with this setting, fading too quickly will likely result in a failed print, or could potentially crash the nozzle into the bed if done near Z0. Default is 10.0

-   move_check_distance:

The minimum distance a move can be split. Default is 5.0

-   split_delta_z:

The minimum amount of z-difference that will trigger a split move. The check algorithm will traverse a move by the amount specified in move_check_distance until it finds a z-delta greater than or equal to split_delta_z. Default is 0.025

-   mesh_pps:

A comma separated pair of integers (x,y) indicating the number of points to interpolate for each segment in the axis. Consider a 3x3 probed grid. There are two “segments” between the X points, and two between the Y points. If you specify mesh_pps: 3,3 then there will be 6 interpolated points and 3 probe points in the mesh along each axis, for a total of 81 points in the mesh. If this is set to zero, then no interpolation will be done on the axis. Note that this value can also be a single integer, in which case the number is applied to both axes. Default is 2,2.

-   algorithm:

The interpolation algorithm to use. May be either “lagrange” or “bicubic”. 3x3, 4x3, and 3x4 meshes must use lagrange, 4x4 or above may choose either. Default is lagrange.

-   bicubic_tension:

The bicubic interpolation algorithm uses cardinal hermite spline interpolation. A “tension” parameter may be entered to influence the amount of slope interpolated in the curve. That is, a higher tension will will make the mesh more curvy, and zero tension will be closer to bilinear interpolation. Be careful with this setting as generating steep hills and valleys in the mesh may cause the the nozzle to crash. This setting will be ignored if not using bicubic interpolation. Default is 0.2.

### Bed Mesh Gcodes

    BED_MESH_CALIBRATE

Initiates the calibration procedure (ie probes the bed and builds the mesh).

    BED_MESH_OUTPUT

Prints the results of the Mesh to the terminal.

    BED_MESH_MAP

This will probe the bed, serialize the points, and send them to the terminal. No mesh will be generated during this procedure, so no correction will be applied. It will however clear any prior mesh data. The purpose of this gcode is to allow for Octoprint plugins such as PrusaMeshMap to easily fetch probe data from a large number of sampled points. This has not yet been implemented in any plugins, but the functionality is there for those who wish to take advantage of it.

    BED_MESH_CLEAR

This will clear the mesh from memory. No further Z adjustment will be performed after a clear.

    BED_MESH_PROFILE LOAD=<name> SAVE=<name> REMOVE=<name>

BED_MESH_PROFILE can be used to save mesh state to persistent storage.  This isn't advised for MK3 users as bed geometry may not be consistent between prints, However users with rigid beds and glass surfaces may find this functionality useful.

### Generating Aliases

To generate gcode aliases, the following can be added to your printer.cfg:

    [gcode_macro G80]
    gcode:
     G28
     BED_MESH_CALIBRATE
     G1 X0 Y0 Z0.4 F4000

    [gcode_macro G81]
    gcode:
     BED_MESH_OUTPUT

This will create G80 and G81 aliases respectively. Also, as you can see, the G80 Macro moves the tool back to the origin after calibration. You can alter this GCode line to move it where you please at a speed that best suits your printer.

### Final Notes

-   Generally probing a 3x3 grid with default mesh values will produce the desired result. However, one may wish to experiment with more probe points and different interpolation algorithms to eliminate deadspots. Lagrange interpolation tends to oscillate as the number of samples increase, so it is recommended to use bicubic interpolation for larger probe grids.

Bed Skew Correction:
--------------------
TODO (COMING SOON)

Pressure Advance
----------------

The next thing you'll have to do is to configure _Pressure Advance_ (from this point downwards _PA_). Without _PA_ you will be getting ugly prints with blobs and curling at corners and lots of oozing. There is a [guide](https://github.com/KevinOConnor/klipper/blob/master/docs/Pressure_Advance.md) on how to configure _PA_ in the main Klipper repository, but it is complex and requires lots of manual steps. Read it through to understand what it is about, but don't actually follow it. We provide a setup process which is mode advanced and simpler at the same time, where you only have to print one test object from which you can derive the _PA_ value. The guide is [here](Pressure_Advance.md).



[Alpha] Probe Temperature Compensation
----------------------------------------

Initial support has been added for probe temperature drift compensation. In its current form temperature compensation is configured manually, in a similar fashion to the method used in stock Prusa firmware.

To enabled Probe temperature support, add the following to your printer.cfg:

    [probe_temp]
    sensor_type: EPCOS 100K B57560G104F
    sensor_pin: PF3
    t_offsets:
     35.0, 0.0
     40.0, 0.02
     45.0, 0.06
     50.0, 0.120
     55.0, 0.2
     60.0, 0.3

Note that the offsets above are Prusa Firmware's defaults. Also note the space padding the front of each offset. This is <b>required</b>, otherwise Klipper's parser will get confused.

The following gcodes are added with this module:

    GET_PROBE_TEMP

This simply returns the probe's current temperature to octoprints terminal

    PROBE_WAIT TEMP=<Target Temperature> TIMEOUT=<SECONDS>

Use the gcode above to wait for the probe to reach a certain temperature. The minimum target is 20, maximum is 70. The direction is automatically determined by the heater state.  If both heaters are off then the gcode will wait for the probe to cool to the supplied temperture, otherwise it will wait for it to heat.  Timeout sets a timeout in minutes. If the timeout is reached the printer will stop waiting and no changes will be made to the offset. A timeout value of 0 will wait indefinitely, which is the default value. 

    APPLY_TEMP_OFFSET

The gcode above will look up the probe's current temperatue, calculate the offset to apply based on the supplied parameters, then adjust the gcode offset by that amount.



### Manual Calibration Procedure

1.  Before Calibrating, make sure to remove t_offsets and all of its associated values from printer.cfg, then restart Klipper. This will make sure that no additional offset is applied during calibration.
2.  Use a gcode similar to what is used for manual probe calibration on Prusa Firmware. A single layered object with a large surface area works well.
3.  Your start gcode should look something like the following:
        M83  ; extruder relative mode
        M104 S210 ; Set nozzle temp
        M140 S60 ; set bed temp
        M190 S60 ; wait for bed temp
        M109 S210 ; wait for extruder temp
        G28 ; home axes
        G1 X50 Y50 Z.4 ; move printhead to a good warming position
        PROBE_WAIT TEMP=40 DIRECTION=heat ; wait for the probe to reach 40C
        G80 ; mesh leveling
        G1 X0 Y-3.0 F3000.0 ; go outside print area
        G92 E0.0
        G1 X60.0 E9.0  F1000.0 ; intro line
        G1 X100.0 E12.5  F1000.0 ; intro line
        G92 E0.0

    Adjust the above to your filament requirements. You may be able to move your nozzle closer to the bed when warming, but be careful as mesh leveling has not yet been applied to compensate for warped bed geometry. Also note that bed geometry changes as heat is applied.

4.  Use Klipper's SET_GCODE_OFFSET Z_ADJUST=[value] to act in a similar manner to live-z. Note that positive and negative offsets can be mapped to buttons (see Octoprint's Custom Control Editor plugin). A z_adjust value of +/-.02 is a good place to start, continue adjusting until you have your desired first layer
5.  Use GET_POSITION to get your total z_offset. Your output will look something like this:
        Send: GET_POSITION
        Recv: // mcu: x:-4778 y:-5497 z:-25
        Recv: // stepper: x:50.000000 y:50.000000 z:50.000000
        Recv: // kinematic: X:50.000000 Y:50.000000 Z:50.000000
        Recv: // toolhead: X:50.000000 Y:50.000000 Z:50.000000 E:0.000000
        Recv: // gcode: X:50.000000 Y:50.000000 Z:49.980000 E:0.000000
        Recv: // gcode base: X:0.000000 Y:0.000000 Z:-0.020000 E:0.000000
        Recv: // gcode homing: X:0.000000 Y:0.000000 Z:-0.020000

    The Z value next to gcode base is your total z adjustment. In this example, drift at 40C increased by .02, as an offset of -.02 was added to compensate. The value 40.0, 0.02 should be added to t_offsets in printer.cfg. NOTE: If you are already using SET_GCODE_OFFSET to adjust your nozzle height, don't forget to account for it.

### Auto Calibration Testing

Currently there is no automatic calibration because we simply do not have enough data, and the data we have is wildly consistent. For example, in our experiments, drift at X50 Y50 with only the bed on results in insignificant drift. With the extruder on, at the same position, drift increases significantly. The amount of drift increases with higher extruder and bed temperatures.

However, if the probe is repositioned directly over the center standoff on the bed, roughly X97 Y103, the probe actually triggers LOWER. This holds true at high extruder and bed temperatures. This phenomenon suggests that “drift” may not be related to the Probe, but rather to a change in bed geometry. If that is the case then drift can simply be overcome with a more accurate mesh when applying leveling.

That being said, more data will lead to a more solid conclusion, and if the probe itself is indeed experiencing drift, then perhaps we can come up with a way to automatically compensate for it. If you are interested in collecting this data, read on.

The current probe_temp implementation includes the following gcode:

    CALIBRATE_PROBE_TEMP X=97 Y=103 TARGET=45 B_TMP=70 E_TMP=200 TIMEOUT=180

Currently the gcode doesn't actually calibrate the sensor. It gathers temperature and drift data, serializes it, and dumps it to a file. As you can see there are several options, which are explained below. The values for each option above are defaults, any option may be left out if you desire a default value.

-   X - X position from which to gather probe data
-   Y - Y position from which to gather probe data
-   TARGET - The target temperature for the Pinda to reach. Once it has been obtained collection will end.
-   B_TMP - The bed temperature to set
-   E_TMP - The extruder temperature to set
-   TIMEOUT - The maximum time, in seconds, between each sample. If timeout is reached collection will end.

When calibration is complete (or times out) data will be dumped to ~/PindaTemps.json. It is useful to calibrate at the default position (center standoff) and one other position such as X50 Y50, up to a target temp of 55 to 60C. To reach these probe temperatures it is recommended to heat the extruder to a minimum 235C and the Bed to 90C.

If you are interested in collecting data, please visit the \#mk3-klipper channel on the Prusa3d-Users discord server.

Filament Sensors
----------------

The MK3 and MK3S both have a filament sensor, but they each use a different type of sensor. In order to use them with Klipper you'll need to update your printer.cfg with the appropriate section below, then add/update the common sections to your printer.cfg. Look in the example-extra.cfg for more details. You must use Klipper's RESUME command and not OctoPrint's once a runout has been detected and filment has loaded. 

### MK3 Filament Sensor (pat9125)

    [pat9125 fsensor]
    pause_on_runout: True
    runout_gcode:
        M118 Filament Runout Detected
        M600 X250 Y-3 Z10
    insert_gcode:
        M118 Filament Load Detected
        LOAD_FILAMENT
    invert_axis: True
    oq_enable: True

### MK3S Filament Sensor

    [filament_switch_sensor fsensor]
    pause_on_runout: True
    runout_gcode:
        M118 Filament Runout Detected
        M600 X250 Y-3 Z10
    insert_gcode:
        M118 Filament Load Detected
        LOAD_FILAMENT
    event_delay: 3.0
    switch_pin: !PK0

### Common configuration for both

You will need to add the following sections to you printer.cfg so that the M600 and LOAD_FILAMENT commands in the above work as intended. You can adjust the gcodes to suite your need, as long as the M600 starts with Klipper's PAUSE command.

    [respond]
    default_type: command

    [pause_resume]

    # Filament change gcode, parameters are a default park position if no XYZ is specified  - Z is relative.
    [gcode_macro M600]
    default_parameter_X: 100
    default_parameter_Y: 0
    default_parameter_Z: 10
    gcode:
        PAUSE
        G91
        G1 E-.8 F2700
        G1 Z{Z}
        G90
        G1 X{X} Y{Y} F3000
        M117 Ready for unload

    [gcode_macro LOAD_FILAMENT]
    gcode:
        M117 Loading Filament...
        G1 E70 F400
        G1 E40 F100
        G92 E0.0
        M400
        M117 Load Complete

    [gcode_macro UNLOAD_FILAMENT]
    gcode:
        M117 Unloading Filament...
        G1 E0.5 F1000
        G1 E-0.5 F1000
        G1 E1.0 F1000
        G1 E-1.0 F1000
        G1 E1.5 F1000
        G1 E-1.5 F1000
        G1 E2.0 F1000
        G1 E-100 F3000
        M400
        M117 Remove Filament Now!
        M300 S300 P1000

These two are not strictly needed, but they are useful to add - They add a __Change Filament__ and __Resume__ to the Filament menu on the display.
````
[menu __filament __change]
type: command
name: Change Filament
gcode:
    M600

[menu __filament __resume]
type: command
name: Resume
gcode:
    RESUME
````

### Notes

You can check the status of the filament sensor with the following command
    QUERY_FILAMENT_SENSOR SENSOR=fsensor
If you are using the 'filament_switch_sensor' and the status is inverted, then you just remove the ! on the 'switch_pin' so that it reads
    switch_pin: PK0
If you are using an older version of OctoPrint (<0.16) then you will also need to edit OctoPrint's config.yaml and add `unknownCommandsNeedAck: true` to the serial section. It should look something like this.
````
serial:
    additionalPorts:
    - /tmp/printer
    baudrate: 250000
    unknownCommandsNeedAck: true
    disconnectOnErrors: false
    logPositionOnCancel: true
    port: /tmp/printer
````
You need to SSH into your Pi or use SFTP. The file should be in ~/.octoprint directory.
