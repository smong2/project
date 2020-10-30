var nextStartidx;
var listQueryParams;

function resizeSelf()/*{{{*/
{
	try {
		parent.resizeIFrame('id_frmMain', document.body.scrollHeight );
	}
	catch (e) { }
}/*}}}*/

function closeAllOfLayers()/*{{{*/
{
	if (document.getElementById('layer_select').style.display == 'none') {
	}
	else {
		layerClose('layer_select');
	}
}/*}}}*/

/****************************************************************************** 
 ***** MESSAGE **************************************************************** 
 ******************************************************************************/

var messageCnt = 0;

/**
 * 현재 보여주고 있는 메시지 수를 저장한다.
 */
function increaseMessageCnt()/*{{{*/
{
	messageCnt++;
}/*}}}*/

var isLoadingMessages = false;

/**
 * 메시지 목록 더보기
 */
function getMessagesMore()/*{{{*/
{
	if (isLoadingMessages) {
		return;
	}
	isLoadingMessages = true;
	setTimeout(function () { isLoadingMessages = false; }, 3000);

	if (nextStartIdx == '') {
		return;
	}

	try {
		var parameters = listQueryParams;
		parameters['startIdx'] = nextStartIdx;

		var options = {
			method: 'get',
			insertion: Insertion.Bottom,
			evalScripts: true,
			onComplete: function ()
			{
				isLoadingMessages = false;
				resizeSelf();
			},
			parameters: parameters
		};
		new Ajax.Updater('box_messages', '/list/messagesAjax', options);
	}
	catch (e) {
	}
}/*}}}*/

/**
 * 다음 메시지 ID를 저장한다.
 */
function setNextStartIdx(idx)/*{{{*/
{
	nextStartIdx = idx.trim();

	if (idx.trim() == '') {
		document.getElementById('btn_more').style.display = 'none';
	}
	else {
		if (Prototype.Browser.WebKit) {
			document.getElementById('btn_more').style.display = 'block';
		}
		else {
			document.getElementById('btn_more').style.display = 'none';
		}
	}
	resizeSelf();
}/*}}}*/

/**
 * Add 버튼 숨기기
 */
var messageIdsByUserId = {};

/**
 * 피플로 추가하기
 */
function addPeople(userId, userName)/*{{{*/
{
	try {
		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				// 해당 사용자에 붙어있는 ADD 버튼을 모두 감춘다.
				var messageIds = messageIdsByUserId[userId];
				for (var key=0; key<messageIds.length; key++) {
					document.getElementById('btn_add_'+messageIdsByUserId[userId][key]).style.display = 'none';
				}

				if (confirm('커넥팅 피플에 추가되었습니다. 리스트를 확인하시겠습니까?')) {
					openWindow('http://connect.nate.com/index.nate?menu=81');
				}
			},
			parameters: {mode: 'self', idList: userId+'|'+userName+',', type: 1, page: 1}
		};
		new Ajax.Request('/connecting/setting/addPeople.nate', options);
    }
	catch (e) {
	}
}/*}}}*/

/**
 * 메시지 삭제
 */
function deleteMessage(senderCmn, messageId)/*{{{*/
{
    if (confirm('삭제하시겠습니까?') == false) {
		return;
	}
	
	try {
		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}

				document.getElementById('box_message_'+messageId).style.display = 'none';
				messageCnt--;

				if (messageCnt == 0 && nextStartIdx == '') {
					document.getElementById('box_none_msg').style.display = 'block';
				}
				resizeSelf();
			},
			parameters: {senderCmn: senderCmn, messageId: messageId}
		};
		new Ajax.Request('/message/delete', options);
    }
	catch (e) {
	}
}/*}}}*/

/**
 * 리커넥팅을 보여준다.
 */
function openReconnecting(messageId)
{
	var elem = document.getElementById('reconnecting_'+messageId);
	if (elem.style.display == 'none') {
		elem.style.display = '';
	}
	else {
		elem.style.display = 'none';
	}
}
/****************************************************************************** 
 ***** COMMENTS *************************************************************** 
 ******************************************************************************/

/**
 * 댓글 목록을 가져온다.
 */
function getComments(senderCmn, messageId, page)/*{{{*/
{
	try {
		var options = {
			method: 'get',
			evalScripts: true,
			onComplete: function ()
			{
				resizeSelf();
			},
			parameters: {senderCmn: senderCmn, messageId: messageId, page: page}
		};
		new Ajax.Updater('box_comments_'+messageId, '/message/commentsAjax', options);
	}
	catch (e) {
	}
}/*}}}*/

/**
 * 댓글 박스를 펼친다.
 */
function openComments(senderCmn, messageId)/*{{{*/
{
	var elem = document.getElementById('box_comments_'+messageId);
	if (elem.style.display == 'none') {
		elem.style.display = 'block';
		getComments(senderCmn, messageId, -1);
	}
	else {
		elem.style.display = 'none';
		resizeSelf();
	}
}/*}}}*/

/**
 * 댓글 수를 업데이트 한다.
 */
function setTotalComments(messageId, totalComments, totalCommentsStr)/*{{{*/
{
	if (totalComments <= 0) {
		document.getElementById('number_totalComments_'+messageId).innerHTML = '0';
		document.getElementById('icon_isNew_'+messageId).style.display = 'none';
	}
	else {
		document.getElementById('number_totalComments_'+messageId).innerHTML = totalCommentsStr;
	}
}/*}}}*/

/**
 * 댓글을 비밀글로 변경한다.
 */
function secretComment(messageId, commentId)/*{{{*/
{
    if (confirm('비밀글로 변경하시겠습니까?') == false) {
		return;
	}
	
	try {
		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}

				var tg = document.getElementById('icon_secret_'+commentId);
				tg.className = 'secret';
				tg.title = '귓속말 댓글입니다.';
				tg.innerHTML = '비밀';

				var tg = document.getElementById('btn_secret_'+commentId);
				tg.style.display = 'none';
			},
			parameters: {messageId: messageId, commentId: commentId}
		};
		new Ajax.Request('/message/comment/secret', options);
    }
	catch (e) {
	}
}/*}}}*/

/**
 * 댓글을 삭제한다.
 */
function deleteComment(senderCmn, messageId, commentId, page, totalPages, totalComments)/*{{{*/
{
    if (confirm('삭제하시겠습니까?') == false) {
		return;
	}
	
	try {
		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}

				// 마지막 페이지일 경우에는 이전 페이지를 보여준다.
				if (totalPages == page && (totalComments-1) % 10 == 0) {
					page--;
				}

				getComments(senderCmn, messageId, page);
			},
			parameters: {senderCmn: senderCmn, messageId: messageId, commentId: commentId}
		};
		new Ajax.Request('/message/comment/delete', options);
    }
	catch (e) {
	}
}/*}}}*/

/**
 * 댓글을 삭제한다.
 */
function addComment(messageId)/*{{{*/
{
	var fo = document.getElementById('fo_comment_'+messageId);

	if (fo.content.value.trim() == '') {
		alert('내용을 입력해주세요.');
		fo.content.focus();
		return;
	}

	try {
		var options = {
			method: 'post',
			onComplete: function (transport, json)
			{
				if (json.result == false) {
					alert('잠시 후에 다시 시도해주세요.');
					return;
				}

				getComments(fo.senderCmn.value, fo.messageId.value, -1);
			},
			parameters: {senderCmn: fo.senderCmn.value, messageId: fo.messageId.value, isSecret: fo.isSecret.checked ? '1' : '0', content: fo.content.value}
		};
		new Ajax.Request('/message/addComment', options);
    }
	catch (e) {
	}
}/*}}}*/
