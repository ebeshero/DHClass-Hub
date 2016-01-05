## Steps for converting the plain text transcript of the Cheese-Straws Recipe to simple XML using Regular Expression matching.

1. Housekeeping: Remove extra white space at top and bottom. Surround singular elements with appropriate tags. Wrap the whole thing in a root element.
2. Remove extra white spaces from the paragraph text-wrapping (still tidying up). (Note: sometimes you might want to keep white spaces if they distinctively mark something you need!) 
Do a find for the start of a new line with the caret: ^ and multiple white spaces: \s+ and a start with any alphanumeric character: \w Look in the Find window in oXygen to see what you're turning up:
Find: ^\s+\w

3. Use a capturing group with parentheses to isolate the parts of the expression we want to keep.
^\s+(\w)
Replace with a backslash and the number of the capturing group:
\1
Notice what happens.

4. Put the simple tags in. Now look at the single digits that start multiple lines. Try a regular expression to match these:
^\d\s

Can you match to the end of the line? Use the dot, but make sure you don't have dot matches all set. (See what happens when you have this toggled and when you don't. Sometimes we want dot matches all, and sometimes we don't.)

^\d\s.+$

Think about what we want to replace this with. Items in a list? Use a capturing group in your Find expression to keep what we want inside the <item> element.

Find: ^(\d\s.+)$
Replace: <item>\1</item>

5. Numbers in measurements vs. numbers in years. How can we tell the difference?

\d\d\d\d  or \d{4}

Find: (\d{4})
Replace: <year>\1</year>

6. For measurement numbers, we need to set two capturing groups (so we don't lose the white space):

Find: (\d)(\s)
Replace: <measure>\1</measure>\2

7. City-state? Can we see a pattern and write a regex to match? We need a regex for capital letters, and we want to account for a comma and a space in the middle:
Use a character set for capital letters [A-Z] . Notice where we want more than one!
(If we want Roman numerals, we streamline the character set to just the characters we want, like so: [IVXLC])

[A-Z][a-z]+,\s[A-Z]{2}

In Regular Expressions there are often several ways of writing the same pattern:
[A-Z]\w+,\s[A-Z]{2}

Notice that NEITHER of these is quite right--we're missing one of the city, states. Why?

Try the dot. Uh oh--that won't work either! It's too "greedy" a match.
Try the character we may or may not have, with a ? after it: picks up zero or one of this! (Sound familiar?)

-?\w+

[A-Z]\w+-?\w+,\s[A-Z]{2}

Think about how we want to tag this. Try something like <place><city>...<city>, <state>...<state></place> to bind the info together. For this, how do we set up
capturing groups? And how do we write the replace?

Find: ([A-Z]\w+-?\w+)(,\s)([A-Z]{2})
Replace: <place><city>\1</city>\2<state>\3</state>



















