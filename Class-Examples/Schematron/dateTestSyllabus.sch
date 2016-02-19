<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
 <pattern>
   <rule context="tei:div[@type='day'][preceding-sibling::tei:div[@type='day']]">
         <assert test="xs:date(.//tei:date/@when) gt xs:date(preceding-sibling::tei:div[@type='day'][1]//tei:date/@when)">
             The date inside a div designating a day on this syllabus must be later than the immediately preceding day on the syllabus.
         </assert>
         
     </rule>

 </pattern>
    
</schema>
