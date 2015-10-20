<?xml version="1.0" encoding="UTF-8"?>
    <xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema"
        xmlns:math="http://www.w3.org/2005/xpath-functions/math"
        exclude-result-prefixes="xs math"
        xmlns="http://www.w3.org/1999/xhtml"
        version="3.0"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        
        <xsl:output method="xhtml" doctype-system="about:legacy-compat" 
            omit-xml-declaration="yes"/> 
    <!-- <xsl:strip-space elements="*"/>-->
        <xsl:template match="/">
            
            <html>
                <head>
                    <title>Explanatory Guides Used in This DH Course</title>
                <!--ebb We'd put a CSS link line here-->
                </head>
                <body>
                    <h1>Explanatory Guides Used in This DH Course</h1>
                    
                     
                    <xsl:apply-templates select="//div[@type='guides']"/>
    
                    
 
                </body>           
                
            </html>
 
        </xsl:template>
        
        <xsl:template match="list">
            
            
            <ol><xsl:apply-templates/></ol>
            
            
            
            
        </xsl:template>
        
        <xsl:template match="item">
            
            <li><xsl:apply-templates/></li>
        </xsl:template>
        
        <xsl:template match="ref">
            
            <a href="{@target}"><xsl:apply-templates/></a>
        </xsl:template>
        
        
    
</xsl:stylesheet>