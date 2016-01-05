##In Class 10-26-15    
###XPath Exam   
 * Access through Courseweb under Tests Tab 
 * 20 minutes (with 10 minute grace if necessary)  
 * Link for submissions will be removed immediately after exam  
 * Solution Posted to GitHub after class 

###Review Issues from Previous Assignment     
 *  [XSLT Exercise 4](http://newtfire.org/dh/XSLTExercise4.html)  
 *  Link for submissions will be removed at the start of class
 *  Solution Posted to GitHub after class  
 *  Reference: [Attribute Value Templates](http://dh.obdurodon.org/avt.xhtml)

###Discuss [XSLT Exercise 5](http://newtfire.org/dh/XSLTExercise5.html)      
 * In-Class Lesson: 
	1.  `collection()` function and the `$`  
	2.  `@mode` on `<xsl:apply-templates select=".XPath.Expression"/>`  
	3.  setting `@class` of the `<span>` element equal to another attribute (using AVT)      
 * **Examples:**  
Using [Shakespeare Sonnets](https://github.com/ebeshero/DHClass-Hub/tree/master/Class-Examples/XSLT/ExamplesFrom10-26_10-28_10-30/sonnets)   

Collection Function:

`<xsl:variable name="sonnetColl" select="collection('sonnets')"/>` with `<xsl:apply-templates select="$sonnetColl//sonnet"/>`

Modal XSLT:
  
`<xsl:apply-templates select="$sonnetColl//sonnet" mode="toc"/>` with `<xsl:template match="sonnet" mode="toc">` 
  
Using AVT: 

`<xsl:template match="sonnet">
        <h3 id="sonnet{@number}">
            <span class="sonnetNumber">
                <xsl:apply-templates select="@number"/>
            </span>
        </h3>
        <xsl:apply-templates/>
    </xsl:template>`

NOTICE WHERE THERE ARE `{}` !!!

##In Class 10-28-15  
###Review Issues from Previous Assignment     
 *  [XSLT Exercise 5](http://newtfire.org/dh/XSLTExercise5.html)  
 *  Link for submissions will be removed at the start of class  
 *  Solution Posted to GitHub after class    
   
###Discuss [XSLT Exercise 6](http://newtfire.org/dh/XSLTExercise6.html)   
* In-Class Lesson: 
	1.  `xsl:sort`  
	2.  `translate()` function  
	3.  making links with AVT  



##In Class 10-30-15    
###Review Issues from Previous Assignment    
 *  [XSLT Exercise 6](http://newtfire.org/dh/XSLTExercise6.html)  
 *  Link for submissions will be removed at the start of class  
 *  Solution Posted to GitHub after class 

###Discuss [XSLT Exercise 7](http://newtfire.org/dh/XSLTExercise7.html)    
* In-Class Lesson: 
	1.  `xsl:if` and `xsl:choose` Conditionals 
	2.  `<xsl:for-each>`  







