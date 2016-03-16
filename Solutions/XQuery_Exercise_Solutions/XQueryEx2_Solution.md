# XQuery Exercise 2

  1.  
````
declare default element namespace "http://www.tei-c.org/ns/1.0";
count(collection('/db/mitford')/TEI/base-uri())
````

Returned: 99

  2. 
````
xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
collection('/db/mitford')/*
````
This returns the XML of all 99 files in the collection! Because we have coded them consistently, we can always find a special `<titleStmt>` element in the same place in each file, and that makes it easy for us to retrieve all the main titles of each file. We can see that `<titleStmt>`is a grandchild of the `<teiHeader>`, and that it has a child element, `<title>` which contains that main title. 

  3. 
````
xquery version "3.0";
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $coll := collection('/db/mitford')
let $allBodies := $coll/*//body
let $docTitles := $coll//teiHeader//titleStmt/title/string()
return $docTitles
````
Note: We CANNOT use `text()` here because that misses the coded text inside the `<title>` elements. So we use `string()` instead, and this returns 100 results now instead of the 99 we got previously. That's because one file in this collection actually has *two* title elements sitting in its `<titleStmt>` For a bonus challenge, we invited you to write XQuery to locate and identify the culprit file. Here's how we did that:

````
declare default element namespace "http://www.tei-c.org/ns/1.0";
let $coll := collection('/db/mitford')/*
let $docTitles := $coll//teiHeader//titleStmt/title/string()
for $file in $coll 
let $fileTwoTitles := $file[count(.//teiHeader//titleStmt/title) gt 1]
return $fileTwoTitles

````

  4. Here is how we located the distinct values of `@ref` attributes, and then tested each one to see which were referred to in more than 15 files in the Mitford collection. We used the `tokenize()` function to trim off the hashtag at the beginning of the @ref attribute, but we only did it in the very last step. You might have done that in an earlier stage and the results would still work. 
````
let $coll := collection('/db/mitford')/*
let $docBodies := $coll//body
let $docTitles := $coll//teiHeader//titleStmt/title/string()
let $allPeeps := $docBodies//persName/@ref/string()
let $distinctPeeps := distinct-values($allPeeps)
for $peep in $distinctPeeps
let $FilesHoldingPeep := $docBodies[.//persName[@ref = $peep]]/base-uri()
where count($FilesHoldingPeep) gt 15
order by count($FilesHoldingPeep) descending 
return tokenize($peep, '#')[last()]
```` 
We return 10 results, in reverse alphabetical order: Talfourd_Thos, Shakespeare, Russell_M, Palmer_CF, Mitford_Geo, Macready_Wm, MRM, James_Miss, Haydon, Elford_SirWm 

5. - 6. At this point, we need to do some namespace reconfiguration and reference TEI elements with `tei:` namespace prefixes, like we do in Schematron.
 To write this properly so that XQuery *reads* TEI elements and *outputs* HTML we create two namespace lines at the top, and we make the HTML namespace be default, since it controls our output elements and everything without a namespace prefix here. Notice that we have added the `tei:` namespace prefix to every TEI element (but not the attributes, since these are in no namespace). 

````
xquery version "3.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<html>
<head><title>Top Ten Most Referenced People in the Digital Mitford Project</title></head>
<body>
    <table>
        <tr>
            <th>Person (@ref attribute)</th><th>Files</th>
            </tr>
        
{
let $coll := collection('/db/mitford')/*
let $docBodies := $coll//tei:body
let $docTitles := $coll//tei:teiHeader//tei:titleStmt/tei:title/string()
let $allPeeps := $docBodies//tei:persName/@ref/string()
let $distinctPeeps := distinct-values($allPeeps)
for $peep in $distinctPeeps
let $FilesHoldingPeep := $docBodies[.//tei:persName[@ref = $peep]]/tokenize(base-uri(), '/')[last()]
where count($FilesHoldingPeep) gt 15
order by count($FilesHoldingPeep) descending 
return 
    
    <tr>
        
        <td>{tokenize($peep, '#')[last()]}</td>
       <td>{string-join($FilesHoldingPeep, ', ')}</td>
    
    </tr>
}

</table>
</body>
</html>
````

7. To output this with a table nested inside the table cell to hold each of the file names, we altered our XQuery like this:

````
xquery version "3.0";
declare default element namespace "http://www.w3.org/1999/xhtml";
declare namespace tei="http://www.tei-c.org/ns/1.0";
<html>
<head><title>Top Ten Most Referenced People in the Digital Mitford Project</title></head>
<body>
    <table>
        <tr>
            <th>Person (@ref attribute)</th><th>Files</th>
            </tr>
        
{
let $coll := collection('/db/mitford')/*
let $docBodies := $coll//tei:body
let $docTitles := $coll//tei:teiHeader//tei:titleStmt/tei:title/string()
let $allPeeps := $docBodies//tei:persName/@ref/string()
let $distinctPeeps := distinct-values($allPeeps)
for $peep in $distinctPeeps
let $FilesHoldingPeep := $docBodies[.//tei:persName[@ref = $peep]]/tokenize(base-uri(), '/')[last()]
where count($FilesHoldingPeep) gt 15
order by count($FilesHoldingPeep) descending 
return 
    
    <tr>
        
        <td>{tokenize($peep, '#')[last()]}</td>
       <td> <table>
           {for $File in $FilesHoldingPeep
           return
               <tr>
               <td>{$File}</td>
               </tr>
           }
           </table>
       </td>
    
    </tr>
}

</table>
</body>
</html>

````
Notice the use of curly braces inside the `<table>` element, to calculate a new little FLWOR inside.
