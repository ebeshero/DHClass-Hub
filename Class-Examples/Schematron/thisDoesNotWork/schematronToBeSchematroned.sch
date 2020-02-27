<?xml version="1.0" encoding="UTF-8"?>
<?xml-model href="schematronOnSchematron.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
        
        <sch:ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>
        <sch:pattern>
            <sch:rule context="tei:head/tei:date" role="error">
                <sch:assert test="matches(., '^[MWF]')">Hey! Make sure you start with a M W or F.</sch:assert>
                <sch:report test="matches(., '^[ a-z]')">This alarm is going off because you started with a lower case letter or a white space! </sch:report>
                
            </sch:rule>
            
        </sch:pattern>
        
    </sch:schema>
