<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    version="3.0">
 <!--2015-10-08 ebb: Solution to XSLT Exercise 1: An Identity Transformation Stylesheet to run with ForsterGeorgComplete.xml .--> 
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:template match="emph">
        <hi rend="italics">
            <xsl:apply-templates/>
        </hi>
    </xsl:template>
    
    <xsl:template match="head/l">
        <xsl:apply-templates/>
        <lb/>
    </xsl:template>
    
    <xsl:template match="div[@type='book']">
        <div type="book" n="{count(preceding::div[@type='book']) + 1}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    
<!--ebb: Chapter Numbering Variation 1: Numbering chapters: Run this, look at the output, scanning for chapter numbers through each of the books 
        through the end of the document. Then comment out this template rule, and remove the comments from the next one.
    Run the XSLT transformation again, and look at the chapters. -->
    <xsl:template match="div[@type='chapter']">
        <div type="chapter" n="{count(preceding-sibling::div[@type='chapter']) + 1}">
            <xsl:apply-templates/>
        </div>
        
    </xsl:template>
    
    <!--ebb: Chapter Numbering Variation 2: Remove the comments from around this template rule and run it to see how it outputs chapter numbers. 
        What's the difference between this and the previous rule? Think about why either version might be useful!-->
    
    <!--<xsl:template match="div[@type='chapter']">
        <div type="chapter" n="{count(preceding::div[@type='chapter']) + 1}">
            <xsl:apply-templates/>
        </div>
        </xsl:template>-->
    
</xsl:stylesheet>
    
