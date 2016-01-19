<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math" exclude-result-prefixes="xs math"
    xmlns="http://www.w3.org/1999/xhtml" version="3.0">

    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    <xsl:variable name="nelsonColl" select="collection('.//spadafore_nelsonArticles_XML')"/>
    <!-- this is the assignment we need to make the XSLT for-each-group tutorial out of -->
    <!-- ras: This is working over a batch of files that I modified (for consistency in my xslt table of contents) from the Nell Nelson Project -->

    <xsl:template match="/">

        <html>
            <head>
                <title>Nelson Article Dialogue XSLT 7</title>
                <link rel="stylesheet" href="spadafore_11-02_XSLT7.css" type="text/css"/>
            </head>
            <body>
                <div id="title">
                    <h1>Nell Nelson: Dialogue and Elements</h1>
                </div>
                <br/>

                <div id="toc">
                    <h2>Chicago Times</h2>
                    <ul>
                        <xsl:apply-templates select="$nelsonColl//newspaperTitle/date" mode="toc"/>
                        <!-- ras: Sets up a linked toc, like our last hw -->
                    </ul>
                </div>
                
                <!--ebb: The following block of code with <xsl:for-each-group> outputs your index of element names and counts, using xsl:for-each-group. Here is how this works:
                <xsl:for-each-group> has to take an @select attribute that points to something you want to organize into groups, and an attribute (usually @group-by) that establishes how you want to group them (called the grouping key).
               In this case we want to group all the elements inside articleBody in the Nelson Collection. And we want to group them by their element names. We don't have to take distinct-values() because 
               xsl:for-each-group does that *for* us: It makes groups based on the distinct values of the thing you've designated as your grouping key.
              
              You first establish WHAT you want to group, and HOW you want to group it in those attributes on <xsl:for-each-group>. Then you set up an <xsl:for-each> to nest inside the for-each-group, and you set its select either to the current group or its current-grouping-key, depending on what you are processing. 
              
              When sorting in an <xsl:for-each-group>, you position your <xsl:sort> ABOVE the <xsl:for-each> (which makes sense, because you're processing each group-of-something in turn inside that for-each statement). In the code here, I've created a couple of different ways you could sort your groups, and notice how I've set them up. Notice I've set the output and the sorting to be based on the "current-grouping-key()" rather than the "current-group()". The current-grouping-key() is the part that takes the distinct-values of something you designate, and that's what you want to output here: the distinct-values of the element names inside articleBody.
              
              To get the counts of all the elements that match the current-grouping-key() I have to map that key back onto the XML tree. I have to say, get me a count of how many times we see an element that *has a name equal to the current-grouping-key()*. That is because the grouping does the same things as taking distinct-values: It pulls the element nodes out of their context in the XML hierarchy. To count their instances, we need to go back and look them up on the tree. 
               
              What's Really Helpful about this syntax is that it's designed to keep things simple for XSLT coders, so we don't have to pile on as many functions to process groups (no need to take distinct-values at all). It's such a common phenomenon to want to group things using XSLT that there's a whole XSLT function that processes this sort of thing.-->
                <h3>Elements:</h3>
                <ul>
                    <xsl:for-each-group select="$nelsonColl//articleBody//*" group-by="$nelsonColl//articleBody//*/name()">
                        <!--<xsl:sort select="current-grouping-key()"/>-->
                        <!--ebb: If you want to sort alphabetically by element name, uncomment the above. Here I've set the sort to list the elements based on how many times they are used.-->
                        <xsl:sort select="count($nelsonColl//articleBody//*[name() eq current-grouping-key()])" order="descending"/>
                        <xsl:for-each select="current-grouping-key()">
                            <li>
                            <xsl:value-of select="current-grouping-key()"/><xsl:text>, Count:</xsl:text>
                          <xsl:value-of select="count($nelsonColl//articleBody//*[name() eq current-grouping-key()])"/>
                        </li>
                        </xsl:for-each>

                    </xsl:for-each-group>
                   
                </ul>
                
                <xsl:apply-templates select="//articleBody/*" mode="dialogue"/>
                
                
                

                <hr/>

                <xsl:apply-templates select="$nelsonColl//newspaperTitle/date" mode="main"/>
                <!-- ras: Adds title/link to body entries -->
            </body>
        </html>

    </xsl:template>












    <xsl:template match="newspaperTitle/date" mode="toc">
        <!-- ras: match: date toc- adds @href, <li> and <a> -->
        <li>
            <a href="#issue{//newspaperTitle/date}">
                <xsl:apply-templates/>
            </a>
        </li>
    </xsl:template>




    <xsl:template match="newspaperTitle/date" mode="main">
        <!-- ras: match: date main- adds @id, <h3>, list of distinct-values, dialogue -->
        <div>
            <h2 id="issue{.}">
                <strong>
                    <xsl:apply-templates/>
                </strong>
            </h2>

                   </div>
        <br/>
    </xsl:template>




    <xsl:template match="articleBody//*" mode="dialogue">
        <!-- ras: match: all elements in articleBody, outputs dialogue for masc, fem, and Nell Voice -->
        <xsl:choose>
            <xsl:when test="femVoice">
                <h3>femVoice:</h3>
                <sp who="femVoice">
                    <xsl:apply-templates select="."/>
                </sp>
                <br/>
                <br/>
            </xsl:when>
            <xsl:when test="mascVoice">
                <h3>mascVoice:</h3>
                <sp who="mascVoice">
                    <xsl:apply-templates select="."/>
                </sp>
                <br/>
                <br/>
            </xsl:when>
            <xsl:when test="nellVoice">
                <h3>nellVoice:</h3>
                <sp who="nellVoice">
                    <xsl:apply-templates select="."/>
                </sp>
                <!-- This doesn't catch all instances of nellVoice; it ignores any occurance where there is an attribute with the element.
                        This is a problem with the initial coding of the documents and would be a non issue if the documents were fixed to
                        represent TEI standards. (my dialogue proposal on the citySlaveGirls issues board would fix this) -->
                <br/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>









</xsl:stylesheet>
