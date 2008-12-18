// tooltip widget
/* ohne moseover
function toggleTooltip(event, element) { 
  var __x = Event.pointerX(event);
  var __y = Event.pointerY(event);
  //alert(__x+","+__y);
  element.style.top = __y + 5;  
  element.style.left = __x - 40;
  element.toggle();
}
*/
  
 
// tooltip widget with mouseover
function positionTooltip(event, element){
var __x = Event.pointerX(event);
  var __y = Event.pointerY(event);
  //alert(__x+","+__y);
  element.style.top = __y + 5;  
  element.style.left = __x - 40;
}

function toggleTooltip(event, element) { 
  positionTooltip(event, element);
  element.toggle();
}

function showTooltip(event, element) { 
  positionTooltip(event, element);
  element.show();
}

function hideTooltip(event, element) { 
  positionTooltip(event, element);
  element.hide();
}
// tooltip widget
function toggleTooltip(event, element) { 
  var __x = Event.pointerX(event);
  var __y = Event.pointerY(event);
  //alert(__x+","+__y);
  element.style.top = __y + 5;  
  element.style.left = __x - 40;
  element.toggle();
  if (element.style.display == "none") {
      element.firstChild.innerHTML = "<img src='/images/loading.gif' alt='Loading'/>"
  }      
}

function showAjaxTooltip(id, url) {
    if ($('tooltip_' + id).style.display == "none") {
        new Ajax.Updater('tooltip_content_' + id, url, {asynchronous:true, evalScripts:true});
    }
}