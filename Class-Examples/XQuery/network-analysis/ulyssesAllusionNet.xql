xquery version "3.1";
(: Co-occurrence network of mentioned writers/artists/famous people in Joyce's Ulysses that show up in the same holding elements together. :)
declare variable $ThisFileContent:= string-join(

let $ulyssesColl := collection('/db/ulysses/ulysses/')
let $allus := $ulyssesColl//allusion/@persName/string()
let $distAllus := $allus => distinct-values()
for $d in $distAllus
let $parentContext := $ulyssesColl//*[child::allusion/@persName/string() = $d]/name() => distinct-values()
for $p in $parentContext
let $countP := $ulyssesColl//*[./name() = $p and child::allusion/@persName = $d] => count()
(:  :let $otherRefs := $ulyssesColl//*[./name() = $p and child::allusion/@persName = $d]/reference/@to/string() :)
let $otherAllus := $ulyssesColl//*[./name() = $p and child::allusion/@persName = $d]/allusion/@persName[string() != $d]
(:  :let $distORs := $otherRefs => distinct-values() :)
let $distOAs := $otherAllus => distinct-values()
for $o in $distOAs
order by $countP descending
return concat($d(:source node:), "&#x9;"(:tab character:), $p(:shared interaction or edge:), "&#x9;", $countP, "&#x9;", $o (:target node:)), "&#10;") ;

let $filename := "ulyssesAllusionNet.tsv"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: NOTE: for generating plain text output (.txt, .csv, or .tsv), you need to add "text/plain" to the xmldb:store function. 
 : The lines above create a filename and a filepath, and apply the eXist database function xmldb:store() to bundle 
 : these together with our XQuery-generated file content to create a new document and store it to the database. :)
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/ulyssesAllusionNet.tsv :)     