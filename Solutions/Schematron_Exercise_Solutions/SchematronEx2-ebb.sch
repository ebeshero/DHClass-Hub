<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.tei-c.org/ns/1.0" prefix="tei"/>


    <pattern>
        <rule context="tei:rdg">
            <report test="not(@wit)"> There must be an @wit attribute on an rdg element, and other attributes are not permitted.</report>
        </rule>
<!--Folks! You could use <assert test="@wit">, right? -->
        <rule context="tei:app">
            <assert test="count(tei:rdg) ge 1"> There must be at least one or more rdg elements
                inside an app element. </assert>
        </rule>
    </pattern>
    <pattern>
        <!--2016-02-21 ebb: If this rule were placed in the pattern above, it would fire in place of the other rule whose context is set on
        tei:rdg: Only the first rule set on tei:rdg would fire, even though this rule's context is more specfiic.
        So we had to put this and the other rules to do with white space control ahead of tei:rdg elements in a separate pattern. -->
        
        <rule context="tei:rdg[parent::tei:app[preceding-sibling::text()]]">
            <report
                test="not(matches(parent::tei:app/preceding-sibling::text()[1], '[ “—]|&quot;$')) and matches(., '^[A-z]')"
                > Add a white space before the app element. </report>
            <report test="matches(., '^\s') and matches(parent::tei:app/preceding-sibling::text()[1], '\S\s$')">
                There's an extra white space either in the rdg element or before the app element.
            </report>
        </rule>
       
    </pattern>
    <pattern>
        <!--2016-02-21 ebb: Once again we needed to set this rule in its own pattern in order for it fire apparently because its context at least sometimes duplicates the context of the other rules for tei:rdg.-->
        <rule context="tei:rdg[parent::tei:app[following-sibling::text()]]">
            <report test="matches(parent::tei:app/following-sibling::text()[1], '^\s\S') and matches(., '\s$')">
                There's an extra white space to remove, either at the end of an rdg element or the text that follows after the app element closes.
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:div[@type='poem']//tei:title">
            <assert test="matches(., 'Poem\s\d+\s')">
                Titles of poems must be formatted correctly: They must begin with the word Poem follwed by a digit and a space.
            </assert>
        </rule>
    </pattern>
    <pattern>
        <rule context="tei:div[@type='poem'][following-sibling::tei:div]//tei:title">
            <assert test="(number(substring(., 6, 2)) + 1) eq number(following::tei:title[1]/substring(., 6, 2))">
                This poem appears to be out of sequence with its position in the text!
            </assert>
        </rule>
        
    </pattern>
    
<!--Extra schematron rules, not required for this assignment but useful in projects.-->
    
    <pattern>
  <!--2016-02-21 ebb:The next two patterns help to show how @xml:ids can function in a project. We make a standard list of unique identifiers for people, places, books, witnesses to a text somewhere, perhaps in the TEI header or perhaps in a separate file. That way we can point to those identifiers as a handy abbreviation whenever we are referring to them, as many times as we need to in the document. Each xml:id must be unique, so its value cannot be used more than once. In the body of your project files, you can point to that identifier as many times as you need to in *other* attributes (like @wit, @ref, etc.) by placing a hashtag in front of the xml:id (so you are not reusing the xml;id). 
The two Schematron patterns below provide a way to ensure you are preparing xml:ids without hashtags or white spaces. That's important because we *want to be able to use hashtags and white spaces* in the body of the documents when we need to point to the xml;id in yoru list of unique identifiers. We use white spaces when we need to refer to multiple entries in our list, like this:

<listPerson>
<person xml:id="benthamJ">
   <persName><surname>Bentham</surname>
   <forename>Jeremy</forename>
   </persName>
   <persName type="alias">Some Dude<persName>
   <. . .more info and tags to describe the person, perhaps birth and death dates, a biographical note etc.. . .>
<person>
<person xml:id="dickinsonE">
   <persName><surname>Dickinson</surname>
   <forename>Emily</forename>
   </persName>
  <. . .more info and tags to describe the person, perhaps birth and death dates, a biographical note etc.. . .>
<person>

