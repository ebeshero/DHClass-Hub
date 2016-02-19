## Solutions to XPath Exercise 4: Manipulating Strings##
### Step-by-Step explanation: ###

**Q1:** There are two books referenced in the syllabus using the tag 'bibl'. What Xpath will
                return a comma-separated list of the authors?
                
 **A1:** Work this out step-by-step. We're told that there are two books referenced using a bibl tag, 
 so first let's find those with 

`//bibl`

Then, we look inside the bibl elements and we see an `<author>` element inside:
 
`//bibl/author`

We want to return a semicolon-separated list of our results, so we need an XPath function that gives us a chance to set some punctuation or 
special character as a separator. That function is string-join(), which we apply like this:

`string-join((//bibl/author), "; ")`

and we return in the results window: Michael Kay; Bruce Hyslop, Lenny Burdette, and Chris Casciano. Our semicolon neatly separates the single author of one book from the multiple-author string of the second book.

**Q2:** 
* Which 'div' elements contain references to the word "homework"? How many results do you return?

A: `//div[contains(., 'homework')]` We retrieve 18 items
* Can you figure out how to retrieve the immediate parent element containing the word "homework" in the text() node? (Hint: it involves looking for any element below the div, and then its text() node, since we need the element whose *text* contains the word "homework.")

A: For this, we needed to drill down into unknown territory. We don't know the names of the elements containing the word "homework" (and we don't want to figure that out one-by-one from the results of the previous XPath search).  

`//div//*/text()[contains(., 'homework')]/parent::*`

Notice that our number of results is less, only 9 results, and that is because our previous set of results retrieved every div AS WELL AS its child or descendent div elements containing the word "homework."

**Q3:**
* What XPath returns all the Fridays on the syllabus? (Scroll through the document looking for the date elements to help determine this.)

A: Our answer uses contains(), though you could have used matches():

` //div[@type="day"]//date[contains(., "F")] `

* Now, what if we want to return those dates in their ISO format, as yyyy-mm-dd? Can you retrieve that with XPath? 

A: Yes, because we have that form of the date encoded in the @when attribute on the date element. So we just added a step over to the attribute axis to retrieve that form of the date:

`//div[@type="day"]//date[contains(., "F")]/@when `
 
* Return a string-joined list of all these dates, separated with a comma and a space.

A:
`string-join((//div[@type="day"]//date[contains(., "F")]/@when), ", ")

**Q4:** 
* How many <code>div</code> elements of @type 'assign' contain references to word "GitHub"?

A: Be careful to spell GitHub with the proper capitals, or this won't work. We retrieve 10 results with:
`//div[@type="assign"][contains(., "GitHub")]`

or wrap it in count(): 

`count(//div[@type="assign"][contains(., "GitHub")])` to retrieve the number 10 in the results window.

* Find the longest and shortest div elements of this type (that contain the word "GitHub") in the document. How long and short are they? Hint: You will need to use min(), max(), and the string-length() function here, as well as some complex predicates.
                
A: We broke this one down into stages: First, to retrieve the string-lengths of the largest assignment div containing the word GitHub, we started with this XPath:

`//div[@type="assign"][contains(., "GitHub")]/string-length()` 

which returned a list of 10 numbers in the results window, and apparently ranked from highest to lowest. To do this properly, though, we wrapped it in the max() function: 

`max(//div[@type="assign"][contains(., "GitHub")]/string-length())`
and this returned the number 2359, the number of text characters in that div!

To retrieve the minimum, we did wrapped the expression in min():
`min(//div[@type="assign"][contains(., "GitHub")]/string-length())`

Now, the question asked for the **div elements** that contain the max and the min, so to retrieve those, we need to move the expressions we just wrote into a complicated predicate!

Here is how we retrieved the divs that matched the minimum value. There are three of them, all with the same string-length() of 223:

`//div[@type="assign"][contains(., "GitHub")][string-length() = min(//div[@type="assign"][contains(., "GitHub")]/string-length())] `

Notice how we use an equal sign in our predicate. The idea here is that we hunt for all the divs @type="assign" that contain the word "GitHub", and that also meet the condition that their string-length() is **equal to** the minimum string-length(). This is a predicate that basically filters all the results based on their string-length() number and only retrieves the smallest divs.

For the biggest div, we simply changed min to max in the expression above:

`//div[@type="assign"][contains(., "GitHub")][string-length() = max(//div[@type="assign"][contains(., "GitHub")]/string-length())] `

This retrieves a single div of 2359 characters. Try tacking `/string-length()` to the very end to test that number!


**Q5:**
* Working with **only** the @when attribute on the date elements, convert those dates so they display the days of the week (and anything else you wish). 
Record at least two different ways to output the date.

A: We first just created an XPath that returned all the dates in their ISO yyyy-mm-dd form, encoded in the @when attributes on the element date:

`//date/@when` 

We discover there are 45 dates. Then we tinkered with format-date() to reformat these in the return window, and tried the following:

`//date/@when/format-date(xs:date(.),'[FNn] : [MNn] : [D] : [YWw]')`
This output a capitalized day of the week, followed by the name of the month, the numerical day, and the year as the phrase, "Two Thousand and Fifteen".

We then changed the picture string [D] to [DWw] to output the numerical day as a word: Thirty One, One, Two, etc.
And we toyed with the picture string for [YWw] and changed it to [YISOWw] to add the output string for the ISO 8601 calendar, which output the year 2015 as a Roman numeral:
MMXV. (You can put a cultural calendar code after the Y, M, D, or F designations: putting the ISO after [F] gives a Roman numeral to designate I, III, or V, the days of a seven-day week on which we have class.

* Output only the Friday dates on the syllabus, using format-date().

A: We need either the contains() or matches() function for this (and we could have used starts-with() as well). First we need to filter the dates, according to their formatted forms so that we search through a list of dates that includes days of the week.
We retooled our answer above, simplified it a little so we were only looking at picture strings of days of the week, and retooled it so that we could apply the contains() function to our output, to see which of our 45 dates turn up as Fridays:

`//date/@when/contains(format-date(xs:date(.),'[FNn]'), "F")`

The output of this is a Boolean "true" or "false." We can see that for each date, the XPath parser runs a test to determine if it contains a capital letter "F", and when it doesn't, it returns "false." When it does it returns "true." 
But we don't want this output. We actually want to output dates, and only the Friday dates on our syllabus. Here's how we did that:

`//date/@when[contains(format-date(xs:date(.),'[FNn]'), "F")]/format-date(xs:date(.), '[FNn]:[MNn]:[D]:[Y]')`
This retrieves 14 Fridays formatted like this:
Friday:September:4:2015

* Output all the Friday dates in October only:

A: To do this we needed to add one more predicate filter, to retrieve the Month and find which dates then contained the word "October":

`//date/@when[contains(format-date(xs:date(.),'[FNn]'), "F")][contains(format-date(xs:date(.),'[MNn]'), "O")]/format-date(xs:date(.), '[FNn]:[MNn]:[D]:[Y]')`
This expression holds a filter for finding Fridays and a filter to find the October dates. Putting the two predicates side by side as a filter on the @when attribute yields all the Fridays in October. 
We discover there are five Fridays in October: 

Friday:October:2:2015

Friday:October:9:2015

Friday:October:16:2015

Friday:October:23:2015

Friday:October:30:2015



