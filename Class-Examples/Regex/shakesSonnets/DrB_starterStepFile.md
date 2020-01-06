# Dr. B Step File For Regex 1

1. Trimmed off Project Gutenberg stuff from beginning and end.
1. Checked for reserve characters like the &, <, >. Didn't find any.

1. Clean up extra unnecessary white spaces. Find three or more hard returns (or newlines) in a row, and replace with just two newlines. 
Find: 
```
\n{3,}
```
Replace:
```
\n\n
```
1. Removed leading white spaces from lines with:
Find:
```
^\s{2,}
```
Replace: leave empty to cut these off.
1. Added root element.
1. Start the inside-out method. Find and replace everything with a
line element
Find: 
```
.+
```
Replace:
```
<line>\0</line>
```
1. Find and wrap the sonnets:
Find:
```
<line> ([IVXLC]+)</line>
```
Replace:
```
</sonnet><sonnet n="\1">
```
1. Removed extra </sonnet> from top and did clean up tags
1. Save as .xml 
