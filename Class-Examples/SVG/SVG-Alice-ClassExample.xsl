<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <!--global variables-->
    <xsl:variable name="Width" select="40"/>
    <xsl:variable name="Interval" select="$Width + 30"/>
    <xsl:variable name="space" select="7"/>
    <xsl:template match="/"><!-- template match .. duh! -->
        <svg xmlns="http://www.w3.org/2000/svg" width="100%" height="100%"><!-- namespace!! -->
            <g transform="translate(70, 525)">
                <line x1="20" x2="20" y1="0" y2="-500" stroke="black" stroke-width="1"/>
                <line x1="20" x2="900" y1="0" y2="0" stroke="black" stroke-width="1"/>
                <text x="5" y="0" text-anchor="middle">0</text>
                <text x="5" y="-70" text-anchor="middle">10</text>
                <text x="5" y="-140" text-anchor="middle">20</text>
                <text x="5" y="-210" text-anchor="middle">30</text>
                <text x="5" y="-280" text-anchor="middle">40</text>
                <text x="5" y="-350" text-anchor="middle">50</text>
                <text x="5" y="-420" text-anchor="middle">60</text>
                <text x="5" y="-490" text-anchor="middle">70</text>
                <xsl:for-each select="//chapter">
                    <!-- local variables  -->
                    <xsl:variable name="xPosition" select="position()*$Interval"/>
                    <xsl:variable name="yPosition" select="count(.//q[@sp='alice'])* $space"/>
                    <line x1="{$xPosition}" y1="0" x2="{$xPosition}" y2="-{$yPosition}" color="black" stroke="black" stroke-width="3"/>
                    <text x="{$xPosition}" y="20" text-anchor="middle"> Ch.
                            <xsl:value-of select="@which"/>
                    </text>
                </xsl:for-each>
            </g>
        </svg>
    </xsl:template>
</xsl:stylesheet>


