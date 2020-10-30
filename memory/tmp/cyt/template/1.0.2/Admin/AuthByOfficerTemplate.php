<?php /* /home/mong/project/memory/template/Admin/AuthByOfficer.tpl */ class Admin_AuthByOfficerTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $currUser; public $officers = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_7 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_7->{$__key} = $__val; } $this->_tpl_7->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">권한 관리 (운영자별)</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="cmd" style="padding-left:20px;">
				<table cellpadding="0" cellspacing="0" border="0" width="260">
					<tr><td>
						<form id="form_officer">
							운영자
							<select name="user_id" onchange="$('form_officer').submit();">
								<?php $_fid_39_var = $this->officers; if ($_fid_39_var == false) $_fid_39_var = array(); $_fid_39_idx = 1; $_fid_39_cnt = count($_fid_39_var); foreach ($_fid_39_var as $officer) { ?><option value="<?php echo $this->_escapeAttrib($officer->getUserId()); ?>" <?php echo ($this->currUser->getUserId() === $officer->getUserId()) ? 'selected="selected"' : ''; ?>><?php echo $officer->user->getRealNameAndIdStr(); ?></option><?php $_fid_39_idx++; } ?>
							</select>
						</form>
					</td></tr>
				</table>
			</td></tr>

			<tr height="10"><td></td></tr>

			<form action="authByOfficerUpdateProc" method="post">
			<input type="hidden" name="user_id" value="<?php echo $this->_escapeAttrib($this->currUser->getUserId()); ?>" />
			<tr><td class="desc">
				<table class="list" cellspacing="0" cellpadding="0" border="0" width="260">
					<tr>
						<th width="200">메뉴명</th>
						<th>권한</th>
					</tr>
					<?php $_fid_68_var = AdminMenu::$arrMenu; if ($_fid_68_var == false) $_fid_68_var = array(); $_fid_68_idx = 1; $_fid_68_cnt = count($_fid_68_var); foreach ($_fid_68_var as $menuGb=>$menuNm) { ?><tr>
						<td><label for="menus_<?php echo $this->_escapeAttrib($menuGb); ?>"><?php echo $menuNm; ?></label></td>
						<td><input type="checkbox" id="menus_<?php echo $this->_escapeAttrib($menuGb); ?>" name="menus[]" value="<?php echo $this->_escapeAttrib($menuGb); ?>" <?php echo ($this->currUser->haveAuthOf($menuGb)) ? 'checked="checked"' : ''; ?> /></td>
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