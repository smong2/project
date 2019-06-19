<?php /* /home/mong/project/NateOnConnecting/template/Message/CommentsAjax.tpl */ class Message_CommentsAjaxTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $message; public $totalComments; public $comments = array(); public $mode; public $totalPages; public $page; public $request; public $twit_id; public function printHead($p_intLine, $p_intCol) { ?><script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
	try { 
		document.getElementById('textbox_comment_'+<?php echo str_replace('\r', '', json_encode($this->message->getMessageKey())); ?>).focus(); 
	} catch (e) { }
	try { 
		setTotalComments(<?php echo str_replace('\r', '', json_encode($this->message->getMessageKey())); ?>, <?php echo str_replace('\r', '', json_encode($this->totalComments)); ?>, <?php echo str_replace('\r', '', json_encode(number_format($this->totalComments))); ?>); 
	} catch (e) { }
</script>
<ul class="viewReply">
	<?php $_fid_7_var = $this->comments; if ($_fid_7_var == false) $_fid_7_var = array(); $_fid_7_idx = 1; $_fid_7_cnt = count($_fid_7_var); foreach ($_fid_7_var as $comment) { ?>
		<?php $this->_tpl_9 = Podo_Template::instance('Message_Comment'); foreach ($this as $__key=>$__val) { $this->_tpl_9->{$__key} = $__val; } $this->_tpl_9->comment = $comment; $this->_tpl_9->message = $this->message; $this->_tpl_9->mode = $this->mode; $this->_tpl_9->printHead(-1, -1); ?><?php $this->_tpl_9->printTail(-1, -1); unset($this->_tpl_9); ?>
	<?php $_fid_7_idx++; } ?>
</ul>

<?php if ($this->totalPages > 1) { ?>
	<?php $__strHref = '/message/comment/pageNavigator'; $__arrAttr = array('max'=>$this->totalPages, 'curr'=>$this->page, 'senderCmn'=>$this->request->senderCmn, 'messageKey'=>$this->request->messageKey, 'mode'=>$this->mode, 'twit_id'=>$this->twit_id); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
<?php } ?>

<?php $this->_tpl_18 = Podo_Template::instance('Message_PostComment'); foreach ($this as $__key=>$__val) { $this->_tpl_18->{$__key} = $__val; } $this->_tpl_18->id = $this->message->getMessageKey(); $this->_tpl_18->messageKey = $this->message->getMessageKey(); $this->_tpl_18->commentKey = ''; $this->_tpl_18->userId = $this->message->getSender()->getUserId(); $this->_tpl_18->parentId = ''; $this->_tpl_18->mode = $this->mode; $this->_tpl_18->twitId = $this->twit_id; $this->_tpl_18->printHead(-1, -1); ?><?php $this->_tpl_18->printTail(-1, -1); unset($this->_tpl_18); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>