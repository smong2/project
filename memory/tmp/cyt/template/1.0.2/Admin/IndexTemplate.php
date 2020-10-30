<?php /* /home/mong/project/memory/template/Admin/Index.tpl */ class Admin_IndexTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<frameset rows="40, *">
		<frame src="topMenu" scrolling="no" /> 
		<frameset cols="160, *">
			<frame src="leftMenu" scrolling="no" />
			<frame src="home" name="body" />
		</frameset>
	</frameset>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>