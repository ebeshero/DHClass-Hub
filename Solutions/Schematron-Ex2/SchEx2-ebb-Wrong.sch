<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
 <!--ebb: This schema won't work: it fires an error on the last article content, even when all the content is the appropriate length.
Can you tell why it won't work? -->
    <pattern>
        <rule context="content"> 
           <assert test="following::content/string-length(normalize-space()) &lt;= ./string-length(normalize-space()) div 2">
               This article breaks our length rule, because it is more than half of size of the previous article..
            </assert>
        </rule>
    </pattern>
    
</schema>