<?php /* /home/mong/project/memory/template/Mybox/Config/Duplicate.tpl */ class Mybox_Config_DuplicateTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $dup_result; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>
		<script>
			var before = {
				'dup' : <?php echo str_replace('\r', '', json_encode($this->dup_result)); ?>
			}
			if(before.dup==1) {
				opener.$("checkval").value=1;
				alert("사용 가능한 닉네임 입니다");
			} else {
				opener.$("checkval").value=0;
				alert("사용 불가합니다. 다시 검색해주십시오")
			}
			self.close();

		</script>
	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>