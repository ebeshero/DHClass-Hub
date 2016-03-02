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
   
    <xsl:variable name="dickinsonColl" select=".//collection('Dickinson')"/>

            <xsl:template match="$dickinsonColl">
                <xsl:apply-templates select="$dickinsonColl//body"/>
            </xsl:template>
    
    <xsl:template match="$dickinsonColl//head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
   
   <xsl:template match="$dickinsonColl//l">
       <xsl:apply-templates/><br/>
   </xsl:template>
    
    <xsl:template match="$dickinsonColl//lg">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
</xsl:stylesheet>