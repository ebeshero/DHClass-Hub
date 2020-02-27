<?xml version="1.0" encoding="UTF-8"?>
<sch:schema
    xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    
    <sch:ns uri="http://purl.oclc.org/dsdl/schematron" prefix="sch"/>
    <sch:pattern>
     <sch:rule context="sch:rule" role="warning">
            <sch:assert test="@role='info'">There must only be a role of 'info' set on the Schematron rule.</sch:assert>
       
     </sch:rule>
   
    </sch:pattern>

</sch:schema>