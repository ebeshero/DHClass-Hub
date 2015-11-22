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
                <link rel="stylesheet" type="text/css" href="WSGA.css"/>
                <script type="text/javascript" src="WSGA.js">/**/</script>
            </head>
            <body>
                <h1>Sanitary Conditions of Workshops and Factories in New York City</h1>
                <h2>Graph with Table Results</h2>
                <div id="svg">
                    <xsl:comment>ebb: We'll paste in the results of the other XSLT to SVG here. We'll tinker with that SVG to make it 
                        share space with a table of survey results on the right.</xsl:comment>
                </div>
                
           <div id="Tables">  <!--<h2>Table 1: Yes or No Questions</h2>  -->
               <span class="instructions">Click on a bar on the graph to see the numerical breakdown of responses for each survey question.
               Scroll down for more survey questions and response data, and a view of the original 19th-century survey results.
               </span>
               
               <table id="graphData">
               <xsl:comment>ebb: We'll align this table to the right of the SVG.</xsl:comment> 
                   <tr>
                      <th class="id">Survey Id</th>
                       <th class="table1Question">Question</th>
                       <th class="Yes">Yes</th>
                       <th class="Yes_but_fined">Yes, but fined</th>
                       <th class="No">No</th>
                       <th class="Blank">Blank</th>
                       <th class="Total">Total Responses</th>
                       
                   </tr>
                    <xsl:apply-templates select="//fs[f[@name='response'][@select='Yes']]"/>
                </table>
          
               <hr/><hr/> 
                <div id="otherTables">
<h2>Other Survey Questions:</h2>
   <h3>Sources of Offensive Odors</h3>
                <table id="T2">
                   <tr>
                       <th>Survey Id</th>
                     <th>Question</th>
                    <th>Water Closet</th>
                    <th>Other Sources</th>
                     <th>Total Responses</th>
                   </tr>
                    <xsl:apply-templates select="//fs[f[@name='response'][@select='water_closet']]"/>
                </table>
                
                <h3>Standing or Sitting at Work</h3>
                <table id="T3">
                    <tr>
                        <th>Survey Id</th>
                        <th>Question</th>
                        <th>Sit</th>
                        <th>Stand</th>
                        <th>Optional</th>
                        <th>Blank</th>
                        <th>Total Responses</th>
                    </tr>
                   <xsl:apply-templates select="//fs[f[@name='response'][@select='Sit']]"/>
                </table>
           </div>
           </div>
                <img src="originalWSGAch1_table.jpg" alt="19th-century survey data"/>
            </body>            
        </html>
    </xsl:template>
    
   <xsl:template match="fs[f[@select='Yes']]">
       <tr id="{@xml:id}">
           <!--2015-11-20 ebb: I used an Attribute Value Template here to grab the (new) @xml:id from each fs. 
               Now our table rows will preserve the unique identifiers for each question. -->
         <!--  <td><xsl:value-of select="count(./preceding-sibling::fs[f[@select='Yes']]) + 1"/></td>-->
          
           <td class="id"><xsl:value-of select="@xml:id"/></td>
           <td class="table1Question"><xsl:apply-templates select="f[@name='question']"/></td>
           <td class="Yes"><xsl:apply-templates select="f[@select='Yes']/@n"/></td>
           <td class="Yes_but_fined"><xsl:apply-templates select="f[@select='Yes_but_fined']/@n"/></td>
           <td class="No"><xsl:apply-templates select="f[@select='No']/@n"/></td>
           <td class="Blank"><xsl:apply-templates select="f[@select='Blank']/@n"/></td>       
           <td class="Total"><xsl:text></xsl:text><xsl:value-of select="sum(f/@n)"/></td>
          
       </tr>
   </xsl:template>
    
 
<xsl:template match="fs[f[@select='water_closet']]">

        <tr id="T2{@xml:id}">
            <td class="id"><xsl:value-of select="@xml:id"/></td>
            <td class="question"><xsl:apply-templates select="f[@name='question']"/></td>
        <td class="water_closet"><xsl:apply-templates select="f[@select='water_closet']/@n"/></td>
        <td class="other_causes"><xsl:apply-templates select="f[@select='other_causes']/@n"/></td>
        <td class="Total"><xsl:value-of select="sum(f/@n)"/></td></tr>
    </xsl:template>
    
    <xsl:template match="fs[f[@select='Sit']]">
     <tr id="T3{@xml:id}">
         <td class="id"><xsl:value-of select="@xml:id"/></td>
         <td class="question"><xsl:apply-templates select="f[@name='question']"/></td>
        <td class="sit"><xsl:apply-templates select="f[@select='Sit']/@n"/></td>
        <td class="stand"><xsl:apply-templates select="f[@select='Stand']/@n"/></td>
        <td class="optional"><xsl:apply-templates select="f[@select='Optional']/@n"/></td>
        <td class="Blank"><xsl:apply-templates select="f[@select='Blank']/@n"/></td>
        <td class="Total"><xsl:text></xsl:text><xsl:value-of select="sum(f/@n)"/></td>
     </tr>
        
    </xsl:template>
</xsl:stylesheet>   
