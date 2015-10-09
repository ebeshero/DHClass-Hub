#In-Class Example: XPath 10/9/15

##### [Playing with the Mitford Site Index](https://github.com/ebeshero/DHClass-Hub/blob/master/Class-Examples/XPath/si-modified.xml)

Familiarize with the Document using the oXygen  Outline view

- check out the div type="historical people"
- can't use RegEx to find a full name like our example George Mitford 
- lets navigate instead with XPath

##Using XPath:

 Know we are looking in div type="historical people"

* in XPath - 

`//div[@type="historical_people"]//person`

gets 324 results - this is a start

 Know we are looking for forename George and surname Miford and want to return information inside of the element 

* in XPath - 

`//div[@type="historical_people"]//person[.//surname = "Mitford"]/@xml:id`

gives us the 3 xml IDs of people with surname Mitford

Dot `.` delimits. 
Without the dot the `//` goes all the way back to the root element whereas we want the surnames to be caught on the person element.

* in XPath - 

`distinct-values(//*[@xml:id]/name())`

this gives us 7 results giving us the distinct values of the elements that contain xml IDs - Distinct Values removed the XPath content from the results so we have just a list of the names of elements that have xml IDs as children


How about looking for every person that doesn't have a surname searching anywhere in the document?

* in XPath - 

`//person[not(.//surname)]`

AGAIN THE DOT `.` DELIMITS!!!


How to get every surname that forename doesn't come after?

* in XPath - 

`//surname[not(following-sibling::forename)]`




 

