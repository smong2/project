<fieldset class="{$this->commentKey?'':'innerReply'}">
	<form id="fo_comment_{$this->id}" onsubmit="postComment({@ $this->messageKey}, {@ $this->mode==Comment::COMMENT_TYPE_RECOMMENT?$this->commentKey:''}, {@ $this->mode}, {@ $this->twitId}, document.getElementById('textbox_comment_{$this->id}')); return false;">
		<span id="comment_length_{$this->id}" style="display:none;"/>
		<input type="hidden" name="messageKey" value="{$this->messageKey}" />
		<input type="hidden" name="reComment_{$this->id}"/>
		<input type="hidden" name="parent_id" value="{$this->parentId}"/>
		<input type="hidden" name="senderCmn" value="{$this->userId}" />

		<p class="twt" podo:if="$this->mode == Comment::COMMENT_TYPE_TWIT">@{$this->twit_id}님의 트위터로 동시 전송됩니다.</p>
		<span class="charCnt" podo:if="$this->mode == Comment::COMMENT_TYPE_TWIT">(<span id="com_len_{$this->id}">0</span>/{Comment::MAXLEN_CONTENT})</span>
		<div class="reSecret" podo:if="$this->mode != Comment::COMMENT_TYPE_TWIT"><input type="checkbox" name="isSecret" id="secret01" value="1" onclick="olapStat('CIM29');"  onfocus="blur();"/> <label for="secret01">귓속말하기</label></div>
		<div class="reInput">
			<span class="txtbox"><input id="textbox_comment_{$this->id}" name="content" type="text" maxlength="150"  value=""  onkeyUp="containedUrlCheck(document.getElementById('textbox_comment_{$this->id}'),'');"/></span>
			<button class="reply" onfocus="blur()" style="cursor:pointer"  onclick="olapStat('CIM30'); postComment({@ $this->messageKey}, {@ $this->mode==Comment::COMMENT_TYPE_RECOMMENT?$this->commentKey:''}, {@ $this->mode}, {@ $this->twitId}, document.getElementById('textbox_comment_{$this->id}')); return false;">댓글</button>
		</div>
	</form>
</fieldset>
<dummy podo:if="$this->mode == Comment::COMMENT_TYPE_TWIT">
	<script type="text/javascript" language="javascript">
		commonAttachEvent(document.getElementById('textbox_comment_{$this->id}'), 'keyup', function(event) {
			document.getElementById('com_len_{$this->id}').innerHTML = document.getElementById('textbox_comment_{$this->id}').value.length;
		});
	</script>
</dummy>
