document.domain = 'nate.com';

/******************************************************************************
 ***** 유용한 변수 ************************************************************
 ******************************************************************************/

var isIE = (navigator.appVersion.indexOf("MSIE") != -1) ? true : false;

/******************************************************************************
 ***** ON_LOAD 핸들러 *********************************************************
 ******************************************************************************/

var arrOnloadHandle = new Array();
for (var i=0; i<10; i++) {
	arrOnloadHandle[i] = new Array();
}

/**
 * @param int priority 0~9 사이의 정수, 숫자가 낮을수록 우선순위가 높다. 기본은 5
 */
function addOnloadHandle(f, priority)/*{{{*/
{
	if (typeof(priority) == 'undefined') {
		priority = 5;
	}
    arrOnloadHandle[priority][arrOnloadHandle[priority].length] = f;
}/*}}}*/

function commonAttachEvent(tg, name, func)/*{{{*/
{
    if (tg.addEventListener) {
        tg.addEventListener(name, func, false);
    }
    else if (tg.attachEvent) {
        tg.attachEvent('on'+name, func);
    }
}/*}}}*/

function execOnloadHandle()/*{{{*/
{
    for (var p=0; p<10; p++) {
		for (var i=0; i<arrOnloadHandle[p].length; i++) {
			var func = arrOnloadHandle[p][i];
			func.call();
		}
	}
}/*}}}*/

commonAttachEvent(window, 'load', execOnloadHandle);

/******************************************************************************
 ***** STRING 관련 함수들 *****************************************************
 ******************************************************************************/

String.prototype.trim = function() /*{{{*/
{
	return this.replace(/^[\s　]+|[\s　]+$/g,"");
}/*}}}*/

String.prototype.ltrim = function() /*{{{*/
{
	return this.replace(/^[\s　]+/,"");
}/*}}}*/

String.prototype.rtrim = function() /*{{{*/
{
	return this.replace(/[\s　]+$/,"");
}/*}}}*/

/******************************************************************************
 ***** TEXT FORM 관련 함수들 **************************************************
 ******************************************************************************/

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

function onEnter(e, tg)/*{{{*/
{
	if (getKeyCode(e) == 13) {
		return true;
	}

	return false;
}/*}}}*/

var currFocusForm;

function loadChecker(inputId, maxLength, lengthId) /*{{{*/
{
	if (isIE == false) {
		// firefox 용
		HTMLElement.prototype.objInstance = null;
	}

	this.maxLength  = maxLength;
	this.currLength = 0;

	this.checkLength = function (objInput) {/*{{{*/
		this.currLength = objInput.value.length;

		if (this.currLength > this.maxLength) {
			alert(this.maxLength + '자까지만 입력할 수 있습니다.', objInput);
			this.cutString(objInput);
			objInput.focus();
		}

		this.updateLengthString();
	};/*}}}*/

	this.cutString = function (objInput) {/*{{{*/
		objInput.value = objInput.value.substr(0, maxLength);
		this.currLength = objInput.value.length;
	};/*}}}*/

	if (lengthId == '') {
		this.updateLengthString = function () {
		};
	}
	else {
		if (document.getElementById(lengthId) == false) {
			alert('loadChecker: The length element is not found.');
			return;
		}

		this.objLength = document.getElementById(lengthId);

		this.updateLengthString = function () {
			this.objLength.innerHTML = this.currLength;
		};
	}

	if (document.getElementById(inputId) == false) {
		alert('loadChecker: The input element is not found.');
		return;
	}

	var objInput = document.getElementById(inputId);

	objInput.objInstance = this;

	if (isIE) {
		commonAttachEvent(objInput, 'keyup', function (e) {
			e = e || event;
			tg = e.srcElement || e.target;

			tg.objInstance.checkLength(objInput, false);
		} );

		commonAttachEvent(objInput, 'keypress', function (e) {
			e = e || event;
			tg = e.srcElement || e.target;

			tg.objInstance.checkLength(objInput, false);
		} );

		commonAttachEvent(objInput, 'change', function (e) {
			e = e || event;
			tg = e.srcElement || e.target;

			tg.objInstance.checkLength(objInput, true);
		} );
	}
	else {
		commonAttachEvent(objInput, 'focus', function (e) {
			e = e || event;
			tg = e.srcElement || e.target;

			currFocusForm = tg;
		} );
	}
}/*}}}*/

