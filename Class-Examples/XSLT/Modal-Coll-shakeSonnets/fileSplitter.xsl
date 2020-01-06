<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="sonnets">
        <xsl:apply-templates select="sonnet"/>
    </xsl:template>
    
<xsl:template match="sonnet">
    <xsl:result-document href="shakeSonnets/sonnet{@number}.xml" method="xml"> 
       <sonnet number="{count(preceding-sibling::sonnet) + 1}">
            <xsl:apply-templates/>
           
       </sonnet>
    </xsl:result-document>
</xsl:template>
    
</xsl:stylesheet>