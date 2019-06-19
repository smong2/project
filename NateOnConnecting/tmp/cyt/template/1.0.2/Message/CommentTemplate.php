<?php /* /home/mong/project/NateOnConnecting/template/Message/Comment.tpl */ class Message_CommentTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $comment; public $mode; public $page; public $totalPages; public $totalComments; public $twit_id; public $myUser; public $message; public function printHead($p_intLine, $p_intCol) { ?><li style="white-space:normal; word-break:break-all; word-wrap:break-word;" class="<?php echo $this->_escapeAttrib($this->comment->isReComment()?'rereple':'reply'); ?><?php echo $this->_escapeAttrib($this->comment->getIsSecret()?' secret':''); ?>">
	<u>
	  <?php if ($this->comment->getIsSecret()) { ?><img src="/ui/img/ico_lock.gif" alt="비밀" /><?php } ?>
	  <a href="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->comment->getDomain()); ?>');" onclick="javascript:openWindow('http://connect.nate.com/<?php echo $this->_escapeAttrib($this->comment->getDomain()); ?>'); olapStat('CIM27'); return false" id="comment_writer_nm_<?php echo $this->_escapeAttrib($this->comment->getCommentKey()); ?>" onfocus="blur();"><?php echo htmlspecialchars($this->comment->getProfileTitle()); ?></a></u>

	<span <?php if ($this->comment->getVisible() == 'false') { ?>class="private"<?php } ?>>
			<?php echo $this->comment->getContentHTML(); ?>
		<b title="<?php echo $this->_escapeAttrib(date('Y.m.d H:i', $this->comment->getWriteDt())); ?>"><?php echo $this->comment->getWriteDtDiffHTML(); ?></b>

		<?php if (($this->comment->isReComment() == false && $this->mode != Comment::COMMENT_TYPE_TWIT)) { ?><a href="javascript:openAddReComment(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->comment->getCommentKey()))); ?>); return false;" id="re_reply" onclick="openReComment(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->comment->getCommentKey()))); ?>); return false;" onfocus="blur();">재댓글</a><?php } ?>
		<?php if ($this->comment->isRemovable($this->myUser) && $this->comment->getDeletedYN() == 'n') { ?><a href="#" onclick="deleteComment(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->comment->getMessage()->getSender()->getUserId()))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->comment->getMessage()->getMessageKey()))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->comment->getCommentKey()))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->page))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->totalPages))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->totalComments))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->mode))); ?>, <?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode($this->twit_id))); ?>);olapStat('CIM28'); return false;" class="re_del" title="댓글삭제" onfocus="blur();">삭제</a><?php } ?>
		<?php if ($this->comment->isNew()) { ?><img src="/ui/img/ic_n.gif" width="8" height="8" alt="new" /><?php } ?>
	</span>
	
	<?php if ($this->comment->isReComment() == false) { ?>
		<div class="re_reply" id="box_recomments_<?php echo $this->_escapeAttrib($this->comment->getCommentKey()); ?>" style="display:none">
			<?php $this->_tpl_47 = Podo_Template::instance('Message_PostComment'); foreach ($this as $__key=>$__val) { $this->_tpl_47->{$__key} = $__val; } $this->_tpl_47->id = $this->comment->getCommentKey(); $this->_tpl_47->messageKey = $this->message->getMessageKey(); $this->_tpl_47->commentKey = $this->comment->getCommentKey(); $this->_tpl_47->userId = $this->message->getSender()->getUserId(); $this->_tpl_47->parentId = $this->comment->getCommentId(); $this->_tpl_47->mode = (Comment::COMMENT_TYPE_RECOMMENT); $this->_tpl_47->twitId = ''; $this->_tpl_47->printHead(-1, -1); ?><?php $this->_tpl_47->printTail(-1, -1); unset($this->_tpl_47); ?>
		</div>
	<?php } ?>
</li>
<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript" language="javascript">
	cutStrByPixel("comment_writer_nm_", <?php echo str_replace('\r', '', json_encode($this->comment->getCommentKey())); ?>, "59", false);
</script><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>