## XQuery Exercise 1 Solution

1. To isolate the TITLE element that gives the title of the play (and not TITLE elements that appear deeper inside the Shakespeare files), use: 
`collection('/db/shakespeare/plays')/PLAY/TITLE`

To return the entire plays, either of these XPath statements work:
`collection('/db/shakespeare/plays')/PLAY`
or
`collection('/db/shakespeare/plays')/*` 
Remember that the asterisk or "splat" represents any element. The second expression with the splat returns a few more results from the database, but also pulls up the full texts of the plays, so it works for scrolling and analyzing the elements in use in the documents.

And here is how you could retrieve all the play titles using a FLWOR:

````
let $titles := collection('/db/shakespeare/plays')/PLAY/TITLE
return $titles
````   
We get the three play titles inside of `<TITLE>` tags.  
  
  2.  We wanted to show you a few different ways to return just the text contents of the TITLE elements. They each work a little differently:
a. `text()`: This isn't a function, remember. It's just used to indicate the text() node children inside an element. We simply append it to the end of our XQuery expression thus:
`collection('/db/shakespeare/plays')/PLAY/TITLE/text()` 

A note about `text()`: It's only going to return plain text that is the **immediate child** of the element you've landed on with your XPath. That may be what you want, but sometimes it isn't! Here is what happens when return text() from a `<title>` element if it's coded like this:
`<title><person>Romeo</person> and <person>Juliet</person></title>`:
If we write in XPath or XQuery:
`//title/text()`
The return will be the word " and " (including the white spaces around it), because each character is a text() node child of `<title>`, and the parts inside `<person>` tags are literally NOT text() node children.

You're safe here with text() because none of the main `<TITLE>` elements in our collection contain mixed content or internal markup. But because we can't always easily predict the element contents when we are working with a collection in XQuery, **we nearly always prefer `string()` to `text()`**. The `string()` function, which we show you next, will convert the **entire contents** of an element (including its nested children and descendant elements all the way down the XPath tree) into a plain text string. 


b. `string():` **This is really the optimal solution** when writing XQuery for the reasons we explained above. This *is* a function and it works only on single elements in turn to convert their contents (all the way down through the descendant axis if it's present) into a string of text. That means we need to write string() to be appended on the *end* of our expression, to return results one by one. Note: If you try to wrap `string()` around a whole XPath expression, eXist returns a "cardinality error": In this case the error is: "Expected cardinality: zero or 1, got 3." The error occurs because we have three TITLE elements to parse and `string()` is designed to convert *only one element at a time*. So append it at the end, and each time we land on a `<TITLE>` element, we can output a string of text. It looks, then, almost exactly like our expression for `text()`, but this time we're using an XPath function:
`collection('/db/shakespeare/plays')/PLAY/TITLE/string()` 

c. `data()`: This is also a function, but unlike `string()` it is useful for processing a sequence of results. It's also right for this task because we can use it to return just the "atomic values" at the point where the XPath lands. What's an atomic value? It is a particular value that has *nothing to do with the XPath position*: it's whatever string of text or numerical value is there, and it pulls that out of its XPath context. So in this case, `data()` can return a list of text strings within the PLAY/TITLE elements across the collection. To write it, we have to **wrap** the entire collection() path inside the data() function, like this:
`data(collection('/db/shakespeare/plays')/PLAY/TITLE)`
or we have to specify the `self::*` axis with the dot (`.`), because data(.) requires an argument inside it:
`collection('/db/shakespeare/plays')/PLAY/TITLE/data(.)`

And of course we could write any of these into a FLWOR. Here's a FLWOR we wrote to return the `string()` value of the TITLE elements:

````
  let $plays := collection('/db/shakespeare/plays')
  let $title := $plays/PLAY/TITLE
  let $titleText := $title/string()
  return $titleText  
````   
  
  3. To return the the play with more than 40 distinctly different speakers, here's our XPath solution:
`collection('/db/shakespeare/plays')/PLAY[count(distinct-values(.//SPEAKER)) gt 40]/TITLE/text()` 

To write that in a FLWOR, we break this into pieces and we need to use a **"for" loop** so we can evaluate just one play at a time and count all of its speakers one by one. Otherwise, without the For loop in the XQuery FLWOR, we take distinct-values on the speakers across the *entire collection* of plays, and so there will always be more than 40 distinct speakers and we'd return all three titles. We wanted to show you the difference between retrieving the result in a long XPath statement vs. writing the XQuery so that you can learn about what **"for" loops** are all about. We don't need to do anything special in the XPath statement because our predicate expression is doing the work of filtering out the play *that has* the count of distinct-values greater than 40. But with a FLWOR, because you're defining variables, the `for $play in $plays` line does the work of testing each individual play in the collection. We call this a "for loop" because of what happens in the parsing: the XQuery parser **loops** over and over looking at each singular part of a plural list in turn. 

````
 let $plays := collection('/db/shakespeare/plays')
  for $play in $plays
  let $title := $play/PLAY/TITLE
  let $speaker := $play//SPEAKER
  let $countSpeaker := count(distinct-values($speaker))
  where $countSpeaker gt 40
  return $title
````  
Returned `<TITLE>The Tragedy of Macbeth</TITLE>`    
  
  4. This involves modifying our solution to the previous XQuery challenge to return not the whole play but just a) the title, and b) the `base-uri()`:
