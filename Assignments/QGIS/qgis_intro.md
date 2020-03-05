# Making a Basic Map with QGIS 
Maps, at their most basic, are symbolic, visual representations of elements arranged in a space. From the ancient maps, originating in Mesopotamia, of the night sky to modern maps of Subway system, maps have been guiding people and graphically depicting spatial relationships for centuries. Geographic information systems, or GIS, are computer systems intended to capture, store, check, and display geographic data, or data related to positions on Earth’s surface ([National Geographic](https://www.nationalgeographic.org/encyclopedia/geographic-information-system-gis/)).  Some popular GIS systems include ArcGIS, QGIS, Google Earth Pro, and MapInfo. This tutorial focuses on QGIS. 

From the [QGIS website](https://qgis.org/en/site/about/index.html), “QGIS is a professional GIS application that is built on top of and proud to be itself Free and Open Source Software (FOSS)… It runs on Linux, Unix, Mac OS X, Windows, and Android and supports numerous vector, raster, and database formats and functionalities.” It is an official project of the Open Source Geospatial Foundation, or OSGeo, whose “mission is to foster global adoption of open geospatial technology by being an inclusive software foundation devoted to an open philosophy and participatory community driven development ([OSGeo](https://www.osgeo.org/about/)). As part of this movement and as stated above, QGIS is open-source software, which means that its source code is publicly available to be modified and contributed to; this means that it by principle is free to use. 

To download QGIS, go to [Download QGIS](https://qgis.org/en/site/forusers/download.html) and select the installer appropriate for your operating system, such as Windows, Mac OS X, or Linux Ubuntu. Please take care to download version 3.4.15 - Madeira or a newer version. This tutorial was created with 3.4.15 in mind, and so later versions might look slightly different, though the functionality will still be the same. Earlier versions, such as 2.18, will look very different, and if you install a version earlier than 3.0 you might have serious difficulty following along with the tutorial. Let me know if downloading an earlier version of QGIS (earlier than 3.0) is necessary for you. 

In QGIS, we work in Projects. To create a new project, first open QGIS. One option would be to click the icon of a piece of white paper in the upper left-hand corner of the page. It is circled in red in the image below. 

![](qgis_intro/Screen%20Shot%202020-03-03%20at%207.52.55%20PM.png)

Alternatively, you could hit the “Project” button in the ribbon at the top of the page and then select “New Project” from the resulting dropdown menu.  It is circled in red in the image below. 

![](qgis_intro/Screen%20Shot%202020-03-03%20at%207.56.22%20PM.png)

Another option, evident with the image of the menu above, is to use the shortcut Command-N (for Mac OS X users) or Control-N (for Windows or Linux users). 

Once you have created a new project, your QGIS screen should be blank, like the following image. 

![](qgis_intro/Screen%20Shot%202020-03-03%20at%207.59.40%20PM.png)

QGIS, like all GIS, “analyzes spatial location and organizations layers of information into visualizations using maps and 3D scenes. With this unique capability, [it] reveals deeper insights into data, such as patterns, relationships, and situations” ([ESRI](https://www.esri.com/en-us/what-is-gis/overview)). It utilizes layers to allow users to dive deep into a location and glean more information from it than traditional maps may have allowed. Layers are added to a project to create a map. 

Next, you’ll add your first layer to the QGIS project, the base layer: the OpenStreetMaps XYZ Tiles. An XYZ Tile Layer is “a set of web-accessible tiles that reside on a server. The tiles are accessed by a direct URL request from the web browser” ([Tile layers—Portal for ArcGIS   (10.3 and 10.3.1) | ArcGIS Enterprise](https://enterprise.arcgis.com/en/portal/10.3/use/tile-layers.htm)). As such, you’ll need an Internet connection to first add this layer to your project; however, it’s essentially a base map of the world that OpenStreetMaps, another open-source project, provides for free from their server. 

To add the OpenStreetMap XYZ Tile Layer to your project, go to the Browser menu on the left-hand side of the page and select “XYZ Tiles.” The option “OpenStreetMap” should appear below “XYZ Tiles,” as pictured below. 

![](qgis_intro/Screen%20Shot%202020-03-03%20at%208.34.21%20PM.png)

Double click on “OpenStreetMap” to add the layer to your project. Your QGIS page should now look like the image below, with a map of the world where the blank white space used to be. 

![](qgis_intro/Screen%20Shot%202020-03-03%20at%208.43.31%20PM.png)


You should notice that now “OpenStreetMap” is present in the “Layers” menu, which is beneath the “Browser” menu.  One other thing to notice is that there is a checkmark next to the layer name, which means that that layer should be visible on the map. To deactivate that layer, click on the checkbox to remove the checkmark; you should then see the map of the world disappear from view. 

Next, we will import a TSV (tab-separated values) file and use it to generate another layer, which we will place on top of our base map. 

Please download the following text file, which is a TSV file with the latitude and longitude coordinates of all significant earthquakes since 2150 BC from NOAA’s National Geophysical Data Center. Save this to your computer as a .txt file, a .csv file, or a .tsv file. This data in this file is separated by tabs, which makes it technically a tab-separated value (TSV) file. Any file that contains data separated by a specific character is a delimited text file, so as long as you save it as one of those, you will be fine. 

<a href='qgis_intro/signif.txt'>signif.txt</a>

If you open this file and examine it, you’ll notice that there is a column for latitude coordinates and a column for longitude coordinates. Those are the two most essential columns in this document for creating a layer in QGIS: the X and Y coordinates of the locations you want to map. 

Quite simply, the X coordinates will be the longitude coordinates and the Y coordinates will be the latitude coordinates. Why? 

Remember the Cartesian coordinate plane. 

![](qgis_intro/TKyga.png)
Picture source: [calculus - Standard Cartesian Plane - Mathematics Stack Exchange](https://math.stackexchange.com/questions/1093289/standard-cartesian-plane)

The y-axis goes up and down; it is vertical. Conversely, the x-axis goes from left to right; it is horizontal. 

Now, remember latitude and longitude lines. 

![](qgis_intro/longitude-and-latitude-simple.png)
Picture source: [What Is Longitude and Latitude?](https://www.timeanddate.com/geography/longitude-latitude.html)

Like the x-axis, lines of latitude go from left to right across the globe; they are horizontal. Similarly, the lines of longitude, like the y-axis, are vertical. As such, the X coordinates of the table are the latitude coordinates, and the Y coordinates of the table are longitude coordinates. 

To import a document into QGIS, its data must be in some way connected to location. Perhaps the easiest connection to make is for each row in the table to have X and Y coordinates. Otherwise, you’ll have to join tables, which is something that we will get into later. 

To import the data file, go to “Layer” in the top ribbon, hover over “Add Layer,” and then select “Add Delimited Text Layer.” If you remember from before, the file that we want to add is a delimited text file, and so the layer that we want to add is a delimited text layer. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%201.20.47%20PM.png)

There are other types of layers, such as Vector layers or Raster layers, but we will worry about those later. 

You will then be faced with a screen that looks like this one. 
1. Click on the three dots next to “File Name” to navigate to the file, signif.txt, that you downloaded earlier. 
2. As a default, the layer will be named signif. However, that name is fairly meaningless out of context. Rename the layer in the text box next to “Layer Name” to something meaningful. 
3. Unless you saved the document as a CSV file, then you will have to select “Custom Delimeters” and make sure that the box next to “Tab” is selected. 
4. As you might recall, the first row of the document includes the column names. As such, you’ll want to make sure that the box next to “First record has field names” is checked. If you look at the bottom of the page at the Sample Data, you should then see the column names grayed out or differentiated by color from the actual data.  
5. Next, you’ll want to select the columns named LONGITUDE and LATITUDE in the drop-down menus next to “X Field” and “Y Field.” As mentioned earlier, LONGITUDE should be in the X Field, and LATITUDE should be in the Y Field. (If you have Detect Field Types selected, then it’s possible that these fields will already be correctly selected.) 
6. Finally, you’ll want to select the appropriate Coordinate Reference System (CRS). I will err on the side of simplicity and not go into what a CRS is or how it works, but you should just trust me that you should choose the Default CRS: WGS 84. 
7. Click Add. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.01.32%20PM.png)


Pins, marking the locations of significant earthquakes around the world, should appear on your base map. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.03.16%20PM.png)

Your list of Layers should now look like the following image. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.14.16%20PM.png)

You should notice that the new layer, “earthquakes”, is higher on the list than “OpenStreetMap.” This means that the “earthquakes” layer is layered _on top of_ the “OpenStreetMap” layer. If you were to click and drag the “earthquakes” layer, then it would disappear on the map, because the base map “OpenStreetMap” would then be layered on top of it; it would cover it and render it invisible. 

Congratulations! You’ve added your first layer to your first project. 

Now, we’ll work on creating a map from the project. 

Use the Pan and Zoom controls in the QGIS menu bar, pictured below, to zoom in on California. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.28.15%20PM.png)

The resulting zoom should look something like the following image. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.25.54%20PM.png)


Next, click on “Project” in the top ribbon, and then click on “New Print Layout.” 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.31.28%20PM.png)

You’ll then be asked to give the new Print Layout a name. 
(Yes, I misspelled California in the screenshot, but I don’t want to take another one.) 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%202.34.43%20PM.png)

Give a name, and then click “OK.” 

You should be then presented with a blank screen. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%204.48.53%20PM.png)

Click on “Zoom Full” (the magnifying glass with three arrows pointing outward) to get the full extent of the map layout. 

Next, go to “Add Item” in the top ribbon and select “Add Map” from the dropdown menu. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%204.51.23%20PM.png)

