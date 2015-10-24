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
    <!--ebb: Stylesheet template must be updated to match on TEI and output XHTML-->
    <xsl:template match="/">
        <html>
            <head>
                <title>Sanitary Conditions of Workshops and Factories in New York City</title>
            </head>
            <body>
                <h1>Sanitary Conditions of Workshops and Factories in New York City</h1>
             <h2>Table 1: Yes or No Questions</h2>  <table>
                    <tr>
                        <th>Number</th>
                        <th>Question</th>
                        <th>Yes</th>
                        <th>Yes, but fined</th>
                        <th>No</th>
                        <th>Blank</th>
                        <th>Total Responses</th>
                      <!--  
                        <th>Stand</th>
                        <th>Water Closets</th>
                        <th>Other Causes</th>
                        <th>Optional</th>
                      -->
                        
                    </tr>
                    <xsl:apply-templates select="//fs[f[@name='response'][@select='Yes']]"/>
                </table>
                
                <h2>Table 2: Sources of Offensive Odors</h2>
                <table>
                   <tr>
                     <th>Question</th>
                    <th>Water Closet</th>
                    <th>Other Sources</th>
                     <th>Total Responses</th>
                   </tr>
                    <xsl:apply-templates select="//fs[f[@name='response'][@select='water_closet']]"/>
                </table>
                
                <h2>Table 3: Standing or Sitting at Work</h2>
                <table>
                    <tr>
                        <th>Question</th>
                        <th>Sit</th>
                        <th>Stand</th>
                        <th>Optional</th>
                        <th>Blank</th>
                        <th>Total Responses</th>
                    </tr>
                   <xsl:apply-templates select="//fs[f[@name='response'][@select='Sit']]"/>
                </table>
            </body>            
        </html>
    </xsl:template>
    
   <xsl:template match="fs[@type='QandA'][f[@select='Yes']]">
       <tr>
           <td><xsl:value-of select="count(./preceding-sibling::fs[f[@select='Yes']]) + 1"/></td>
           <td><xsl:apply-templates select="f[@name='question']"/></td>
           <td><xsl:apply-templates select="f[@select='Yes']/@n"/></td>
           <td><xsl:apply-templates select="f[@select='Yes_but_fined']/@n"/></td>
           <td><xsl:apply-templates select="f[@select='No']/@n"/></td>
           <td><xsl:apply-templates select="f[@select='Blank']/@n"/></td>       
           <td><xsl:text></xsl:text><xsl:value-of select="sum(f/@n)"/></td>
           <!--ebb: Here is a story about the need for simplicity, about Why it's best to use the sum() function here, though other
               solutons are available:
               Our first instinct was to write this as a simple arithmetic, adding a series of the attribute numbers on each f element one based on its @select value.
           It looked like this (and this is Problematic Code, so don't copy it! We're including it by way of illustration of How to Solve a Problem: 
           
           <td><xsl:value-of select="f[@select='Yes_but_fined'] + f[@select='Yes']/@n + f[@select='No']/@n + f[@select='Blank']/@n"/></td>
           
           And this was problematic and stopped the output when we ran our transformation, because not every f element has an @select="Yes_but_fined". We could write an xsl:conditional
           statement to deal with that problem, to test for a case where this attribute exists, and where it does, to add it to the output, and where it does not to base the calculation on 
           the values on f elements with 'Yes', 'No', and "Blank' attribute values, and that would probably work but would take several lines
           more code. 
           Our much simpler solution shows the virtues and powers of the sum() function: 
           We are simply adding up all of the @n attributes on all of the f elements inside fs, *wherever they sit*, and
           adding them up. This always works, and is transferrable to each of our other template rules for the other two tables. 
           And we don't have to go hunting to make sure we are including every possible attribute and assessing the conditions for it. 
           -->
       </tr>
   </xsl:template>
    
    <xsl:template match="fs[@type='QandA'][f[@select='water_closet']]">
        <tr><td><xsl:apply-templates select="f[@name='question']"/></td>
        <td><xsl:apply-templates select="f[@select='water_closet']/@n"/></td>
        <td><xsl:apply-templates select="f[@select='other_causes']/@n"/></td>
        <td><xsl:value-of select="sum(f/@n)"/></td></tr>
    </xsl:template>
    
    <xsl:template match="fs[@type='QandA'][f[@select='Sit']]">
     <tr><td><xsl:apply-templates select="f[@name='question']"/></td>
        <td><xsl:apply-templates select="f[@select='Sit']/@n"/></td>
        <td><xsl:apply-templates select="f[@select='Stand']/@n"/></td>
        <td><xsl:apply-templates select="f[@select='Optional']/@n"/></td>
        <td><xsl:apply-templates select="f[@select='Blank']/@n"/></td>
        <td><xsl:text></xsl:text><xsl:value-of select="sum(f/@n)"/></td>
     </tr>
        
    </xsl:template>
</xsl:stylesheet>   
