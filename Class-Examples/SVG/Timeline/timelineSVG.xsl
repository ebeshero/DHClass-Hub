<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"  
    exclude-result-prefixes="xs"
    version="3.0">
<!--2018-11-25 ebb: This XSLT is designed to generate a timeline in SVG from the dates marked in a collection of XML files from a project on World War I Letters. NOTE: These were not coded in TEI. (To adapt for a TEI project, add the xpath-default-namespace to the xsl:stylesheet root element above.) -->
    <xsl:variable name="lettersColl" as="document-node()+" select="collection('letters/?select=*.xml')"/>
    <!--ebb: This variable points to the directory of files we want to process, using the XPath collection() function to point only to the files with .xml extensions. This XSLT file is saved together with that directory, so the files inside the directory are a level just below the XSLT. -->
    
    
    <xsl:template match="/">
        <xsl:for-each select="$lettersColl//abstract">
            <xsl:sort select="date/@when"/>
     <!--ebb: First we'll just survey what we've got. Filenames, data in the <abstract> element? Let's take a look, and output the info in comments.  
     From surveying the markup, it looks like we don't always have letter dates marked, but we usually have birth and death dates for the writers. We could try plotting that information on a time chart.
     We'll start by defining a lot of variables and testing them in xsl:comments as our "scratchpad".
     -->
            <xsl:comment><xsl:value-of select="position()"/>. Filename: <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>Writer: <xsl:apply-templates select="persName"/> Born: <xsl:value-of select="persName/@born"/>
         
         Died: <xsl:value-of select="persName/@death"/>
         
        Letter date: <xsl:value-of select="date/@when"/>
         </xsl:comment>
        </xsl:for-each>
        <!--ebb: What's the earliest date and what's the latest date? First, let's define a variable that catches all the dates we want to plot. Then let's isolate the years to determine the earliest and the latest. -->
        <xsl:variable name="allDates"  select="$lettersColl//persName/@born | $lettersColl//$lettersColl//persName/@death | $lettersColl//date/@when"/>
        
        <xsl:comment>      List all dates: <xsl:value-of select="string-join($allDates, ', ')"/>
            </xsl:comment>  
        <!-- Earliest date:--> <xsl:variable name="earliest" select="min(for $i in $allDates return tokenize($i, '-')[1]) ! xs:integer(.) "/> 
     <!--Latest date:--> <xsl:variable name="latest" select="max(for $i in $allDates return tokenize($i, '-')[1]) ! xs:integer(.)"/>
     <xsl:comment>Earliest date: <xsl:value-of select="$earliest"/>. Latest date: <xsl:value-of select="$latest"/>. Difference between the two:
     <xsl:value-of select="$latest - $earliest"/></xsl:comment>   
  
<!--For our SVG, think of plotting the years as whole numbers, and specific dates in a year as fractions that you add to the year. So a full year is maybe 100 units, and July 1 of that year is 50 units added to that year. 
     We need to use the special XPath function format-date() to retrieve the nth day of a year (so that for February 15, it will output 46, as it is the 46th day of a 365-day year, and for 23 March, it will output the number 83, for the 83rd day of the year). We then need to convert the number to an integer and add that to the year value on our plot. 
     Be careful to write this unusual function correctly with its distinctive picture string argument inside single quotes and square brackets, like this:
format-date($yourDateVariable, '[d]') 
    See https://www.w3.org/TR/xpath-functions-30/#rules-for-datetime-formatting for the full list of picture strings for the format-date function.
        -->
  
  <!--Let's run this as a vertical timeline, plotting from top down the earliest to the latest year. For once, this runs with the grain of SVG, since larger numbers plot lower on the y axis. -->
        <xsl:variable name="spacer" select="100"/>
        <svg xmlns="http://www.w3.org/2000/svg" width="1000" height="{$latest * $spacer - $earliest * $spacer + 500}" viewBox="0 0 1200 2000">
          
            <g transform="translate(200, -5500)">
                <line stroke="red" stroke-width="6" x1="0" x2="0" y1="0" y2="{$latest * $spacer - $earliest * $spacer}"/>
                
                <!--Okay, let's plot the years along the line. -->
                <xsl:for-each select="0 to $latest - $earliest">
                    <circle cx="0" cy="{current() ! xs:integer(.) * $spacer}"  r="6" fill="black"/>
                    <text x="-50" y="{current() ! xs:integer(.) * $spacer}" text-anchor="middle" style="font-family: Arial;
                        font-size  : 20;
                        stroke     : black;
                        fill       : red;
                        "><xsl:value-of select="$earliest + position() -1"/></text>
                </xsl:for-each>
                
                <g><!--Here, let's plot some specific events on our timeline. Remember, we have to stay referenced within our big timeline measurements.-->
                    <xsl:for-each select="$lettersColl//abstract/persName">
                        <xsl:variable name="who" select="."/> 
                        <!--Calculate birth dates and positions -->
                        <xsl:variable name="birth" select="@born"/>
                        <xsl:variable name="yearBirth" select="tokenize($birth, '-')[1] ! xs:integer(.)"/>
                        <xsl:variable name="yearBirth_SVG" select="$yearBirth - $earliest"/>
                        <xsl:variable name="birthDay">
                            <xsl:choose>
                                <xsl:when test="contains(@born, '-')">
                                    <xsl:value-of select="(format-date($birth, '[d]') ! xs:integer(.)) div 365"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="0"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="birthDay_SVG" select="($yearBirth_SVG + $birthDay) * $spacer "/>
                        <xsl:comment> The value of $birthDay is <xsl:value-of select="$birthDay"/>. The value of $birthDay_SVG is <xsl:value-of select="$birthDay_SVG"/></xsl:comment>
                        
        <!--SVG for birthdays: -->                 
                        <circle cx="{150 + position()*50}" cy="{$birthDay_SVG}" r="6" fill="purple"/> 
                        <line x1="0" x2="{150 + position()*50}" y1="{$birthDay_SVG}" y2="{$birthDay_SVG}" stroke="black" stroke-width="1.5"/> 
                        <text x="{375 + position()*50}" y="{$birthDay_SVG}" text-anchor="middle" style="font-family: Arial;
                            font-size  : 20;
                            stroke     : black;
                            fill       : red;
                            "><xsl:value-of select="$who"/> is born (<xsl:value-of select="$birth"/>).</text>  
                        
                    
            <!--Calculate death dates and positions -->
                        <xsl:variable name="death" select="@death"/>
                        <xsl:variable name="deathDay">
                            <xsl:choose>
                                <xsl:when test="contains(@death, '-')">
                                    <xsl:value-of select="(format-date($death, '[d]') ! xs:integer(.)) div 365"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="0"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>         
                        <xsl:variable name="yearDeath" select="tokenize($death, '-')[1] ! xs:integer(.)"/>
                        <xsl:variable name="yearDeath_SVG" select="$yearDeath - $earliest"/>
                        <xsl:variable name="deathDay_SVG" select="($yearDeath_SVG + $deathDay) * $spacer  "/>                <!--Next, we can plot (in this same for-each over the persName data) the SVG for death dates. We can draw a circle and connecting line to the main timeline, and draw a line connecting to the birthday. TO BE CONTINUED -->   
                        
                    </xsl:for-each>
                    
                    
                </g>  
            </g>
            
       
                
            
      </svg>
            
    </xsl:template>
    
    
</xsl:stylesheet>