addOnloadHandle(function () {/*{{{*/
	if (isIE == false) {
		setInterval(function () {
			if (currFocusForm) {
				currFocusForm.objInstance.checkLength(currFocusForm, false);
			}
		}, 100);
	}
});/*}}}*/

/****************************************************************************** 
 ***** NATE ON 인증 처리 ****************************************************** 
 ******************************************************************************/
var openPopName;

function openPopupWindowNoneBrg(url, width, height) {/*{{{*/
	openPopName = window.open(url, 'img_view', 'width='+width+',height='+height+',scrollbars=yes,top=0,left=0,toolbar=no,menubar=no,resizable=no,location=no,title=no,copyhistory=no');
}/*}}}*/

function openWindow(url) /*{{{*/
{
	if (document.getElementById('fo_bridge') == null) {
		try {
			parent.openWindow(url);
			return;
		}
		catch (e) { }
	}

	_openWindowToTarget(url, '_blank');
}/*}}}*/

function openPopupWindow(url, width, height) /*{{{*/
{
	var window_name = 'connecting_popup';

	if (document.getElementById('fo_bridge') == null) {
		try {
			parent.openPopupWindow(url, width, height);
			return;
		}
		catch (e) { }
	}

	try {
		openPopName = window.open('', window_name, 'width='+width+',height='+height+',toolbar=no,menubar=no,resizable=no');
		openPopName.focus();
	}
	catch (e) { }

	_openWindowToTarget(url, window_name);
}/*}}}*/

function _openWindowToTarget(url, target) /*{{{*/
{
	var now = new Date();
	var f = document.forms['bridgeForm'];

	f.elements['r_url'].value = url;
	f.target= target;

	if (f.elements['expireTime'].value < parseInt(now.getTime()/1000)) {
		if (confirm('보안을 위한 로그인 유지 시간이 완료되었습니다.\n다시 한번 로그인해주세요') == false) {
			if (target == 'connecting_popup') {
				openPopName.close();
			}
			return false;
		} else {
			// 다른 IE 에서 다른 아이디로 로그인이 되어있는 경우 
			// 새창이 뜨면 그 아이디로 로그인 된 창이 뜨게 된다.
			// 이 때, 네이트온 아이디와 새 창의 아이디가 달라서
			// 사용자에게 혼란을 일으킬 수 있으므로
			// 이 경우는 무조건 로그인을 하도록 한다.
			f.elements['r_url'].value = 'http://xo.nate.com/login.jsp?redirect=' + url;
		}
	}

	f.submit();
}/*}}}*/

function resizePopupWindow(width, height) {/*{{{*/
	// scroll 보정
	width += 30;
	height += 55;

	if (screen.width < width || width <= 0) {
		width = screen.width - 50;
	}

	if (screen.height < height || height <= 0) {
		height = screen.height - 50;
	}

	if (isIE == false) {
		height += 35;
	}

	window.resizeTo(width, height);
}/*}}}*/

function ndrStat(ndrCode)/*{{{*/
{
	i = new Image();
	i.src = 'http://stat.nate.com/stat/stat.tiff?cp_url=[nateconnect_ndr.nate.com/' + ndrCode + ']';
}/*}}}*/

function olapStat(olapCode)/*{{{*/
{
	pndrpageid = 'nnc2';

	var now = new Date();

	i = new Image();
	i.src =  "http://statclick.nate.com/stat/statclick.tiff?t="+ now.getTime() +"&cp_url=[click_ndr.nate.com/??ndrpageid=" + pndrpageid + "&ndrregionid=" + olapCode + "]";
}/*}}}*/

/*********************************************************************************
 * *********** 글자 자르기
 ********************************************************************************/
