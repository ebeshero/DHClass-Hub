<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <!--2016-03-01 ebb: Megan: you were missing the HTML "skeleton" elements
        that you need to output an HTML file when you match on the document node!
        Once I added those, your XSLT worked. Because you have set your output to
        be xhtml (as you're supposed to do) you *have* to construct a full HTML
        file in the document node to get output.
        -->
    
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:variable name="dickinsonColl" select="collection('Dickinson')"/>
    
    <xsl:template match="/">
    <html>
        <head><title>SOMETHING HERE</title>
        </head>
        
        <body>
        <xsl:apply-templates select="$dickinsonColl//body"/>  </body>
    
    
    </html>
   
    </xsl:template>
    
    <xsl:template match="title">
        <h2>
            <xsl:apply-templates/>
        </h2>
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
    
</xsl:stylesheet>