# Writing XQuery to Visualize Data in SVG
## With special features for plotting with date and duration data

### Quick navigation to the section you need:
* [Global variables](#Global-variables)
* [Processing Date and Duration data with User-defined Functions](#Processing-Date-and-Duration-data-with-User-defined-Functions)
     * [Unpacking the dateTime and duration datatypes](#Unpacking-the-dateTime-and-duration-datatypes)
     * [Writing user-defined functions to convert date and duration to decimal values](#Writing-user-defined-functions-to-convert-date-and-duration-to-decimal-values)
* [Writing XQuery to draw SVG](#Writing-XQuery-to-draw-SVG)

This tutorial is designed to show you how to work with XQuery in eXist-db to generate an SVG visualization. Along the way we will introduce you to user-defined functions in XQuery with an example that involves doing date and duration arithmetic to plot a timeline from XML data encoded using the `xs:dateTime` and `xs:duration` datatypes. 

## Global variables
For this exercise, we are working with XML data from the Spring 2020 [Rocket Launches project](http://rocket.newtfire.org) to create a timeline infographic using SVG. XML data for this project is stored in the [newtfire eXist-db](http://newtfire.org:8338), and we address the collection with XPath in the eXide window there as `collection('/db/rocket/')`. 

We want you to learn about some nifty “global” features in writing XQuery, so we’ll start by showing you how to write a global variable. We can begin a new XQuery file by declaring a global variable that addresses the collection:

```
declare variable $rocketColl as document-node()+ := collection('/db/rocket/');
```

Notice the syntax of a global variable: it begins with the words “declare variable” and ends with a semicolon. Also we are illustrating how to be super precise in “typing” a variable by indicating what kind of content it contains, whether that is a series of document nodes (as here, `document-node()+` means one or more document-nodes representing a collection of XML documents). 

Why make global variables? A global variable does pretty much the same thing as a top-level `let` statement in a FLWOR, but it is available anywhere and everywhere in your XQuery, for use in multiple FLWOR statements you might write. In preparing files for generating SVG, global variables can be helpful, particularly if think you might want to work with multiple FLWOR statements later, perhaps to generate multiple different kinds of plots from the same data sources that you want to make available across the file. You can think of FLWOR statements as local spaces that can draw upon any global variables that you declare. And you can declare other helpful global things, like user-defined functions, which we’ll show you in the next section. Anything defined globally is conveniently listed in the outline view that you can find on the left-hand side of the eXide window.

## Processing Date and Duration data with User-defined Functions
We began by surveying the kinds of date and duration data that the Rocket Launches project provides. Our first XQuery script shows us in concatenated strings what that data looks like. Find it in eXide by opening `/db/2020_ClassExamples/rocketDateDurationSurvey.xql`, or you can access [the file on the DHClass-Hub/Class-Examples/XQuery here ](https://github.com/ebeshero/DHClass-Hub/blob/master/Class-Examples/XQuery/rocket-date-duration-survey.xql). In eXide, you should hit `eval` on the file to review its output.

In this file we wrote two **user-defined functions** to process the `xs:dateTime` and `xs:duration datatypes` into a simpler decimal format that we can use for plotting lines and shapes in SVG. You can follow the comments we left in this file for details, and we will just briefly summarize here what we needed to process and how we did it. Our goal here is to give you enough information so you can write your own user-defined XQuery functions when you need them. If you are doing simple counts or arithmetic on your XML data, you probably will not need to write functions. But if you want to do more complex processing, like in this case, unpacking dateTime datatypes to be able to plot dates and durations along a line proportionally, it is helpful to define your own functions. 

### Unpacking the dateTime and duration datatypes
Launch dates are encoded in the Rocket Launches project using the xs:dateTime datatype in an `@sDateTime` attribute on the `<launch>` element. We accessed the launch dateTimes in the Rocket Launches project with this variable (and notice how we add a datatype for it). This global variable defines a series of dateTime values, which we sent to the XPath `sort()` function to organize them from earliest to latest.  

```
declare variable $launchDateTimes as xs:dateTime+ := $rocketColl//launch/@sDateTime ! xs:dateTime(.) => sort();
```

Here is how the xs:dateTime datatype is formatted in the first of our results: `1981-04-12T07:00:03`

This corresponds to a launch date of April 12, 1981 with a time of 7:00:03 in the morning.  (Note: The attribute value does not appear to be specifying a time zone, but if it were going to represent UTC or universal time according to the Prime Meridian, we would see a `Z` at the end, as in `1981-04-12T07:00:03Z`. Here are [some more examples](https://www.w3schools.com/xml/schema_dtypes_date.asp) of the dateTime datatype with time zones encoded.) For our purposes in plotting a timeline of launch dates and durations, the time of day is less important to us than the date information. We want to plot a timeline that shows how frequently space launches took place from the 1980s to the 2010s (or the latest available date in this collection). 

We could use the `tokenize()` function to strip the times off the dates, but we located a series of XPath functions designed to read in an `xs:dateTime` value and output [in the XPath specs](https://www.w3.org/TR/xpath-functions-31/#dates-times). Those specs are lengthy but readable, and we will just summarize them here: We learn that for `xs:dateTime` there are functions available to do “component extraction, order comparisons, arithmetic, formatted display, and timezone adjustment.” 

* **Component extraction** means, pull out the year, month, day, hour, minute, or second as a value (as we might do with tokenizing the parts of the datatype). 
* **Order comparisons** would help you evaluate and select dateTime values before or after a certain dateTime that you identify (evaluating dateTime values as less than or greater than each other, or setting them in sequence). 
* **Formatted display** is something we experimented with in [XPath Exercise 4](https://dh.newtfire.org/XPathExercise4.html) to convert an xs:dateTime like `2020-03-31T07:00` into a string like this `Tuesday, March thirty-first, two thousand and twenty at seven o’ clock am.` 
* **Time-zone conversion** would help us to take data given in one time-zone and convert it to another. 

#### Into the weeds of date arithmetic
Because we are interested in sorting values and doing date arithmetic, we wanted to see how simple arithmetic functions work on dateTime data in exist-dB. To experiment, we wrote a simple XQuery script which you can find at `/db/2020_ClassExamples/rocketSimpleDateArithmetic.xql`. It looks like this:

```xquery version "3.1";
declare variable $rocketColl := collection('/db/rocket/');
let $launchDateTimes as xs:dateTime := $rocketColl//launch/@sDateTime ! xs:dateTime(.) => sort()
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

We share this just to inform you how `xs:dateTime` and `xs:duration` are commonly processed in the universe of XML data. We also need to be aware of the limitations of that processing. If we want to draw SVG lines and shapes that indicate relative proportion and distance in time, SVG will not be able to read an xs:duration value or a xs:dateTime value directly. These datatypes will need to be converted to a decimal format (`xs:decimal`) in order to work out plotting them on a screen. 

In a perfect universe, there would be a ready-made function to convert the date and duration datatypes to a decimal notation. However, the documentation and our own experience shows us that it’s only possible conduct date arithmetic in XPath within the family of dateTime and duration datatypes (including `gYear`, `gYearMonth`, etc). We cannot simply convert those into decimal values automatically with something like `number()`, `xs:decimal()`, `xs:integer()`, or `xs:float()`. (Try it yourself and take a look at the error messages.) We are going to have to define our own functions to create a reasonable conversion of our dateTime and duration values into a decimal notation for plotting shapes on a screen. 

##### A sidenote for scholars of past centuries
Historical date arithmetic needs to deal with different calendar systems than our current Gregorian calendar system in use throughout most of the world and the world’s electronics. Fortunately, there are [calendar converters like this one](https://www.fourmilab.ch/documents/calendar/) to assist.)

### Writing user-defined functions to convert date and duration to decimal values
Here we explain how to write your own **user-defined functions** in XQuery, to address our problem of needing to generate decimal values from `xs:dateTime` and `xs:duration` datatypes. Like a global variable declaration, a function that you define is also available in a global way throughout an XQuery document. Think of a function as something to which you can send one or more nodes or values for processing to give you an output that you want. 

In our case, we need to define two functions:  
1) for converting durations into decimal values, and
2) for converting dateTime values into decimals

#### Writing a user-defined function
To write your own functions, you have to work in a different namespace. By default XQuery supplies a `local:` namespace for this, but we like the idea of defining our own functions in a personalized namespace that we make up. You can make up your own, and we encourage you to do so. A namespace is conventionally written in the format of a distinct URI only because it makes for a distinct identifier. Sometimes people prepare websites at a web address if people want to look up more information about a namespace (see for example [the website about the SVG namespace](https://www.w3.org/2000/svg)), but that isn't required. We simply declare our personal made-up namespace at the top of the file and that is all that is necessary. You make up the namespace and a prefix by which to refer to it, like this:

```
declare namespace ebb="http://newtfire.org";
```

Here I created a namespace designated by `http://newtfire.org` and I will refer to it with the three letters before the `=`: `ebb`. In my code, I'll follow the namespace prefix with a colon before introducing my function: `ebb:`.

Now I declare a function, which shares the `declare` language of a global variable definition. I will show the entire function in full (in the following subsection) so you can see how it works. 

##### User-defined conversion of xs:duration to xs:decimal
This user-defined function will convert the `xs:duration` datatype into an `xs:decimal` value: 
```
declare function ebb:durationConverter($dur as xs:duration?)
as xs:decimal?
{
let $d as xs:integer := days-from-duration($dur)
let $h as xs:integer := hours-from-duration($dur)
let $m as xs:integer := minutes-from-duration($dur)
let $s as xs:decimal := seconds-from-duration($dur)
let $durDec as xs:decimal := $d + $h div (24) + $m div (24 * 60) + $s div (24 * 60 * 60)
return $durDec
}; 
```
This function is declared with an `ebb: namespace prefix` and a name which I came up with to be descriptive. `ebb:durationConverter()` takes a single input argument designated inside the parentheses (`$dur`), and that argument needs to be a single duration value. (We could call that input argument anything we like, but it represents the data you will be sending to this function from elsewhere in your XQuery script.) The phrase `as xs:duration` indicates the dataType. The function will output new data in a different datatype, and that appears on the next line following the parentheses: `as xs:decimal` followed by the question mark. The question mark indicates that this is a *parameter*, that is, some value that will be passed into or out of this function. The input parameter goes inside the parentheses. After the parentheses, there is another `as` statement followed by a `?` to indicate the datatype of the output, here a decimal. 

The work of the function happens inside the set of curly braces `{ }`, and it is delivered in a simple FLWOR statement. Let’s unpack it.  Our function takes one input argument, a duration value, and it will output a decimal value. It then analyzes the xs:duration, unpacking its parts into four variables: 
 * $d (a value for the number of days)
 * $h (a value for the number of hours)
 * $m (for the number of minutes)
 * $s (for the number of seconds). 

The next variable contains the calculation to create a decimal value:
```
let $durDec as xs:decimal := $d + $h div (24) + $m div (24 * 60) + $s div (24 * 60 * 60)
```
Here we retain the total number of days as whole number, and convert the rest to a decimal. There are 24 hours in a day. (Divide the $h portion by 24) and add it to the days. There are 60 minutes in an hour, and 60 * 24 gives the total number of minutes in a day. So we divide the $m portion by 60 * 24) and add it to hours. There are 60 seconds in a minute. and 60 * 60 * 24 gives us the total number of seconds in a day. We then divide the $s portion by 60 * 60 * 24 and add that value to minutes and hours to give us a decimal conversion of days in the duration. 

##### Calling the user-defined function
Within our XQuery that is processing data from the Rocket Launch project, we can now call our new user-defined function. We will be doing that in multiple places, wherever we need to convert an `xs:duration` value into an `xs:decimal` value. Here is one such place in the code:

```
let $duration as xs:duration := $m/following-sibling::duration/@time ! xs:duration(.)
let $durDayDec as xs:decimal := ebb:durationConverter($duration) 
```
We are continuing our practice of *typing* the variables with `as` statements. The first variable, `$duration` extracts a duration value, and the next variable, `$durDecDay`, sends that duration value to our user-defined `ebb:durationConvert()` function, bundling `$duration` inside its parentheses as the parameter to be delivered for processing.


#### Converting xs:dateTime into an xs:decimal
Our durationConverter function will do the work of preparing decimal values from duration data, and we have multiple uses for it. As we discussed in [the earlier section on date arithmetic](Into the weeds of date arithmetic), when we subtract the `xs:dateTime` value of an early date from a later date, we return an `xs:duration` value in days. Knowing this, we can we can convert the dateTime value of each mission launch from the Rocket Project collection and convert it into a duration value. We will do that by working with the earliest of the dateTime values, the minimum value in the sequence of dateTimes. In our section of global variables we can isolate that earliest date to use it as our “ground zero” plotting the timeline. We can also isolate the latest date to help determine endpoint of the timeline: 

```
declare variable $launchDateTimes as xs:dateTime+ := $rocketColl//launch/@sDateTime ! xs:dateTime(.) => sort();
declare variable $minDateTime as xs:dateTime := $launchDateTimes => min();
declare variable $maxDateTime as xs:dateTime := $launchDateTimes => max();
```
Our XQuery code will need to loop through the sequence of `$launchDateTimes` in order to report and visualize information about each one:   
```
for $l in $launchDateTimes
```
As we mentioned, each `$l` will need to be converted to a decimal value based on its difference in days from the earliest mission. It is time to create another user-defined function to do this work. (We define these functions in their own section near the top of the document, together with other global declarations.)

```
declare function ebb:dateDecimalConverter($dT as xs:dateTime?) 
as xs:decimal?
{
let $dateAsDuration as xs:duration := $dT - $minDateTime
let $dateAsDurDec as xs:decimal := ebb:durationConverter($dateAsDuration)
return $dateAsDurDec
};
```
Notice that this function takes one input parameter in the `xs:dateTime` datatype, returns `xs:decimal` output. First, it subtracts the earliest mission launch dateTime value from that input dateTime, which in the way of XPath date arithmetic returns an `xs:duration`. The next line involves our first user-defined function, the durationConverter, to return our decimal value in days. 

Back in our XQuery code, we will call this new user-defined dateDecimalConverter function inside our `for-loop`:
```
for $l in $launchDateTimes
let $lDec as xs:decimal := ebb:dateDecimalConverter($l)
```
Now, each `$l` in `$launchDateTimes` will be processed in turn by that function, and be stored as the value of the variable `$lDec`. 

Here is a simple text output from our first XQuery designed to survey the data conversions: 
```
Launch Date: 1982-11-11T07:19:00, mission: STS-5: This Launch Decimal Date: 578.013159722222222222: Duration: P5DT2H14M26S: Decimal Notation:5.093356481481481481
```
### Writing XQuery to draw SVG

Now we are ready to begin plotting our SVG timeline! Our tasks are:
Our tasks are:

* To plot in SVG a line that represents time span of all the rocket launches in the collection from earliest to latest.

* To plot the mission dates in proportional relation to one another as SVG shapes along that line.

* To indicate the relative duration of each mission in the area of a shape (such as a circle or square) that we plot on the timeline. 

* To plot SVG text elements labelling the mission dates and identifiers. 

#### Structuring the code
We will work with the converted decimal data that we prepared to plot the dates and durations in visible screen space with SVG. Much as we do when writing XQuery to generate HTML, we declare a global variable to hold our output file to save to the database. We will also typically declare a global variable or two  holding just a number to help us add spacing for our plot in the X and Y directions. 

```
(: Global variables go up here :)
 declare variable $timelineSpacer := 10;
declare variable $maxDecDate as xs:decimal := ebb:dateDecimalConverter($maxDateTime); 
 declare variable $ThisFileContent := 
<svg xmlns="http://www.w3.org/2000/svg">
   <g>
      <line x1="??" y1="??" x2="??" y2="??" style="??;??;"/>  
   <!--ebb: The line element above will represent the start and end points of our line. You may choose to plot this vertically or horizontally. x1 and y1 will represent the earliest date, while x2 and y2 will represent the latest date. -->   
         {
         <!--ebb: FLWOR statements go here to process the data about each mission and plot it along our timeline.-->
         }
      
   </g>
</svg> ;
$ThisFileContent
```
Here we declared the global variable $ThisFileContent (so that its declaration ends with a semicolon after the the close tag of the `</svg>`. (You will remember and find on other examples how to use this variable after this point to it up for storage in your directory on our eXist-dB.) We are also "calling the variable" or returning its content in the return window by just entering it at the end here. This is how we recommend testing and viewing the SVG output as you are creating it.

#### Plotting the timeline
If we plot a vertical line that runs from top to bottom in chronological order, we can take advantage of the y-coordinate space that increases as we move down the screen with SVG. (Or you may, if you like, opt to plot your timeline horizontally instead, if you prefer to think of time scrolling from left to right.) Either way, we need to know how long our line should be. To measure it, remember that we want to mark a set of dates separated from each other by a regular interval (large enough to give us room to plot some information). We need to write variables to determine how many years we need to plot, and then separate them by regular space. We could do this by hand, and pound this out point by point, but since the Rocket Launches collection can always add more mission dates by adding current launch information, it would be better to write code that searches for the maximum and minimum date represented in the collection at any given time. (That means you could run your XQuery whenever the XML collection is updated and easily update your infographic with new data.)

In our starter script, we have already worked out decimal conversions of the dateTime data for each launch (as well as its duration). We need to add a couple of global variables to determine the length of the timeline. We use the XPath `min()` and `max()` functions to define variables identifying the earliest and latest years in our series. We need to make sure `min()` and `max()` are reading the sequence of launch dateTimes as the xs:dateTime() datatype, like so:

```
let $maxLaunchDateTime := $launchDateTimes ! xs:dateTime(.) => max()
let $minLaunchDateTime := $launchDateTimes ! xs:dateTime(.) => min()
```

We usually subtract the `min()` value from the `max()` and multiply by our spacer value to give us the full length of a timeline. The `min()` launch date becomes our `0,0` point, and the difference between `max()` and `min()` becomes the endpoint of the line. Remember that we need to calculate that as a decimal for SVG, and we now have a user-defined function that will calculate that for you. 

In our for-each loop, we will need to subtract the `min()` value from each mission dateTime decimal value, so we can plot from 0 (as the earliest launch). And just like we did with the `max()` value, we'll want to multiply it by our spacer, and adjust that spacer value so our plot is easy to read (neither too crowded nor too gappy). We'll output the actual dateTime and the mission identifier as labels for our data, and we'll use the duration for each mission to determine the relative size or area of the shape we wish to plot.

#### Namespace issues and Q{}
As soon as we create an SVG document in XQuery, we are placing the new code we generate in the SVG namespace. That means when writing an XQuery script inside the SVG root element, we will not be able to extract project data unless we indicate that it's in another namespace or no namespace. We indicate that using a special notation: `Q{}` set before any elements in an XPath reaching into project data. Attributes by default are not referenced in a namespace so you don’t have to indicate anything special aobut them. Here is how we had to change our variable to read the Rocket Launches data from within our XQuery script.

```
let $launchDateTimes := $rocketColl//Q{}launch/@sDateTime
```

#### Viewing your output

You should be able to plot the timeline now! Run your results with the Eval button, and view them as **Adaptive Output** in the results window to look at your code. You should see SVG generated with its namespace in the root node, and your should see a simple SVG file containing a line element. You can view the SVG as a graphic in XQuery by toggling the XML Output option to **Direct Output**, but you will probably need to scroll to see your entire line. That is because we need to set the width and height attributes on our SVG and set up the long vertical line to be viewable in a browser window on scrolling down.

#### Setting the viewport and shifting things with transform="translate(x, y)" so you can see the full line:

To make your long line visible, you want to estimate something wider than its widest x value and something a little longer than its largest y value so that you program a viewable area for your SVG. When generating SVG with calculated values as we are doing, this can be tricky, so we usually output our code first and read its maximum values before plugging in what is known as the viewport. To create a viewport, you need to add `@height` and `@width` attributes to your `<svg>` element. We did this in our SVG timeline by using raw numbers without units, estimating a bit beyond our largest y value and our widest x value, thinking about how wide we will eventually want to make our file.

We also decided to shift our SVG over a little bit so that if we use 0, 0 coordinates, the timeline won’t be flush against the top and side of the screen. To do this, we add `transform="translate(x, y)"` to the outermost `<g>` element, which bundles the all the SVG elements into a group. Using the `transform="translate(x, y)"`function, we adjust the x and y values of the plotted elements inside, moving them over by x units and up or down by y units. 

We have created a sample starter XQuery to SVG file for this exercise and stored it in our newtFire eXist-dB as `/db/2020_ClassExamples/rocketTimelineStarter.xql`.