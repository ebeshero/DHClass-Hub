xquery version "3.1";
declare namespace ebb="http://newtfire.org";
declare variable $rocketColl := collection('/db/rocket/');
(: ebb: This script introduces you to user-defined functions in XQuery. 
These can be useful for taking values from your XQuery variables and performing a conversion, as we're doing here.
Since the Rocket Launches project has multiple attributes encoding launch dates and landing dates in the same xs:dateTime format, 
and since they work with the xs:duration datatype too, for coding how long a mission lasted, 
we can work with these data to do "date arithmetic" to make simple graphs and charts if we can convert it to a simple decimal notation.
Let's start reading this by skipping past the section I've marked off with asterisks as USER-DEFINED FUNCTIONS, and come back to it :) 

(: **************** USER-DEFINED FUNCTIONS **************************:) 
(: CONVERT DATETIME to DECIMAL :)
(: ebb :This user-defined function will unpack the date components from an input xs:dateTime datatype.
We will first extract the year from the datatype with year-from-dateTime(), 
and then use format-dateTime() to return a 'picture string' that will give us the date's numerical position in the year. 
We then divide that date number by 365 (since most years have 365 days). 
This will give us a decimal format we can use in making charts and graphs. :)
declare function ebb:dateDecimalConverter($dT as xs:dateTime) 
as xs:decimal?
{
let $year := year-from-dateTime($dT) ! xs:integer(.)
let $dayInYear := format-dateTime($dT, '[d]') ! xs:integer(.)
let $decimalDay := $dayInYear div 365 
return $year + $decimalDay
};
(: CONVERT DURATION TO DECIMAL :)
(: ebb: The next user-defined function will convert the xs:duration datatype into a decimal value based on number of days. 
 : If we input a duration indicating 1 day, 6 hours, and 0 minutes, we should return 1.25 from this function. 
 : Our function takes four input arguments: $d (a value for the number of days), $h (a value for the number of hours),
 : $m (for the number of minutes), and $s (for the number of seconds). In our XQuery, we created variables to separate each of these values 
 : and submitted them as the input to this function.
 : Here's what we're calculating: There are 24 hours in a day. (Divide the H portion by 24) and add it to the days.
 : There are 60 minutes in an hour, and 60 * 24 gives the total number of minutes in a day. 
 : So we divide the M portion by 60 * 24) and add it to hours.
 : There are 60 seconds in a minute. and 60 * 60 * 24 gives us the total number of seconds in a day. 
 : We then divide the S portion by 60 * 60 * 24 and add that value to minutes and hours to give us 
 : the decimal proporition of a day in the duration. Finally we add that to the number of days in the duration. 
 : :)
declare function ebb:durationConverter($d as xs:integer, $h as xs:integer, $m as xs:integer, $s as xs:integer?)
as xs:decimal?
{
let $TDec := $h div 24 + $m div (60 * 24) + $s div (60 * 60 * 24)
return $d + $TDec
}; 
(: *******************END USER-DEFINED FUNCTIONS ********************** :)

let $launchDateTimes := $rocketColl//launch/@sDateTime
for $l in $launchDateTimes
(: To do date arithmetic, take a look at these functions: https://www.w3.org/TR/xpath-functions-31/#dates-times
 : We'll write a user-defined function to convert this datatype into a decimal notation. :)
let $lDec := ebb:dateDecimalConverter($l)
let $m := $rocketColl//launch[@sDateTime = $l]/preceding-sibling::sts
let $mID := $m  ! tokenize(., ':')[1]


let $duration := $m/following-sibling::duration/@time
(: ebb: To do duration arithmetic, start by looking at the functions here: 
: https://www.w3.org/TR/xpath-functions-31/#durations
 : Let's try representing durations in terms of days with a decimal. 
 : We'll write a user-defined function to convert hours, minutes, and seconds into a fraction of the day. :)
let $durDays := days-from-duration($duration)
let $durHours := hours-from-duration($duration)
let $durMins := minutes-from-duration($duration)
let $durSecs := seconds-from-duration($duration)
(: Now in line 43, we send our variables to our user-defined function for turning date datatypes into decimal values. :)
let $durDayDec := ebb:durationConverter($durDays, $durHours, $durMins, $durSecs) 

order by $lDec
return concat('Launch Date: ', $l, ', mission: ', $mID, ': This Launch Decimal Date: ', $lDec, 
': Duration: ', $duration, ': Decimal Notation:', $durDayDec)