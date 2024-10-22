# LaminAir V2

Effective personal air cleaning via laminar flow, meant to be used close to the face. In a matter of seconds, can give 5-to-13 exposure reduction factors (i.e. 80-93% reduction of aerosols) when breathing near the middle, 15-inches-or-less away from the face. Another effective tool to add to your arsenal of multilayer protections.

<div style='display: grid; grid-template-columns: 50% 50%; grid-template-rows: auto;'>
    <img width='500' src="https://breathesafe-llc.myshopify.com/cdn/shop/files/F7F347BD-2015-495D-94B2-4AA1C5B36874_1_105_c.jpg?v=1728439005" alt="front">
    <img width='500' src="https://breathesafe-llc.myshopify.com/cdn/shop/files/B3418CC7-9A49-4E87-8E3C-5162F355BAFB_1_105_c.jpg?v=1728444456" alt="back">
    <img width='500' src="https://breathesafe-llc.myshopify.com/cdn/shop/files/D1AA6A1A-E37F-4572-B699-C1E7BAB34F1D_1_105_c.jpg?v=1728439046" alt="laminair on stand">
    <img width='500' src="https://breathesafe-llc.myshopify.com/cdn/shop/files/FFFDCA4A-86AA-42AB-A5FA-6049E354336B_1_105_c.jpg?v=1728439095" alt="laminair on stand at the dentist">
    <img width='500' src="https://breathesafe-llc.myshopify.com/cdn/shop/files/4263F86A-0201-4A02-9D70-98288BE1BE8D_1_105_c.jpg?v=1728439056" alt="laminair at the dentist">
</div>

## Experimental Results on Efficacy
80-92% reduction (5-13 exposure reduction factors) in particles between 0.02 and 1 micron when used close to the face.

Look at a birds-eye view of exposure reduction factors:
![exposure reduction factors grid](https://breathesafe-llc.myshopify.com/cdn/shop/files/GZVDrBeW0AANzxP.png?v=1728439786)

| label | notes |
| - | - |
|X| corresponds to left and right movement of the head when facing the LaminAir V2. |
|Y| corresponds to moving closer or farther away from the LaminAir.|
|Z| is the height from the ground, kept constant in the middle. |

The graph above was produced by using a PortaCount 8020A. Ambient air was being sampled right in the intake of the device at the back and then compared to the cleaner air in the front:

<img src="https://breathesafe.s3.us-east-2.amazonaws.com/images/laminair/images/IMG_0264.jpeg" width='500' alt="PortaCount validation">

Edderic moved the PortaCount sampling probe inch by inch to get the grid. Each position is a minute's worth of samples. So in total, Edderic spent more than two hours testing the device.

## License
- [See License](https://github.com/Edderic/air-cleaners/blob/main/LICENSE.md)


## DIY

If you have access to a 3D printer, and you are interested in printing out the pieces yourself to save on labor, please take a look at [the instructions](./diy/diy.md), which shows the 3D-printable parts in STL format.

If you already have the 3D printed parts and would like to assemble the pieces together, you can also take a look at [the instructions](./diy/diy.md).

The rest of the pieces are listed
[here](https://docs.google.com/spreadsheets/d/1wJ6nfeIdMQBHosVignK3vL9RzcDbh2oNCUtzVA7f1og/edit#gid=1259436206), which shows the name of the parts, the amount needed per part, and where you can buy them via Amazon.

## Buying devices

If you'd rather buy a pre-assembled device, you can purchase [here](https://breathesafe-llc.myshopify.com/products/laminair).

### Modifying the pieces

[OpenSCAD](https://openscad.org/) is a tool for programmers to programmatically create 3D-printable designs. See [OpenSCAD tutorials](https://openscad.org/documentation.html) to learn how to use the tool. OpenSCAD lets someone edit `.scad` files. The 3D printable models then get exported from there as STL files, which essentially contain information about shapes and curves. Finally, these STL files are then transformed into G-Code, which contains all the steps for a 3D printer to print the objects. I use [PrusaSlicer](https://www.prusa3d.com/page/prusaslicer_424/) to convert STL files to G-Code. Once that is done, the G-Code is then exported to an SD card, which is then finally inserted to a 3D printer. A fine choice is Prusa's MK3S+.


