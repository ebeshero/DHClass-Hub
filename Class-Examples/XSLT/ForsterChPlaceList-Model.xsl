<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output method="xhtml" indent="yes" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Places Mentioned in Georg Forster Account</title>
            </head>
            <body>
                <h1>Places Listed in Each Chapter of Georg Forster’s Voyage Record</h1>
                <ul>
                    <xsl:apply-templates select="//text/body//div[@type='chapter']"/>
                </ul>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="div[@type='chapter']">
        <li>
            <xsl:apply-templates select="head/l"/>
            <ul>
                <xsl:apply-templates select=".//p/placeName"/>
                <!--ebb: In this stylesheet, we wanted to include only the placeName elements inside the body paragraphs of the chapters. So we set our @select statement to step down and collect only these placeNames -->
            </ul>
        </li>
    </xsl:template>
    <xsl:template match="p/placeName">
        <!--ebb: This template rule matches on a pattern: Any time this rule is called, it finds a placeName that is the child of a body paragraph. In the previous template rule, we called for this template to be applied *only selectively to the placeNames inside the paragraphs within chapter divs.* So this template rule will only fire under those selective conditions. -->
        <li><xsl:apply-templates/>
        <!--ebb: When we don't use an @select on apply-templates, we simply output the content of the element we're matching on, and we output it as plain text. Run this stylesheet and scroll through the output and you'll see that perhaps we should consider modifying this rule! We seem to be outputting note elements that are children of placeName in this document, and our transformation can show us some things we may want to change about our source code, or things we can try to exclude in our XSLT transformation! -->
        </li>
    </xsl:template>
   
</xsl:stylesheet>