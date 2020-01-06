var originalColor; /* ebb: This defines a global variable, so it can be passed from function to function and redefined. */
window.addEventListener('DOMContentLoaded', init, false);
/* This is our first event listener, and it responds to loading the content of the web page. It fires a function named init, defined next.  */

function init() {
    alert('The page loaded!');
    originalColor = document.getElementsByClassName("p-for-banner")[0].style.color 
    /* ebb: The originalColor variable here is set to whatever it is when the page loads */
    var bannerNames = document.getElementsByClassName("p-for-banner");
for (var i = 0; i < bannerNames.length; i++) {
        bannerNames[i].addEventListener('mouseover', mouseOver, false);
    }
}

function mouseOver() {
    turnOff();   /*ebb: Here is one way to handle an on-off or show/hide, or any kind of change that you want to happen to just one thing at a time. You can create a function FIRST to TURN EVERYTHING BACK to its original state, and NEXT, fire only on "this", which is **the current element from the event listener that the visitor has selected**. 
     * Another way to handle an on/off or show/hide change can be written inside this function with JavaScript if-then-else statements: If the color is already red to start with, then change it back to the originalColor; else just change it to red. For an example showing this syntax, with more extensive options for color switching, see http://dh.obdurodon.org/javascript_piece-by-piece.xhtml : You can scroll to the bottom and look at the complete file. 
     * */
    this.style.color = "red";
}

function turnOff() {
/* ebb: With our simple turnOff function, we turn everything back to its original color, preventing the user from highlighting all the menu items.*/
 var bannerNames = document.getElementsByClassName("p-for-banner");
for (var i = 0; i < bannerNames.length; i++){
    bannerNames[i].style.color = originalColor
}   
    
}
