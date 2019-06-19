<?php /* /home/mong/project/NateOnConnecting/template/List/Message.tpl */ class List_MessageTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $message; public $myUser; public $request; public function printHead($p_intLine, $p_intCol) { ?><script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
	increaseMessageCnt();
</script>

<li id="box_message_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>" class="<?php echo $this->_escapeAttrib($this->message->getOpenYN() == Message::OPEN_PEOPLE?'friends':''); ?>">
	<div class="cntView <?php echo $this->_escapeAttrib($this->message->getSender()->getUserId() == $this->myUser->getUserId()?'':'f_clear'); ?>">
		<div class="pfImg">

			<?php if ($this->message->getOriginMsgCmn()) { ?>
				<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getOriginMessage()->getDomain()); ?>')" title="<?php echo $this->_escapeAttrib($this->message->getOriginMessage()->getProfileTitle()); ?>님의 커넥팅으로 이동하기" onclick="olapStat('CIM17'); openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getOriginMessage()->getDomain()); ?>'); return false;" onfocus="blur()"><img src="<?php echo $this->_escapeAttrib($this->message->getOriginMessage()->getProfileImageUrl()); ?>" width="56" height="56" alt="" /></a>

			<?php } 
			else { ?>
				<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>')" title="<?php echo $this->_escapeAttrib($this->message->getProfileTitle()); ?>님의 커넥팅으로 이동하기" onclick="olapStat('CIM17'); openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>'); return false;" onfocus="blur()"><img src="<?php echo $this->_escapeAttrib($this->message->getProfileImageUrl()); ?>" width="56" height="56" onerror="this.src='<?php echo $this->_escapeAttrib($this->myUser->generateProfileImageUrl(1)); ?>';" alt="" /></a>
			<?php } ?>
		</div>
		<dl>
			<dt>
				<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getOriginMsgCmn()?$this->message->getOriginMessage()->getDomain():$this->message->getDomain()); ?>');" onfocus="blur()" onclick="olapStat('CIM18');"><u id="writer_nm_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>"><?php echo $this->message->getOriginMsgCmn()?$this->message->getOriginMessage()->getProfileTitle():$this->message->getProfileTitle(); ?></u></a> 

				<span title="<?php echo $this->_escapeAttrib(date('Y.m.d H:i', $this->message->getWriteDt())); ?>"><a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>/<?php echo $this->_escapeAttrib($this->message->getMessageId()); ?>');" onclick="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>/<?php echo $this->_escapeAttrib($this->message->getMessageId()); ?>');olapStat('CIM20'); return false;" onfocus="blur();"><?php echo htmlspecialchars($this->message->getWriteDtDiffStr()); ?></a></span>

			</dt>
			<dd class="btn">
				<?php if ($this->message->getOpenYN() == Message::OPEN_PEOPLE) { ?><span class="friend">친구공개</span><?php } ?>
				<?php if ($this->message->isRemovable($this->myUser)) { ?>
					<a href="#" onclick="olapStat('CIM25'); deleteMessage(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getSender()->getUserId()))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getMessageKey()))); ?>); return false;" class="del" onfocus="blur();">삭제</a>
				<?php } ?>
				<?php if ($this->message->isReconnectable($this->myUser)) { ?>
					<a href="javascript:;" onclick="javascript:openReconnecting(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getMessageKey()))); ?>);olapStat('CIM24'); return false;" ondblclick="javascript:openReconnecting(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getMessageKey()))); ?>);olapStat('CIM24'); return false;" onfocus="blur()">공유하기</a>
				<?php } ?>
			</dd>
			<dd class="origin"><?php echo htmlspecialchars($this->message->getSourceTitleStr()); ?></dd>
			<dd id="message_<?php echo $this->_escapeAttrib($this->message->getMessageId()); ?>" class="<?php echo $this->_escapeAttrib($this->message->isClipped() && $this->message->getThumbUrl() ? 'rcnt' : 'message_cls'); ?>" style="white-space:normal; word-break:break-all; word-wrap:break-word;">
				<?php if ($this->message->isClipped() && $this->message->getThumbUrl()) { ?>
					<a href="<?php echo $this->_escapeAttrib($this->message->getSourceUrl()); ?>" target="_blank" onclick="olapStat('CIM33');" onfocus="blur()"><img src="<?php echo $this->_escapeAttrib($this->message->getThumbUrl()); ?>" <?php if ($this->message->getAttachType() == Message::ATTACH_TYPE_CLIPPED_VIDEO) { ?>onerror="this.src='http://connect.nate.com/img/2.0/ico_youtube.gif';"<?php } ?> width="49" alt="<?php echo $this->_escapeAttrib($this->message->getMessage()); ?>" onfocus="blur()" /></a>
				<?php } ?>

				<?php if ($this->message->getFromIcon()) { ?><img src="/ui/img/<?php echo $this->_escapeAttrib($this->message->getFromIcon()); ?>" /><?php } ?>


				<?php $this->_isCondResult1 =  ($this->message->getSourceUrl()); if ($this->_isCondResult1) { ?><a href="<?php echo $this->_escapeAttrib($this->message->getSourceUrl()); ?>" target="_blank" onclick="<?php echo $this->_escapeAttrib($this->message->isClipped() && $this->message->getThumbUrl() ? 'olapStat(\'CIM34\');' : 'olapStat(\'CIM33\');'); ?>" onfocus="blur();"><?php } ?><?php echo $this->message->getMessageHTML(); ?><?php if ($this->_isCondResult1) { ?></a><?php } ?>
			</dd>
		</dl>
		<?php if ($this->message->isClipped()) { ?><div class="scrapAlim">외부사이트에서 스크랩 + 커넥팅한 글입니다.<br /><a href="http://connect.nate.com/index.nate?menu=7" onclick="olapStat('CIM35'); openWindow('http://connect.nate.com/index.nate?menu=7'); return false;" onfocus="blur();" target="_blank">싸이월드스크랩보기</a></div><?php } ?>

		<div class="subTxt">

			<?php if ($this->message->isReconnected()) { ?>
			<div class="reCnting">
				<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>');" onclick="olapStat('CIM23');" onfocus="blur();"><img src="<?php echo $this->_escapeAttrib($this->message->getProfileImageUrl()); ?>" width="30" height="30" class="reimg" alt="" /></a><!-- 이미지 사이즈 : 30*30 -->
				<a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->message->getDomain()); ?>');" onclick="olapStat('CIM23');" onfocus="blur();" class="user" id="reconnect_writer_nm_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>"><?php echo htmlspecialchars($this->message->getProfileTitle()); ?></a>님이 공유한글
			</div>
			<?php } ?>

			<div class="replyCnt">
				<a href="javascript:;" onclick="olapStat('CIM26'); javascript:openComments(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getSender()->getUserId()))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getMessageKey()))); ?>); return false;" ondblclick="javascript:openComments(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getSender()->getUserId()))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->message->getMessageKey()))); ?>);olapStat('CIM26'); return false;" class="reply" onfocus="blur();">댓글 <i id="number_totalComments_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>"><?php echo htmlspecialchars(number_format($this->message->getCommentCnt())); ?></i></a>
				<span id="icon_isNew_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>" class="new" style="display:<?php echo $this->_escapeAttrib($this->message->hasNewComments() ? '' : 'none'); ?>">new</span>
			</div>
		</div>
	</div>

	<?php if ($this->message->isReconnectable($this->myUser)) { ?>
	<div id="reconnecting_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>" class="reCntInput" style="display:none">
		<?php $this->_tpl_233 = Podo_Template::instance('Main_Reconnecting'); foreach ($this as $__key=>$__val) { $this->_tpl_233->{$__key} = $__val; } $this->_tpl_233->message = $this->message; $this->_tpl_233->sort = $this->request->sort; $this->_tpl_233->printHead(-1, -1); ?><?php $this->_tpl_233->printTail(-1, -1); unset($this->_tpl_233); ?>
	</div>
	<?php } ?>
	<div id="box_comments_<?php echo $this->_escapeAttrib($this->message->getMessageKey()); ?>" class="replyBox" style="display:none;"></div>
</li>
<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
	cutStrByPixel("writer_nm_", <?php echo str_replace('\r', '', json_encode($this->message->getMessageKey())); ?>, "65", false);
	
	<?php if ($this->message->isReconnected($this->myUser)) { ?>
		cutStrByPixel("reconnect_writer_nm_", <?php echo str_replace('\r', '', json_encode($this->message->getMessageKey())); ?>, '65', false);
	<?php } ?>

</script><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>