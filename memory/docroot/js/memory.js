function getKeyCode(e)/*{{{*/
{
	var ev = (window.event) ? window.event : e;
	if (!ev || !ev.type) {
		return false;
	}
	var ME = ev;

	if (ME.type.indexOf('key') != -1) {
		return (ev.keyCode) ? ev.keyCode : ((ev.charCode) ? ev.charCode : ev.which);
	}
	else {
		return '';
	}
}/*}}}*/

function resizePopupWindow(width, height) {/*{{{*/
	if (typeof(window.innerWidth) == 'number') {
		var w = width - window.innerWidth;
		var h = height - window.innerHeight;
	}
	else {
		var w = width - document.documentElement.clientWidth;
		var h = height - document.documentElement.clientHeight;
	}

	window.resizeBy(w, h);

	document.body.style.overflow = 'hidden';
}/*}}}*/
