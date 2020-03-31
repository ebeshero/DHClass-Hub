# Writing XQuery to Visualize Project Data in SVG

This tutorial is designed to show you how to work with XQuery in eXist-db to generate an SVG visualization. Along the way we will introduce you to user-defined functions in XQuery with an example that involves doing date and duration arithmetic to plot a timeline from XML data encoded using the `xs:dateTime` and `xs:duration` datatypes. 

## Accessing Rocket Launches project data, and using global variables
We work with XML data from the Spring 2020 [Rocket Launches project](http://rocket.newtfire.org) to create a timeline infographic using SVG. XML data for this project is stored in the [newtfire eXist-db](http://newtfire.org:8338), and we address the collection with XPath in the eXide window there as `collection('/db/rocket/')`. 

We want to show you some nifty “global” features in writing XQuery, so we’ll start by showing you how to write a global variable. We can begin a new XQuery file by declaring a global variable that addresses the collection:

```
declare variable $rocketColl := collection('/db/rocket/');
```

Notice the syntax of a global variable: it begins with the words “declare variable” and ends with a semicolon. In preparing files for generating SVG, global variables can be helpful, particularly if think you might want to work with multiple FLWOR statements later.  
Why make global variables? A global variable does pretty much the same thing as a top-level `let` statement in a FLWOR, but it is available anywhere and everywhere in your XQuery, for use in multiple FLWOR statements you might write. Since you might find yourself wanting to generate multiple SVG graph plots from your project data, you may find yourself writing a few separate FLWOR statements to draw on the same material. Also, you can define other helpful global things, like user-defined functions, which we’ll show you in the next section. Also, anything defined globally is listed in the outline view that you can find on the left-hand side of the eXide window.

## Surveying the Rocket Launches date and duration data
We created a 