function cutStrByPixel(id, unique_key, pixel_size, bold_yn)/*{{{*/
{
	obj = document.getElementById(id + unique_key);
	obj.innerHTML = DrawPixelSizedText(obj.innerHTML, pixel_size, bold_yn);
}/*}}}*/

function DrawPixelSizedText(strText, nPixel, bBold)/*{{{*/
{
	strText = strText.split("&amp;").join("&").split("&quot;").join("\"").split("\\;").join(";").split("&gt;").join(">").split("&lt;").join("<").split("&#39;").join("'");
	return (GetPixelSizedText(strText, nPixel, bBold));
}/*}}}*/

function GetPixelSizedText(strText, nPixel, bBold)/*{{{*/
{
	var strReturn = '';
	var nLen = 0;
	
	for (var i = 0; i < strText.length; i++)
	{
		var nCharLen = _GetCharPixelWidth(strText.charAt(i), bBold);
		if (nLen + nCharLen > nPixel)
			break;

		nLen = nLen + nCharLen;
		strReturn = strReturn + strText.charAt(i);
	}  

		if (strReturn != strText)
		{
			if (nLen + (bBold ? 10 : 12) > nPixel)
			{
				var nTemp = 0;
				var nReturnLength = strReturn.length;
				
				for (var i = 0; i < nReturnLength; i++)
				{
					nTemp = nTemp + _GetCharPixelWidth(strReturn.charAt(nReturnLength - 1 - i), bBold);
					if (nLen + (bBold ? 10 : 12) - nTemp <= nPixel)
						break;
				}
				strReturn = strReturn.substring(0, nReturnLength - i - 1) + (bBold ? '...' : '...');
			}
			else
				strReturn = strReturn + (bBold ? '...' : '...');
		}
		strReturn = strReturn.split("<").join("&lt;");

		return strReturn;
}/*}}}*/

var aryAsciiWidth = new Array(0,6,6,6,6,6,6,6,6,0,0,0,0,0,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,4,3,5,7,7,11,8,4,5,5,6,6,4,6,4,6,6,6,6,6,6,6,6,6,6,6,4,4,8,6,8,6,10,8,8,9,8,8,7,9,8,3,6,7,7,11,8,9,8,9,8,8,7,8,8,10,8,8,8,6,11,6,6,6,4,7,7,7,7,7,3,7,7,3,3,6,3,9,7,7,7,7,4,7,3,7,6,10,6,6,7,6,6,6,9);
var aryAsciiBoldWidth = new Array(0,7,7,7,7,7,7,7,7,0,0,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,5,4,6,8,8,12,9,5,6,6,7,7,5,7,5,7,7,7,7,7,7,7,7,7,7,7,5,5,9,7,9,7,11,9,9,10,9,9,8,10,9,4,7,8,8,12,9,10,9,10,9,9,8,9,9,11,9,9,9,7,12,7,7,7,5,8,8,8,8,8,4,8,8,4,4,7,4,10,8,8,8,8,5,8,4,8,7,11,7,7,8,7,7,7,10);


function _GetCharPixelWidth(strChar, bBold)/*{{{*/
{
	var nCode = strChar.charCodeAt(0);
	if (nCode > 126)
		return (bBold ? 13 : 12);
		return (bBold ? aryAsciiBoldWidth[nCode] : aryAsciiWidth[nCode]);
}/*}}}*/

	/**
	 * 메시지 작성 리턴 처리
	 */
	function addProcCheck(result, frmForFocus)/*{{{*/
	{
		if (result.result == false) {
			alert('잠시 후에 다시 시도해주세요.');
			return false;
		} else if (result.result == '273') {
			alert('건강한 인터넷 문화 정착을 위해\n'+result.descript+'****는 제외하고 작성해주세요.');
			frmForFocus.focus();
			return false;
		} else if (result.result == '464') {
			alert('일시적으로 등록 차단된 사용자입니다.');
			frmForFocus.focus();
			return false;
		} else if (result.result == '465') {
			alert('영구적으로 등록 차단된 사용자입니다.');
			frmForFocus.focus();
			return false;
		}

		return true;
	}/*}}}*/