In the homework, we prepared a list of editions with bibliography information about each, in a listWit or a list of witnesses, each one holding distinct identifying information about a different "witness" or editors' representation of Emily Dickinson's manuscript poems. Each edition produced distinct "variants" or different readings of the same document, as the editors "normalized" and changed Dickinson's poems in the different published editions. The Dickinson team needed to mark the different variants of particular lines in each poem, so they referred to the source of each variant by its unique identifier. They need a way to make sure they always type those in accurately, and for that we use the following two patterns, which you should feel free to adapt to your own projects!
  -->
        <rule context="@xml:id">
            <report test="starts-with(., '#')">
                xml:id attributes must not begin with a hashtag!
            </report>
            <report test="matches(., '\s+')">
                @xml:id values may NOT contain white spaces!
            </report>       
        </rule>
    </pattern>
    <pattern>
        <rule context="@wit">
            <let name="tokens" value="for $w in tokenize(., '\s+') return substring-after($w, '#')"/>
            <assert test="every $token in $tokens satisfies $token = //tei:TEI//tei:listWit//@xml:id">
                Every reading witness (@wit) after the hashtag must match an xml:id defined in the list of witnesses in this file!
            </assert>
  <!--2016-02-21 ebb: This rule permits us to use white space as a separator, so we can refer to multiple published editions that represent a particular variant in the text. We format that like so: <rdg wit="#df16 #fh #poems2"> (so this refers to three different editions, identified up in the TEI header by the xml:ids: df16, fh, and poems. 
      This does several things you've not seen before: 
      1) The "let" statement: This defines a *variable* in Schematron, and gives it a name ("tokens") which we can quickly refer to with a dollar-sign in front of it ("$token"). We can define a variable inside a rule to make it local (in which case the parser only "knows" about it and reads it within the context of a particular rule), OR we can define it *globally* and set it outside the patterns so it can be invoked everywhere. We make global variables when we need to write Schematron rules that point to other files, to see if a value of an attribute matches an xml:id defined in a separate project file, for example.  
      
      2) Dealing with multiple values: First, in our variable, we tokenized our @wit attribute on white space, and that created multiple values or token. So if we *do* use one or more white spaces in a @wit attribute, we use those white spaces as a dividing point: we separate the value into "tokens": so <rdg wit="#ce #poems2 #fh"> would be tokenized into three pieces. Our language, "for $w in tokenize(., '\s+'), defines a separate variable *for each one of these tokens*, since we need to look at them one by one. For each of these, we need to cut off the leading hashtag, so we do one more thing: return the substring-after($w, '#').
This creates three tokens in this format: 
      token 1: ce
      token 2: poems2
      token 3: fh
Now our assert test needs to do something more, so it can deal with a situation in which there's only one token OR multiple tokens. We can't just test ALL the tokens at once against each xml:id: Schematron needs to look at them one at a time: first ce, then poems2, then fh. For that we use this syntax:
<assert test="every $token in $tokens satisfies $token = //tei:TEI//tei:listWit//@xml:id">
The work of this is done by the language "every [singular] in [plural] satisfies [a test you design for the singular value]. 

  -->
        </rule>
    </pattern>
    
<!--2016-02-21 ebb: Go ahead and remove the comments around this pattern element if you want to use this as a guide to replacing straight quotes and apostrophes. Or, better yet, 
        write this as a replace operation using analyze-string() in XSLT or XQuery. 
        Note: There will certainly be possible combinations to watch for, like spaces inside quotations, or spaces after opening and before closing quotation marks, 
        and spaces in front of other kinds of quotation marks, so new rules could be
        added here!
        
        <pattern>
        <rule context="tei:l">
            <report test="matches(., ''&apos;')">
                Change the straight apostrophe to a curly apostrophe.
            </report>
            <report test="matches(., '&quot;')">
                Replace straight quotes with the appropriate left or right curly quotes.
            </report>
            <report test="matches(., '[”]\w')">
                There's a closing (right) curly quote appearing at the start of a quote. Change it to a left curly quote!
            </report>
            <report test="matches(., '\w[“]')">
                There's an opening (left) curly quote appearing at the end of a quote. Change it to a right curly quote!
            </report>
        </rule>
        
    </pattern>-->

</schema>
