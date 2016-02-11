## Solution to Regex Exercise 4: Up-Converting Pygmalion ##
### Step-by-Step explanation: ###

For the purpose of this assignment, we began by removing the boilerplate information from project Gutenberg, as well as the "meta" information at the top, which
 could be easily reintroduced and manually tagged later, before beginning our autotagging.



`1.` As always, our first step with regular expressions and up-conversion is to *search for any reserved characters.* Always search for the ampersands first, because if there are left and right angle brackets in the text, you need to replace them with code-characters that contain an ampersand! So, we first look for

Find: `&`

This shows that there is in fact one ampersand. Given that there is *only one,* we can zoom to it using the console and manually replace it with the entity `&amp;`
When we search for `<` and `>`, we don't find any to replace. (If we did, we'd replace `<` with `&lt;` and `>` with `&gt;` .)

`2.` We are now going to normalize newlines. Most segments of text are divided from one another by two newlines; this will fix any that exceed two newlines to match 
the rest. 

Find: `\n{2,}`

Replace: `\n\n`

`3.` We think the easiest way forward from here is to turn everything into a paragraph, working from the "inside-out" with our up-conversion. We can do this by finding every instance of two newlines and replacing it with a closing and then 
an opening `<p>` tag, and we're positioning a newline in between to help keep the document readable for us: 

 
Find: `\n{2,}`

Replace: `</p>\n<p>`



`4.` After doing this, we need to manually fix up the very beginning and end, as the expression will not 
format those properly. 


`5.` We now want to convert our speech acts that are tagged as <p> to speech and speaker elements. We can do this by finding <p> tags in which the first thing is a name in all 
capitals, followed by an arbitrary amount of speech.


Find: `<p>([A-Z.\- ]{2,}[A-Z]{2,})([ .].+?)</p>`

Replace: `<speech><speaker>\1</speaker>\2</speech>` 


The expression for matching names is contained within the first set of paragraphs. It is by necessity a bit complex, so 
here is a breakdown: We begin with a character class containing the range of capital letters A-Z, as well as the literal period, the dash character, and a space. **Note** there are some complexities here with escaping characters: 
The dot actually does NOT need to be escaped, because it is already understood as a literal period by virtue of being within a class. 
The dash, however, usually has the purpose of establishing a range in a character 
class, so it DOES need to be escaped. We need the period, the dash, and the space to match characters that sometimes enter in pairs or groups, such as MRS. HIGGINS and THE PARLOR-MAID. 
We say that this must be *at least two characters long* with the numerical bound `{2,}` so that we avoid matching strings that are shorter than 
we want. Then, we use the character class `[A-Z]` to say that this must *end* in at least two capital letters, so that we avoid getting matches such as "FREDDY. I" (
where Freddy's first utterance in the speech act is "I," which would otherwise be matched). We then match all of the text up to the closing `<p>` tags, group
 our expression to find the name in the first parenthesis and the rest of the text in the second, and output this accordingly. 



`6.` Find all of the act headings by matching ACT, followed by one space, followed by a roman numeral constructed from some combination of "I" and "V" characters, wrapped in `<p>...</p>` tags so that we can get rid of these at the same time. Preserve 
the number in a capturing group by surrounding it in parentheses so that this can be duplicated.

Find: `<p>ACT ([IV]+)</p>`

Replace: `</act>\n<act n="\1">ACT \1`


After doing this, we need to go and delete
 the extra closing <act> tag at the beginning and add in the required closing <act> tag at the end. 


`7.` Next we search for stage directions, with "Dot matches all" turned on, because some of these spill over multiple lines!

Find: `\[.+?\]`

Replace: `<stageDirection>\0</stageDirection>`
This is a simple expression to match any stage directions in square brackets. We escape the opening and closing bracket, and inside of those do a dot to match any character 
with a plus sign repetition indicator, and then a question mark to make it non-greedy. If you do not want to preserve the square brackets, you can easily capture only the text 
inside of those with parentheses and output this with `\1` rather than `\0` 


`8.` At this point, we want to convert our remaining paragraph tags, ONLY the ones inside the Acts of the play, into `<stageDirection>` tags. This can be easily done 
by matching a pair of `<p>` tags with text in the middle (the only kind that remains are stage directions), capturing the text, and duplicating it inside `<stageDirection>` tags.

Find: `<p>(.+?)</p>`

Replace: `<stageDirection>\1</stageDirection>`

 **Note:** for this replacement, we highlighted only the acts of the play (ie., not the preface or epilogue), and we selected **`<oXygen/>`'s "Only selected lines"** feature inside the Find/Replace window. 
This way, we avoided changing the tags in the preface and epilogue sections. 

Finally, we manually inserted <preface> and <outro> tags to surround those preface and epilogue sections to finish up!


