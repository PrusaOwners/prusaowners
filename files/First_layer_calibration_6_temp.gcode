G28 W ; home all without mesh bed level

;
; Square 35C
;

M201 X1000 Y1000 Z200 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 S1250 T1250 ; sets acceleration (S) and retract acceleration (T)
M205 X10 Y10 Z0.4 E2.5 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M83  ; extruder relative mode

G0 Z100 ; Cooling PINDA position
M106 S255 ; Turn fan on
M860 S30; Let PINDA cool down to 30C
M107 ; Turn fan off

M104 S195 ; set extruder temp
M140 S60 ; set bed temp
M190 S60 ; wait for bed temp
M109 S195 ; wait for extruder temp
G0 X50 Y50 Z0.15 ; this is a good PINDA heating position
M860 S35 ; wait until PINDA is >= 35C
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling

G1 Y10.0 F1000.0 ;
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000

; now print the square
G1 X89.826 Y110.826
G1 Z0.200
G1 E0.80000 F2100.00000
M204 S1000
G1 F1800
G1 X90.000 Y110.790 E0.00620
G1 X112.000 Y110.790 E0.76831
G1 X112.174 Y110.826 E0.00620
G1 X112.210 Y111.000 E0.00620
G1 X112.210 Y133.000 E0.76831
G1 X112.174 Y133.174 E0.00620
G1 X112.000 Y133.210 E0.00620
G1 X90.000 Y133.210 E0.76831
G1 X89.826 Y133.174 E0.00620
G1 X89.790 Y133.000 E0.00620
G1 X89.790 Y111.000 E0.76831
G1 X89.808 Y110.913 E0.00337
G1 X89.814 Y110.885 E0.00118
G1 X89.966 Y110.717 F10800.000
G1 F8640
G1 X90.000 Y110.790 E-0.04823
G1 X93.083 Y110.790 E-0.71177
G1 E-0.04000 F2100.00000
G1 Z0.800 F10800.000

G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
G1 X0 ;

;
; Square 40C
;

M201 X1000 Y1000 Z200 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 S1250 T1250 ; sets acceleration (S) and retract acceleration (T)
M205 X10 Y10 Z0.4 E2.5 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M83  ; extruder relative mode

G0 Z100 ; Cooling PINDA position
M106 S255 ; Turn fan on
M860 S35; Let PINDA cool down to 35C
M107 ; Turn fan off

M104 S195 ; set extruder temp
M140 S60 ; set bed temp
M190 S60 ; wait for bed temp
M109 S195 ; wait for extruder temp
G0 X50 Y50 Z0.15 ; this is a good PINDA heating position
M860 S40 ; wait until PINDA is >= 40C
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling

G1 Y15.0 F1000.0 ;
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000

; now print the square
G1 X113.826 Y110.826
G1 Z0.200
G1 E0.80000 F2100.00000
G1 F1800
G1 X114.000 Y110.790 E0.00620
G1 X136.000 Y110.790 E0.76831
G1 X136.174 Y110.826 E0.00620
G1 X136.210 Y111.000 E0.00620
G1 X136.210 Y133.000 E0.76831
G1 X136.174 Y133.174 E0.00620
G1 X136.000 Y133.210 E0.00620
G1 X114.000 Y133.210 E0.76831
G1 X113.826 Y133.174 E0.00620
G1 X113.790 Y133.000 E0.00620
G1 X113.790 Y111.000 E0.76831
G1 X113.808 Y110.913 E0.00337
G1 X113.814 Y110.885 E0.00118
G1 X113.894 Y110.662 F10800.000
G1 F8640
G1 X114.000 Y110.790 E-0.04823
G1 X117.083 Y110.790 E-0.71177
G1 E-0.04000 F2100.00000
G1 Z0.800 F10800.000

G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
G1 X0 ;

;
; Square 45C
;

M201 X1000 Y1000 Z200 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 S1250 T1250 ; sets acceleration (S) and retract acceleration (T)
M205 X10 Y10 Z0.4 E2.5 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M83  ; extruder relative mode

