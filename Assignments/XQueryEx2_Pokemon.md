## XQuery Exercise 2: Where are the Pokemon?

In [our eXist-db](http://newtfire.org:8338) we have uploaded a collection of XML files from the Pokemon team. Access the Pokemon collection with:
``
collection('/db/pokemonMap/pokemon')
``
(The collection is not coded in a namespace, so you can simply open a New XQuery and begin writing queries over it with no namespace declaration line.) 
Open a text or markdown file to paste in the expressions you use for each of the following:

1. Write an expression to return a count of the number of files in the collection, using the `count()` function.
1. Return the filepaths of all the files in the Pokemon collection with the `base-uri()` function. Then trim the results to return only the filenames: Tokenize the file paths on the `/` and retrieve the last token.
1. For the next few steps, we will ask you to study and answer some questions about the XML you retrieved to help prepare you to query it. 
   * a. We need to see how the XML in each file is structured to know how to query it. Starting from the `collection()`, write a basic XQuery expression to show you the coding of the files, using `/*`: This will show you the root element of each file (and thus each entire file).
   * b. What XML element and attribute holds the **type** of a Pokemon? 
   * c. Where can you find the locations associated with each Pokemon? (What element and attribute holds this information?)
   * d. If we _started_ an XPath from the element holding the type of Pokemon, what XPath axis would we use to find the name of the Pokemon? 
   * e. If we _started_ an XPath from an element holding the **landmark**, what XPath axis would we use to find the **type** of Pokemon here? (We will need to express this relationship in our XQuery below.)
  
1. We want to learn from the Pokemon collection what **types** of Pokemon can be found in specific **landmarks** in the Pokemon world. Let’s start working on a FLWOR expression to help us pull this data from the files. 
   * a. Start by defining (and returning) a variable holding all the Pokemon types. We want to work with the `@type` attribute on the `typing` element, because this seems to return a list of standardized values. **Note**: To return an attribute value in eXist-db you will need to set `string()` at the end of your expression.  
   * b. Look at your output: Do you see the white spaces? Several attributes hold a list of multiple type values separated by white space. Use the `tokenize()` function to break these apart on the white space separator, and return all of the individual values. 
   * c. You have a big list of multiple duplicate values now. Define a variable to get rid of those duplicates and return only the distinct values. 
   * d. Look at the return for the above list of distinct values. Do you see some duplicates? Here's a good opportunity to try the `lower-case()` or `upper-case()` function on your nodes before you send them to distinct-values. Do it. How many items do you see now in the sequence of values that you return?
1. Now things get interesting! We want to build up this FLWOR so XQuery will show us which locations are associated with each distinct type of Pokemon. We have a list of distinct values that is *off the XML tree*.**Our goal**:  We want to output a simple chart that contains, on one side, the distinct **type** of Pokemon, and on the other, a list of the distinct **locations** where we can find that Pokemon type. For each type there are going to be multiple locations.
   * a. Make a special `for` statement to create an index variable, to take each member of the distinct-values list of types one by one. 
       * Understand, this sequence of distinct-values() is *off the tree*, and the values have been tokenized and lower-cased or upper-cased. Notice: once you define a `for` statement, your returns are constructed in a `for loop`: If you return any variable, it returns once for each member of the sequence of values you are looping over. Try it. 
   * b. Define a variable with a `let` statement in the `for loop` that returns to the Pokemon XML collection and looks for all the `landmark` elements (inside the `location` elements). 
   * c. Define a new variable to return *only* the landmarks in files that hold the *current* type value in the `for loop`. That *current* value is stored in the `for loop` variable. Make a predicate filter on the landmark nodes to return *only* the landmarks that are associated with the *current* value of your `for loop`. How to do that? You want to find the landmarks whose `preceding::` node gives a type, which, if you lower-case or upper-case it, will *contain* the current `for loop` variable. 
   * d. Try testing your return in stages. 
      * If you return your `for` loop variable, you should see 26 results. We want a total of 26 results in our return, so each type of Pokemon is presented alongside a list of landmarks for finding it.
      * Try returning just the special matching landmarks variable: there will be 144 of them. But notice there are many duplicates in the results. To keep our chart concise and tidy, let’s define a new variable to hold the `distinct-values()` of those matching landmarks. There will be 83 distinct values.
      * You can return multiple variables together by wrapping them in parentheses like this: 
      ``
      return ($d, $distLM)
     `` 
The first is my distinct type (my `for-loop` variable), and the second is the list of distinct landmarks.
       * Frequently when we are working with a list of `for loops` and matching values in XQuery, we have a small list (26 `for` values), with a longer list of matching results *indexed* to them. Let’s play with string functions to tie these together into 26 tidy bundles. Use the `concat()` function in a one-to-one relationship with single strings, and it can take *and* number of comma-separated pieces, including literal strings in quotation marks and XQuery variables. Try `concat($d, 'is cool')` to see how this works. If we take `string-join()` and bundle up each list of landmarks associated with a type, you can make *one* string with a separator that will fit as an argument in your `concat()`, so you can construct something like: `concat('Type: ', $d, ' :Landmark: ', string-join($distLM))`

1. Want to make that prettier for your website? Look at [the examples on our tutorial on Building New HTML or XML with XQuery](http://dh.newtfire.org/explainXQuery.html#Curly) and take careful note of how and where to use the curly braces to activate XQuery (so it is not just treated as plain text). See if you can construct an HTML page with a table in it, outputting inside the `for loop` each of 26 table rows containing a Pokemon type and its associated landmarks. Congratulations! You have found, and formatted the Pokemon types! Try creating a folder for yourself in the database to save your work as a `.xql` document, but also copy and paste it into a text or markdown file to submit as homework over Courseweb. 



  
