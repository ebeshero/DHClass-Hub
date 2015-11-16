<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <pattern>
        <rule context="content[preceding::content]">
            <report test="preceding::content/string-length() &lt; (2 * ./string-length())">
               This article breaks our length rule, because it is more than half of size of the previous article..
            </report>
        </rule>
    </pattern>
</schema>

<!--2015-11-08 ebb: Our solution might be surprising because we didn't try to locate the content that *follows* the first article.
    We instead set as our rule context, the content elements *that have preceding content elements*. That way, we only select content
    elements that we require to have a set length by comparison with earlier elements. We don't bother trying to locate or deal with
    the very first content element, and in fact we want to exclude it from our rule, 
    because first article can be as long as the author wants it to be!
    
    Having set our context, we set a report test, which returns a message *if the test condition we describe is being met.*
    We want to know whenever one of the content elements we've indicated as our rule context breaks our length rule, which is that
    it is over half the size of the preceding article. For this we used the XPath string-length() function, which counts the characters
    in a string of text and returns a number. We decided to write this as simply as we could, 
    so instead of dividing the preceding::content by two and calling a report whenever the current context is greater than that, we wrote it
    the opposite way so we only have to multiply. We indicated that the preceding::content just needs to be less than 2 times the 
    string-length() of the current content. Simple arithmetic operations are useful in Schematron and other kinds of processing we're
    doing at this point in our course, so you'll want to look up how to write addition, subtraction, multiplication, division, as well
    as comparisons like greater than, or greater than and equal to. 
   You can find this in the Michael Kay book if you have it, or on the web. Here's a good web resource: http://www.w3schools.com/xsl/xpath_operators.asp
    
If you didn't already do this with your own solution, you might try writing your Schematron rule the opposite way, to divide the preceding::content by two, and see if you can rewrite the rule to make
    it report as we want it to. 
    
    -->