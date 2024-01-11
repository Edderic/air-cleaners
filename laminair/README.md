# LaminAir

Highly effective personal air cleaning. Uses Laminar flow to create concentrated clean air in front of the user. Meant to be used relatively close to the face.

## License
- [See License](https://github.com/Edderic/air-cleaners/blob/main/LICENSE.md)

## Theoretical and Experimental Results on Efficacy

- [Twitter announcement](https://x.com/eddericu/status/1738041192049266939)
- [Threader App](https://threadreaderapp.com/thread/1738041192049266939.html)
- [Research](https://github.com/Edderic/iaq/blob/main/notebooks/milestone-eoy-2023.ipynb)

## DIY

If you are interested in printing out the pieces, please take a look at [Printables](https://www.printables.com/model/716902-laminair/), which shows the 3D-printable parts in STL format.

The rest of the pieces are listed
[here](https://docs.google.com/spreadsheets/d/1wJ6nfeIdMQBHosVignK3vL9RzcDbh2oNCUtzVA7f1og/edit#gid=1259436206), which shows the name of the parts, the amount needed per part, and where you can buy them via Amazon.


### Putting things together

Once you've printed all the parts, you can start assemble the parts together. Watch the [Assembly walkthrough on YouTube](https://youtu.be/tnxe13Jcs5g).

### Modifying the pieces

[OpenSCAD](https://openscad.org/) is a tool for programmers to programmatically create 3D-printable designs. See [OpenSCAD tutorials](https://openscad.org/documentation.html) to learn how to use the tool. OpenSCAD lets someone edit `.scad` files. The 3D printable models then get exported from there as STL files, which essentially contain information about shapes and curves. Finally, these STL files are then transformed into G-Code, which contains all the steps for a 3D printer to print the objects. I use [PrusaSlicer](https://www.prusa3d.com/page/prusaslicer_424/) to convert STL files to G-Code. Once that is done, the G-Code is then exported to an SD card, which is then finally inserted to a 3D printer. A fine choice is Prusa's MK3S+.


## Buying devices

If you'd rather buy a pre-assembled device, you can purchase [here](https://breathesafe-llc.myshopify.com/products/laminair).

If you don't have access to a 3D printer but still would like to save some money on labor, you'll be able to purchase them through [Breathesafe LLC](https://breathesafe-llc.myshopify.com/) at some point.


