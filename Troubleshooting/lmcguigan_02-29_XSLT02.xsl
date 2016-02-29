<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <link rel="stylesheet" type="text/css" href="lmcguigan_02-29_XSLT02.css"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Lauren XSLT</title>
            </head>
            <body>
               
               <xsl:apply-templates select="//head"/>
               
                <xsl:apply-templates select="//articleBody"/>
            </body>
        </html>
    </xsl:template>
       
    
    <xsl:template match="nellVoice">
    <span class="nellVoice">
        <xsl:apply-templates/>
    </span>
    </xsl:template>
    

<xsl:template match="//workingConditions[@category=/toneElements[@tone]]">
    <span class="bad">
    <xsl:apply-templates/>
    </span>
    <span class="good">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<xsl:template match="//mascVoice[@connotation=/toneElements[@tone]]">
    <span class="bad">
        <xsl:apply-templates/>
    </span>
    <span class="good">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<xsl:template match="//femVoice[@connotation=/toneElements[@tone]]">
        <span class="bad">
            <xsl:apply-templates/>
        </span>
        <span class="good">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
<xsl:template match="//nellVoice[@connotation=/toneElements[@tone]]">
        <span class="bad">
            <xsl:apply-templates/>
        </span>
        <span class="good">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

<xsl:template match="headLine">
   <h2>
    <xsl:apply-templates/>
   </h2>
</xsl:template>
    
    
    <xsl:template match="newspaperTitle">
        <h1>
            <xsl:apply-templates/>
        </h1>
    </xsl:template>
    
</xsl:stylesheet>