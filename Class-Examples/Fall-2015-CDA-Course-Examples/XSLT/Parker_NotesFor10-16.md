Refer to the [XSLT Intro!](http://newtfire.org/dh/explainXSLT.html)
In class examples from [ForsterGeorgComplete.xml](https://raw.githubusercontent.com/ebeshero/DHClass-Hub/master/Class-Examples/XSLT/ForsterGeorgComplete.xml)


Applications of XSLT   

1. IDENTITY TRANSFORMATION - takes a file's identity and transforms a piece of it (ie. renaming elements, adding elements) A REPRODUCTION OF THE ORIGINAL FILE! 

2. Transorm it into a different file type (a HTML file)!


XSLT designates different steps on the tree. The xpath used in XSLT tells us where we are in the tree. 


Open a new XSLT stylesheet:

`xmlns:xsl="http://www.w3.org/1999/XSL/Transform"` this is saying how to transform .. Leave it always!!

`xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">` 

we change in here to define a namespace... need to add a line say XPath this source document is TEI so when you do the transformation XSLT know you are working with TEI 

for TEI need to add this line `xpath-default-namespace="http://www.tei-c.org/ns/1.0"`

Also we sometimes need to define specifics about what we are outputting 

to output html you will need this line `xmlns="http://www.w3.org/1999/xhtml"`

THIS IS ALL DETAILED ON THE INTRO AND IN EACH HOMEWORK ASSIGNMENT!!! DON'T NEED TO MEMORIZE JUST NEED TO UNDERSTAND WHAT EACH LINE MEANS.

Copy and paste the example completed stylesheet from the Intro.

Practice running a transformation ... notice we have a new screen setup click the XSLT screen setup located at the top right of the oXygen window.

It is important that you have the right files specified for xml and xslt especially if you have multiple files open in oXygen. Make sure you change from Saxon 6.5.5 to Saxon-PE 9.6.05 or Saxon-EE 9.6.05!

Use the arrows to run the transformation ... we favor the last arrow which transforms till the end (that is the arrow with the curly brace).

To see the HTML view click the `</>`HTML button that comes after the output box so you can see the text generated and a preview of the html output. 

Save the results by right clicking the output from the third window and reopen it in oxygen to check for valid, well-formed HTML. (Using the files we specified won't get you well-formed HTML, but this was just practice doing transformations)

What the stylesheet says: much better description in the Intro to XSLT

First `<xsl:template match="/">` go to the beginning of the xml document all the way to the root

First `<xsl:apply-templates select="//text/body//div[@type=’chapter’]"/>` -- being selective grab only this specific part of the source document and output it here inside of the html 

the first `<xsl:template match="/">` closes

the second <xsl:template match="div[@type='chapter']"> says find and match on this part of the xml (in context)

the second `<xsl:apply-templates select="head/l"/>` and third `<xsl:apply-templates select=".//placeName"/>` sits inside of html tags relating what you want xslt to grab from source document, how you want what is selected to sit in the html hierarchy and the apply-templates says go and process what is selected

the second `<xsl:template match="div[@type='chapter']">` closes






 







