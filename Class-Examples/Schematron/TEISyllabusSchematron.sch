<?xml version="1.0" encoding="UTF-8"?>
<schema queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    <pattern>
     <rule context="tei:head/tei:date">
            <assert test="matches(., '^[MWF]')">Hey! Make sure you start with a M W or F.</assert>
         <report test="matches(., '^[ a-z]')">This alarm is going off because you started with a lower case letter or a white space! </report>

     </rule>
   
    </pattern>

</schema>