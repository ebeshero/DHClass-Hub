# JavaScript Exercise
## Make SVG talk to HTML on the Same Page

Your task with this assignment is to learn from another project team’s code, and build a webpage for your project site that implements JavaScript to illuminate data in a list or table correlated to specific pieces of an SVG infographic.

### Study the Graveyard Project’s code: 
Take a look at the Graveyard Project team’s page sharing the [“Common Age of Death in Brush Creek Cemetery”](http://www.graveyard.newtfire.org/ageGraphOutput.html). View the page source in your browser to study the code.

Begin this exercise by taking notes (in a text or markdown file that you will submit to Courseweb for this exercise), observing how the file components fit together. Answer the following questions:

1. Look at the code of the HTML page: How are `@id` on SVG `<g>` elements related to `@id` on HTML elements? What would you have to do to the SVG version to make the HTML version? Can you write what you would have to do using an XPath function? 
1. Look at [the JavaScript file](http://www.graveyard.newtfire.org/ageGraph.js). What is JavaScript working over? What function sets the *event listeners* (to respond to mouseover) on the page, and what elements are given those event listeners? What function is triggered on mouseover?
1. How do the JavaScript functions work with DOM selectors? Look at [the standard JavaScript methods to retrieve DOM elements here](https://javascript.info/searching-elements-dom). Which DOM selector methods do you see in the Graveyard JavaScript file, and what elements are they retrieving in the web document?  
1. What is going on with the global variable `trow`? To define this as a *global variable*, it is just named at the top of the file with the line `var trow`, and that makes it available to be passed along and redefined or acted upon from function to function in the file. Each function calls it and redefines it.

    a. How is `trow` defined in `function initialize()`? 
  
    b. How is `trow` redefined in function `tableShow()`? To answer this, you need to understand what `this` is in the line: 
    ```js 
    trow = document.getElementById(this.id.split("_")[1]);
    ```
  
    c. What is `this`, and how is it altered by the JavaScript `split()` method? (Read [more about `split()` here](https://www.tracedynamics.com/javascript-split-string-method/#jssplit).) What portion of `this.id` is returned (realizing that JavaScript starts counting from 0)? How does Javascript find *another* element in the file containing the split-off portion of the `@id`? 
  
    d. What happens to `trow` in `function hide_last()`? Why is this the first action taken (to fire `function hide_last()`) in `function tableShow()`?

### Now, you try it: 

Now that you have studied the code from the Graveyard Project, **apply it to your project**. 

Output an SVG file, and output some HTML holding data that is keyed to it using attributes that you can reference with JavaScript DOM selector methods. 

Set these together on an HTML page (and make sure the combined code is well-formed and valid). 
  * See [Sara Soueidan’s tutorial on SVG viewport and viewbox](https://www.sarasoueidan.com/blog/svg-coordinate-systems/). 
  * Work with [CSS Flexboxes](https://medium.com/@js_tut/the-complete-css-flex-box-tutorial-d17971950bdc) to balance the portions of your webpage as you like it. 
  * If you are hiding some of the HTML or SVG code to be exposed on click or mouseover, set the CSS property `display:none;` on the appropriate elements in your CSS. You will want the code not to be displayed at first, and then be exposed in relevant portions to view with JavaScript. 

Write your JavaScript and CSS ideally as separate files linked with this file in the HTML `<head>` element. Write and adapt JavaScript functions to create dynamic effects when a user visits the page and exploring the data.

To finish and submit this assignment, do the following: 
* Sign your code in a comment. Indicate who wrote it and give the date (2019-04-10 Your Name). 
* Post your HTML, CSS, and JavaScript to your newtFire webspace (personal or project space) and to your GitHub repo. 
* Include a link to your published code in the text or markdown file you used to record your answers to the study of the Graveyard Project’s code, and submit this file to the JavaScript Ex 2 upload point on Canvas.



