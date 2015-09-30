## Solution to Regex Exercise 3: Up-Converting the Voyage Narrative##
### Step-by-Step explanation: ###

`1.` First, we did a search for reserved characters `&`, `<`, `>`,  We found `&` symbols,  but they were already fixed to be `&amp;` 
Remember, you always want to search for the ampersands first, because if there are left and right angle brackets in the text, you need to replace them with code-characters that contain an ampersand! So, we first look for

Find: `&`

 But there is nothing to replace--all is well. If we *did* find any, we'd replace it with `&amp;`
When we search for `<` and `>`, we also don't find any to replace. (If we did, we'd replace `<` with `&lt;` and `>` with `&gt;` .)

`2.` Get rid of extra lines. We chose to look for *three or more blank lines in a row* and replace them with just two so we could see regular patterns in the text more easily:

Find: `\n{3,}` 

Replace: `\n\n` 

`3.` Now we placed `<p>` tagsets, using our "close-open" strategy, around all of the paragraphs, as well as all of the lines separated by *two or more* spaces:

Find: `\n{2,}` 

Replace: `</p>\0<p>` 

After this replace, we fixed the beginning and end `<p>` tags, making sure "BOOK I." and the main title "A VOYAGE round the WORLD." are surrounded by p tags. We reversed the positions of the `</p>` tag from the beginning of the document and the final `<p>` tag at the end of the document.

`4.` We put book divisions around each book using our "close-open" strategy, to place the ending tag for the book first just before the start of the next book. We also wrap the book headings in a `<head>` element (like we did with the chapter titles in the Blithedale Romance exercise). We want to lose the `<p>` and `</p>` tags so we can replace them with new tags for the book divisions and their `<head>` labels, so we set up a capturing group in parentheses and call it with \1 in the replace window: 

Find: `<p>(BOOK\s[IVXLC]+\.)</p>` 

Replace `</div><div type="book"><head>\1</head>` 

(Note: We decided to add an `@type` attribute to go one better than [the sample XML file](http://newtfire.org/dh/ForsterGeorgComplete-regex2-xml.xml): just to help distinguish a `<div>` that is a book from a div that surrounds a chapter.)
Then, we moved the extra opening `</div>` tag to the end of the document to close the last `<div type="book">`.

`5.` Now, we located and set the chapter divisions around each chapter. We noticed that the chapter titles span multiple lines, so we just searched to find the beginning of them:

Find: `<p>CHAP\.\s[IVXLC]+\.` 

Replace: `</div><div type="chapter">\0` 

And then we fixed the beginning and end `<div type="chapter">` tags making sure to put the last closing chapter tag before the last closing book tag.

`6.` Next, we selected "Dot matches all" in the Find and Replace window, so we could search for chapter titles that span over multiple lines. 

Find: `<p>(CHAP\.\s[IVXLC]+\.(.*?))</p>` 

Replace: `<title type="chapter">\1</title>` 

`7.` Keep "Dot matches all" selected. We need to locate dates, and our document analysis (running eyeballs over the document) shows us that some of them span multiple lines. 
So we 

Find: `\` `[(.+?)` `\` `]`   
**Note:** If you paste this into your Find window, remove the spaces between the regex characters: There should be no spaces here: We just had some trouble rendering this expression literally in the codeblock on this page.)

Replace: `<date>\1</date>` - this surrounded all of the dates in square brackets with a date tag set and removed the brackets.

`8.` We noticed that a number of dates have internal square brackets, still, in this form: `\` `][` `\`. We searched for these, but we wanted to add a white space in their place. We noticed that if you enter `\s`, the brackets are replaced with a literal "s"! So instead, we pressed the space bar once in the Replace window, which succeeded in positioning a space in place of the internal square brackets.

`9.` We selected "Dot matches all" again for a last tidying-up step: there seem to be a large number of mostly empty paragraph elements holding only a semicolon inside.  

Find: `<p>;(.*?)</p>` 
We replaced these with nothing, just to delete them. (No worries if you didn't do this in your solution. It's just an extra tidying step to clean our document.)

`10.` We added a root element and saved the file as an XML. Then we re-opened the file in oXygen to check if it is well formed. Even though oXygen was green, we discovered that Books and Chapters were sitting at the same hierarchy when we looked at the document in outline view. We discovered this was becauss the closing `</div>` tag for the last chapter of each book was sitting *after* the starting `<div type="book">`. So we needed to clean up the first and last chapters between books due to tangled tags, to give us a properly nested hierarchy of chapters *inside* books. We caught every instance of this tangled tagging with:

Find: `(</div><div type="book">.+?)(</div>)`

Replace: `\2\1`

Notice how we *reversed the order* of our capturing group! 
**Note:** If you did your element tagging differently, and used different element names, like `<book>` and `<chapter>`, oXygen will show you that your XML is not well formed, so the tangled tagging comes up more directly this way. If you do what we did, and named books and chapters with the same element name, differentiating them only with attributes, oXygen won't have a problem with your code, but will just put chapters and books at the same hierarchical level--which doesn't make sense for us!

`11.` Lastly, we manually edited the `<p>` tags surrounding the main title to `<title type="main">` and `</title>`. And we moved that chapter title to its appropriate position after the first `<div type="chapter">`.
