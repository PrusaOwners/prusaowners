PLA bearings are just a great idea. (Needs Verification)

They are cheap, printable, lightweight, silent, accurate and they CAN work flawlessly.

This is what I use <https://www.thingiverse.com/thing:2202854> but there are other designs. I recommend reading through the attached texts on Thingiverse too.

Preparing the STL
-----------------

You need to download the [OpenSCAD](http://www.openscad.org) file from Thingiverse. Then fill up some parameters you want your bearings to have. There are some suggested values in the comments too. Don't fiddle with this too much for the first iteration, you need something to start with. Remember to fill up proper extrusion width that you use in your slicer. I also use 8 teeth on most of my bearings.

Slicing and printing
--------------------

You need to ensure there is no infill / gaps filing. This should be printed used only perimeters, see the attached images on Thingiverse. Set the number of perimeters in slicer according to value in the OpenSCAD file. I print mine with 0.4mm nozzle on 0.2 layer height. Also, ensure that the seam is set to aligned, so you can sand it off later easily or align the bearing so it does not cause problems. Always put at least two of them on the plate a bit far from each other, otherwise, they may have not enough cooling and your results will be different when you put more on the plate later. When you are iterating to find proper sizing, you can always stop the print midway and try them, so you save some time and filament. Then print those.

Post processing
---------------

You need to take the rods off your printer, degrease them (I use soap and water). Try pushing the bearing on the cleaned rods, top layer first (the bottom might get squished during print). They should be mildly hard to get there, but nothing like you need a hammer to do it. It also should not be too easy. If they are too small or large, change the inner diameter in OpenSCAD, slice, and print again. TODO: video of the right ID crude bearing

After you got the right tightness of the crude bearings, you should slide them up and down very quickly on the rods, until the rod gets pretty hot. Try to move things parallel and not to twist the bearing, as this may introduce clearance issues. If you do this right, you will feel that the bearing has less and less friction. When the friction does not improve anymore, it is time to stop. Do not remove the bearing from the rod. Let it cool down and try sliding it. There should be NO sticking to the rod, it should move freely, if you hold the bearing (do not hold it too tight), the rod should slide through it freely on its own weight. If you slowly slide the bearing on the rods using finger, there should be NO 'unsticking' happening. If it does, you need to process the bearing a little bit more. If there is clearance to the bearing, and it does wiggle on the rods significantly, you need less post processing or something fishy happened to the print. TODO: video of the desired behavior

Installing the bearings
-----------------------

These bearings are plastic. That means, you should not tighten them somewhere using screws, otherwise they WILL deform. Your best chances are using the classic linear bearing housing. Worst case use zip ties. This does make these almost useless on the mk3 (u-screws, X backplate...) unless you encase them in a metal casing.

You can use the crappy lm8uu bearings, pull the guts out of them, and find the right OD to make inserts like I did.

<img src="images/Pla_bearings.jpg" title="Pla_bearings.jpg" alt="Pla_bearings.jpg" width="300" />

Or you can find some steel pipe with the right outer diameter (15mm for LM8UUs), get it cut on the desired length and make proper fitting inserts for the pipe. This is the most ideal solution in my opinion.

They are still very sensitive to overtightening even in the lm8uu metal casing, so do not overtighten.

F.A.Q.
------

### How fast do they wear off?

When using proper lubrication, they can last for a very long time. I've had them installed on my previous printer for 400+ print hours, and they are like new, without any signs of wear.

### What is proper lubrication?

I use lithium grease and it works well. Do not use oil-based lubricant as this might end up in a gooey mess.

### Can you just provide me STL / gcode?

I can, but it is useless. You need to find proper sizing in 1/100s of a millimeter which would vary when using a different printer, or filament, or settings, or rods. You need to edit them in OpenSCAD on your own until you find the proper fit.

### Do they stick to rods and introduce backlash to axes?

When properly post-processed, they do not stick to the rods.

### Are they silent?

Yes. They are very silent. <https://drive.google.com/open?id=1dRCuqLUuqVaeE8ck3g-9f8ysJidY7OxA>

### Will they fail in a heated chamber?

Depends on the amount of heat. I printed ABS in heated cardboard chamber with these installed and I had no problems. The rods themselves probably provided enough cooling to those. Your mileage may vary though. It may be a good idea to use HTPLA if you plan on printing in a heated chamber.