## Steps for up-converting Chocolate Chip Cookies Recipe

What you want to do is record your steps. 


1.Find the block capital letters with:
```
^([A-Z ]{2,})(.+)
```
Replace with:
```
<author>\2</author><title>\1</title>
```
2.Made a root element and wrapped the document (by hand, no find and replace).

3. Working on the ingredient list, only the ingredients. These are all on lines that *begin* with a digit. 
Find:
```
^\d
```
Replace is complex here!
When we find the *beginning* of a repeating pattern, we have also found the *end* of the immediately preceding one. So we can use what we like to call "close-open" or "clopen": Set down a close-tag immediately before the open tag, to set complete container elements up. And use `\0` to indicate the entire match with Find.
```
</ingred><ingred>\0
```
Now, when we replace with this, we will have an *extra* close-tag at the top of the ingredients list, and we'll be *missing* a close-tag at the list. 
4. So, we manually move the `</ingred>` from the top of hte ingredients list to the end to create well-formed markup. 
5. Save as an XML file with a `.xml` extension. Close the file and re-open it to see if the syntax is well-formed. 

We could continue on and tag the ingredients steps from here. (Feel free to keep doing that to continue practicing with regex!) 

