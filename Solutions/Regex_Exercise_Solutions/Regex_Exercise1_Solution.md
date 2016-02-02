###Regex Exercise 1:
1. Delete all of the unnecessary front and back matter.
2. Find all of the reserved characters. **You have to find and replace these characters in this order because the ampersand is in the code for the greater than and less than signs!  If you did tried to find the ampersand last, it would find and change all of the less than and greater than code that you just fixed!**
 * Find: `&`
   * Replace: `&amp;`
 * Find: `<`
   * Replace: `&lt;`
 * Find: `>`
   * Replace: `&gt;`
3. Get rid of extra whitespace.
 * Find: `\n{3,}`
   * Replace: `\n\n`
4. Surround the paragraphs with `<p>` and `</p>`.
 * Find: `\n\n`
   * Replace: `</p>\n\n<p>`
5. Add a `</p>` at the end of the document and `<p>` to the beginning of the document.
6. Surround the chapter titles with `<title>` and `</title>`.
 * Find: `^<p>([VXI]+\..+)</p>$`
   * Replace: `<title>\1</title>`
7. Surround the _entire_ chapter text in `<chapter>` and `</chapter>`.
 * Find: `^\n(<title>.+</title>)$`
   * Replace: `</chapter>\n\n<chapter>\1`
8. Delete `</chapter>` from before Chapter 1 and add `</chapter>` at the end of the last chapter.
9. Surround the quotes with `<quote>` and `</quote>`. **Make sure the "_Dot matches all_" box is checked!**
 * Find: `"(.+?)"`
   * Replace: `<quote>\1</quote>`
10. Clean up the document by getting rid of the word 'by', taking out the `<p>` tags around the title, author, and table of contents, surrounding the title in `<title>` elements, surrounding the author in `<author>` elements, surrounding 'Table of Contents' in `<toc>` elements, and surrounding the entire document in a `<book>` root element.
11. **OPTIONAL**
 * Because the chapter titles in the table of contents were spaced out, highlight them, change the scope in the Find/Replace box to "_Only selected lines_", and get rid of the spaces:
   * Find: `^\s+`
     * Replace: `[nothing entered here]`
 * Keep "_Only selected lines_" checked and wrap the chapter titles in `<title>` tags:
   * Find: `^([VXI]+\..+?)$`  (Use "_Dot matches all_" here!)
     * Replace: `<title>\1</title>`
12. Save the document as an XML file to check for well-formedness.