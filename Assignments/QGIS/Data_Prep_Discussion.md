# Data Prep Discussion 
For Friday, I’d like for us all to take a look at these scenarios and see if 
1)  you can identify problems with the given data sets and 
2) come up with solutions for how to fix the data sets or prepare them. The process for fixing the data may involve multiple steps! 

You don’t actually have to fix the data, just talk about what you might do to fix it. 

## Scenario One 
You have been spending the past few weeks writing up Pokemon XML files, which document the different Pokemon and where they are located. You want to map these Pokemon in Japan, to try and see if industrialized locations correlate with certain Pokemon types. As such, you included coordinates for latitude and longitude in the XML files, uploaded the collection of XML files to Exide (db_2020_ClassExamples_pokemonQGIS/bad_data_set), and wrote the following XQuery script to create a TSV that you can later import into QGIS. 

<a href='Data_Prep_Discussion/qgis_1_pokemon.xql'>qgis_1_pokemon.xql</a>

You get the following resulting TSV. 

<a href='Data_Prep_Discussion/pokemon_bad_data.tsv'>pokemon_bad_data.tsv</a>

What is wrong with this data? What can you do to fix it? 

## Scenario Two 
You want to examine reported incidents of piracy throughout the years, to see if areas of the sea associated with high rates of piracy remain so over time.  To try to answer this questions, you navigate to the National Geospatial Intelligence Agency’s [Maritime Safety Information](https://msi.nga.mil/Piracy) page on piracy and download the Anti-Shipping Activity Messages geodatabase file that they have published there. This contains reports of incidents of anti-shipping activity, which includes reports of piracy. 

You can find the geodatabase file, asam_data_download.gdb, on DHClass-Hub in Assignments_QGIS_bad_data. Save the folder to your machine. Then, open up QGIS, use the file browser in QGIS to navigate to where you saved the folder, open it, and click and drag the layer “ASAM_events” to the project to add it as a layer. You can then add a base map to help contextualize the information. 

What is wrong with this data? What can you do to fix it? 

Hint: right click on the layer in the layer menu and click “Open Attribute Table.” This is a copy of the data contained in the layer. Click on the header “dateofocc” to sort by the date of the incident. Look at the description columns in conjunction with the “subreg” column. 

## Scenario Three 
You’ve spent the past few weeks of the semester writing up XML files to encode Malcolm Sutton’s [Index of Deaths from the Troubles in Ireland](https://cain.ulster.ac.uk/sutton/chron/index.html), and have used an API to connect the place names listed in those records to geocoordinates. Now, you want to posit that data against different kinds of socio-economic demographic information to see if you can make connections between the people who died and the population contexts they existed in when they died. You decide that a neat place to start might be to examine the year 1971 - the third year of the Troubles and also conveniently the year that the census was taken in Northern Ireland - and see if there is a connection between conflict-related death rates and areas in which high portions of the population are employed and own a vehicle or vehicles. 

Therefore, you go to the [Northern Ireland Statistic and Research Agency’s census report for 1971](https://www.nisra.gov.uk/publications/1971-census-reports) and download the Workplace and Transport to Work table. 

<a href='Data_Prep_Discussion/1971-census-workplace-transport-tables.PDF'>1971-census-workplace-transport-tables.PDF</a>

You have geocoordinates, shape files, for the government districts listed on the census, pre-1998 counties, each with a unique identifier. You want to use the information listed in Table 5 (page 40) of this report to shade those shape files. 

What is wrong with this data? What could you do to fix it? 







