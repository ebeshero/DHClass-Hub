<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:variable name="dColl" select="collection('Dickinson')"/>
    <xsl:template match="/">
        <html>
            <head><title>Fascicle 16</title></head>
            <body>
                <h1>Fascicle 16</h1>
                <h2>Table of Contents</h2>
                <ul><xsl:apply-templates select="$dColl//body" mode="tc"/></ul>
                <hr/>
                <div id="fullText">
                    <xsl:apply-templates select="$dColl//body"/>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="body" mode="tc">
        <li><xsl:text>Title: </xsl:text><xsl:apply-templates select=".//title"/>
            <xsl:text>Line </xsl:text><xsl:apply-templates select="lg[1]/l[1]"/><!-- RJP: I originally wanted to write out First Line: and have the line appear without the numbering (1:) but I couldn't figure out a way to eliminate the numbers on the first line here and not everywhere else as well : see commented out template below  -->
            <xsl:text>Variants: </xsl:text><xsl:value-of select="count(.//rdg)"/></li>
    </xsl:template>
    
<xsl:template match="body">
        <h2><xsl:apply-templates select=".//title"/></h2>
        <xsl:apply-templates select=".//lg"/>
    </xsl:template>
    <xsl:template match="lg">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="l">
        <xsl:value-of select="count(preceding::l) + 1"/><xsl:text>: </xsl:text><xsl:apply-templates/><xsl:if test="following-sibling::l"><br/></xsl:if>
    </xsl:template>
     <xsl:template match="rdg">
         <span class="{@wit}"><xsl:apply-templates/></span>
    </xsl:template>
    <!-- <xsl:template match="l" mode="tc">
        <xsl:if test="preceding-sibling::l"><xsl:value-of select="count(preceding::l) + 1"/><xsl:text>: </xsl:text><xsl:apply-templates/><xsl:if test="following-sibling::l"><br/></xsl:if></xsl:if>
    </xsl:template>-->
    <!--RJP: What rule could we write to pull the line numbering from the lines that appear in the table of contents-->
</xsl:stylesheet>