<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
    exclude-result-prefixes="xs math" 
    xmlns="http://www.w3.org/1999/xhtml" 
    version="3.0"> 
    <xsl:output method="xhtml" indent="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="/">
        <html>
            <head><title>TITLE</title></head>
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
    
    <xsl:template match="dialogue">
        <br/>
        <br/>
        <span class="dialogue"><em>**<xsl:apply-templates/>**</em></span>
        <br/>
        <br/>
    </xsl:template>
    
    <xsl:template match="dialogue/femVoice">
        <span class="femVoice"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="dialogue/nellVoice">
        <span class="nellVoice"><em><xsl:apply-templates/></em></span>
    </xsl:template>
    
    <xsl:template match="dialogue/mascVoice">
        <span class="mascVoice"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="company[@name='identified']">
        <span class="companyName"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody//workingConditions[@category=//workingConditions[@tone='good']/@id]">
        <span class="good"><xsl:apply-templates/></span>
    </xsl:template>
    
<!--    <xsl:template match="articleBody/workingConditions[@category='positive']">
        <span class="good"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[@category='camaraderie']">
        <span class="good"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[@category='negative']">
        <span class="bad"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[@category='comparison']">
        <span class="bad"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[@category='wageDesc']">
        <span class="bad"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[@category='workDesc']">
        <span class="bad"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[@category='descriptionNeutral']">
        <span class="neutral"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="articleBody/workingConditions[not(@category)]">
        <span class="neutral"><xsl:apply-templates/></span>
    </xsl:template>-->
    
</xsl:stylesheet>