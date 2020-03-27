xquery version "3.1";

declare variable $ThisFileContent := string-join(
let $pokemon := collection('/db/2020_ClassExamples/pokemonQGIS')
let $types := $pokemon//typing/@type
let $distTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ') => distinct-values()
for $d in $distTypes 
let $locations := $pokemon//landmark
let $locsMatch := $locations[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@n/string()
let $distLM := $locsMatch => distinct-values()
for $l in $distLM
let $lat := $pokemon//landmark[preceding::typing/@type ! upper-case(.)[contains(.,$d)]][@n = $l]/@lat => distinct-values()
let $lon := $pokemon//landmark[preceding::typing/@type ! upper-case(.)[contains(.,$d)]][@n = $l]/@lon => distinct-values()
return string-join(($d, $l, $lat, $lon), "&#x9;")
, "&#10;");

let $filename := "qgis_1_test.tsv"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/qgis_1_test.tsv :)  