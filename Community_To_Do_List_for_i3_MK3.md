To Be Fixed
-----------

### Inconsistent Extrusion

Inconsistent Extrusion is still not fixed. Many details can be seen at [Github Issue \#602](https://github.com/prusa3d/Prusa-Firmware/issues/602).

To Be Improved
--------------

### Klipper

#### Done

-   Basic Configuration
-   Linear Correction
-   Compatibility with Brigandier's PrusaMeshMap plugin
-   Support for M117, LOAD_FILAMENT, and UNLOAD_FILAMENT gcodes

#### BETA

N/A

#### ALPHA

-   Mesh Bed Leveling - See [Klipper#configuring-mesh-bed-leveling](Klipper#configuring-mesh-bed-leveling "wikilink")
-   Pinda Drift Compensation - See [Klipper#alpha-probe-temperature-compensation](Klipper#alpha-probe-temperature-compensation "wikilink")

#### Todo (ordered by priority)

-   Mesh Leveling Alpha 2 (Parameterized Variables, support larger probe sample and bicubic interpolation, custom gcode to report json serialized probe points to the terminal for Brigandier's plugin)
-   Live-z support
-   Fan sensors
-   Filament sensors
-   Use z tops to tram x axis (ram into top)
-   Support for homing z axis at center of bed naively rather than through G0
-   Octoprint plugin supporting Klipper installation and upgrades
-   Support for display connected directly to the Pi

### Skelestruder

#### Done

@leefla -&gt; write up better instructions already! :-)

#### Todo (ordered by priority)

### Bed Leveling Modifications

Mesh bed leveling is nice, but ultimately it leaves parts with curved bottoms (or curved all the way through, if no Z fade is present) or skew. This can be mitigated by leveling the system properly.

#### Done

-   Octoprint Plugin has been made for quickly understanding bed level issues.
-   Wave springs under the bed standoffs allow for bed curvature correction.

#### Todo

-   Create Y axis rod mounts that allow leveling
-   Create Z stepper mounts that allow leveling
-   Create Z axis endcaps that allow leveling

Documentation
-------------

@jltx write up SCAD -&gt; STEP flow