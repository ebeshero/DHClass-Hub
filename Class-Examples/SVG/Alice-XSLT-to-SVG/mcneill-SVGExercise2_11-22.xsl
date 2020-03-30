<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    
    <xsl:output method="xml" indent="yes"/>

<xsl:variable name="Y-Stretcher" as="xs:integer" select="7"/>

<xsl:variable name="X-Spacer" as="xs:integer" select="70"/>

<xsl:template match="/">
    <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%" >
        <g transform="translate(70, 525)">
            <line x1="20" y1="0" x2="20" y2="-500" stroke-width="3" stroke="black"/>
            <line x1="20" y1="0" x2="900" y2="0" stroke-width="3" stroke="black"/>
            <text x="150" y="-550" text-anchor="middle" stroke="black" font-size="20">Number of Alice's quotes in Each Chapter</text>
       
       <!--ebb: We can do these in an xsl:for-each. Remind me to show you. -->
            <text x="5" y="0" text-anchor="middle" stroke="DarkOrchid">0</text>
            <text x="5" y="{-10 * $Y-Stretcher}" text-anchor="middle">10</text>
            <text x="5" y="{-20 * $Y-Stretcher}" text-anchor="middle">20</text>
            <text x="5" y="{-30 * $Y-Stretcher}" text-anchor="middle">30</text>
            <text x="5" y="{-40 * $Y-Stretcher}" text-anchor="middle">40</text>
            <text x="5" y="{-50 * $Y-Stretcher}" text-anchor="middle">50</text>
            <text x="5" y="{-60 * $Y-Stretcher}" text-anchor="middle">60</text>
            
          
            
            <xsl:for-each select="descendant::chapter">
                <text x="{position() * $X-Spacer}" y="20" text-anchor="middle" stroke="DarkOrchid">Ch. <xsl:value-of select="@which"/></text>
                
                <!--ebb: We can always use the position() function to give us the position in the sequence of whatever it is we're processing in xsl:for-each. (We could also have used @which, which gives us a chapter number.)
                -->
              <!--  <line x1="{position() * $X-Spacer}" y1="0" x2="{position() * $X-Spacer}" y2="-{count(descendant::q[@sp='alice']) * $Y-Stretcher}" stroke="ForestGreen" stroke-width="3"/>-->
                
                <line x1="{position() * $X-Spacer}" y1="-{count(descendant::q[@sp='alice']) * $Y-Stretcher}" x2="{(position() + 1) * $X-Spacer}" y2="-{count(following-sibling::chapter[1]//q[@sp='alice']) * $Y-Stretcher}" stroke="ForestGreen" stroke-width="3"/>
                
                
                <circle cx="{position() * $X-Spacer}" cy="-{count(descendant::q[@sp='alice']) * $Y-Stretcher}" r="5" fill="DarkOrchid" stroke="black" stroke-width="2"/>
                
               
                
                
            </xsl:for-each>
           
        </g>
    </svg>
</xsl:template>
</xsl:stylesheet>