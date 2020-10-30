<?php /* /home/mong/project/memory/template/Admin/AuthByMenu.tpl */ class Admin_AuthByMenuTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $currMenu; public $officers = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_7 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_7->{$__key} = $__val; } $this->_tpl_7->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">권한 관리 (메뉴별)</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="cmd" style="padding-left:20px;">
				<table cellpadding="0" cellspacing="0" border="0" width="260">
					<tr><td>
						<form id="form_menu">
							메뉴
							<select name="menu_gb" onchange="$('form_menu').submit();">
								<?php $_fid_39_var = AdminMenu::$arrMenu; if ($_fid_39_var == false) $_fid_39_var = array(); $_fid_39_idx = 1; $_fid_39_cnt = count($_fid_39_var); foreach ($_fid_39_var as $menuGb=>$menuNm) { ?><option value="<?php echo $this->_escapeAttrib($menuGb); ?>" <?php echo ($this->currMenu->getMenuGb() === $menuGb) ? 'selected="selected"' : ''; ?>><?php echo $menuNm; ?></option><?php $_fid_39_idx++; } ?>
							</select>
						</form>
					</td></tr>
				</table>
			</td></tr>

			<tr height="10"><td></td></tr>

			<form action="authByMenuUpdateProc" method="post">
			<input type="hidden" name="menu_gb" value="<?php echo $this->_escapeAttrib($this->currMenu->getMenuGb()); ?>" />
			<tr><td class="desc">
				<table class="list" cellspacing="0" cellpadding="0" border="0" width="260">
					<tr>
						<th width="200">실명(아이디)</th>
						<th>권한</th>
					</tr>
					<?php $_fid_68_var = $this->officers; if ($_fid_68_var == false) $_fid_68_var = array(); $_fid_68_idx = 1; $_fid_68_cnt = count($_fid_68_var); foreach ($_fid_68_var as $officer) { ?><tr class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_68_idx, $_fid_68_cnt) ? 'last' : ''); ?>">
						<td><label for="officers_<?php echo $this->_escapeAttrib($officer->getUserId()); ?>"><?php echo $officer->user->getRealNameAndIdStr(); ?></label></td>
						<td align="center"><input type="checkbox" id="officers_<?php echo $this->_escapeAttrib($officer->getUserId()); ?>" name="officers[]" value="<?php echo $this->_escapeAttrib($officer->getUserId()); ?>" <?php echo ($this->currMenu->isGrantedTo($officer)) ? 'checked="checked"' : ''; ?> /></td>
					</tr><?php $_fid_68_idx++; } ?>
				</table>
			</td></tr>

			<tr height="10"><td></td></tr>

			<tr><td class="cmd">
				<table cellpadding="0" cellspacing="0" border="0" width="250">
					<tr><td align="right">
						<input type="submit" value="변경" />
					</td></tr>
				</table>
			</td></tr>
			</form>

			<tr height="30"><td></td></tr>
		</table>
	<?php $this->_tpl_7->printTail(-1, -1); unset($this->_tpl_7); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>