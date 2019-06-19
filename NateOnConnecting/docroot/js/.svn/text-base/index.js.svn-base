commonAttachEvent(document, 'click', function () {/*{{{*/
	try {
		document.frames('id_frmMain').closeAllOfLayers();
	} catch (e) { }
});/*}}}*/

function resizeIFrame(psID, piHeight){/*{{{*/
	var iHeight = document.getElementById(psID).getAttribute("height");
	if (piHeight < 130) piHeight = 130; // 메뉴를 위한 보정
	if (piHeight != iHeight) {
		document.getElementById(psID).setAttribute("height", piHeight);
	}
}/*}}}*/

function onResize()/*{{{*/
{
	try {
		resizeIFrame('id_frmMain', document.getElementById('id_frmMain').contentWindow.document.body.scrollHeight);
	}
	catch (e) { }
}/*}}}*/

/**
 * 선택된 탭으로 변경한다.
 */
function selectPage(id) /*{{{*/
{
	if (id == 'tab_list') {
		document.getElementById('tab_list').className = 'tab01 on';
		document.getElementById('tab_mine').className = 'tab02';
	}
	else {
		document.getElementById('tab_list').className = 'tab01';
		document.getElementById('tab_mine').className = 'tab02 on';
	}
}/*}}}*/

/**
 * 3일 동안 나를 피플로 등록한 친구가 있는지 확인하고,
 * 있을 경우 알림 박스를 보여준다.
 */
function loadPeopleNoticeBox()/*{{{*/
{
	try {
		document.getElementById('box_people_notice').style.display = '';
	}
	catch (e) {
	}
}/*}}}*/

function loadFollowerNoticeBox()/*{{{*/
{
	try {
		document.getElementById('box_follower_notice').style.display = '';
	}
	catch (e) {
	}
}/*}}}*/

/**
* 말풍선 숨기기
*/
function closeBalloon(balloonType)/*{{{*/
{
	if (balloonType == '') {
		return;
	}

	try {
		var options = {
			method: 'get',
			insertion: Insertion.Bottom,
			evalScripts: true,
			onComplete: function () {
				if (balloonType == 1) {
					closeFollowerNoticeBox();
				} else {
					closePeopleNoticeBox();
				}
			},
			parameters: {balloon_type:  balloonType}
		};
		
		new Ajax.Updater('box_people_notice', '/checkBalloon', options);
	}
	catch (e) {
	}
}/*}}}*/
/**
 * 피플 알림 박스를 닫는다.
 */
function closePeopleNoticeBox()/*{{{*/
{
	setCookie('disable_peopleNotice', '1', 1);
	document.getElementById('box_people_notice').style.display = 'none';
}/*}}}*/

function closeFollowerNoticeBox()/*{{{*/
{
	setCookie('disable_followerNotice', '1', 1);
	document.getElementById('box_follower_notice').style.display = 'none';
}/*}}}*/

function closeStartPage()/*{{{*/
{
	setCookie('disable_startPage', '1', 1);
}/*}}}*/

/****************************************************************************** 
 ***** COOKIE ***************************************************************** 
 ******************************************************************************/

function setCookie(name, value, expireDays) /*{{{*/
{
    var todayDate = new Date();
    todayDate.setDate(todayDate.getDate()+expireDays);
    document.cookie = name + "=" + escape(value) + ";path=/;expires=" + todayDate.toGMTString()+";"
}/*}}}*/

function clearCookie(name)/*{{{*/
{
    document.cookie = name + "= ''";
}/*}}}*/

function getCookie(name)/*{{{*/
{
    var search = name + "=";
    if (document.cookie.length > 0) {
        offset = document.cookie.indexOf(search);

        if (offset != -1){
            offset += search.length;
            end = document.cookie.indexOf(";",offset);
            if (end == -1) {
				end = document.cookie.length;
			}
            return unescape(document.cookie.substring(offset,end));
        }
		else {
			return false;
		}
    }
	else {
		return false;
	}
}/*}}}*/

