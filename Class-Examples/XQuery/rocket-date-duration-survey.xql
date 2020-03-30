xquery version "3.1";
declare namespace ebb="http://newtfire.org";
declare variable $rocketColl := collection('/db/rocket/');
(: ebb :The user-defined function in line 6 will unpack the date components from the dateTime in this attribute using year-from-dateTime(), and a picture string that will give us the date's numerical position as the nth day in the year. We can turn that into a decimal by dividing it by 365 (since most years have 365 days). This will give us a decimal format we can use. :)
declare function ebb:dateDecimalConverter($dT as xs:dateTime) 
as xs:decimal?
{
let $year := year-from-dateTime($dT) ! xs:integer(.)
let $dayInYear := format-dateTime($dT, '[d]') ! xs:integer(.)
let $decimalDay := $dayInYear div 365 
return $year + $decimalDay
};
(: ebb: The next user-defined function will convert the xs:duration datatype into a decimal value based on number of days. 
 : So if we input a duration indicating 1 day, 6 hours, and 0 minutes, we should return 1.25 from this function.  
 : Here's what we're calculating: There are 24 hours in a day. (Divide the H portion by 24) and add it to the days.
 : There are 60 minutes in an hour. (Divide the M portion by 60 * 24) and add it to hours.
 : There are 60 seconds in a minute (Divide the S portion by 60 * 60 * 24) and add it to minutes and hours
 : :)
declare function ebb:durationConverter($d as xs:integer, $h as xs:integer, $m as xs:integer, $s as xs:integer?)
as xs:decimal?
{
let $TDec := $h div 24 + $m div (60 * 24) + $s div (60 * 60 * 24)
return $d + $TDec
}; 

let $launchDateTimes := $rocketColl//launch/@sDateTime
for $l in $launchDateTimes
(: To do date arithmetic, take a look at these functions: https://www.w3.org/TR/xpath-functions-31/#dates-times
 : We'll write a user-defined function to convert this datatype into a decimal notation. :)
let $lDec := ebb:dateDecimalConverter($l)
let $m := $rocketColl//launch[@sDateTime = $l]/preceding-sibling::sts
let $mID := $m  ! tokenize(., ':')[1]


let $duration := $m/following-sibling::duration/@time
(: ebb: To do duration arithmetic, start by looking at the functions here: https://www.w3.org/TR/xpath-functions-31/#durations
 : Let's try representing durations in terms of days with a decimal. We'll write a user-defined function to convert hours, minutes, and seconds into a fraction of the day. :)
let $durDays := days-from-duration($duration)
let $durHours := hours-from-duration($duration)
let $durMins := minutes-from-duration($duration)
let $durSecs := seconds-from-duration($duration)
(: Now in line 43, we send our variables to our user-defined function for turning date datatypes into decimal values. :)
let $durDayDec := ebb:durationConverter($durDays, $durHours, $durMins, $durSecs) 

order by $lDec
return concat('Launch Date: ', $l, ', mission: ', $mID, ': This Launch Decimal Date: ', $lDec, ': Duration: ', $duration, ': Decimal Notation:', $durDayDec)