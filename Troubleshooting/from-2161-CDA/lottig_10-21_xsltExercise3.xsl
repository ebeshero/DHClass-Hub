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
        <head><title>Sanitary Conditions of Workshops and Factories in New York City</title></head>
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
                <xsl:apply-templates select="//div[@type='table']"></xsl:apply-templates>
            </table>
        </body>
    </xsl:template>
    
    <xsl:template match="fs">
        <tr>
            <td><xsl:apply-templates select="./f[@name='question']/string"/></td>
        </tr>
    </xsl:template>
    
</xsl:stylesheet>