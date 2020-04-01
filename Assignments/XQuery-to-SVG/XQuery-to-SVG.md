# Writing XQuery to Visualize Data in SVG
## With special features for plotting with date and duration data

This tutorial is designed to show you how to work with XQuery in eXist-db to generate an SVG visualization. Along the way we will introduce you to user-defined functions in XQuery with an example that involves doing date and duration arithmetic to plot a timeline from XML data encoded using the `xs:dateTime` and `xs:duration` datatypes. 

## Accessing Rocket Launches project data, and using global variables
For this exercise, we are working with XML data from the Spring 2020 [Rocket Launches project](http://rocket.newtfire.org) to create a timeline infographic using SVG. XML data for this project is stored in the [newtfire eXist-db](http://newtfire.org:8338), and we address the collection with XPath in the eXide window there as `collection('/db/rocket/')`. 

We want to show you some nifty “global” features in writing XQuery, so we’ll start by showing you how to write a global variable. We can begin a new XQuery file by declaring a global variable that addresses the collection:

```
declare variable $rocketColl := collection('/db/rocket/');
```

Notice the syntax of a global variable: it begins with the words “declare variable” and ends with a semicolon. In preparing files for generating SVG, global variables can be helpful, particularly if think you might want to work with multiple FLWOR statements later.  
Why make global variables? A global variable does pretty much the same thing as a top-level `let` statement in a FLWOR, but it is available anywhere and everywhere in your XQuery, for use in multiple FLWOR statements you might write. Since you might find yourself wanting to generate multiple SVG graph plots from your project data, you may find yourself writing a few separate FLWOR statements to draw on the same material. Also, you can define other helpful global things, like user-defined functions, which we’ll show you in the next section. Anything defined globally is conveniently listed in the outline view that you can find on the left-hand side of the eXide window.

## Surveying and Processing Date and Duration data with User-defined Functions
We began by surveying the kinds of date and duration data that the Rocket Launches project provides. Our first XQuery script shows us in concatenated strings what that data looks like. Find it in eXide by opening `/db/2020_ClassExamples/rocketDateDurationSurvey.xql`, or you can access [the file on the DHClass-Hub/Class-Examples/XQuery here ](https://github.com/ebeshero/DHClass-Hub/blob/master/Class-Examples/XQuery/rocket-date-duration-survey.xql). In eXide, you should hit `eval` on the file to review its output.

In this file we wrote two **user-defined functions** to process the xs:dateTime and xs:duration datatypes into a simpler decimal format that we can use for plotting lines and shapes in SVG. You can follow the comments we left in this file for details, and we will just briefly summarize here what we needed to process and how we did it. Our goal here is to give you enough information so you can write your own user-defined XQuery functions when you need them. If you are doing simple counts or arithmetic on your XML data, you probably will not need to write functions. But if you want to do more complex processing, like in this case, unpacking dateTime datatypes to be able to plot dates and durations along a line proportionally, it is helpful to define your own functions. 

## Unpacking the dateTime and duration datatypes
Launch dates are encoded in the Rocket Launches project using the xs:dateTime datatype in an `@sDateTime` attribute on the `<launch>` element. We accessed the launch dateTimes in the Rocket Launches project with this variable:

```
let $launchDateTimes := $rocketColl//launch/@sDateTime
```

Here is how the xs:dateTime datatype is formatted in one of our results: `1981-04-12T07:00:03`

This corresponds to a launch date of April 12, 1981 with a time of 7:00:03 in the morning.  (Note: The attribute value does not appear to be specifying a time zone, but if it were going to represent UTC or universal time according to the Prime Meridian, we would see a `Z` at the end, as in `1981-04-12T07:00:03Z`. Here are [some more examples](https://www.w3schools.com/xml/schema_dtypes_date.asp) of the dateTime datatype with time zones encoded.) For our purposes in plotting a timeline of launch dates and durations, the time of day is less important to us than the date information. We want to plot a timeline that shows how frequently space launches took place from the 1980s to the 2010s (or the latest available date in this collection). 

We could use the `tokenize()` function to strip the times off the dates, but we located a series of XPath functions designed to read in an `xs:dateTime` value and output [in the XPath specs](https://www.w3.org/TR/xpath-functions-31/#dates-times). Those specs are lengthy but readable, and we will just summarize them here: We learn that for `xs:dateTime` there are functions available to do “component extraction, order comparisons, arithmetic, formatted display, and timezone adjustment.” 

* Component extraction means, pull out the year, month, day, hour, minute, or second as a value (as we might do with tokenizing the parts of the datatype). 
* Order comparisons would help you evaluate and select dateTime values before or after a certain dateTime that you identify (evaluating dateTime values as less than or greater than each other, or setting them in sequence). 
* Formatted display is something we experimented with in XPath Exercise 4 to convert an xs:dateTime like `2020-03-31T07:00` into a string like this `Tuesday, March thirty-first, two thousand and twenty at seven o’ clock am.` 
* Time-zone conversion would help us to take data given in one time-zone and convert it to another. 

### Into the weeds of date arithmetic
Because we are interested in sorting values and doing date arithmetic, we wanted to see how simple arithmetic functions work on dateTime data in exist-dB. To experiment, we wrote a simple XQuery script which you can find at `/db/2020_ClassExamples/rocketSimpleDateArithmetic.xql`. It looks like this:

```
xquery version "3.1";
declare variable $rocketColl := collection('/db/rocket/');
let $launchDateTimes := $rocketColl//launch/@sDateTime ! xs:dateTime(.) => sort()
let $ldt-one := $launchDateTimes[1]
let $ldt-two := $launchDateTimes[2]
return 
string-join(($ldt-one, $ldt-two, ($ldt-two - $ldt-one)), ', ')
```
This XQuery reaches into the rocket collection and defines `$launchDateTimes` as a sequence of all the values of `@sDateTime`. We needed to make sure the XQuery processor recognized these as xs:dateTime, so we mapped each value as such with `xs:dateTime(.)`. Then we used the arrow operator to apply a `sort()` function, which should sort the dates from earliest to latest. The variable `$launchDateTimes` then contains a sorted sequence of dateTime values (which you can test for yourself by commenting out and altering our return statement). 

We next wanted to test how date arithmetic works. We defined `$ldt-one` and `$ldt-two` to return the first and second values in our sorted sequence of dateTimes. We returned a simple string to show us the first and second dates, and the results of a simple subtraction of one from the other with a minus sign. When we `eval` this in eXide we see:

```
"1981-04-12T07:00:03, 1981-11-12T10:09:59, P214DT3H9M56S"
```

The third value here, `P214DT3H9M56S`, is an **xs:duration** datatype indicating that the difference between November 12, 1981 at 7:00:03 and April 12, 1981 at 10:09:59 is 214 days, 3 hours, 9 minutes, and 56 seconds. As a further experiment, we tried to see what would happen if we changed the minus to a plus, to *add* the two dates. This returned an error message that indicated the operand after the plus sign should be a duration of some kind, not a date. (This makes sense if you think about it. We would commonly do date arithmetic to find out how far apart in time two dates are using simple subtraction, and by trying to calculate what the date would be after a certain duration: what will be the date 90 days from now?) 

We share this just to inform you how dateTime and duration are commonly processed in the universe of XML data. We also need to be aware of the limitations of that processing. If we want to draw SVG lines and shapes that indicate relative proportion and distance in time, SVG will not be able to read an xs:duration value or a xs:dateTime value directly. These datatypes will need to be converted to a decimal format (xs:decimal or xs:float) in order to work out plotting them on a screen. 

In a perfect universe, there would be a ready-made function to convert the date and duration datatypes to a decimal notation. However, the documentation and our own experience shows us that it's only possible conduct date arithmetic in XPath using the collection of dateTime and duration datatypes (including `gYear`, `gYearMonth`, etc). We cannot simply convert those into decimal values automatically with something like `number()`, `xs:decimal()`, `xs:integer()`, or `xs:float()`. (Try it yourself and take a look at the error messages.) We are going to have to define our own functions to create a reasonable conversion of our dateTime and duration values into a decimal notation for plotting shapes on a screen. 

## Writing user-defined functions for converting date and duration to decimal values



```
Launch Date: 1981-04-12T07:00:03, mission: STS-1: 
This Launch Decimal Date: 1981.279452054794520548: 
Duration: P2DT6H20M53S: Decimal Notation:2.264502314814814815
```








