<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/2000/svg">
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:variable name="Interval" select="60"/>
    <xsl:template match="/">
        <svg width="100%" height="100%">
            <g transform="translate(60, 575)">
                <text x="375" y="-550" text-anchor="middle">Number of Quotes by Alice in Each Chapter of "Alice in Wonderland"</text>
                <line x1="20" x2="20" y1="0" y2="-450" stroke="black" stroke-width="1"/>
                <line x1="20" x2="750" y1="0" y2="0" stroke="black" stroke-width="1"/>
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-60" text-anchor="middle">10</text>
                <text x="5" y="-120" text-anchor="middle">20</text>
                <text x="5" y="-180" text-anchor="middle">30</text>
                <text x="5" y="-240" text-anchor="middle">40</text>
                <text x="5" y="-300" text-anchor="middle">50</text>
                <text x="5" y="-360" text-anchor="middle">60</text>
                <text x="5" y="-420" text-anchor="middle">70</text>
                <xsl:apply-templates select="//chapter"/>
            </g>
        </svg>
    </xsl:template>
    <xsl:template match="chapter">
        <xsl:variable name="xPos" select="position()*$Interval"/>
        <xsl:variable name="yPos" select="count(.//q[@sp='alice']) * 6"/>
        <xsl:variable name="xPos2" select="(position()+1)*$Interval"/>
        <xsl:variable name="yPos2" select="(count(.//following-sibling::chapter[1]//q[@sp='alice']))*6"/>
        
        <text x="{$xPos}" y="30" text-anchor="middle"> Ch.
            <xsl:value-of select="@which"/></text>
  
        
        <xsl:if test="./following-sibling::*">
            <line x1="{$xPos}" y1="-{$yPos}" x2="{$xPos2}" y2="-{$yPos2}" color="black" stroke="black" stroke-width="4"/>
            </xsl:if>
      
        <circle cx="{$xPos}" cy="-{$yPos}" r="6" fill="red"/>
        <text x="{$xPos - 3}" y="{-$yPos - 30}"><xsl:value-of select="count(.//q[@sp='alice'])"/></text>
        
</xsl:template>
    
</xsl:stylesheet>