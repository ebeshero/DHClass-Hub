<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Mitford Index
                </title>
            </head>
            <body>
                <h1>Index</h1>
                
                <ol> <xsl:apply-templates select="/listOrg"/></ol><!--RJP: Make sure are stepping down far enough.. remember that @select is a literal xpath expression and needs direction on how far and where to step down-->
                
                
                
            </body>
            
        </html>
    
    </xsl:template>
    <xsl:template match="org">
        
        <ul><xsl:apply-templates/></ul><!--RJP: make a selection on what exactly you are looking to output-->
        
    </xsl:template>
    <xsl:template match="orgName">
        
        <li><xsl:apply-templates/></li><!--RJP: make a selection on what exactly you are looking to output-->
        
    </xsl:template>
    
    
    
</xsl:stylesheet>