a) To return only the title, you could have used `data()` or `string()` or `text()`. We used `text()` here:

````  
  let $plays := collection('/db/shakespeare/plays')
  for $play in $plays
  let $speaker := $play//SPEAKER
  let $title := $play/PLAY/TITLE
  let $titleText := $title/text()
  let $countSpeaker := count(distinct-values($speaker))
  where $countSpeaker gt 40
  return $titleText  
````
Returned `The Tragedy of Macbeth`  

b) Let's see what this `base-uri()` is all about:  

````
  let $plays := collection('/db/shakespeare/plays')
  for $play in $plays
  let $speaker := $play//SPEAKER
  let $playURI := $play/base-uri()
  let $countSpeaker := count(distinct-values($speaker))
  where $countSpeaker gt 40
  return $playURI
````  
Returned `/db/shakespeare/plays/macbeth.xml`  
The `base-uri()` provided us with the filename and **filepath** of the specified document. The filepath is the literal location of the file in its directory, so we can see where it is sitting in our eXist database. The eXist database always has a root file directory named "db" and then our collections sit inside that. The very last part of the filepath is the file name with its extension, so this is sometimes useful to us. Each file has a distinct "uri" (Uniform Resource Identifier"), and the `base-uri()` function returns a string of text giving its distinctive location the directory it lives in, and that is what you retrieve with this function.   

c) Now, let's just modify that so we only retrieve the file name that sits at the end of the filepath after the last forward slash. This is something we need to do sometimes if we want to generate relative links to a file sitting in the same directory say on the web server but not in eXist. We reach into eXist, grab a `base-uri()` file-path, break it (using the `tokenize()` function) into pieces, and then just retrieve the piece sitting in the `last()` position. This works because when we tokenize, the pieces remain in the set order of their position in the string, so you could retrieve them by position() predicates. To get the first token, we'd have used [1] (which would return 'db'), and to get the third token we'd have used [3] to return 'play'. To get the last() whatever it is, we used the convenient `last()` function inside a predicate. What looks a little unusual about this is the positioning of a predicate after a function, and it works because our function gets us multiples of something that we can then **filter** with our predicate. We retrieved it this way: 

````
  let $plays := collection('/db/shakespeare/plays')
  for $play in $plays
  let $speaker := $play//SPEAKER
  let $playURI := $play/base-uri()
  let $tokenLast := tokenize($playURI,"/")[last()]
  let $countSpeaker := count(distinct-values($speaker))
  where $countSpeaker gt 40
  return $tokenLast  
````
Returned `macbeth.xml`  

We wanted to show you this to give you more experience with moving from plural returns to a singular result. If we didn't use the predicate, could we have written a **"for loop"** to go through the tokens? Yes! Give it a try. Sometimes we have to decide whether to use a "for loop" or a predicate, and in this case because we just need a simple thing, the predicate makes sense, and makes eXist work a little less hard in processing our code. "For loops" can technically be a little expensive of computer processing power, but that is usually only a problem with really large, complicated *nested* loops--that is, setting a "for loop" inside another "for loop". We'll have occasion to do that later, and when we do you may notice a little lag in eXist as it processes your nested FLWORs. 
  
  5. Here's an alternate way of writing the previous expression in a long XPath:
`tokenize(collection('/db/shakespeare/plays')/PLAY[count(distinct-values(.//SPEAKER)) gt 40]/base-uri(), '/')[last()]`
We have set the entire XPath down to the base-uri() function as the first argument of tokenize. 
You could write different kinds of FLWOR statements, to define more or less in a single variable that holds an XPath expression--that's up to you and how you step your way through the thinking process of writing XQuery and XPath. So, here's one more way, with a very little FLWOR and longer XPath statements:

````
let $PlayWithManySPeakers := collection('/db/shakespeare/plays')/PLAY[count(distinct-values(.//SPEAKER)) gt 40]/base-uri()
let $tokenLast := tokenize($PlayWithManySPeakers,"/")[last()]
return $tokenLast
````



  


