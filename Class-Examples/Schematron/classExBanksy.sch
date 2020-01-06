<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <pattern>
        <rule context="desc">
            <report test="contains(., 'Bnanksy')">PLEASE try to spell the artist's name correctly, will you????!!!! </report>
        </rule>
    </pattern>

</schema>