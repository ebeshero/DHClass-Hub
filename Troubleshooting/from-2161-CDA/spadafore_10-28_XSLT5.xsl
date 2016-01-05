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
    
    <xsl:variable name="dickinsonColl" select="collection('../Dickinson')"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Dickinson Poems</title>
            </head>
            <body>
                <div><xsl:apply-templates select="$dickinsonColl//l"/></div>
                <h1>Dickinson Poems</h1>
                <h2>Table of Contents</h2>
                <ul>
                    <xsl:apply-templates select="$dickinsonColl//body" mode="toc"/>
                </ul>
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="$dickinsonColl//body">
        <h2></h2>
    </xsl:template>
    
    <xsl:template match="$dickinsonColl" mode="toc">
        <ul>
            <li><xsl:apply-templates select="title"/></li>
        </ul>
    </xsl:template>
    
</xsl:stylesheet>