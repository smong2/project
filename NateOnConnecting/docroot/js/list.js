var nextStartidx;
var listQueryParams;

function resizeSelf()/*{{{*/
{
	try {
		parent.resizeIFrame('id_frmMain', document.body.scrollHeight);
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
		olapStat('CIM32');

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
* 메시지 삭제
*/
function deleteMessage(senderCmn, messageKey)/*{{{*/
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

				document.getElementById('box_message_'+messageKey).style.display = 'none';
				messageCnt--;

				if (messageCnt == 0 && nextStartIdx == '') {
					document.getElementById('box_none_msg').style.display = 'block';
				}
				resizeSelf();
			},
			parameters: {senderCmn: senderCmn, messageKey: messageKey}
		};
		new Ajax.Request('/message/delete', options);
	}
	catch (e) {
	}
}/*}}}*/

/**
* 리커넥팅을 보여준다.
*/
function openReconnecting(messageKey)/*{{{*/
{
	var elem = document.getElementById('reconnecting_'+messageKey);

	if (elem.style.display == 'none') {
		elem.style.display = '';
	}
	else {
		elem.style.display = 'none';
	}
}/*}}}*/

/** 
 * 리커넥팅하기
 */
function reconnect(reconnectKey)/*{{{*/
{
	var fo = document.getElementById('frmReconnect_'+reconnectKey);

	if (fo.comment.value.trim() == '' || fo.comment.value == '담는 말을 입력해주세요 (150자까지 입력 가능합니다)') {
		fo.comment.value = '';
	}

	try {
		containedUrlCheck(document.getElementById('reconnect_message_'+reconnectKey),'add');

	var options = {
		method: 'post',
		asynchronous: false,
		onComplete: function (transport, json)
		{
			if (addProcCheck(json,document.fo.comment) == false) {
				return;
			}

			location.replace('/list');
		},
		parameters: {reconnect_key: fo.reconnect_key.value, comment: fo.comment.value}
		};

		new Ajax.Request('/message/reconnect', options);
	}
	catch (e) {
	}
}/*}}}*/

/****************************************************************************** 
***** COMMENTS *************************************************************** 
******************************************************************************/

/**
* 댓글 목록을 가져온다.
*/
function getComments(senderCmn, messageKey, mode, twit_id,  page)/*{{{*/
{
	try {
		var options = {
		method: 'get',
		evalScripts: true,
		onComplete: function ()
		{
			resizeSelf();
		},

		parameters: {senderCmn: senderCmn, messageKey: messageKey, mode: mode, twit_id: twit_id, page: page}
		};
		new Ajax.Updater('box_comments_'+messageKey, '/message/commentsAjax', options);
	}
	catch (e) {
	}
}/*}}}*/

/**
* 댓글 박스를 펼친다.
*/
function openComments(senderCmn, messageKey, mode, twit_id)/*{{{*/
{
	var elem = document.getElementById('box_comments_'+messageKey);
	if (elem.style.display == 'none') {
		elem.style.display = 'block';
		getComments(senderCmn, messageKey, mode, twit_id, -1);
	}
	else {
		elem.style.display = 'none';
		resizeSelf();
	}
}/*}}}*/

/**
* 재댓글 박스를 펼친다.
*/
function openReComment(commentKey)/*{{{*/
{
	var elem = document.getElementById('box_recomments_'+commentKey);
	if (elem.style.display == 'none') {
		elem.style.display = 'block';
		document.getElementById('fo_comment_'+commentKey).content.value = '';
		document.getElementById('fo_comment_'+commentKey).content.focus();
	}
	else {
		elem.style.display = 'none';
		resizeSelf();
	}
}/*}}}*/

/**
* 댓글 수를 업데이트 한다.
*/
function setTotalComments(messageKey, totalComments, totalCommentsStr)/*{{{*/
{
	if (totalComments <= 0) {
		document.getElementById('number_totalComments_'+messageKey).innerHTML = '0';
		document.getElementById('icon_isNew_'+messageKey).style.display = 'none';
	}
	else {
		document.getElementById('number_totalComments_'+messageKey).innerHTML = totalCommentsStr;
	}
}/*}}}*/

/**
* 댓글을 삭제한다.
*/
function deleteComment(senderCmn, messageKey, commentKey, page, totalPages, totalComments, mode, twit_id)/*{{{*/
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

				getComments(senderCmn, messageKey, mode, twit_id, page);
			},
			parameters: {senderCmn: senderCmn, messageKey: messageKey, commentKey: commentKey, mode: mode}
		};
		new Ajax.Request('/message/comment/delete', options);
	}
	catch (e) {
	}
}/*}}}*/

/**
* 댓글을 등록전 단축 URL 체크.
*/
function postComment(message_key, comment_key, mode, twit_id, comment_id)/*{{{*/
{
	containedUrlCheck(comment_id,'add');
	addComment(message_key, comment_key, mode, twit_id);
}/*}}}*/

/**
* 댓글을 등록한다.
*/
function addComment(messageKey, commentKey, mode, twit_id)/*{{{*/
{
	if (commentKey) {
		var fo = document.getElementById('fo_comment_'+commentKey);
	}
	else {
		var fo = document.getElementById('fo_comment_'+messageKey);
	}

	if (fo.content.value.trim() == '') {
		alert('내용을 입력해주세요.');
		fo.content.focus();
		return;
	}

	if (typeof(fo.isSecret) == 'undefined'){
		isSecret = 0;
	} else {
		isSecret = fo.isSecret.checked?'1':'0';
	}

	try {
	var options = {
		method: 'post',
		asynchronous: false,
		onComplete: function (transport, json)
		{
			if (addProcCheck(json,document.getElementById('memo')) == false) {
				return;
			}

			if (json.result == false) {
				alert('잠시 후에 다시 시도해주세요.');
				return;
			} else if (json.result == '273') {
				alert('건강한 인터넷 문화 정착을 위해\n'+json.descript+'****는 제외하고 작성해주세요.');
				fo.content.focus();
				return;
			} else if (json.result == '464') {
				alert('일시적으로 등록 차단된 사용자입니다.');
				fo.comment.focus();
				return;
			} else if (json.result == '465') {
				alert('영구적으로 등록 차단된 사용자입니다.');
				fo.comment.focus();
				return;
			}

			getComments(fo.senderCmn.value, messageKey, mode, twit_id, -1);
		},
		parameters: {senderCmn: fo.senderCmn.value, messageKey: fo.messageKey.value, isSecret: isSecret, content: fo.content.value, mode: mode, twit_id:twit_id,  parent_id:fo.parent_id.value}
		};

		new Ajax.Request('/message/addComment', options);
	}
	catch (e) {
	}
}/*}}}*/
