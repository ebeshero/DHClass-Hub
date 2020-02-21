## Solutions to XPath Exercise 1 ##


**Q1.** Like most of the long voyage publications, Georg Forster’s voyage account is produced in multiple books, and inside each books we find multiple chapters. Both books and chapters are coded with `<div>` elements. Take a look at the outline view of the document before you begin to familiarize yourself with the structure of this file, and answer the following:

 * How can XPath tell apart the books from the chapters?  
	   _Answer:_ attributes in the `<div>` elements.
	
* What XPath would find ONLY the books in the file?  
		_Best:_ `//div[@type="book"]`	(n=3)  
		_Okay:_ `//body/div/div`
	
* What XPath would find ONLY the chapters in the file?  
		_Best:_ `//div[@type="chapter"]`	(n=26)  
		_Okay:_ `//body/div/div/div` or `//div/div/div`
	
* What XPath would find ONLY the chapters in Book 2?  
		_Best:_ `//div[@type="book"][2]/div[@type="chapter"]`	(n=8)  
		_Okay:_ `//body/div/div[2]/div` or `//div/div[2]/div`

**Q2.** Look at the outline structure of the document to help you with these: 
	
* What’s the XPath to identify the `<head>` element inside a chapter `<div>`?  
        _Best:_ `//div[@type="chapter"]/head`	(n=26)  
		_Okay:_ `//div/div/div/head`
	
* How would we locate a `<l>` (or line) element inside a chapter `<div>`?  
		_Best:_ `//div[@type="chapter"]//l`	(n=142)  
		_Okay:_ `//div/div/div//l`

**Q3.** Georg Forster used a lot of footnotes in his document: These are coded inside `<ref>` elements throughout the body paragraphs `<p>`of the text. 
	
* What’s the XPath to locate all the notes in the document?  
		`//ref`	(n=313)  
	This works, but to be more specific `//ref//note`  
	or even more exact `//body//p//ref//note`

**Q4.** We’ve encoded lots of `<placeName>` elements in this document to mark names of places, and these may occur in lots of positions. Sometimes they’re in the `<head>` elements that start the book or chapter divs, positioned inside lines of texts (coded with `<l>`). Most often they’re nested in the body paragraphs `<p>`, and they’re frequently coded in Forster's notes, which you’ve just located.
	
 * What’s the XPath to determine the number of placeNames that appear inside ONLY the `<head>` elements, and not in the rest of the document? (Notice where these are located in the heads).  
		`count(//head//placeName)`	(n=56)
		
* What’s the XPath to find the placeNames that are only mentioned in the notes?  
		`//ref//placeName`	(n=151)  
		or `//note//placeName` or `//ref//note//placeName`

* What’s the XPath to find the placeNames that are only mentioned in the notes of Book I?  
		`//div[@type="book"][1]//ref//placeName`	(n=38)  
		Notice the position of the [1] in our solution:  
		This is a positional predicate indicating the first `div` whose `[@type]` is `"book"`.  

* How many of these are there? (Our answer uses an XPath function, `count()` to show you how this is written, but you might simply have read the number of results in the search result window.  
	    `count(//div[@type="book"][1]//ref//placeName)`	(n=38)  
