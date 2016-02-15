## Solutions to XPath Exercise 1 ##


**Q1.** Like most of the long voyage publications, Georg Forster’s voyage account is produced in multiple books, and inside each books we find multiple chapters. Both books and chapters are coded with `<div>` elements. Take a look at the outline view of the document before you begin to familiarize yourself with the structure of this file, and answer the following:
	* How can XPath tell apart the books from the chapters?
	*Answer:* attributes in the `<div>` elements.
	
	* What XPath would find ONLY the books in the file?
		`//div[@type="book"]`	(n=3)
	
	* What XPath would find ONLY the chapters in the file?
		`//div[@type="chapter"]`	(n=26)
	
	* What XPath would find ONLY the chapters in Book 2?
		//div[@type="book"][2]/div[@type="chapter"]	(n=8)

**Q2.** Look at the outline structure of the document to help you with these: 
	
	* What’s the XPath to identify the <head> element inside a chapter <div>?
		`//div[@type="chapter"]/head`	(n=26)
	
	* How would we locate a `<l>` (or line) element inside a chapter <div>?
		//div[@type="chapter"]//l	(n=142)

**Q3.** Georg Forster used a lot of footnotes in his document: These are coded inside `<ref>` elements throughout the body paragraphs of the text. 
	
	* What’s the XPath to locate all the notes in the document?
		`//ref`	(n=313)

**Q4.** We’ve encoded lots of `<placeName>` elements in this document to mark names of places, and these may occur in lots of positions. Sometimes they’re in the <head> elements that start the book or chapter divs, positioned inside lines of texts (coded with `<l>`). Most often they’re nested in the body paragraphs (`<p>`), and they’re frequently coded in Forsters notes, which you’ve just located.
	
* What’s the XPath to determine the number of placeNames that appear inside ONLY the `<head>` elements, and not in the rest of the document? (Notice where these are located in the heads).
		`count(//head//placeName)`	(n=56)
	* What’s the XPath to find the placeNames that are only mentioned in the notes?
		`//ref//placeName`	(n=151)

	* What’s the XPath to find the placeNames that are only mentioned in the notes of Book I? 
		`//div[@type="book"][1]//ref//placeName`	(n=38)
Notice the position of the [1] in our solution: This is a positional predicate indicating the first div whose [@type] is "book". 

	* How many of these are there? (Our answer uses an XPath function, count() to show you how this is written, but you might simply havee read the number of results in the search result  window.
			`count(//div[@type="book"][1]//ref//placeName)`	(n=38)