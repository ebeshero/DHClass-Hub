<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output method="xhtml" indent="yes" omit-xml-declaration="yes"
        encoding="utf-8" doctype-system="about:legacy-compat"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>skyrim</title>
                <link rel="stylesheet" type="text/css" href="skyrim.css"></link>
            </head>
            <body>
                <ul>
                    <xsl:apply-templates select=".//QuestEvent" mode="list">
                        <xsl:sort select='translate(upper-case(.), "&apos;", "")'/>
                    </xsl:apply-templates>
                </ul>
                <xsl:apply-templates/>
                <span id="padSpan"></span>
            </body>
        </html>
        
    </xsl:template>
    
    <xsl:template match="QuestEvent" mode="list">
        <li>
            <a href="#qe{count(preceding::QuestEvent)}">
                <xsl:value-of 
                    
                    select="normalize-space(concat(upper-case(substring(., 1, 1 )), substring(., 2)))"
                    
                /> 
            </a>
        </li>
    </xsl:template>
    
    <xsl:template match="paragraph">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="QuestEvent">
        <span id="qe{count(preceding::QuestEvent)}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="faction">
        <span class="{@ref}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
</xsl:stylesheet>