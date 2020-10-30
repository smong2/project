<?php /* /home/mong/project/memory/template/Mp/GetMts.tpl */ class Mp_GetMtsTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $mts = array(); public $request; public function printHead($p_intLine, $p_intCol) { ?><?php $_fid_153_var = $this->mts; if ($_fid_153_var == false) $_fid_153_var = array(); $_fid_153_idx = 1; $_fid_153_cnt = count($_fid_153_var); foreach ($_fid_153_var as $mt) { ?><p>
	<?php echo $mt->getTimeTag()->getShortStr(); ?>에 <?php echo $mt->getWriterNick(); ?>님은
	<br />
	<?php echo $mt->getContent(); ?>
	<br />
	<a href="?mp_sq=<?php echo $this->_escapeAttrib($this->request->mp_sq); ?>&amp;mt_sq=<?php echo $this->_escapeAttrib($mt->getMtSq()); ?>" onclick="toggleMtChildren(<?php echo $this->_escapeAttrib($mt->getMtSq()); ?>); return false;" ondblclick="toggleMtChildren(<?php echo $this->_escapeAttrib($mt->getMtSq()); ?>); return false;">댓글 (<?php echo $mt->getChildMtCnt(); ?>)</a>
	<br />
	<?php echo date('Y.m.d H:i', $mt->getInsertDt()); ?> <a href="#">주소복사</a>

	<div id="mt_children_<?php echo $this->_escapeAttrib($mt->getMtSq()); ?>" style="display:none; border-left: 2px solid gray; margin-top: 10px; margin-left: 30px; padding-left: 10px;"></div>
</p><?php $_fid_153_idx++; } ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>