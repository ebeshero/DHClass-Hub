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
    
    <xsl:variable name="nelsonColl" select="collection('Nelson')"/>
    
    <xsl:template match="/">
    <html>
        <head>
            <title>Nell Nelson Articles</title>
        </head>
        <body>
            <h1>Nelson Articles</h1>
            <h2>Table of Contents</h2>
            
            <ul><xsl:apply-templates select="$nelsonColl//body" mode="toc">
                
            </xsl:apply-templates></ul>
            
            <div id="main">
                <xsl:apply-templates select="$nelsonColl//body"/>
                
            </div>
            
            
            
        </body>
    </html>
    </xsl:template>
        
        <xsl:template match="$nelsonColl//body" mode="toc">
            <li>
                <a href="#article{//body/div/@n}"> 
                <xsl:text>Title: </xsl:text><xsl:apply-templates select="//body/div/head/title"/>
                </a>
            </li>
        </xsl:template>
    
    
    <xsl:template match="title">
        <span id="article{//body/div/@n}">
            <span class="title"><strong>
                <xsl:apply-templates/>
            </strong></span>
        </span>
        
    </xsl:template>
    
    <xsl:template match="p">
        <p><xsl:apply-templates/></p><br/>
    </xsl:template>
    
    <xsl:template match="orgName">
        <span class="orgName"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="persName">
        <span class="persName"><xsl:apply-templates/></span>
    </xsl:template>
    
    
    <!--<xsl:template match="body">
        <h2><span id="article{//body/div/@n}"><xsl:apply-templates select=".//title"/></span>
        </h2>
        
        
    </xsl:template>-->
    
    
    

</xsl:stylesheet>