Once you click “Add Map,” the “Add Map” mode will be activated. Click and drag a square on the white canvas to add a map to that square. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%204.54.01%20PM.png)

You should end up with an image like the one above. 

Next, click the “Item Properties” tab on the right-hand side of the page and make sure that the boxes next to “Lock layers” and “Lock styles for layers” are checked. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%204.57.01%20PM.png)

Then, navigate to the main QGIS window. Use the Pan and Zoom tools to zoom in on the San Francisco Bay Area. We will use this area as an inset on our larger map. 

Next, right click on the “earthquakes” layer in the “Layers” menu. In the pop up menu, click on “Styles” and use the resulting color wheel to choose a new color for the points on the map marking where the earthquakes occurred. Try to make it one that is brighter or more noticeable than the original color of the symbols. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%205.05.20%20PM.png)

Switch back to the “Print Layout” menu, and again select “Add Item” and then “Add Map.” 

This time, use the cursor to drag a smaller square on top of the preexisting map of California, perhaps in a corner or off to the side where it won’t cover any data points. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%205.09.33%20PM.png)

Now, we want to make the inset look better with a frame and highlight the area from which the inset was taken. 

In the “Items” menu on the right-hand side of the page, select “Map 2,” which is the inset map. Click on the “Item Properties” tab, and then make sure that the button next to “Frame is checked.” A menu should then appear, and you should change the thickness to 1.0 and hit “Enter” on your keyboard.  A border should appear around the inset. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%205.12.08%20PM.png)

