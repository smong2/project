<form id="frmReconnect_{$this->message->getReconnectKey()}" name='frm_{$this->message->getMessageId()}' onsubmit="reconnect({@ $this->message->getReconnectKey()}); return false;">
<input type="hidden" name="reconnect_key" value="{$this->message->getReconnectKey()}"/>
<dl>
	<dt>공유하기</dt>
	<dd class="re">
		<dummy podo:if="$this->message->getOriginMessage()">
			<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getOriginMessage()->getDomain()}')" class="reuser"  onclick="javascript:openWindow('http://connect.nate.com/{$this->message->getOriginMessage()->getDomain()}'); olapStat('CIM23'); return false;" onfocus="blur()" id="origin_writer_nm_{$this->message->getMessageKey()}">{$this->message->getOriginMessage()->getProfileTitle()}</a>
		</dummy>
		<dummy podo:else>
			<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}')" class="reuser" onfocus="blur()" onclick="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}');olapStat('CIM23'); return false;" id="origin_writer_nm_{$this->message->getMessageKey()}">{$this->message->getProfileTitle()}</a>

		</dummy>

		{HTML($this->message->getMessageHTML())}
	</dd>
	<dd class="reInput">
		<span class="user" id="re_writer_nm_{$this->message->getMessageKey()}">{$this->myUser->getShowNickname() == 'y'?$this->myUser->getNickname():$this->myUser->getRealname()}</span>
		<span id='reconLen_{$this->message->getReconnectKey()}' style='display:none'/>
		<input type="hidden" id="reconID_{$this->message->getReconnectKey()}"  value="{$this->message->getReconnectKey()}"/>

		<span class="txtbox"><input type="text" name="comment" id="reconnect_message_{$this->message->getReconnectKey()}" value="담는 말을 입력해주세요 (150자까지 입력 가능합니다)" style="ime-mode:active;" onkeyUp="containedUrlCheck(document.getElementById('reconnect_message_{$this->message->getReconnectKey()}'),'');" onclick="txtClear(this); return false;" maxlength="150" /></span>
		<button type="submit" class="send" onfocus="blur()" onclick="olapStat('CIM37');">보내기</button>
	</dd>
	<dd class="btn"><a href="#" onclick="javascript:openReconnecting({@ $this->message->getMessageKey()});olapStat('CIM36'); return false;" class="btnClose" onfocus="blur()">닫기</a></dd>
</dl>
</form>

<script type="text/javascript">
	cutStrByPixel("origin_writer_nm_", {@ $this->message->getMessageKey()}, '53', true);
	cutStrByPixel("re_writer_nm_", {@ $this->message->getMessageKey()}, '53', true);
</script>
