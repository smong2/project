<?php /* /home/mong/project/memory/template/Admin/Home.tpl */ class Admin_HomeTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_7 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_7->{$__key} = $__val; } $this->_tpl_7->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">HOME</td>
					</tr>
				</table>
			</td></tr>
		</table>
	<?php $this->_tpl_7->printTail(-1, -1); unset($this->_tpl_7); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>