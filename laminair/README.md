# LaminAir V2

## Experimental Results on Efficacy
80-92% reduction in particles between 0.02 and 1 micron when used close to the face.

Look at a birds-eye view of exposure reduction factors:
![exposure reduction factors grid](https://breathesafe-llc.myshopify.com/cdn/shop/files/GZVDrBeW0AANzxP.png?v=1728439786)

X corresponds to left and right movement of the head when facing the LaminAir V2.
Y corresponds to moving closer or farther away from the LaminAir.
Z is the height from the ground, kept constant in the middle.

## License
- [See License](https://github.com/Edderic/air-cleaners/blob/main/LICENSE.md)


## DIY

If you have access to a 3D printer, and you are interested in printing out the pieces yourself to save on labor, please take a look at [the instructions](./diy/diy.md), which shows the 3D-printable parts in STL format.

If you already have the 3D printed parts and would like to assemble the pieces together, you can also take a look at [the instructions](./diy/diy.md).

The rest of the pieces are listed
[here](https://docs.google.com/spreadsheets/d/1wJ6nfeIdMQBHosVignK3vL9RzcDbh2oNCUtzVA7f1og/edit#gid=1259436206), which shows the name of the parts, the amount needed per part, and where you can buy them via Amazon.

Installation instructions are [here](./diy.md).


### Printing Instructions

#### Have a Prusa MK3S+?

If you do, you can create G-Code files using the 3mf files included here.

#### Don't have a Prusa MK3S+?

You can import the STL files to your slicer of choice (e.g. [PrusaSlicer](https://www.prusa3d.com/page/prusaslicer_424/)). See details below.

| Name | Printing Orientation | Supports | Infill | Number of vertical walls |
| - | - | - |-  | - |
| top_left.stl | Fan-grill side is on the heatbed. | Add custom supports to the hanging sections. | 60% | 3 |
| top_right.stl | Fan-grill side is on the heatbed. | Add custom supports to the hanging sections. | 60% | 3 |
| bottom_left.stl | Fan-grill side is on the heatbed. | Add custom supports to the hanging sections. | 60% | 3 |
| bottom_right.stl | Fan-grill side is on the heatbed. | Add custom supports to the hanging sections. | 60% | 3 |
| shoulder_strap_half_ring.stl | The flat parts of the screwable section should be on the heatbed. | Support on build plate only | 100% | 2 |
| louver.stl | Flat side should be on heatbed. For Prusa MK3S+ printer, will need to rotate so that the longest side is on a diagonal to fit on the heatbed. | Support on build plate only | 100% | 2 |
| foot.stl | Widest flat side should be on the heatbed. Need 4 of these. | None needed | 20% | 2 |
| battery_fan_enclosure.stl | Widest flat side should be on the heatbed. Need 4 of these. | Custom supports for the hanging sections (screwables) | 20% | 2 |
| filter_louvers_container_p1.stl | Widest flat side should be on the heatbed. | None needed | 20% | 2 |
| filter_louvers_container_p2.stl | Widest flat side should be on the heatbed. | None needed | 20% | 2 |
| filter_louvers_container_p3.stl | Widest flat side should be on the heatbed. | None needed | 20% | 2 |
| filter_louvers_container_p4.stl | Widest flat side should be on the heatbed. | None needed | 20% | 2 |

### Purchasing other parts
[Here is a google spreadsheet that describes parts, cost, and links to Amazon.](https://docs.google.com/spreadsheets/d/1wJ6nfeIdMQBHosVignK3vL9RzcDbh2oNCUtzVA7f1og/edit#gid=1259436206)

### Putting things together

Once you've printed all the parts, you can start assemble the parts together.

[![Watch the video](https://breathesafe-airgo.s3.us-east-2.amazonaws.com/images/laminair/laminair-assembly-thumbnail.png)](https://www.youtube.com/watch?v=tnxe13Jcs5g)

### Modifying the pieces

[OpenSCAD](https://openscad.org/) is a tool for programmers to programmatically create 3D-printable designs. See [OpenSCAD tutorials](https://openscad.org/documentation.html) to learn how to use the tool. OpenSCAD lets someone edit `.scad` files. The 3D printable models then get exported from there as STL files, which essentially contain information about shapes and curves. Finally, these STL files are then transformed into G-Code, which contains all the steps for a 3D printer to print the objects. I use [PrusaSlicer](https://www.prusa3d.com/page/prusaslicer_424/) to convert STL files to G-Code. Once that is done, the G-Code is then exported to an SD card, which is then finally inserted to a 3D printer. A fine choice is Prusa's MK3S+.


## Buying devices

If you'd rather buy a pre-assembled device, you can purchase [here](https://breathesafe-llc.myshopify.com/products/laminair).

If you don't have access to a 3D printer but still would like to save some money on labor, you'll be able to purchase them through [Breathesafe LLC](https://breathesafe-llc.myshopify.com/) at some point.


