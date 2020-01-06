<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    
  <xsl:output method="xml" indent="yes"/> 
<!--2019-11-20 ebb: Here is a STARTER file to help orient you to writing XSLT read from XML and output SVG. You may want to use and modify this for your first XSLT-to-SVG exercise. NOTE: This XSLT is unfinished, and represents a first stage of organizing information and setting up X and Y axis lines for a graph.   
    -->
    
<!--2019-11-19 ebb: This is an XSLT designed to plot an SVG graph of the number of choices associated with each game setting in the Waterfall map of the Undertale game. I started by studying the waterfall.xml file with XPath to see a count of choice elements within each setting element. I used this XPath to scope the document:
    //setting/count(descendant::choice)  
    
I  noticed that a few settings didn't have choice elements inside, so I decided to filter those out of the plot: 

//setting[count(choice) gt 0]/count(descendant::choice)

I noticed that the count was never higher than 8, and the number of settings giving choices to the game player was 10. this helped me to estimate how big my plot would be: 10 settings spaced along one axis, and values no higher than 10 on the Y axis.

Values this low would make a very tiny SVG, so we'll expand them with a multiplier in each direction. Let's plot the setting names running down the Y axis and give them plenty of space apart: We'll separate the Y values by a nice roomy 50 pixels. And we'll plot the number of choices in thick lines running across the X axis: let's stretch those out by a factor of 20.
I'm storing these in spacer/stretcher values in global variables below:
    -->  
    
    <xsl:variable name="Y-Spacer" as="xs:integer" select="50"/>  
 <xsl:variable name="X-Stretcher" as="xs:integer" select="20"/>
 
 
    <xsl:template match="/">
        <!--ebb: Here's where we plot the structure of the SVG plot. Let's put an X and Y axis here.--> 
        <svg>
            <g transform="translate(200, 600)">
               <!--The @transform="translate()" attribute-value pair lets me shift the X axis over to the right from the edge of the screen by 200 pixels (giving me room to add in some labels, and it shifts the Y axis down the screen by 600. Depending on the size of your plot, you will want to experiment with these numbers.-->
                
                <line x1="0" y1="0" x2="0" y2="{-10 * $Y-Spacer}" stroke-width="3" stroke="blue"/>
      <!--Y axis: My @y2 attribute value is an ATV, which is right now (with the value of $Y-Spacer set to 50) basically the value of -10 * 50 (that will equal -500). Notice how I'm plotting UP the screen from zero to -100. 0,0 is shifted down 150 pixels, so I can plot back *up* the screen with a negative value.  -->   
      
      <line x1="0" y1="0" x2="{12 * $X-Stretcher}" y2="0" stroke-width="3" stroke="maroon"/>
    <!--X axis. For this plot which is going across the screen with the number of choices a game player is given in each setting, I grabbed the number 12 as a bit higher than my maximum value, which I think was 8, so my X axis would be long enough. And I multiply that to stretch across the screen using my $X-Stretcher variable. -->
       
                
 <!--Let's plot a title for the graph up ABOVE everything. My highest Y-value on the Y axis is -10 * $Y-Spacer, so let's push this up ONE more to -11 * $Y-Spacer. -->
                
                <text x="150" y="{-11 * $Y-Spacer}" text-anchor="middle" stroke="black" font-size="20">Number of choices at each setting in Undertale’s Waterfall map</text>
                
  
<!--ebb: Now, we can either use xsl:apply-templates and select those descendant::setting elements with a count(choice) greater than zero, OR we can use an xsl:for-each here. This will look inside each setting and plot a text label just to the left of the X axis, and plot a thick line (which we think is easier than a rectangle to set up in SVG) for each one and make us a little bar graph running horizontally down the screen. TEST this at every stage of tinkering to make sure you're getting output. And OPEN that output file in oXygen to check and make sure it gets the green square for being well-formed, valid SVG.  -->
                
                <xsl:for-each select="descendant::setting[count(choice) gt 0]">
                    
                    <g>
                        <text x="-20" y="{-position() * $Y-Spacer + $Y-Spacer div 1.8}" fill="indigo" text-anchor="end"><xsl:value-of select="@name"/></text>
                        <!--This gives me labels running down the X axis. I futzed with spacing these a little by adding something just shy of a half-measure of the $Y-Spacer. And I set the @text-anchor to end, so they all line up neatly along the axis  -->    
                        
                        <line x1="0" x2="{count(descendant::choice) * $X-Stretcher}" y1="{-position() * $Y-Spacer + $Y-Spacer div 2 }" y2="{-position() * $Y-Spacer + $Y-Spacer div 2}" stroke="green" stroke-width="10"/>
                        
                        
                    </g>
                </xsl:for-each>
                
            </g>
        </svg>
    </xsl:template>
    
</xsl:stylesheet>