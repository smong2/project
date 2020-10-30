<?php /* /home/mong/project/memory/template/Admin/TopMenu.tpl */ class Admin_TopMenuTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $myOfficer; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_7 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_7->{$__key} = $__val; } $this->_tpl_7->printHead(-1, -1); ?>
		<table width="100%" style="margin:10px 0px;">
			<tr>
				<td style="padding-left:10px; font-size:11pt; font-weight:bold;">
					<a href="http://www.nate.com" target="_top"><strong>Nate</strong></a>
					<a href="http://memory.nate.com" target="_top" style="font-size:10pt;">기억나</a>
				</td>
				<td align="right" style="padding-right:10px;">
					<?php echo $this->myOfficer->user->getRealNameAndIdStr(); ?> |
					<a href="http://xso.nate.com/rlogout.jsp?redirect=http://memory.nate.com/admin/index" target="_top">로그아웃</a>
				</td>
			</tr>
		</table>
	<?php $this->_tpl_7->printTail(-1, -1); unset($this->_tpl_7); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>