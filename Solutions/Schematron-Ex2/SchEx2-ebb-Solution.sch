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