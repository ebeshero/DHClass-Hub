<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    
  <xsl:output method="xml" indent="yes"/> 
    
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
        <svg viewBox="0 0 800 800">
            <!--I added this @viewBox last to tinker with the scale of the plot. Read more about the viewBox attribute here in Sara Soueidan's tutorial: https://www.sarasoueidan.com/blog/svg-coordinate-systems/ -->
            <g transform="translate(200, 600)">
                <!--The @transform="translate()" attribute-value pair lets me shift the X axis over to the right from the edge of the screen by 200 pixels (giving me room to add in some labels, and it shifts the Y axis down the screen by 600. Depending on the size of your plot, you will want to experiment with these numbers.-->
                
                <line x1="0" y1="0" x2="0" y2="{-10 * $Y-Spacer}" stroke-width="3" stroke="blue"/>
                <!--Y axis: My @y2 attribute value is an ATV, which is right now (with the value of $Y-Spacer set to 50) basically the value of -10 * 50 (that will equal -500). Notice how I'm plotting UP the screen from zero to -100. 0,0 is shifted down 150 pixels, so I can plot back *up* the screen with a negative value.  -->    
      
      <line x1="-1.5" y1="0" x2="{12 * $X-Stretcher}" y2="0" stroke-width="3" stroke="maroon"/>
      <!--I decided to pull the X axis line back by half the value of the stroke-width just so the corners align. (Try plotting this with x1="0" and see how the stroke-width screws up the corners?) -->
        
<!--Here's a label for the X axis:  -->        
    <text x="120" y="40" fill="indigo" text-anchor="middle">Number of choices at this location</text>
                
      <xsl:for-each select="descendant::setting[count(choice) gt 0]">
          <xsl:sort select="descendant::choice => count()"/>
          <g>
              <text x="-20" y="{-position() * $Y-Spacer + $Y-Spacer div 1.8}" fill="indigo" text-anchor="end"><xsl:value-of select="@name"/></text>
          <!--This gives me labels running down the X axis. I futzed with spacing these a little by adding something just shy of a half-measure of the $Y-Spacer. And I set the @text-anchor to end, so they all line up neatly along the axis  -->    

              <line x1="0" x2="{count(descendant::choice) * $X-Stretcher}" y1="{-position() * $Y-Spacer + $Y-Spacer div 2 }" y2="{-position() * $Y-Spacer + $Y-Spacer div 2}" stroke="green" stroke-width="10"/>
              
          <!--I've added a little text at the end of each line to include the total count value. We'll place it 10 pixels to the right of the end of the line: -->
              <text x="{count(descendant::choice) * $X-Stretcher + 10}" y="{-position() * $Y-Spacer + $Y-Spacer div 1.8}" fill="indigo" text-anchor="middle"><xsl:value-of select="count(descendant::choice)"/></text>  
              
              
          </g>
      </xsl:for-each>
                
                
<!--Now we're OUTSIDE the xsl:for-each. Let's decorate our graph to add some labels. Here are some little labeled vertical hashmarks for the X axis: -->
                    
                
                <line x1="{10 * $X-Stretcher div 2}" y1="0" x2="{10 * $X-Stretcher div 2}" y2="{-10 * $Y-Spacer}" stroke-width="1" stroke="maroon" stroke-dasharray="3 2" />   
                <text x="{10 * $X-Stretcher div 2}" y="{-10.2 * $Y-Spacer}" text-anchor="middle" stroke="maroon"><xsl:value-of select="10 div 2"/></text>
                
 <!--Finally, let's plot a title for the graph up ABOVE everything: -->
                
                <text x="150" y="{-11 * $Y-Spacer}" text-anchor="middle" stroke="black" font-size="20">Number of choices at each setting in Undertale’s Waterfall map</text>
                
            </g>
        </svg>
    </xsl:template>
    
</xsl:stylesheet>