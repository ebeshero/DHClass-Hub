window.addEventListener('DOMContentLoaded',init,false);
function init() {
var buttons = document.getElementsByTagName("button");
buttons[0].addEventListener('click', showTable, false)
buttons[1].addEventListener('click', showTableRows2, false)
}

function showTable() {
var table1 = document.getElementById("ECCO")
if (table1.style.display == 'none') 
{table1.style.display='block';}
else {table1.style.display='none';}
} 
 /* You may be wondering why we don't code the "if" statement like this: if (table1.style.display = 'none'). That  won't work because '=' in JavaScript doesn't test for a condition of equality. Instead
 * it ASSIGNS a new value. So what you need to do to test for a condition is use the DOUBLE EQUAL SIGN: if (table1.style.display == 'none') 
 */


function showTableRows2() {
var table2 = document.getElementById("NCCO")
var tCells = table2.getElementsByTagName("td")
/*getElementsByTagName works to look for all the descendant elements of the "NCCO" table named "td". Then we set up a for loop to step through
 each table cell in turn. */
 for (var i = 0, length = tCells.length; i < length; i++)
if (tCells[i].style.display == 'none') 
{tCells[i].style.display='table-cell';}
else {tCells[i].style.display='none';}
}
/* Notice: we used a CSS display value here of "table-cell". We did that after trying the standard "block" and "inline" and seeing the output look
 * pretty awful in the browser. Lesson: Table elements have special CSS display properties, which can be found here:
 * http://www.w3schools.com/csSref/pr_class_display.asp
 * */