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
    
    <xsl:variable name="dickinsonColl" select="collection('Dickinson')"/>
    
    <xsl:template match="/">
      <html>
          <head><title>Emily Dickinson’s Fascicle 16</title></head>
          <body>
        
          <h1>Emily Dickinson’s Fascicle 16</h1>
              <h2>Table of Contents</h2>
        <ul><xsl:apply-templates select="$dickinsonColl//body" mode="toc">
            <xsl:sort select='translate(upper-case(.), "&apos;", "")'/>
        </xsl:apply-templates></ul>
              <hr/>
            
          <div id="main">
             <xsl:apply-templates select="$dickinsonColl//body"/>

          </div>
          
          </body>
          
      </html>
    </xsl:template>
    
    <xsl:template match="$dickinsonColl//body" mode="toc">
        <li>
            <a href="#p{count(preceding::h2) + 1}"> 
                <!--<xsl:apply-templates select="//body//title"/>-->
                <xsl:apply-templates select="lg[1]/l[1]"/>
                
            </a> 
        </li>
    </xsl:template>
    <!--
    <xsl:template match="body" mode="toc">
       <li><strong><xsl:apply-templates select=".//title"/></strong>: 
           <xsl:apply-templates select="lg[1]/l[1]"/>
           
           
      <xsl:text> [Variants: </xsl:text><xsl:value-of select="count(.//rdg)"/><xsl:text>]</xsl:text>
       </li>
     
      
    </xsl:template>-->

    <xsl:template match="body">
        <h2><span id="#p{count(preceding::h2) + 1}"><xsl:apply-templates select=".//title"/></span>
          </h2>
       
        <xsl:apply-templates select=".//lg"/>
        
    </xsl:template>
    
    <xsl:template match="lg">
        <p><xsl:apply-templates/></p>
    </xsl:template>
   
   <!-- <xsl:template match="l">
        <xsl:value-of select="count(preceding::l) + 1"/><xsl:text>: </xsl:text><xsl:apply-templates/>
       <xsl:if test="following-sibling::l"><br/></xsl:if>
         </xsl:template>-->
    
    <xsl:template match="rdg">
        <span class="{@wit}"><xsl:apply-templates/></span>
    </xsl:template>
  

</xsl:stylesheet>  
