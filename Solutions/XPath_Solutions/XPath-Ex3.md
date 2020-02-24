## Solutions to XPath Exercise 3 ##   

Using [ForsterGeorgComplete.xml](http://newtfire.org/dh/ForsterGeorgComplete.xml)

**Q1. Working with @type:**  
Write an XPath using a function that returns a count of number of times we've used @type attributes in the Georg Forster file.  
`//@type => count()`  or `count(//*[@type])` or `count(//@type)` 
  
What's the XPath to return the parent elements (whatever they are) of @type?  
`//@type/parent::* or //@type/..`   

Modify the XPath in your previous statement to return in the bottom results window the names of those parent elements.  
`//*[@type]/name() or //@type/../name() or //@type/parent::*/name()`
  
Modify the XPath expression once more to return a list of only the distinct-values of those parent elements.    
With simple map `!` and arrow operator `=>`: `//*[@type] ! name() => distinct-values()`
Other ways: `distinct-values(//*[@type]/name()) or distinct-values(//@type/../name()) or distinct-values(//@type/parent::*/name())`   
   
**Q2. Working with attributes of ANY kind:**   
Write an XPath expression to return all the attributes of any kind, anywhere in this file.  
`//@*`  
  
Using the name() function, build on your previous XPath expression to return the names of these attributes.  
`//@*/name()` or `//@* ! name()`  
  
Now, return only the distinct-values of those attribute names: What XPath expression does this?  
With arrow operator: `//@* ! name() => distinct-values()`
`distinct-values(//@*/name())`  
  
Now, what if we wanted to find all the parent elements (without knowing what they are) of any attributes in use within the body element of the file? Write the XPath expression.  
`//body//@*/.. or //body//@*/parent::* or //body//parent::*[@*]`  

What's the XPath to return the distinct-values of the names of those parent elements in the body of the file. 
Several ways to do this: `//body//@*/parent::* ! name() => distinct-values()`
Simple map and arrow operator: `
`distinct-values(//body//@*/../name())` or `distinct-values(//body//@*/parent::*/name())` or `distinct-values(//body//parent::*[@*]/name())`  
  
How many distinctly different element names are holding attributes of any kind? (What expression returns this as a count?)  
With arrow operator: `//body//@*/parent::* ! name() => distinct-values() => count()`
Other ways: 
`count(distinct-values(//@*/../name())) or count(distinct-values(//body//@*/parent::*/name())) or distinct-values(//parent::*[@*]/name())`  
  
**Q3. Working with the `count()` and `position()` functions in predicates: (`count()`, `position()`, `last()`):**    
(You'll need to look up how to look for a `count()` of something and set it equal to, greater than, or less than a particular number.)   
 
Write an XPath expression that returns the last paragraph in the ENTIRE Georg Forster file that contains more than one latitude record, coded as `<geo select="lat">`. (Hint: This builds on things we showed you in the XPath Exercise 2 homework. Note that you should only get ONE result here!)  
With arrow operator: `(//p[descendant::geo[@select='lat'] => count() gt  1])[last()]`
or
`(//p[count(geo[@select="lat"])>1])[last()]`  
  
Modify the expression so you return the first paragraph in the ENTIRE Georg Forster file that contains more than two latitude records. (There's no such thing as a first function, but remember how we found the first, second, and third books and chapters in past XPath exercises? The same working with position numbers applies here.) Again, you should only get one result in your results window.
With arrow operator: `(//p[descendant::geo[@select='lat'] => count() gt  2])[1]`
or
`(//p[count(geo[@select="lat"])>2])[1]`  
  
Now, how would we write XPath to find the very last paragraph in Book 2 that contains more than 1 latitude record? As before, you should only get one result for this.
With arrow operator: `(//div[@type="book"][2]//p[descendant::geo[@select='lat'] => count() gt 1])[last()]`
or
`(//div[@type="book"][2]//p[count(geo[@select="lat"])>1])[last()]`  
  
Now, can you write an XPath expression that finds the very first paragraph holding more than two latitude records, that also holds more than one placeName element?  
With arrow operator: `(//p[descendant::geo[@select='lat'] => count() gt 2][descendant::placeName => count() gt 1])[1]`
or
`(//p[count(geo[@select="lat"])>2][count(placeName)>1])[1]`  
  
How would you modify the previous expression to return the contents of the placeName elements in that paragraph? What are the placeNames?  
With arrow operator: `(//p[descendant::geo[@select='lat'] => count() gt 2][descendant::placeName => count() gt 1])[1]//placeName/text()`
or
`(//p[count(geo[@select="lat"])>2][count(placeName)>1])[1]/placeName/text()`  
The placeNames are South Sea and Cape of Good Hope.
