<script type="text/javascript" src="/js/shortcut.js"></script>
<script type="text/javascript" src="/js/post.js"></script>
<style>
.btn_disable {
	display:none;
}
</style>
<script type="text/javascript">
	var msgOpenDefault = {@ $this->myUser->getMsgOpenDefault()};
	var isTwitLink = {@ $this->myUser->isLinkedTwitter()};
	var isFirstVisit = {@ $this->myUser->isFirstVisit()};
	var	firstTxt = "{$this->myUser->getRealname()}님! 지금 머리속을 스치는 생각, 친구들에게 하고싶었던 이야기들을 150자로 커넥팅에 적어보세요";

addOnloadHandle(function() {/*{{{*/
	commonAttachEvent(document.getElementById('memo'), 'keyup', function (event) {

		containedUrlCheck(document.getElementById("memo"),'');	

		document.getElementById("len").innerHTML = document.getElementById('memo').value.length;
		if (document.getElementById('memo').value.length > 150) {
			document.getElementById("btn").className = "btn_disable";
			document.getElementById("btn").disabled = true;
		} else {
			document.getElementById("btn").className = "btn";
			document.getElementById("btn").disabled = false;
		}
	});

	commonAttachEvent(document.getElementById('memo'), 'click', function (event) {
		if (isIE) {
			document.getElementById("memo").disabled = false;
		}
		else {
			document.getElementById("memo").readOnly = false;
		}
	});

	shortcut.add("Alt+Enter",function() {
		sendMessage();
	});

	if (isFirstVisit) {
		document.getElementById("memo").value= firstTxt;
	}

	setDefault();

});/*}}}*/

/***************************** 
	기본값 셋팅
*****************************/ 
function setDefault() /*{{{*/
{
	send_twitter = document.getElementById('send_twitter');

	textareaColor('all');
	send_twitter.disabled = false;
	document.getElementById('open_yn_y').checked = true;

	if ('n' == msgOpenDefault) {
		document.getElementById('open_yn_n').checked = true;
		textareaColor('friend');
		send_twitter.checked = false;
		send_twitter.disabled = true;
	} else if ('t' == msgOpenDefault) {
		send_twitter.checked = true;
	} else if ('' == msgOpenDefault) {
		send_twitter.checked = false;
	}

	if (isTwitLink == false) {
		send_twitter.checked = false;

		send_twitter.onclick = function() { 
		  send_twitter.checked = false; 
		  var twitterOAuthWin = openPopupWindow("http://connect.nate.com/extblog/regTwitter.vm" ,800,380);
		};
	}
} /*}}}*/

/***************************** 
	공개여부 버튼 클릭시 트위터 체크 버튼 처리
*****************************/ 
function chkTwitByOpenFl(result)/*{{{*/
{
	send_twitter = document.getElementById('send_twitter');

	if (isIE) {
		if (result == 'friend') {
			send_twitter.disabled = true;
			send_twitter.checked = false;
		} else {
			send_twitter.disabled = false;
		}
	} else {
		if (result == 'friend') {
			send_twitter.readOnly = true;
			send_twitter.checked = false;
		} else {
			send_twitter.readOnly = false;
		}
	}
}/*}}}*/

/***************************** 
	공개여부에 따른 글쓰기 배경색 처리
*****************************/
function textareaColor(classmode)/*{{{*/
{
	document.getElementById("memo").className = classmode;
}/*}}}*/

/***************************** 
	처음 사용자 처리 로직
******************************/
function firstVisitProc()/*{{{*/
{
	if (isFirstVisit) {
		if (document.getElementById('memo').value == firstTxt || document.getElementById('memo').value == '') {
		   alert('메시지를 입력하세요.');
		   return false;
		}

		if(id_frmMain.document.getElementById('firstVisit') != null) {
			id_frmMain.document.getElementById('firstVisit').style.display = 'none';	
			closeStartPage();
		}
	}
	return true;
}/*}}}*/

function clearFirstTxt()/*{{{*/
{
	if (document.getElementById("memo").value == firstTxt) {
		document.getElementById("memo").value = "";
	}
}/*}}}*/

/***************************** 
	메시지 보내기 - 처음 사용자 접근 처리 포함
******************************/
function sendMessage()/*{{{*/
{
	document.getElementById('memo').value = document.getElementById('memo').value.replace('　', '');

	if (firstVisitProc() == false) {
		return false;
	}

	frm = document.getElementById("fo_message");
	open_yn = document.getElementById("open_yn_y").checked ? 'y' : 'n';
	send_twitter = document.getElementById("send_twitter").checked ? 'y' : 'n';

	containedUrlCheck(document.getElementById("memo"), 'add');	
	addMessage(frm.memo.value, open_yn, send_twitter);
}/*}}}*/
</script>
<form id="fo_message" onsubmit="return false;">
	<input type="hidden" id="profileType" name="profileType" value="{$this->myUser->getProfileImage() ? User::PROFILE_TYPE_CUSTOM : 1}">
	<dl class="cntInput" onmouseover="document.getElementById('aa').style.display='block'" onmouseout="document.getElementById('aa').style.display='none'">
		<dt>
			<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=18');" onclick="olapStat('CIM03'); openWindow('http://connect.nate.com/index.nate?menu=18'); return false;" target="_blank" onmouseover="document.getElementById('pfManage').style.display='block'" onmouseout="document.getElementById('pfManage').style.display='none'" onfocus="blur();">
				<img src="{$this->myUser->getProfileImage() ? $this->myUser->getProfileImageUrl() : User::generateProfileImageUrl(1)}" width="56" height="56" alt="" />
				<img src="/ui/img/btn_manage.gif" id="pfManage" class="pf_mng" alt="관리"/>
			</a>
		</dt>
		<dd class="write"><textarea id="memo" name="memo" cols="50" rows="3" style="overflow:auto;" onclick="clearFirstTxt()" attr-if:onclick="$this->myUser->isFirstVisit()"></textarea></dd>
		<dd id="aa" class="writeSend" style="display:none;">
			<div class="writeSendbox" id="sendMessage">
				<span class="count">(<span id="len">0</span>/{Message::MAXLEN_MESSAGE})</span>
				<div class="sendtype">
					<input type="radio" id="open_yn_y"  name="open_yn" onfocus="this.blur()" value="y" onclick="chkTwitByOpenFl('all');olapStat('CIM04');textareaColor('all');"/>
					<label for="open_yn_y" class="openall">전체공개</label>
					<input type="radio" id="open_yn_n" name="open_yn" onfocus="this.blur()" value="n" onclick="chkTwitByOpenFl('friend');olapStat('CIM04');textareaColor('friend');"/>
					<label for="open_yn_n" class="openbuddy">친구공개</label>
					<input type="checkbox" id="keep_use" value='y' checked style="display:none"/><br/>
					<input type="checkbox" id="send_twitter" name="send_twitter"  onfocus="this.blur()" onclick="olapStat('CIM05');" disabled/>
					<label for="send_twitter" class="opentwitter">트위터 보내기</label>
					<button onclick="olapStat('CIM06'); sendMessage();" onfocus="blur();" class="btn" id="btn" style="cursor:pointer;">보내기</button>
				</div>
			</div>
		</dd>
	</dl>
</form>
