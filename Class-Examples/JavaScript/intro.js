


function init() {
var button = document.getElementsByTagName("button");
button[0].addEventListener('click', toggle, false);
    
}

/*function toggle() {
    var span = document.getElementsByClassName("grab")
    
    if (span[0].style.backgroundColor !=="yellow")
    {
        span[0].style.backgroundColor = "yellow"
    }
    else 
    span[0].style.backgroundColor = ""
}
/*
/*Notice how the function as written above only highlights the FIRST span. To highlight more than one, see the code below:*/

function toggle() {
var span = document.getElementsByClassName("grab")
for (var i = 0; i < span.length; i++) 
if (span[i].style.backgroundColor !== "yellow") {
span[i].style.backgroundColor = "yellow"
}
else span[i].style.backgroundColor = ""
    
}
   
  


window.onload = init;