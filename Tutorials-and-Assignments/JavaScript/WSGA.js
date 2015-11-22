/* 2015-11-21 ebb: JavaScript to respond on click of bars on SVG graph 
to show/hide rows of associated HTML table. */

var trow; // current one-question row in table

function init() {
//window.alert("hi!");
  var svgSelect = document.querySelectorAll('g[id]');
  for (var i = 0; i < svgSelect.length; i++) {
    svgSelect[i].addEventListener('click', tableShow, false);
    } 
    trow = document.getElementById('QA1');
  }

function tableShow() {
    /*window.alert("function tableShow is firing, and this.id (split after the SVG portion) is: " + this.id.split("-")[1]);*/
  
    hide_last(); 
     this.style.stroke = 'red';
    trow = document.getElementById(this.id.split("-")[1]);
  trow.style.display = "table-row";
  document.getElementById('selectedQA').innerHTML = this.id.split("-")[1];
}



function hide_last() {
var gRed = document.querySelectorAll('g[id]');
for (var i = 0; i < gRed.length; i++) 
if (gRed[i].style.stroke='red'){gRed[i].style.stroke=''};
  trow.style.display = "none";
 
  }
  
  

window.onload = init;