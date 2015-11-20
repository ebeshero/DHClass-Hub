window.addEventListener('DOMContentLoaded',buttons,false);
function buttons() {
  var buttons = document.getElementsByTagName("button");
	var button = buttons[0];
	button.onclick = show_hide;
}
function show_hide() {
  if (tableOfValues.style.visibility != "hidden") {
    tableOfValues.style.visibility = "hidden";
	}
	else {
	  tableOfValues.style.visibility = "visible"
	}
}
