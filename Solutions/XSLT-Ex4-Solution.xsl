<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <!--2015-10-25 ebb: Use the above output line to maximize compatibility 
        with our newtfire web server and output w3C-valid HTML 5 in XHTML format.-->
    <xsl:template match="/">
        <html>
            <head><title>XSLT Exercise 4 HTML Transformation from Nelson Article</title><link rel="stylesheet" type="text/css" href="nelsonStyle.css"/></head>
            <body>
                <h1><xsl:apply-templates select="//head/newspaperTitle"/></h1>
                <h2><xsl:apply-templates select="//head/seriesTitle"/></h2>
                <h3><xsl:apply-templates select="//head/byline"/></h3>
                <h3><xsl:apply-templates select="//head/date"/></h3>
                <xsl:apply-templates select="//head/headLine"/>
                <p><xsl:apply-templates select="//articleBody"/></p>
            </body>
        </html>        
    </xsl:template>
   <xsl:template match="headLine">
        <h4><span class="headLine"><xsl:apply-templates/></span></h4>
    </xsl:template>

    <xsl:template match="articleBody//workingConditions[@category=//toneElements/workingCondition[@tone='good']/@id]">
        <span class="good">
            <xsl:apply-templates/>
        </span>
    </xsl:template>     
    <xsl:template match="articleBody//workingConditions[@category=//toneElements/workingCondition[@tone='bad']/@id]">
        <span class="bad">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="articleBody//workingConditions[@category=//toneElements/workingCondition[@tone='neutral']/@id]">
        <span class="neutral">
            <xsl:apply-templates/>
        </span>
    </xsl:template> 
    <xsl:template match="dialogue">
        <br/><br/><span class="dialogue"><xsl:apply-templates/></span><br/><br/>
    </xsl:template>
    <xsl:template match="dialogue/nellVoice">
        <xsl:text>*Nell Nelson:</xsl:text><span class="nellVoice">
            <xsl:apply-templates/>
        </span><xsl:text>*</xsl:text>
    </xsl:template>
    <xsl:template match="dialogue/femVoice">
        <xsl:text>*Female Speaker:</xsl:text><span class="femVoice">
            <xsl:apply-templates/>
        </span><xsl:text>*</xsl:text>
    </xsl:template> 
    <xsl:template match="dialogue/mascVoice">
        <xsl:text>*Male Speaker:</xsl:text><span class="mascVoice">
            <xsl:apply-templates/>
        </span><xsl:text>*</xsl:text>
    </xsl:template>
   <xsl:template match="unclear">
       <xsl:text>[missing word(s)]</xsl:text>
   </xsl:template>
    <xsl:template match="company[@name='identified']">
        <span class="company">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>