G0 Z100 ; Cooling PINDA position
M106 S255 ; Turn fan on
M860 S40; Let PINDA cool down to 40C
M107 ; Turn fan off

M104 S195 ; set extruder temp
M140 S60 ; set bed temp
M190 S60 ; wait for bed temp
M109 S195 ; wait for extruder temp
G0 X50 Y50 Z0.15 ; this is a good PINDA heating position
M860 S45 ; wait until PINDA is >= 45C
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling

G1 Y20.0 F1000.0 ;
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000

; now print the square
G1 X137.826 Y110.826
G1 Z0.200
G1 E0.80000 F2100.00000
G1 F1800
G1 X138.000 Y110.790 E0.00620
G1 X160.000 Y110.790 E0.76832
G1 X160.174 Y110.826 E0.00620
G1 X160.210 Y111.000 E0.00620
G1 X160.210 Y133.000 E0.76832
G1 X160.174 Y133.174 E0.00620
G1 X160.000 Y133.210 E0.00620
G1 X138.000 Y133.210 E0.76832
G1 X137.826 Y133.174 E0.00620
G1 X137.790 Y133.000 E0.00620
G1 X137.790 Y111.000 E0.76832
G1 X137.808 Y110.913 E0.00337
G1 X137.814 Y110.885 E0.00118
G1 X137.772 Y110.657 F10800.000
G1 F8640
G1 X138.000 Y110.790 E-0.04823
G1 X141.083 Y110.790 E-0.71177
G1 E-0.04000 F2100.00000
G1 Z0.800 F10800.000

G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
G1 X0 ;

;
; Square 50
;

M201 X1000 Y1000 Z200 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 S1250 T1250 ; sets acceleration (S) and retract acceleration (T)
M205 X10 Y10 Z0.4 E2.5 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M83  ; extruder relative mode

G0 Z100 ; Cooling PINDA position
M106 S255 ; Turn fan on
M860 S45; Let PINDA cool down to 45C
M107 ; Turn fan off

M104 S195 ; set extruder temp
M140 S80 ; set bed temp
M190 S80 ; wait for bed temp
M109 S195 ; wait for extruder temp
G0 X50 Y50 Z0.15 ; this is a good PINDA heating position
M860 S50 ; wait until PINDA is >= 50C
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling

G1 Y25.0 F1000.0 ;
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000

; now print the square
G1 X89.826 Y76.826
G1 Z0.200
G1 E0.80000 F2100.00000
G1 F1800
G1 X90.000 Y76.790 E0.00620
G1 X112.000 Y76.790 E0.76831
G1 X112.174 Y76.826 E0.00620
G1 X112.210 Y77.000 E0.00620
G1 X112.210 Y99.000 E0.76831
G1 X112.174 Y99.174 E0.00620
G1 X112.000 Y99.210 E0.00620
G1 X90.000 Y99.210 E0.76831
G1 X89.826 Y99.174 E0.00620
G1 X89.790 Y99.000 E0.00620
G1 X89.790 Y77.000 E0.76831
G1 X89.808 Y76.913 E0.00337
G1 X89.814 Y76.885 E0.00118
G1 X89.933 Y76.685 F10800.000
G1 F8640
G1 X90.000 Y76.790 E-0.04823
G1 X93.083 Y76.790 E-0.71177
G1 E-0.04000 F2100.00000
G1 Z0.800 F10800.000

G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
G1 X0 ;

;
; Square 55
;

M201 X1000 Y1000 Z200 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 S1250 T1250 ; sets acceleration (S) and retract acceleration (T)
M205 X10 Y10 Z0.4 E2.5 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M83  ; extruder relative mode

G0 Z100 ; Cooling PINDA position
M106 S255 ; Turn fan on
M860 S50; Let PINDA cool down to 50C
M107 ; Turn fan off

M104 S195 ; set extruder temp
M140 S90 ; set bed temp
M190 S90 ; wait for bed temp
M109 S195 ; wait for extruder temp
G0 X50 Y50 Z0.15 ; this is a good PINDA heating position
M860 S55 ; wait until PINDA is >= 55C
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling

