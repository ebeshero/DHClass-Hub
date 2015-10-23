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
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Nell Nelson - Sanitary Conditions </title>
                <link rel="stylesheet" type="text/css" href="lawrence.xslt3.css"/>
            </head>
            <body>
                <table>
                    <tr>
                        <th>Number</th>
                        <th>Question</th>
                        <th>Yes</th>
                        <th>Yes, but fined</th>
                        <th>No</th>
                        <th>Blank</th>
                        <th>Total Responses</th>
                    </tr>
                    
                    <xsl:apply-templates select="//fs"></xsl:apply-templates>
                    
                </table>
                
                <table>
                    <tr>
                        <th>Question</th>
                        <th>Water Closet</th>
                        <th>Other Sources</th>
                        <th>Total Responses</th>
                    </tr>
                    <xsl:apply-templates select="//fs"></xsl:apply-templates>
                </table>
        
                
            </body>
            
        </html>
        
    </xsl:template>
    
    
    <xsl:template match="fs">
        <tr> 
            <td><xsl:value-of select="count(preceding-sibling::fs) +1"/></td>
            <td><xsl:apply-templates select="./f[@name='question']/following-sibling::f[@select='Yes']/preceding-sibling::f[@name='question']/string"></xsl:apply-templates></td>
            <td><xsl:apply-templates select="./f[@select='Yes']/@n"/></td>
            <td><xsl:apply-templates select="./f[@select='Yes_but_fined']/@n"></xsl:apply-templates></td>
            <td><xsl:apply-templates select="./f[@select='No']/@n"/></td>
            <td><xsl:apply-templates select="./f[@select='Blank']/@n"></xsl:apply-templates></td>
            <td><xsl:value-of select="sum(./f/@n)"></xsl:value-of></td>
        </tr>
    </xsl:template>
   <xsl:template match="fs">
       <tr>
           <td><xsl:apply-templates select="./f[@select='water_closet']/@n"></xsl:apply-templates></td>
           <td><xsl:apply-templates select="./f[@select='other_causes']/@n"></xsl:apply-templates></td>
           <td><xsl:value-of select="sum(./f/@n)"></xsl:value-of></td>
       
       </tr>
       
       
   </xsl:template>
            
            
          
    
</xsl:stylesheet>