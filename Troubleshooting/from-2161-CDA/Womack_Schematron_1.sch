<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <pattern>
        <rule context="//stooge">
            <assert test="@name[matches(.,'Larry')]|@name[matches(.,'Moe')]|@name[matches(.,'Curly')]">The names in the stooge elements must be either larry, moe, or curly</assert>
        <assert test="count(xsd:int)=100"></assert>
        </rule>
    </pattern>
   
</schema>