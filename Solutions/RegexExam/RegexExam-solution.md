# Solution for RegEx Exam


For this exam you need to download the [War-of-the-World-1938-regex.txt file](https://github.com/ebeshero/DHClass-Hub/blob/master/Class-Examples/Regex-Upconversion/War-of-the-Worlds-1938-regex.txt) 

After you have the file downloaded and opened in oXygen open the Find/Replace window.  
Open a new text file to record your steps.

We have already verified there are no reserved characters.   
Also there are no groups of blank lines exceeding 2 (\n{2}).

## Your Tasks:   

1. Find all of the speeches (hint: this was an in-class example) and tag all of the speeches and their corresponding speakers. Use <sp> for speech and <spkr> for speaker. Record all of your Find and Replace expressions and any alterations you made. 

**Solution**

In order to find and tag speeches

Find: `\n[A-Z]{2}.+?:`
Replace: `</sp><sp>\0`

Fix the first and last`<sp>` tags
Then tagging speakers inside of speeches

Find: `<sp>(\n[A-Z]{2}.+?:)`
Replace: `<sp><spkr>\1</spkr>`

2. Find all of the stage directions in parenthesis (hint: this was also an in-class example). Tag all of the stage directions with <sd> removing the pseudo-markup a.k.a. the parentheses. Record all of your Find and Replace expressions and any alterations you made. 

**Solution**

Finding Parenthesis (   )

Find: `\((.+)\)`
Replace: `<sd>\1</sd>`  

3. Make sure there is a root directory.

4. Upload BOTH your text file containing your clearly-labelled Find & Replace regex statements and your up-converted War of the Worlds text to Courseweb. 