Now, select “Map 1”, the larger map, from the “Item” list. Select the “Item Properties” tab, and then scroll down to the “Overviews” section. Click on the green plus sign to add an overview; once you have done that, select “Map 2” as the Map frame. This indicates that Map 1, the larger map, should be highlighted with the selection from Map 2, the inset map. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%205.57.23%20PM.png)

Next, we’ll add a label to the top of the map. Go to “Add Item” at the top ribbon, and then hover over “Add Shape,” and then click on “Add Rectangle.” Then use your cursor to drag out a rectangle on top of the map, preferably away from the inset and the majority of the data points. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%209.05.35%20PM.png)

To color the rectangle, make sure that it is selected in the “Item” list, then go to “Style”; to change the color to match the map underneath it, then go to “Symbol Selector,” then “Select Color,” and then choose the tab to sample a color. You can then use a dropper to select a color from the background map for the background of your label. 

Next, to actually add a label to the map, go to “Add Item” and then “Add Label.” You can then change the font and label as you should so choose, using the Appearance menu on the right-hand side of the page. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%209.32.47%20PM.png)
 
Finally, for the last touch that we’ll be putting on this map, go to “Add Item,” and then go to “Add Scale Bar.” 

A menu such as the one pictured in the image below should appear. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%209.37.04%20PM.png)

These options give you the ability to control the size of the scale bar. Click “OK,” and you will have a scale bar on your map. 

![](qgis_intro/Screen%20Shot%202020-03-04%20at%209.38.11%20PM.png)

Once you save your layout, you can then export it to an image file, an SVG, or even a PDF. 

Congratulations! You’ve made a map with QGIS. 

For more on QGIS, feel free to consult [this website](http://www.qgistutorials.com/en/index.html), which will teach you how to do pretty much anything with this software. 












