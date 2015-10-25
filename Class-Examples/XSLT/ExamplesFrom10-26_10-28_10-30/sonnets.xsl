<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:variable name="sonnetColl" select="collection('sonnets')"/><!-- defining this variable allows us to run this XSLT over the entire collection of sonnets -->
    <xsl:template match="/">
        <html>
            <head>
                <link rel="stylesheet" type="text/css" href="style.css"/><!-- this is where we link a CSS stylesheet -->
                <title>Shakespearean Sonnets</title>
            </head>
            <body>
                <h1>Shakespearean Sonnets</h1>
                <h2>Table of Contents</h2>
                <ul>
                    <xsl:apply-templates select="$sonnetColl//sonnet" mode="toc"/> <!-- the "$" references the defined variable from above and the @mode is how we use modal XSLT to select the same part of the source document multiple times in order to write different template rules grabbing from the same selected part of the source document -->                        
                </ul>
                <hr/>
                <xsl:apply-templates select="$sonnetColl//sonnet"/>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="sonnet" mode="toc">
        <li>
            <xsl:text>Line</xsl:text><xsl:apply-templates select="//lg[1]/line[1]"/>
            (<xsl:apply-templates select="@number"/>)
        </li>
    </xsl:template>
   
    <xsl:template match="sonnet">
        <h3 id="sonnet{@number}"><!-- here we are using an Attribute Value Template to set the attribute value of @number as the new attribute value for @id (notice the curly braces)-->
            <span class="sonnetNumber">
                <xsl:apply-templates select="@number"/>
            </span>
        </h3>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="lg">
        <p><span class="{@type}"><!-- using AVT to set the @class equal to the @type on lg (notice the curly braces)--><xsl:apply-templates/></span></p>
    </xsl:template>
    
    <xsl:template match="line">
        <span class="line"><xsl:value-of select="count(preceding::line) + 1"/><xsl:text>: </xsl:text><xsl:apply-templates/></span><br/>
        </xsl:template>
    
</xsl:stylesheet>