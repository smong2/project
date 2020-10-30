<?php /* /home/mong/project/memory/template/Mybox/Config/Reqtest1.tpl */ class Mybox_Config_Reqtest1Template extends Podo_Template_Base { const HAVE_CDATA = FALSE; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>

		<?php $this->_tpl_4 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<form name="frm" method="post" action="reqtest2" enctype="multipart/form-data">
		<input type="file" text="file_upfield" />
		<input type="submit" value="업로드" />
		</form>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>