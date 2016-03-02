<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
 <!--2016-03-01 ebb: Jessica: Compare this file to the one you were working on.
 I removed all but one reference to your $dickinsonColl variable because it
 was making the computer parser work too hard to duplicate the context you set
 already in your first <xsl:apply-templates> line.

 -->   
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
   
    <xsl:variable name="dickinsonColl" select="collection('Dickinson')"/>

            <xsl:template match="/">
                <html>
                    <head><title>SOMETHING HERE</title></head>
                    <body>
                        <xsl:apply-templates select="$dickinsonColl//body"/>
                        <!--ebb: Here's what is happening at this point. This apply-templates line is
SUPER important, because it's saying, "Apply templates in the rest of this file
ONLY to the context I set RIGHT HERE. That means the REST of your template rules
will only fire inside the dickinson collection folder, and that's what you want.
You don't want to set the context here and then make the parser look up that variable
over and over again in the template rules; apparently that causes problems! -->
    
                    </body>
                    
                </html>
            </xsl:template>
    
    <xsl:template match="head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
   
   <xsl:template match="l">
       <xsl:apply-templates/><br/>
   </xsl:template>
    
    <xsl:template match="lg">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
</xsl:stylesheet>