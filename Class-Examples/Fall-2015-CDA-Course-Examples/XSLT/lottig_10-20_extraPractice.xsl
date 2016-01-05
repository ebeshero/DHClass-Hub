<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" doctype-system="about:legacy-compat"/>
    
    <xsl:template match="/">
        <html>
            <head><title>Bibliography List</title></head>
            <body>
                <ol><xsl:apply-templates select="//listBibl"/></ol>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="listBibl">
        <li><xsl:apply-templates select="./head"/>
        <ul><xsl:apply-templates select="./bibl"/></ul></li>
    </xsl:template>  
    
    <xsl:template match="bibl">
        <li><xsl:apply-templates select="./title"/>
        <ul><xsl:apply-templates select="./author"/><xsl:apply-templates select="./publisher"/><xsl:apply-templates select="./pubPlace"/><xsl:apply-templates select="./date"/></ul></li>
    </xsl:template>
    
    <xsl:template match="author">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="publisher">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="pubPlace">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="date">
        <li><xsl:apply-templates/></li>
    </xsl:template>

</xsl:stylesheet>