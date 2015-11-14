<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>War of The Worlds</title>
            </head>
            <body>
                <h1>War of The Worlds Script</h1>
                
                <div id="castList">   
                    <h2>Cast List</h2>
                    <ul>
                        <xsl:apply-templates select="//body" mode="cl"/>
                    </ul>
                    <hr/>
                </div>
                <div id="main">
                    <xsl:apply-templates select="//body"/> 
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="body" mode="cl">
        <xsl:for-each select="distinct-values(//spkr)">
            <xsl:sort/>
            <li><xsl:value-of select="."/></li>
        </xsl:for-each>    
    </xsl:template>
    
    <xsl:template match="sp">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="stage">
        <xsl:text>**</xsl:text>
        <span class="stageDirection"><xsl:apply-templates/></span>
        <xsl:text>**</xsl:text>
    </xsl:template>
    <!-- RJP: 2015-11-12: I did both in-line styling and the prep. for CSS styling using <span> elements as an examples of both since on the Exam we asked for either of the two -->
    <xsl:template match="spkr">
        <strong><span class="speaker"><xsl:apply-templates/></span></strong>
    </xsl:template>

            
    
    
    
</xsl:stylesheet>