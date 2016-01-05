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
    <!--RJP:10/21/15: Very basic, on-the-fly XSLT for Amadis-in-Translation project -->
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Table Comparing Montalvo and Southey</title>
            </head>
            <body>
                <table>
                    <tr>
                        <th>Montalvo</th>
                        
                        <th>Southey</th>
                    </tr>
                    
                    <xsl:apply-templates select="//fs"></xsl:apply-templates>
                  
                </table>
         
            </body>
         
        </html>
        
    </xsl:template>
    
    <xsl:template match="fs">
        <tr> 
        <td><xsl:apply-templates select="f[@name='montalvo']/string"/></td>
        <td><xsl:apply-templates select="f[@name='southey']/string"/></td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
    
    
    
    
    
    
