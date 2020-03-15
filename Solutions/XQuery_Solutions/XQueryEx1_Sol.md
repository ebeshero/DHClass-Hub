## XQuery Exercise 1 Solution
Housekeeping: Declare the TEI namespace and set a variable defining the collection:
``
declare default element namespace "http://www.tei-c.org/ns/1.0";
collection('/db/apps/shakespeare/data/')
``
1. Find all of the main titles of each of the 42 Shakespeare plays in the collection, by stepping down the descendant axis from the collection. (Hint: the play’s main title is coded near the top of the file in a special element called the titleStmt). 
    * `collection('/db/apps/shakespeare/data/')//titleStmt/title`

1. Return only the text nodes with: `collection('/db/apps/shakespeare/data/')//titleStmt/title/text()`
  * Note: `string()` and `data()` are functions that return the text() nodes of all descendant elements. They work here, too. 

3. Isolate the TEI root element of each play:
`collection('/db/apps/shakespeare/data/')//TEI
`

3. Speeches are coded in the Shakespeare plays like this:
``xml
<sp who="ID"><speaker>Name</speaker> text of the speech</sp>
``
Write an expression that locates a play holding a speaker named Ferdinand. Which play is it? 
``
collection('/db/apps/shakespeare/data/')//TEI[descendant::sp[@who='Ferdinand']]
``
A: *The Tempest*
1. Modify your expression to return only the main title of that play, and record your expression.
``
collection('/db/apps/shakespeare/data/')//TEI[descendant::sp[@who='Ferdinand']]//titleStmt/title
``
1. Find three very special plays that contain a count of more than 58 unique (distinct) speakers. 
  * First, see if you can find the plays: 
``collection('/db/apps/shakespeare/data/')//TEI[distinct-values(descendant::sp/@who) => count()  gt 58]
``
  * And then return only their main titles (recalling the code you wrote previously). You will need to use count() and distinct-values(), and you’ll need a construction involving a count(of something) greater than 58:
``
collection('/db/apps/shakespeare/data/')//TEI[distinct-values(descendant::sp/@who) => count()  gt 58]//titleStmt/title
``.
7. a. Return just the text of the titles:
`` collection('/db/apps/shakespeare/data/')//TEI[distinct-values(descendant::sp/@who) => count()  gt 58]//titleStmt/title/text()
``
    b. Try adding `base-uri()` to the above expression and see what it does:
    Returns the filepaths in the eXist-db database for the three files:
    ``
"/db/apps/shakespeare/data/2h6.xml"
"/db/apps/shakespeare/data/tim.xml"
"/db/apps/shakespeare/data/ri3.xml"
    ``
  c. Return only the file names and trim off the first parts of the URLs:
  `` collection('/db/apps/shakespeare/data/')//TEI[distinct-values(descendant::sp/@who) => count()  gt 58]//titleStmt/title/base-uri() ! tokenize(., '/')[last()]
   `` 
   This breaks apart the pieces of the file path by tokenizing on the forward slash. Then we take the last portion in each series of tokens.
      




``
collection('/db/apps/shakespeare/data/')//TEI[distinct-values(descendant::speaker) => count() gt 58]//titleStmt/title
``

8. FLWOR expression to return the title of the play with more than 58 distinct speakers:

``
let $shakes := collection('/db/apps/shakespeare/data/')

let $wholePlays := $shakes//TEI

for $w in $wholePlays

let $speakers := $w//sp/@who

where $speakers => distinct-values() => count() gt 58

return $w//titleStmt/title/text()
``
