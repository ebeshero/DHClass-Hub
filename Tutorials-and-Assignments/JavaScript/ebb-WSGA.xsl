<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    
   
    <xsl:variable name="barWidth" select="40"/>
    <xsl:variable name="Interval" select="$barWidth + 20"/>
    <!--ghb: Think of this Interval (for x-axis spacing between bars) 
        as measured from the midpoint of the line element (or rectangle or bar). -->
   <xsl:variable name="heightAdjust" select="5"/>
    
    <xsl:template match="/">
        <svg width="100%" height="200%">
            <g transform="translate(60, 600)">
                <xsl:variable name="xAxisLength" select="$Interval * count(//fs[f[@select='Yes']]) + 10"/>
                <text x="375" y="-550" font-size="24px" text-anchor="middle">Survey Results on Sanitary Conditions of Workshops and Factories</text>
                <line x1="20" x2="20" y1="0" y2="-500" stroke="black" stroke-width="1"/>
                <!--y axis-->
                <line x1="20" x2="{$xAxisLength}" y1="0" y2="0" stroke="black" stroke-width="1"/>
               <!--x axis-->  
                <text x="5" y="-250" text-anchor="middle">50%</text>
                <text x="5" y="-500" text-anchor="middle">100%</text>
               
                <xsl:apply-templates select="//fs[f[@select='Yes']]">
                    <xsl:sort order="descending" select="f[@select='Yes']/@n div sum(f/@n)"/>
                    <!--ebb: Notice, I've tucked an <xsl:sort> on the @n attribute (a numerical value), 
                    and I've set this to output in descending order, from the highest to the lowest @n for the 
                    "Yes" responses on each question. I've also decided to divide the number of "Yes" responses by the sum of 
                    all the responses for a question (much the way we take a percentage below), because the total numbers
                    of respones aren't the same for each question. So I'm really sorting based on the ratio of Yesses to totals. 
                    If I multiplied this value by 100, I'd get the percentage of "Yes" responses (as I do below).-->
                </xsl:apply-templates>    
                <line x1="20" x2="{$xAxisLength}" y1="-250" y2="-250" stroke="red" stroke-width="1"
                    stroke-dasharray="5, 5"/>
                <text x="{$xAxisLength + 20}" y="-350" font-size="20px">Legend: Survey Responses</text>
                <line x1="{$xAxisLength + 40}"  x2="{$xAxisLength + 40}" y1="-330" y2="-310" stroke="grey" stroke-width="{$barWidth}"/>
                <text x="{$xAxisLength + 70}" y="-315" text-anchor="start" font-size="16px">Blank</text>
                
                <line x1="{$xAxisLength + 40}"  x2="{$xAxisLength + 40}" y1="-300" y2="-280" stroke="green" stroke-width="{$barWidth}"/>
                <text x="{$xAxisLength + 70}" y="-285" text-anchor="start" font-size="16px">No</text>
                
                <line x1="{$xAxisLength + 40}"  x2="{$xAxisLength + 40}" y1="-270" y2="-250" stroke="orange" stroke-width="{$barWidth}"/>
                <text x="{$xAxisLength + 70}" y="-255" text-anchor="start" font-size="16px">Yes but fined</text>
                
                <line x1="{$xAxisLength + 40}"  x2="{$xAxisLength + 40}" y1="-240" y2="-220" stroke="purple" stroke-width="{$barWidth}"/>
                <text x="{$xAxisLength + 70}" y="-225" text-anchor="start" font-size="16px">Yes</text>
               
            </g>
        </svg>
    </xsl:template>
   
    <xsl:template match="fs[f[@select='Yes']]">
        <xsl:variable name="XPos" select="(position() * $Interval) - $Interval div 4"/>
        <xsl:variable name="YesPercent" select="(f[@select='Yes']/@n div sum(f/@n)) * 100"/>
        <!--ebb: This is how I calculate the the percentage of "Yes" responses.-->
        <xsl:variable name="YesbutFinedPercent" select="(f[@select='Yes_but_fined']/@n div sum(f/@n)) * 100"/>
        <xsl:variable name="NoPercent" select="(f[@select='No']/@n div sum(f/@n)) * 100"/>
        <xsl:variable name="BlankPercent" select="(f[@select='Blank']/@n div sum(f/@n)) * 100"/>
        
        <xsl:variable name="YesLength" select="-$YesPercent * $heightAdjust"/>
        <xsl:variable name="YesbutFinedLength" select="-$YesbutFinedPercent * $heightAdjust"/>
        <xsl:variable name="NoLength" select="-$NoPercent * $heightAdjust"/>
        <xsl:variable name="BlankLength" select="-$BlankPercent * $heightAdjust"/>
        
        <line class="Yes" x1="{$XPos}" x2="{$XPos}" y1="0" y2="{$YesLength}" stroke="purple" stroke-width="{$barWidth}"/>
        <text x="{$XPos}" y="{$YesLength - ($YesLength div 2)}" text-anchor="middle" stroke="white"><xsl:value-of select="format-number($YesPercent, '0')"/><xsl:text>%</xsl:text></text>
      
     

        <xsl:choose><xsl:when test="f[@select='Yes_but_fined']">
        <line class="Yes_but_fined" x1="{$XPos}" x2="{$XPos}" y1="{$YesLength}" y2="{$YesLength + $YesbutFinedLength}" stroke="orange" stroke-width="{$barWidth}"/>
            <line class="No" x1="{$XPos}" x2="{$XPos}" y1="{$YesLength + $YesbutFinedLength}" y2="{$YesLength + $YesbutFinedLength + $NoLength}" stroke="green" stroke-width="{$barWidth}"/>
            <text x="{$XPos}" y="{($YesLength + $YesbutFinedLength + $NoLength) - ($NoLength div 2)}" text-anchor="middle" stroke="white"><xsl:value-of select="format-number($NoPercent, '0')"/><xsl:text>%</xsl:text></text>
            <line class="Blank" x1="{$XPos}" x2="{$XPos}" y1="{$YesLength + $YesbutFinedLength + $NoLength}" y2="{$YesLength + $YesbutFinedLength + $NoLength + $BlankLength}" stroke="grey" stroke-width="{$barWidth}"/>
            <text x="{$XPos}" y="{($YesLength + $YesbutFinedLength + $NoLength + $BlankLength) - ($BlankLength div 2)}" text-anchor="middle" stroke="white"><xsl:value-of select="format-number($BlankPercent, '0')"/><xsl:text>%</xsl:text></text>
        </xsl:when>
        <!--ebb: As we noted in the assignment sheet, if I don't include this xsl:choose test, and I attempt to stack a Yes_but-fined bar on top of a Yes bar, in every bar where there's no value for Yes_but_fined, my output looks fine as code in
            oXygen, but it fails to plot the stacked bars for every question that doesn't have a "Yes but fined response." -->
        <xsl:otherwise>
            <line class="No" x1="{$XPos}" x2="{$XPos}" y1="{$YesLength}" y2="{$YesLength + $NoLength}" stroke="green" stroke-width="{$barWidth}"/>
            <text x="{$XPos}" y="{($YesLength + $NoLength) - ($NoLength div 2)}" text-anchor="middle" stroke="white"><xsl:value-of select="format-number($NoPercent, '0')"/><xsl:text>%</xsl:text></text>
            <line class="Blank" x1="{$XPos}" x2="{$XPos}" y1="{$YesLength + $NoLength}" y2="{$YesLength + $NoLength + $BlankLength}" stroke="grey" stroke-width="{$barWidth}"/>
            <text x="{$XPos}" y="{($YesLength + $NoLength + $BlankLength) - ($BlankLength div 2)}" text-anchor="middle" stroke="white"><xsl:value-of select="format-number($BlankPercent, '0')"/><xsl:text>%</xsl:text></text>
        </xsl:otherwise>
        </xsl:choose>
        
        <text x="{$XPos}" y="5" style="writing-mode: tb;" font-size="12px">
            <xsl:text>Q </xsl:text><xsl:value-of select="position()"/><xsl:text>: </xsl:text>
            <xsl:value-of select="f[@name='question']"/></text>
        <!--ebb: Note that the numbers being returned by position() here do NOT reflect the original order of the questions in the survey.
            The position() function here is returning a number that reflects the xsl:sort order, which is organizing our data from the
        most to the least "Yes" responses.-->
    </xsl:template>
   
    
</xsl:stylesheet> 