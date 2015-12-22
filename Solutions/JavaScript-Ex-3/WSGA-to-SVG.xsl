<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    <!--Initially prepared for SVG Homework Exercise by Alex Mielnicki. Thanks, Alex! -->
    <!-- RJP: comment left on courseweb by Alex: I hope you like it, I worked especially hard on this one :) -->
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <!--***Start Global Variables***-->
    <xsl:variable name="inter" select="50"/>
    <xsl:variable name="barHeight" select="40"/>
    <xsl:variable name="bottom" select="675"/>
    <xsl:variable name="bottomAxis" select="$bottom + 25"/>
    <xsl:variable name="left" select="70"/>
    <xsl:variable name="barStart" select="$left + 17"/>
    <xsl:variable name="barWidth" select="700"/>
    
    <!--***End Global Variables***-->

    <xsl:template match="/">
        <?xml-stylesheet type="text/css" href="https://fonts.googleapis.com/css?family=Open+Sans:400,800" ?>  
        <svg width="100%" height="100%">
            <g>
                <!--***Start Overall Chart Definition***-->
                <!--Chart Title-->
                <text x="{$left}" y="25" style="fill:black; font-size: 24px; text-align:center; font-weight:800; font-family: 'Open Sans', sans-serif;">Survey Results on Sanitary Conditions of Workshops and Factories</text>
                
                <!--Axis Lines-->
                <line x1="{$left + 13}" y1="50" x2="{$barStart + $barWidth}" y2="50" stroke="black" stroke-width="4" />
                <line x1="{$left + 15}" y1="50" x2="{$left + 15}" y2="{$bottom}" stroke="black" stroke-width="4" />
                <line x1="{$left + 13}" y1="{$bottom}" x2="{$barStart + $barWidth}" y2="{$bottom}" stroke="black" stroke-width="4" />
               
                <!--Interval Percentage Lines Text-->
                <text x="{$barStart}" y="{$bottomAxis}" text-anchor="middle">0%</text>
                <text x="{$barStart + ($barWidth * .25)}" y="{$bottomAxis}" text-anchor="middle">25%</text>
                <text x="{$barStart + ($barWidth * .50)}" y="{$bottomAxis}" text-anchor="middle">50%</text>
                <text x="{$barStart + ($barWidth * .75)}" y="{$bottomAxis}" text-anchor="middle">75%</text>
                <text x="{$barStart + $barWidth}" y="{$bottomAxis}" text-anchor="middle">100%</text>
                <!--***End Overall Chart Definition***-->
                
                <!--***Start Bar Definition***-->
                <xsl:for-each select="//fs[f/@select='Yes']">
                    <xsl:sort select="f[@select='Blank']/@n div sum(f/@n)" order="ascending"/>
                    <g id="svg-{@xml:id}" class="bars">
                        <!--2015-11-20 ebb: I'm adding a <g> element here to bundle the bars and text for each question all together 
                            and identify it with a distinct id. Note: If I want to integrate this with an HTML table that
                        has <tr> elements with @id attributes on them, HTML won't permit me to reuse the same @id. I need
                        to introduce a change here (or on the output for the table).-->
                    <!--***Start Local Variables Definition***-->
                    <xsl:variable name="sumBar" select="sum(f/@n)"/>
                    <xsl:variable name="yPos" select="position()*$inter + 20"/>
                    <xsl:variable name="pBarYes" select="(f[@select='Yes']/@n div $sumBar)"/>
                    <xsl:variable name="perBarYesFined" select="(f[@select='Yes_but_fined']/@n div $sumBar)"/>
                    <xsl:variable name="pBarNo" select="(f[@select='No']/@n div $sumBar)"/>
                    <xsl:variable name="pBarBlank" select="(f[@select='Blank']/@n div $sumBar)"/>
                    <xsl:variable name="vBarYes" select="(f[@select='Yes']/@n div $sumBar) * $barWidth"/>
                    <xsl:variable name="vBarYesFined" select="(f[@select='Yes_but_fined']/@n div $sumBar) * $barWidth"/>
                    <xsl:variable name="vBarNo" select="(f[@select='No']/@n div $sumBar) * $barWidth"/>
                    <xsl:variable name="vBarBlank" select="(f[@select='Blank']/@n div $sumBar) * $barWidth"/>
                    <!--***End Local Variables Definition***-->
                    
                    <xsl:choose>
                        <!--***Start Special Bar Definition***-->
                        <xsl:when test="f[@select='Yes_but_fined']">
                            <!--Blank Bar-->
                            <rect x="{$barStart}" y="{$yPos}" width="{$vBarBlank}" height="{$barHeight}" fill="#33C2CC" />
                            <text x="{$barStart + ($vBarBlank div 2)}" y="{$yPos + 25}" text-anchor="middle" style="fill:black; font-size: 12px; font-family: 'Open Sans', sans-serif;"><xsl:value-of select="format-number($pBarBlank,'#.#%')"/></text>
                            <!--No Bar-->
                            <rect x="{$barStart + $vBarBlank}" y="{$yPos}" width="{$vBarNo}" height="{$barHeight}" fill="#FF99A3" />
                            <text x="{($barStart + $vBarBlank) + ($vBarNo div 2)}" y="{$yPos + 25}" text-anchor="middle" style="fill:black; font-size: 12px; font-family: 'Open Sans', sans-serif;"><xsl:value-of select="format-number($pBarNo,'#.#%')"/></text>
                            <!--Yes Fined Bar-->
                            <rect x="{$barStart + $vBarBlank + $vBarNo}" y="{$yPos}" width="{$vBarYesFined}" height="{$barHeight}" fill="#FFFB81" />
                            <!--Yes Bar-->
                            <rect x="{$barStart + $vBarBlank + $vBarNo + $vBarYesFined}" y="{$yPos}" width="{$vBarYes}" height="{$barHeight}" fill="#59FFAD" />
                            <text x="{($barStart + $vBarBlank + $vBarNo + $vBarYesFined) + ($vBarYes div 2)}" y="{$yPos + 25}" text-anchor="middle" style="fill:black; font-size: 12px; font-family: 'Open Sans', sans-serif;"><xsl:value-of select="format-number($pBarYes,'#.#%')"/></text>
                        
                        </xsl:when>
                        <!--***End Special Bar Definition***-->
                        
                        <!--***Start All Other Bars Definition***-->
                        <xsl:otherwise>
                            <!--Blank Bar-->
                            <rect x="{$barStart}" y="{$yPos}" width="{$vBarBlank}" height="{$barHeight}" fill="#33C2CC" />
                            <text x="{$barStart + ($vBarBlank div 2)}" y="{$yPos + 25}" text-anchor="middle" style="fill:black; font-size: 12px; font-family: 'Open Sans', sans-serif;"><xsl:value-of select="format-number($pBarBlank,'#.#%')"/></text>
                            <!--No Bar-->
                            <rect x="{$barStart + $vBarBlank}" y="{$yPos}" width="{$vBarNo}" height="{$barHeight}" fill="#FF99A3" />
                            <text x="{($barStart + $vBarBlank) + ($vBarNo div 2)}" y="{$yPos + 25}" text-anchor="middle" style="fill:black; font-size: 12px; font-family: 'Open Sans', sans-serif;"><xsl:value-of select="format-number($pBarNo,'#.#%')"/></text>
                            <!--Yes Bar-->
                            <rect x="{$barStart + $vBarBlank + $vBarNo}" y="{$yPos}" width="{$vBarYes}" height="{$barHeight}" fill="#59FFAD" />
                            <text x="{($barStart + $vBarBlank + $vBarNo) + ($vBarYes div 2)}" y="{$yPos + 25}" text-anchor="middle" style="fill:black; font-size: 12px; font-family: 'Open Sans', sans-serif;"><xsl:value-of select="format-number($pBarYes,'#.#%')"/></text>
                        </xsl:otherwise>
                        <!--***End All Other Bars Definition***--> 
                    </xsl:choose>
                    <!--***End Bar Definition***-->
                    
                    <!--***Start Chart Text Definition***-->
                    <!--Right Question Text-->
                    <text x="{$barStart + $barWidth + 30}" y="{$yPos + 25}" text-anchor="start" style="font-family: 'Open Sans', sans-serif;"> 
                        <xsl:value-of select="f[@name='question']/string"/>
                    </text>
                    <!--Left Bar Numbering Text-->
                    <text x="{$left}" y="{$yPos + 25}" text-anchor="end" style="font-family: 'Open Sans', sans-serif;"> 
                        <xsl:value-of select="@xml:id"/>
                        <!--2015-11-20 ebb: This is the only thing I've altered, from position(), which returns the sort order, to xml:id which I've now set as 
                        distinct for each question in the input TEI XML.-->
                    </text>
                    <!--Bar/Question Separating Line-->
                    <line x1="{$barStart}" y1="{$yPos + 45}" x2="{$barStart + $barWidth + 500}" y2="{$yPos + 45}" stroke="#EEEEEE" stroke-width="1" />
                    <!--***End Chart Text Definition***-->
                    </g>
                </xsl:for-each>
                
                <!--***Start Interval Percentage Lines***-->
                <line x1="{$barStart + ($barWidth * .25)}" y1="50" x2="{$barStart + ($barWidth * .25)}" y2="{$bottom}" stroke="gray" stroke-width="1" stroke-dasharray="5, 5" />
                <line x1="{$barStart + ($barWidth * .50)}" y1="50" x2="{$barStart + ($barWidth * .50)}" y2="{$bottom}" stroke="gray" stroke-width="1" stroke-dasharray="5, 5" />
                <line x1="{$barStart + ($barWidth * .75)}" y1="50" x2="{$barStart + ($barWidth * .75)}" y2="{$bottom}" stroke="gray" stroke-width="1" stroke-dasharray="5, 5" />
                <line x1="{$barStart + $barWidth}" y1="50" x2="{$barStart + $barWidth}" y2="{$bottom}" stroke="gray" stroke-width="1" stroke-dasharray="5, 5" />
                <!--***End Interval Percentage Lines***-->
                
                <!--***Start Legend Definition***-->
                <!--Legend Box Creation and Text-->
                <rect x="{$barStart - 10}" y="{$bottom + 40}" width="{$left - 10 + $barWidth}" height="60" fill="#DDDDDD" />
                <text x="{$barStart + 40}" y="{$bottom + 80}" style="font-size: 20px; font-family: 'Open Sans', sans-serif;">Legend:</text>
                <!--Legend Color Creation and Key Text-->
                <rect x="{$barStart + ($barWidth * .25)}" y="{$bottom + 50}" width="40" height="40" fill="#33C2CC" />
                <text x="{$barStart + 50 + ($barWidth * .25)}" y="{$bottom + 75}" style="font-family: 'Open Sans', sans-serif;"> = Blank</text>
                <rect x="{$barStart + ($barWidth * .45)}" y="{$bottom + 50}" width="40" height="40" fill="#FF99A3" />
                <text x="{$barStart + 50 + ($barWidth * .45)}" y="{$bottom + 75}" style="font-family: 'Open Sans', sans-serif;"> = No</text>
                <rect x="{$barStart + ($barWidth * .60)}" y="{$bottom + 50}" width="40" height="40" fill="#FFFB81" />
                <text x="{$barStart + 50 + ($barWidth * .60)}" y="{$bottom + 75}" style="font-family: 'Open Sans', sans-serif;"> = Yes, but fined</text>
                <rect x="{$barStart + ($barWidth * .85)}" y="{$bottom + 50}" width="40" height="40" fill="#59FFAD" />
                <text x="{$barStart + 50 + ($barWidth * .85)}" y="{$bottom + 75}" style="font-family: 'Open Sans', sans-serif;"> = Yes</text>
                <!--***End Legend Definition***-->
                <rect x="50" y="{50}" width="1000" height="700" fill="none" stroke="2"/>
                
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>