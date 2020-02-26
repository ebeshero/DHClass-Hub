xquery version "3.1";

declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon');
declare variable $ThisFileContent as element() := 
<html>
    <head><title>Pokemon Types and Locations</title></head>
    <body> 
        <h1>Where to Find Pokemon by Type</h1>
    <table>
        <tr><th>Type</th><th>Routes</th></tr>
{

let $types := $pokemon//typing/@type
let $distTypes := $types ! upper-case(.) ! tokenize(., ',')[1] ! normalize-space() ! tokenize(., ' ') => distinct-values()
for $d in $distTypes 
let $routes := $pokemon//route
let $routesMatch := $routes[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@num/string()
let $distRM := $routesMatch => distinct-values()
return  (: concat($d, ' : Routes Found On : ', string-join($distRM, ', ')) :)

    <tr>
       <td>{$d}</td>
       <td>{string-join($distRM, ', ')}</td> 
    </tr>
}
</table></body>
</html>
;

let $filename := "class_example_pokemon_routes_1.html"
let $doc-db-uri := xmldb:store("/db/frc23", $filename, $ThisFileContent)
return $doc-db-uri
(: The lines above create a filename and a filepath, and apply the eXist database function xmldb:store() to bundle these together with our XQuery-generated file content to create a new document and store it to the database. :)
(: Output at http://newtfire.org:8338/exist/rest/db/frc23/class_example_pokemon_routes_1.html :)  