G1 Y30.0 F1000.0 ;
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000

; now print the square
G1 X113.826 Y76.826
G1 Z0.200
G1 E0.80000 F2100.00000
G1 F1800
G1 X114.000 Y76.790 E0.00620
G1 X136.000 Y76.790 E0.76831
G1 X136.174 Y76.826 E0.00620
G1 X136.210 Y77.000 E0.00620
G1 X136.210 Y99.000 E0.76831
G1 X136.174 Y99.174 E0.00620
G1 X136.000 Y99.210 E0.00620
G1 X114.000 Y99.210 E0.76831
G1 X113.826 Y99.174 E0.00620
G1 X113.790 Y99.000 E0.00620
G1 X113.790 Y77.000 E0.76831
G1 X113.808 Y76.913 E0.00337
G1 X113.814 Y76.885 E0.00118
G1 X113.894 Y76.662 F10800.000
G1 F8640
G1 X114.000 Y76.790 E-0.04823
G1 X117.083 Y76.790 E-0.71177
G1 E-0.04000 F2100.00000
G1 Z0.800 F10800.000

G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
G1 X0 ;

;
; Square 60
;

M201 X1000 Y1000 Z200 E5000 ; sets maximum accelerations, mm/sec^2
M203 X200 Y200 Z12 E120 ; sets maximum feedrates, mm/sec
M204 S1250 T1250 ; sets acceleration (S) and retract acceleration (T)
M205 X10 Y10 Z0.4 E2.5 ; sets the jerk limits, mm/sec
M205 S0 T0 ; sets the minimum extruding and travel feed rate, mm/sec
M83  ; extruder relative mode

G0 Z100 ; Cooling PINDA position
M106 S255 ; Turn fan on
M860 S55; Let PINDA cool down to 55C
M107 ; Turn fan off

M104 S195 ; set extruder temp
M140 S100 ; set bed temp
M190 S100 ; wait for bed temp
M109 S195 ; wait for extruder temp
G0 X50 Y50 Z0.15 ; this is a good PINDA heating position
M860 S60 ; wait until PINDA is >= 60C
G28 W ; home all without mesh bed level
G80 ; mesh bed leveling

G1 Y35.0 F1000.0 ;
G92 E0.0
G1 X60.0 E9.0  F1000.0 ; intro line
G1 X100.0 E12.5  F1000.0 ; intro line
G92 E0.0
M221 S95
M900 K30; Filament gcode
G21 ; set units to millimeters
G90 ; use absolute coordinates
M83 ; use relative distances for extrusion

G1 E-0.80000 F2100.00000
G1 Z0.600 F10800.000

; now print the square
G1 X138.000 Y99.210
G1 Z0.200
G1 E0.80000 F2100.00000
G1 F1800
G1 X137.826 Y99.174 E0.00620
G1 X137.790 Y99.000 E0.00620
G1 X137.790 Y77.000 E0.76832
G1 X137.808 Y76.913 E0.00337
G1 X137.826 Y76.826 E0.00363
G1 X138.000 Y76.790 E0.00620
G1 X160.000 Y76.790 E0.76832
G1 X160.174 Y76.826 E0.00620
G1 X160.210 Y77.000 E0.00620
G1 X160.210 Y99.000 E0.76832
G1 X160.174 Y99.174 E0.00620
G1 X160.000 Y99.210 E0.00620
G1 X138.060 Y99.210 E0.76622
G1 X137.891 Y99.350 F10800.000
G1 F8640
G1 X137.826 Y99.174 E-0.05466
G1 X137.790 Y99.000 E-0.04102
G1 X137.790 Y96.123 E-0.66432
G1 E-0.04000 F2100.00000
G1 Z0.800 F10800.000

; Filament-specific end gcode
G4 ; wait
M221 S100
M104 S0 ; turn off temperature
M140 S0 ; turn off heatbed
M107 ; turn off fan
G1 X0 Y200; home X axis
M84 ; disable motors
