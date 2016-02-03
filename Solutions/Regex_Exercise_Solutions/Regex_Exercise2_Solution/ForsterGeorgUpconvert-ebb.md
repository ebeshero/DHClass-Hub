# Dr. Beshero-Bondar's Solution to Exercise 2

1. **Find:** `&\s` Result: `(none)`  
 **Find:** `<` Result: `(none)`  
 **Find:** `<` Result: `(none)` 
2. **Find:** `\n{3,}` **Replace:** `\n\n` 
3. Wrap all the blocks in `<p>` elements - working from inside-out  
     **Find:** `\n\n^` **Replace:** `</p>` (ctrl+enter) `<p>`
     (**I noticed an odd issue: I can't enter a `\n` in the replace window. oXygen prompted me to use `Ctrl+Enter` to enter a newline (which I positioned in between the `</p>` and the `<p>`).) 
4. **BUILD THIS GRADUALLY: Matching on Chapters AND Descriptions:**
Chapters: First tried `<p>\nCHAP.` but that doesn't capture all the chapters. (Why? Some of them don't have a newline before `CHAP.`, though most of them do.) So, tried this to capture all cases: Either of the following expressions works:
  **Find:** `<p>\n?CHAP.` **OR** `<p>.?CHAP.`  
Turn on "Dot matches all" and see if we can capture the whole` <p>` units that contain `CHAP.` with the description:  
  **Find:** `<p>\n?CHAP\..+?</p>`  
That's enough to give us a div and a head. (Inside the head we are putting these inside `<l>` elements in our model file. By the way, that's not good TEI because these aren't lines of poetry, but hey, cut us a break--this isn't actually TEI anyway and just a model file!)  
We could start building a replace now, OR we could try to grab all the chapters AND their descriptions in one expression! Let's give it a try:  
All we need to do is add a Roman Numeral character set, and be careful with indicating spaces, and continue with our dot-matches-all-don't-be-greedy match:  
  **Find:** `<p>\n?CHAP\.\s[IVXL]+\..+?</p>`  
and then set up our capturing groups for what we want to keep:
  **Find:** `<p>\n?(CHAP\.\s[IVXL]+\.)(.+?)</p>`  
Now be careful with the Replace window. Remember, you want to build `<div>` elements that contain the whole text of a chapter inside, so you want to close-open those divs, and then set up your head and lines that label the chapters.  
  **Replace:** `</div><div type="chapter">\n<head><l>\1</l>\n<l>\2</l>\n</head>`  
**IMPORTANT:** Do a Find for `CHAP.`, and then `<head>.+?</head>` just to see if you caught everything. Aha...there are some rogue `<p>` elements inside the `<head>` tags. The spacing in these Chapter headings is uneven, so sometimes there was a `<p>` element inside. We can remove those with regex:  
  **Find:** `(</?l>.?)</p>\n<p>(.+?</head>)`  
  **Replace:** `\1\2`  
5.  Find and mark the Books!  
First, just Find BOOK (and see there are three books). 
Try `<p>BOOK.+?</p>` and it only matches the first book! What gives? Look at the others. There's a newline inside, so we need a regex to help deal with that:  
  **Find:** `<p>\n?BOOK.+?</p>`    **OR**
  **Find:** `<p>.?BOOK.+?</p>`  
  **Replace:** `</div><div type="book"><head>\1</head>`  
6. Now we manually clean up the extra closing and opening ps and divs at the top and bottom of the document, and add something to deal with the title at the top (ours is set up to be the `<text>` section of a TEI document but yours can be anything you like), save as XML, close the file and reopen it, and check to see if it's valid!  
7. And right! We asked you to look for dates. This will find you any four-digit year inside square brackets, which you need to remember to escape, because they have special meaning as a character set!   
  **Find:** `\[\d{4}.+?\]`
  (But notice there are several of these that are paired up with other dates inside square brackets, so let's do this:)  
  **Find:** `(\[.+?\]){1,}`
  (Why did I need to remove the regex pattern for the year to do this match?)
  We said to remove the pseudomarkup, and we really can't set up our capturing group easily... So let's try this again:  
  **Find:** `\[\d{4}.+?\](\[.+?\])?`
(This returns 62 items, some with a single set of angle brackets and some with a double set....but on scrolling through, some dates aren't set next to year dates!, so we need to make BOTH groups be optional, AND add capturing groups so we can strip out the square brackets when we add our `<date>` tags:  
  **Find:** `(\[(\d{4}.+?)\])?(\[(.+?)\])?` (This yields 338 matches!)  
  **Replace:** `<date>\2\4</date>` 