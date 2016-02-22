<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">

  <pattern>
      <rule context="results">
          <assert test="sum(place) eq 100">
              The sum of the votes for all places must add up to 100!
          </assert>
          <assert test="count(place) eq 4">
              There should be four different place elements in results.   
          </assert>
      </rule>
 
  </pattern> 
    
    <pattern>
        <rule context="place">
            <assert test="number(.) ge 0 and number(.) le 100">
                Each number in the place elements should be between zero and 100.
            </assert>
        </rule>
        
    </pattern>
</schema>