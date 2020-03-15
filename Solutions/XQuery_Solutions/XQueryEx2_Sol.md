## XQuery Exercise 2 Solution

1. Get a count of the number of files in the collection: 
``
collection('/db/pokemonMap/pokemon') => count()
``
1. Take the base-uri(), tokenize the filepath, and return only the filename with:
``
collection('/db/pokemonMap/pokemon')/base-uri() ! tokenize(., '/')[last()]
``
1. 
  * a. Return the entire Pokemon XML files by visiting the root node for each one (the child of the document node): 
``
collection('/db/pokemonMap/pokemon')/*
``
This returns xml documents like this one (the first one): 
```xml
<pokemon> 
   <info> <dexNum num="001">001</dexNum>
   <name>Mbulbasuar</name> 
   <typing type="Grass Poison">Grass Poison</typing> </info> 
   <locations> 
     <landmark n="Pallet Town">Pallet town<lvl min="5" max="5">level 5</lvl> </landmark> 
   </locations> 
</pokemon>
```

  * b. The `<typing>` element and `@type` attribute hold the pokemon type. 
  * c. The `<landmark>` element and `@n` attribute hold the location information.
  * d. To navigate from `<typing>` to `<name>`, use the `preceding-sibling::` axis like this:

`` collection('/db/pokemonMap/pokemon')//typing/preceding-sibling::name
``
  * e.  To go from `<landmark>` to `<type>` (as we will need to do below in our for-loop), you need to start on the `preceding::` axis, like so, and then move to the `attribute::` axis: 

``
collection('/db/pokemonMap/pokemon')//landmark/preceding::typing/@type
``  
4. FLWOR statement to output strings:   

```
(:  :declare variable $pokemon as document-node()+ := collection('/db/pokemonMap/pokemon'); :)
let $pokemon := collection('/db/pokemonMap/pokemon')
let $types := $pokemon//typing/@type

(: Some Pokemon have multiple types, 
coded in the typing/@type as a white-space-separated list. 
A few of these have commas in them, so along the way, we'll trim those out and get rid of any extra white
spaces before taking distinct-values(). :)

let $distTypes := $types ! upper-case(.) ! normalize-space() ! tokenize(., ' ') => distinct-values()

(: Now it's time for the for-loop. 
Let's walk through each type one by one 
and see if we can match them up to names of Pokemon 
and locations for Pokemon. 
We can create a directory of Pokemon types this way. :)

for $d in $distTypes
let $names := $pokemon//name
let $namesMatch := $names[following-sibling::typing/@type ! lower-case(.)[contains(., $d)]]
let $locations := $pokemon//locations/landmark
let $locsMatch := $locations[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@n/string()
let $distLM := $locsMatch => distinct-values()
return concat($d, ' : where: ', string-join($distLM, '! '))
```

6. Amped up FLWOR to output HTML:
```xml
<html>
    <head><title>Pokemon Types and Locations</title></head>
    <body> 
        <h1>Where to Find Pokemon by Type</h1>
    <table>
        <tr><th>Type</th><th>Locations</th></tr>
{
let $pokemon := collection('/db/pokemonMap/pokemon')
let $types := $pokemon//typing/@type
(: Some Pokemon have multiple types, coded in the typing/@type as a white-space separated list. A few of these have commas in them, so along the way, we'll trim those out and get rid of any extra white spaces before taking distinct-values(). :)
let $distTypes := $types ! upper-case(.) ! substring-before(., ',') ! normalize-space() ! tokenize(., ' ') => distinct-values()
(: Now it's time for the for-loop. Let's walk through each type one by one and see if we can match them up to names of Pokemon and locations for Pokemon. We can create a directory of Pokemon types this way. :)
for $d in $distTypes
let $names := $pokemon//name
let $namesMatch := $names[following-sibling::typing/@type ! upper-case(.)[contains(., $d)]]
let $locations := $pokemon//locations/landmark
let $locsMatch := $locations[preceding::typing/@type ! upper-case(.)[contains(., $d)]]/@n/string()
let $distLM := $locsMatch => distinct-values()
return 
  (:  concat($d, ' : where: ', string-join($distLM, ', ')) :)
    <tr>
       <td>{$d}</td>
       <td>{string-join($distLM, ', ')}</td> 
    </tr>
}
</table></body>
</html>
```

For more, including an example of how to apply global variables to save your output to our database and view it as a webpage in the browser, see the 2019_ClassExamples directory in [newtfire's eXist-db](http://newtfire.org:8338).