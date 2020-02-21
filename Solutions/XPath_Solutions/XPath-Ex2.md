## Solutions to XPath Exercise 2 ##

**Q1.** Write an XPath expression to locate all the geo elements in Book I that contain latitude measurements. How many are there (only in Book I)? Check the number in the oXygen result window (Description line) if you like. Be careful if you use the count() function here that you're getting only the count in Book I.

`//div[@type="book"][1]//geo[@select="lat"] `
`count(//div[@type="book"][1]//geo[@select="lat"])`

count=42

**Q2.** These latitude measurements you've just looked up are all held inside paragraphs, or the `<geo select="lat">` element. What would you add to the previous XPath expression to return the paragraphs that hold latitude measurements in Book I? Give your complete XPath expression here.

There are a few different ways you could write this:
* Option 1: `//div[@type="book"][1]//geo[@select="lat"]/parent::p` 
* Option 2: `//div[@type="book"][1]//geo[@select="lat"]/ancestor::p` (We tried this, just in case there's a latitude marker buried down as a descendent of paragraph...though there isn't.)
* Option 3: `//div[@type="book"][1]//p[geo[@select="lat"]]` Notice: we can write it this way, too, with a predicate filter on the `<p>` element.

(n=26)

**Q3.** Write an XPath expression to find the first paragraph in Book III, Chapter 1 that contains a latitude reading. What's the number of this paragraph as coded in the file?

`//div[@type="book"][3]/div[@type="chapter"][1]/p[geo[@select="lat"]][1]/@n`
n=702

**Q4.** Write an XPath to bring up all the paragraphs in this WHOLE file that contain both latitude AND longitude readings. How many of these paragraphs are there?

  * `//p[descendant::geo[@select="lat"]][descendant::geo[@select="lon"]]`
  * `count(//p[geo[@select="lat"]][geo[@select="lon"]])`
  * `//p[descendant::geo[@select="lat"] and descendant::geo[@select="lon"]]`
  * `//p[descendant::geo[@select="lat"] and descendant::geo[@select="lon"]] => count()`

count=54

**Q5.** Are there any paragraphs in this WHOLE file that do NOT have a latitude measurement, but DO have a longitude? What XPath expression reveals these? And how many of these paragraphs are there? 

`//p[not(geo[@select="lat"])][geo[@select="lon"]]`

n=4, although one of the results contains a lat deep inside a `<ref>` element. To exclude that result, we would need to write the not() function so that it excludes `<geo select="lat">` elements deep down the *descendent* axis  from the `<p>`. Here's how we would write that:

`//p[not(descendant::geo[@select="lat"])][descendant::geo[@select="lon"]`
n=3
A less preferable (because more tricky) way to write this is using the self (.) axis and two slashes to go down the descendant axis. You have to remember the self (.) if you use the two forward slashes in a predicate! (We will explain why in class, but you can try it for yourself without the dot and see the difference.): 
`//p[not(.//geo[@select="lat"])][.//geo[@select="lon"]`

**Q6.** Explain why the following two XPath expressions return different results. Run each XPath expression, review the results, and explain what you think each expression is returning.

*  `//p[geo]/placeName[1]` : Returns the first placeName that occurs in every p that contains a geo because it has the predicate [1] only on the element placeName.

* `(//p[geo]/placeName)[1]` : Returns the first occurance of a placeName inside a p that contains a geo because it places the predicate [1] on the entire expression.
