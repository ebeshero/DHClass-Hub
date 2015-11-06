(Solution file adapted from Obdurodon)
## The text

In a three-way election for Best Stooge Ever, each candidate (Curly, Larry, Moe) wins between 0% and 100% of the votes. Assume that all votes are cast for one of the three candidates (no abstentions, write-ins, invalid ballots, etc.), which means that when you add the percentages for the three candidates, the result must be exactly 100%. Assume also that we’re recording percentage of the vote, not raw votes, and that the percentages are all integer values. (In Real Life we’d probably record the raw count and calculate the percentages, but in real life we wouldn’t be voting for Best Stooge Ever in the first place!) Here’s a Relax NG schema for the results of the election:

`start = results`

`results = element results { stooge+ }`

`stooge = element stooge { name, xsd:int }`

`name = attribute name { "Curly" | "Larry" | "Moe" }`

Here’s a sample XML document that is valid against the preceding schema:

`<results>`

    `<stooge name="Curly">50</stooge>`

    `<stooge name="Larry">35</stooge>`

    `<stooge name="Moe">15</stooge>`

`</results>`

We could have written a better Relax NG schema, but we didn’t, and although our sloppy schema works with the results above, it also allows erroneous results like the following:

`<results>`

    `<stooge name="Curly">55</stooge>`

    `<stooge name="Larry">38</stooge>`
    `<stooge name="Moe">11</stooge>`

`</results>`

##The task

The problem here is that the three percentage values total 104%, and no matter how good our coding, it is not possible to prevent this type of error by using Relax NG alone. Your assignment is to write a Schematron schema that verifies that the three percentages always total exactly 100%. Test your results by creating the Relax NG schema, your Schematron schema, and a sample XML document that you can validate against both schemas in `<oXygen/>`. Enter correct and incorrect values and verify that the Schematron schema is working correctly. For homework, upload only your Schematron schema.

## Our solution

`<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">`

    `<pattern>`

        `<rule context="results">`

            `<assert test="sum(stooge) eq 100">`

                `The sum of the vote percentages does not equal 100%.`

            `</assert>`

        `</rule>`

    `</pattern>`

`</schema>`

The Schematron file that we wrote uses only one `<rule>` inside one `<pattern>`, and we defined the value of the `@context` attribute of our <rule> element (equivalent to the `@match` attribute we used in `<xsl:template/>` elements) as results, which is an XPath pattern (not a full XPath path expression). Any <results> element in our document will be submitted to any tests we define inside this `<rule>`. The test inside the `<assert>` element verifies that the sum of the values of all `<stooge>` elements that are children of the current context (the `<results>` element) does not exceed 100. We used `<assert>` instead of `<report>` because assert is positive, meaning it is easy to assert the equivalence of two values, whereas if we had used report, which has a negative perspective, we would have had to test two cases, one where the sum is less than 100, and one where the sum is greater than 100. (Or we could have wrapped the `not()` function around the test to invert the result, but that would feel like a double negative, and double negatives make our heads hurt.) This test uses the XPath `sum()` function to total the values of all stooge elements located on the child axis of our current context, `<results>`, and compare that value to 100.

Inside the `<assert>`, we write an error message that Schematron will generate when this test is failed and the XML document breaks the rules. We put, "The sum of the vote percentages does not equal 100%," but you could have written anything that you feel would be informative to someone trying to correct the error.

## The optional challenge tasks

You can stop here and consider the assignment complete, but for more Schematron practice, you’re welcome to add additional rules to check for additional types of error. The following types of errors could have been controlled by writing a better Relax NG schema, but for the purpose of learning Schematron, let’s do it in Schematron:

There should be exactly three votes, with exactly one for each Stooge. No duplicate Stooges and no missing Stooges.
Each individual Stooge’s vote should range from 0 to 100. No negative integers and no integers greater than 100. (The Relax NG schema is ensuring that all values are integers, so you don’t have to worry about that.)

## Our optional challenge solution

`<?xml version="1.0" encoding="UTF-8"?>`

`<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">`

    `<pattern>`

        `<rule context="results">`

            `<assert test="sum(stooge) eq 100">`

                `The sum of the vote percentages should equal 100%.`

            `</assert>`

            `<assert test="count(stooge) eq 3">`

                `There should be exactly 3 stooges.`

            `</assert>`

            `<assert test="count(stooge) eq count(distinct-values(stooge/@name))">`

                `No two stooges should have the same name.`

            `</assert>`
        
	`</rule>`

        `<rule context="stooge">`

            `<report test="number(.) lt 0 or number(.) gt 100">`

                `Vote percentages must be between 0 and 100.`

            `</report>`

        `</rule>`

    `</pattern>`

`</schema>`

To specify that there should be three stooges, we added a second `<assert>` within the same rule, since we also want to do a single-value comparison here. It is easier to assert that something matches a finite value than to report anything counterfactual to that value. This time we use the `count()` function to count stooges on the child axis, and compare that value to 3. To test that no stooges are repeated, we take advantage of the `@name` attribute and compare the count of all stooges against the count of the distinct values of stooge names. If all of the names are distinct from one another, the count of stooges will be equal to the count of distinct stooge names.

Finally, we want to test that for any given stooge, the vote percentage is within the range from 0 to 100. Since this is something that applies to a stooge specifically and not the <results> element as a whole, we created a new `<rule>` where the value of the `@context` attribute is now stooge. This means that it will fire once for each `<stooge>` element, and that it will check the value for that individual stooge. Inside that rule, we used a `<report>`, which outputs its message when the test inside it is true (because it is reporting that the real situation matches what the test requires), as opposed to `<assert>`, which triggers when false (because it is informing the developer that something asserted has failed to be satisfied). The test here is whether the percentage of votes for the stooge being examined is less than 0 or greater than 100, and we separate these using the XPath or logical operator. To correctly test the value of each stooge’s content without getting a stylesheet error, we used the XPath `number()` function, which converts the content (a string of characters) into a number if possible, or into the special value `NaN` (Not a Number) if not. If the content of one of our `<stooge>` elements is not a number (e.g., an error like `<stooge name="Moe">Moe</stooge>`, which is unlikely, but nonetheless worth guarding against) or is not within the range from 0 to 100, an error will be thrown, targeted at the specific `<stooge>` whose numbers were fudged, because `<stooge>` is the context of our rule.

### A note about NaN: 

NaN exists to cater to situations where you need to perform numerical comparisons and you can’t be certain that you won’t wind up having to evaluate a value that can’t be converted to a number. We used this in real life in a situation where we had to sort some years numerically, and in the field where we were entering years, in some cases we had the string value unknown. That number('unknown') evaluates to NaN, and NaN can be compared to a real number without throwing an error, enabled us to sort by year without having to convert unknown explicitly into a fake numerical value. NaN has the unique mathematical property of being simultaneously neither equal nor not equal to itself!