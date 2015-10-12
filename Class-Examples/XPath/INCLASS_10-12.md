#In-Class Example for 10/12/15  

1. Every answer to a question that is not a yes or no  
In XPath Window: `//body//f[@name="response"][not(@select="Yes")][not(@select="No")]`

2. Get only the distinct answers other than Yes or No 

In XPath Window: 'distinct-values(//body//f[@name="response"][not(@select="Yes")][not(@select="No")]/@select)'

