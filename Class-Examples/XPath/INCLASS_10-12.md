#In-Class Example for 10/12/15
Using [WSGATableCh1 File] (https://github.com/RJP43/CitySlaveGirls-ChicagoDailyTimes1888/blob/master/McEnnisWhiteSlaveGirlsOfAmerica_XML/WSGATableCh1.xml)  

**Every answer to a question that is not a yes or no**    
In XPath Window: `//body//f[@name="response"][not(@select="Yes")][not(@select="No")]`  

Rob's Solution:
`//body//f[@name="response"][not(@select="Yes") and not(@select="No")]`  

**Get only the distinct answers other than Yes or No**   

In XPath Window: `distinct-values(//body//f[@name="response"][not(@select="Yes")][not(@select="No")]/@select)`  



