<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
<pattern><title>Sanity checking the geo data in Banksy</title>
    <rule context="location[contains(., 'AU')]">
        <assert test="number(@lat) lt 0"><!--ASSERT means, AFFIRM that this condition is true. If it is VIOLATED, send out this error message!  -->
            All locations in Australia should have a latitude that is a negative value.</assert>
        <report test="number(@long) lt 0"><!--REPORT says, SEND OUT THIS ERROR MESSAGE IF THIS CONDITION IS TRUE! -->
            All locations in Australia should have a LONGITUDE that is a positive value.</report>
    </rule>
    
    
    
</pattern>
    
    
</schema>