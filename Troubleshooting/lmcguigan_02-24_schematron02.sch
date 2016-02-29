<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
    
<pattern>
    <rule context="tei:app">
        <report test="not(tei:rdg[@wit])">
            element rdg can not have an attribute other than wit
        </report>
        
    </rule>
</pattern>
    
    <pattern>
        <rule context="tei:app">
            <assert test="count(tei:rdg) ge 1">
                element app must have at least on rdg element
            </assert>
        </rule>
    </pattern>



</schema>
