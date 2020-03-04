xquery version "3.1";
declare variable $ThisFileContent:= string-join(  
let $banksyColl := collection('/db/banksy/XML/')
let $titles := $banksyColl//sourceDesc//title[string-length(.) gt 0]
(: ebb: Some of the banky title elements are empty, so I screened those out with the predicate filter above. :)
for $t in $titles
let $edge:=
         if ($t/following-sibling::location[contains(., 'London')]) 
                              then "London"
         else if ($t/following-sibling::location[contains(., 'New York')]) 
                              then "New York"
         else "other place"
let $medium := $t/following-sibling::medium/@type
return
concat($t(:source node:), "&#x9;"(:tab character:), $edge(:shared interaction or edge:), "&#x9;", $medium(:target node:)), "&#10;") ;

let $filename := "banksySimpleNet.tsv"
let $doc-db-uri := xmldb:store("/db/2019_ClassExamples", $filename, $ThisFileContent, "text/plain")
return $doc-db-uri 
(: NOTE: for generating plain text output (.txt, .csv, or .tsv), you need to add "text/plain" to the xmldb:store function. 
 : The lines above create a filename and a filepath, and apply the eXist database function xmldb:store() to bundle 
 : these together with our XQuery-generated file content to create a new document and store it to the database. :)
(: Output at http://newtfire.org:8338/exist/rest/db/2019_ClassExamples/banksySimpleNet.tsv :)     
