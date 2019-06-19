<?php /* /home/mong/project/NateOnConnecting/template/Message/PostComment.tpl */ class Message_PostCommentTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $commentKey; public $id; public $messageKey; public $mode; public $twitId; public $parentId; public $userId; public $twit_id; public function printHead($p_intLine, $p_intCol) { ?><fieldset class="<?php echo $this->_escapeAttrib($this->commentKey?'':'innerReply'); ?>">
	<form id="fo_comment_<?php echo $this->_escapeAttrib($this->id); ?>" onsubmit="postComment(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->messageKey))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->mode==Comment::COMMENT_TYPE_RECOMMENT?$this->commentKey:''))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->mode))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->twitId))); ?>, document.getElementById('textbox_comment_<?php echo $this->_escapeAttrib($this->id); ?>')); return false;">
		<span id="comment_length_<?php echo $this->_escapeAttrib($this->id); ?>" style="display:none;"></span>
		<input type="hidden" name="messageKey" value="<?php echo $this->_escapeAttrib($this->messageKey); ?>" />
		<input type="hidden" name="reComment_<?php echo $this->_escapeAttrib($this->id); ?>" />
		<input type="hidden" name="parent_id" value="<?php echo $this->_escapeAttrib($this->parentId); ?>" />
		<input type="hidden" name="senderCmn" value="<?php echo $this->_escapeAttrib($this->userId); ?>" />

		<?php if ($this->mode == Comment::COMMENT_TYPE_TWIT) { ?><p class="twt">@<?php echo htmlspecialchars($this->twit_id); ?>님의 트위터로 동시 전송됩니다.</p><?php } ?>
		<?php if ($this->mode == Comment::COMMENT_TYPE_TWIT) { ?><span class="charCnt">(<span id="com_len_<?php echo $this->_escapeAttrib($this->id); ?>">0</span>/<?php echo htmlspecialchars(Comment::MAXLEN_CONTENT); ?>)</span><?php } ?>
		<?php if ($this->mode != Comment::COMMENT_TYPE_TWIT) { ?><div class="reSecret"><input type="checkbox" name="isSecret" id="secret01" value="1" onclick="olapStat('CIM29');" onfocus="blur();" /> <label for="secret01">귓속말하기</label></div><?php } ?>
		<div class="reInput">
			<span class="txtbox"><input id="textbox_comment_<?php echo $this->_escapeAttrib($this->id); ?>" name="content" type="text" maxlength="150" value="" onkeyup="containedUrlCheck(document.getElementById('textbox_comment_<?php echo $this->_escapeAttrib($this->id); ?>'),'');" /></span>
			<button class="reply" onfocus="blur()" style="cursor:pointer" onclick="olapStat('CIM30'); postComment(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->messageKey))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->mode==Comment::COMMENT_TYPE_RECOMMENT?$this->commentKey:''))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->mode))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->twitId))); ?>, document.getElementById('textbox_comment_<?php echo $this->_escapeAttrib($this->id); ?>')); return false;">댓글</button>
		</div>
	</form>
</fieldset>
<?php if ($this->mode == Comment::COMMENT_TYPE_TWIT) { ?>
	<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript" language="javascript">
		commonAttachEvent(document.getElementById('textbox_comment_<?php echo htmlspecialchars($this->id); ?>'), 'keyup', function(event) {
			document.getElementById('com_len_<?php echo htmlspecialchars($this->id); ?>').innerHTML = document.getElementById('textbox_comment_<?php echo htmlspecialchars($this->id); ?>').value.length;
		});
	</script>
<?php } ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>