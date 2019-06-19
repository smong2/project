<?php /* /home/mong/project/NateOnConnecting/template/Main/Reconnecting.tpl */ class Main_ReconnectingTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $message; public $myUser; public function printHead($p_intLine, $p_intCol) { ?><form id="frmReconnect_<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>" name="frm_<?php echo $this->_escapeAttrib($this->message->getMessageId()); ?>" onsubmit="reconnect(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getReconnectKey()))); ?>); return false;">
<input type="hidden" name="reconnect_key" value="<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>" />
<dl>
	<dt>공유하기</dt>
	<dd class="re">
		<?php if ($this->message->getOriginMessage()) { ?>
			<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getOriginMessage()->getDomain()); ?>')" class="reuser" onclick="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getOriginMessage()->getDomain()); ?>'); olapStat('CIM23'); return false;" onfocus="blur()" id="origin_writer_nm_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>"><?php echo htmlspecialchars($this->message->getOriginMessage()->getProfileTitle()); ?></a>
		<?php } 
		else { ?>
			<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>')" class="reuser" onfocus="blur()" onclick="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>');olapStat('CIM23'); return false;" id="origin_writer_nm_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>"><?php echo htmlspecialchars($this->message->getProfileTitle()); ?></a>

		<?php } ?>

		<?php echo $this->message->getMessageHTML(); ?>
	</dd>
	<dd class="reInput">
		<span class="user" id="re_writer_nm_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>"><?php echo htmlspecialchars($this->myUser->getShowNickname() == 'y'?$this->myUser->getNickname():$this->myUser->getRealname()); ?></span>
		<span id="reconLen_<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>" style="display:none"></span>
		<input type="hidden" id="reconID_<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>" value="<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>" />

		<span class="txtbox"><input type="text" name="comment" id="reconnect_message_<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>" value="담는 말을 입력해주세요 (150자까지 입력 가능합니다)" style="ime-mode:active;" onkeyup="containedUrlCheck(document.getElementById('reconnect_message_<?php echo $this->_escapeAttrib($this->message->getReconnectKey()); ?>'),'');" onclick="txtClear(this); return false;" maxlength="150" /></span>
		<button type="submit" class="send" onfocus="blur()" onclick="olapStat('CIM37');">보내기</button>
	</dd>
	<dd class="btn"><a href="#" onclick="javascript:openReconnecting(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getMessageKey()))); ?>);olapStat('CIM36'); return false;" class="btnClose" onfocus="blur()">닫기</a></dd>
</dl>
</form>

<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
	cutStrByPixel("origin_writer_nm_", <?php echo str_replace('\r', '', json_encode($this->message->getMessageKey())); ?>, '53', true);
	cutStrByPixel("re_writer_nm_", <?php echo str_replace('\r', '', json_encode($this->message->getMessageKey())); ?>, '53', true);
</script><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>