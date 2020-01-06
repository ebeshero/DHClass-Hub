var trow;
function initialize() {
   var svgSelect = document.querySelectorAll('g[id]');
  for (var i = 0; i < svgSelect.length; i++) 
  {
    svgSelect[i].addEventListener('mouseover', tableShow, false);
  }
  trow = document.getElementById('0to2');
}
function tableShow() {
  hide_last();
  trow = document.getElementById(this.id.split("_")[1]);
  trow.style.display = "table-row";

}

function hide_last() {

  trow.style.display = "none";
}
window.onload = initialize;
