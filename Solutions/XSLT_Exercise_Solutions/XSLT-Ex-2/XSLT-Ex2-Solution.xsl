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
            <head><title>HTML Transformation of 1888-07-30 Nelson Article</title>
                <link rel="stylesheet" type="text/css" href="nelsonStyle.css"/>
            </head>
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

    <xsl:template match="articleBody//workingConditions[@category = //toneElements/category/@id]">
        <span class="{ancestor::root/toneElements/category[@id= current()/@category]/@tone}">
            <xsl:apply-templates/>
        </span>   
        <!--2016-02-26 ebb: This is a complicated ATV! Here's how it works: We have a workingConditions element in 
                the articleBody of the Nelson text, and it has an @category attribute, which is designed to match up to
                a category element and its @id attribute high up in the toneElements portion of the document. Our goal is to *find* the matching 
                @id on a category element and retrieve the value of an @tone attribute sitting on it. To do that, we start by making
                a template matching the workingConditions element that has an @category = the @id up in toneElements. In the template @match, notice 
                the double slashes before toneElements in the predicate expression: We actually want to start from the document node and work down to get that, 
                so the double slashes say, start from the top of the tree and look down for the matching @id. As the XSLT parser matches on each workingConditions
                element that has a matching @category to a category @id, it consumes the element content (with <xsl:apply-templates/>), but it also wraps it in
                an HTML <span> element with an @class attribute set to an AVT: an XPath expression that sort of looks like the *opposite* of what we wrote in the
                template match. In the <span class="{ }"> AVT, we have to start from the point of view of the template match, but we want to climb up and get something 
                from the toneElements/category element: We want to output the @tone attribute from the category element with the matching @id, and the @tone attribute, 
                is our goal here for the AVT. To reach it, we climb up the ancestor:: axis to the root, and then step down to the toneElements category, **whose @id 
                matches the current()/@category**. Here, current() refers to the template match currently being processed. This way we write XSLT to do a lookup for us 
                without our having to key in the @tone values ourselves.-->
                            
    </xsl:template> 
    
    <!--2016-02-26 rjp: Here is another way of doing the above rule by separating it out to multiple rules. However, we do recommend using AVT! If you completed the assignment doing it the following way we recommend you go back and try the above rule instead. At the very least please review the above rule to understand complicated Attribute Value Templates.-->
    <!--<xsl:template match="articleBody//workingConditions[@category = //toneElements/*[@tone='good']/@id]">
        <span class="good">
            <xsl:apply-templates/>
        </span>
    </xsl:template>     
    <xsl:template match="articleBody//workingConditions[@category=//toneElements/*[@tone='bad']/@id]">
        <span class="bad">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="articleBody//workingConditions[@category=//toneElements/*[@tone='neutral']/@id]">
        <span class="neutral">
            <xsl:apply-templates/>
        </span>
    </xsl:template> --> 
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