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
    <xsl:variable name="dickinsonColl" select="collection('Dickinson')"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Emily Dickinson Fascicle 16</title>
            </head>
            <body>
                <h1>Emily Dickinson Fascicle 16</h1>
                <h2>Table of Contents</h2>
        <ul>
            <xsl:apply-templates select="$dickinsonColl//body" mode="toc"/>
        </ul>
                <hr/>
                <div id="main">
                    <xsl:apply-templates select="$dickinsonColl//body"/>
                    
                </div>
                
            </body>
            
        </html>
    </xsl:template>
    <xsl:template match="body">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="title">
        <h2>
        <xsl:apply-templates/>
        </h2>
    </xsl:template>
    
    <xsl:template match="title" mode="toc">
        <li>
            <xsl:apply-templates/>
        </li>
    </xsl:template>
    
    <xsl:template match="lg">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="l">
        <xsl:apply-templates/>
        <br/>
    </xsl:template>
    
    <xsl:template match="l">
        <ul n="{count(preceding::l) + 1}">
        <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    
</xsl:stylesheet>
