<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    
    <xsl:output indent="yes" method="html" doctype-system="about:legacy-compat"/>
    
    <!--ebb: This is an xsl:variable. We give it a name, and we select a value for it. We need this variable to tell us how to find a file directory and process the files inside it.
    -->
    <xsl:variable name="sonnetsColl" select="collection('shakeSonnets/?select=*.xml')"/>
   <!--ebb: We use the collection() function in XSLT to refer to a file collection. That direction is a relative file path, and we step into it from the context of where saved this stylesheet. Look at the DHClass-Hub directory, and you'll see Sonnets-modal-coll.xsl sits just above the directory named shakeSonnets. You'll want to work on your assignments this way too, saving the XSLT stylesheet in the directory above the colleciton of files, just for ease of processing.  --> 
    
    <!-- This is our root template establishing the structure of our HTML-output -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Shakespeare Sonnets</title>
            </head>
            <body>
                <!-- This creates a Table of Contents section -->
                <h1>Shakespearean Sonnets</h1>
                <h2>Contents</h2>
                <ul>
                    <xsl:apply-templates select="$sonnetsColl//sonnet" mode="toc">
                        <xsl:sort select="@number ! number()"/>
                        
                    </xsl:apply-templates>
                       
                    <!--ebb: We have to "CALL our variable" here, because we want to make a table of contents out of the files in our directory. We use a $ to indicate that we're calling a variable, and then we give the variable name.
                    -->
                </ul>
                <hr/> <!-- horizontal rule line to separate sections-->
                <!-- This section reproduces the text of the xml-file -->
                
                <xsl:apply-templates select="$sonnetsColl//sonnet">
                    <xsl:sort select="@number ! number()"/>
                </xsl:apply-templates>
                <!--ebb: Here we invoke the variable again. -->
            </body>
        </html>
    </xsl:template>
    
    <!-- This template creates a single entry in the ToC for each sonnet 
    referencing the sonnet's number and the text of its first line -->
    <xsl:template match="sonnet" mode="toc">
        <li><xsl:text>Sonnet </xsl:text> 
            <xsl:value-of select="@number"/><xsl:text>. </xsl:text>
            
            <xsl:apply-templates select="line[1]" mode="toc"/>
        </li>
    </xsl:template>
    
    <!-- This template reproduces the text of a (first) line of each sonnet 
         referenced by the above template -->
    <xsl:template match="line" mode="toc">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- This template references and formats the sonnet's number to be its title, 
        and then references and places the text of each sonnet inside paragraphs -->
    <xsl:template match="sonnet">
        <h2><xsl:text>Sonnet </xsl:text><xsl:apply-templates select="@number"/>
        </h2>
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- This template reproduces the text of each sonnet, with line-breaks, 
        referenced inside the paragraphs of the above template -->
    <xsl:template match="line">
        <xsl:apply-templates/>
        <!-- This xsl-if statement tests for the presence of a next line, 
            since the last line needs no line-break -->
        <xsl:if test="following-sibling::line">
            <br/>
            <!-- Optional new-line in HTML: <xsl:text>&#x0a;</xsl:text> -->
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
