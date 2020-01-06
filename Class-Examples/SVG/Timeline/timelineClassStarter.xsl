<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.w3.org/2000/svg"  
    exclude-result-prefixes="xs"
    version="3.0">
    <!--2018-11-25 ebb: This XSLT is designed to generate a timeline in SVG from the dates marked in a collection of XML files from the World War Letters project. NOTE: These were not coded in TEI. (To adapt for a TEI project, add the xpath-default-namespace to the xsl:stylesheet root element above.) -->
    <xsl:variable name="lettersColl" as="document-node()+" select="collection('letters/?select=*.xml')"/>
    <!--ebb: This variable points to the directory of files we want to process, using the XPath collection() function to point only to the files with .xml extensions. This XSLT file is saved together with that directory, so the files inside the directory are a level just below the XSLT. -->
    
    
    <xsl:template match="/">
        <xsl:for-each select="$lettersColl//abstract">
            
            <!--ebb: First we'll just survey what we've got. Filenames, data in the <abstract> element? Let's take a look, and output the info in comments.  
     We'll start by defining a lot of variables and testing them in xsl:comments as our "scratchpad".
     -->
      <!--Let me take a look at info on people, and which filenames are mentioning them, and make sure I'm reaching birth dates and death dates with my XPath. In xsl:for-each if I use the position() function it'll count the position of each turn of the for-each, so I can get a sense of how much data I'm processing (how many things are in the for-each series).
      -->      
            <xsl:comment>
                <xsl:value-of select="position()"/>. Filename: <xsl:value-of select="tokenize(base-uri(), '/')[last()]"/>
               Birth Date: <xsl:value-of select="persName/@born"/>
                
              Death Date: <xsl:value-of select="persName/@death"/>
                
         </xsl:comment>
        </xsl:for-each>
        <!--ebb: WHERE ARE THE DATES WE WANT TO PLOT? 
            Then, what's the earliest date and what's the latest date? 
            First, let's define a variable that catches all the dates we want to plot. Then let's isolate the years to determine the earliest and the latest. -->
        
        
        
        
        
       
            
            

        
    </xsl:template>
    
    
</xsl:stylesheet>