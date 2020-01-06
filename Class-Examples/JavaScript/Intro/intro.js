window.addEventListener('DOMContentLoaded',bunny,false);

function bunny() {
    alert ('Hi there! Looks like the page loaded! Yay!');
    var buttons = document.getElementsByTagName("button")
buttons[0].addEventListener('click', changeColor,false)
buttons[1].addEventListener('click', changeColor2, false)
buttons[2].addEventListener('click', newFunction, false)
buttons[3].addEventListener('click', anotherFunction, false)
}


function changeColor() {
var p1 = document.getElementById("colorToggle")
{p1.style.backgroundColor = "skyblue";}
/* here, style is a *property*: the CSS styling of an element: you can add a CSS property after invoking style. */
}

function changeColor2() {
var pars = document.getElementsByTagName('p')
    for (var i = 0, length = pars.length; i < length; i++) {
        pars[i].style.backgroundColor = "pink";
    }   
}

function newFunction() {
alert ('YO! This is function is firing!!');
var li = document.getElementsByTagName('li')    
   for (var i = 0, length = li.length; i < length; i++) {
        li[i].style.backgroundColor = "green";
    }  
}

function anotherFunction() {
var anothers = document.getElementsByClassName('stuff')
    for (var i = 0, length = anothers.length; i < length; i++) {
        anothers[i].style.cssText = "text-decoration: underline; text-decoration-style: wavy;"   
    }
}








