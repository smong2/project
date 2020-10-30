<?php /* /home/mong/project/memory/template/Admin/Officer.tpl */ class Admin_OfficerTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $officers = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_7 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_7->{$__key} = $__val; } $this->_tpl_7->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">운영자 관리</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="subtitle">
				운영자 추가하기
			</td></tr>

			<tr height="10"><td></td></tr>

			<tr><td class="desc">
				<form action="officerAddProc">
				<table class="detail" cellspacing="0" cellpadding="0" border="0">
					<tr class="last">
						<th class="form">네이트 아이디</th>
						<td><input type="text" name="nate_id" value="" size="30" /></td>
						<td><input type="submit" value="추가하기" /></td>
					</tr>
				</table>
				</form>
			</td></tr>

			<tr height="50"><td></td></tr>

			<tr><td class="subtitle">
				운영자 목록
			</td></tr>

			<tr height="10"><td></td></tr>

			<tr><td class="desc">
				<table class="list" cellspacing="0" cellpadding="0" border="0">
					<tr align="center">
						<th>회원번호</th>
						<th>실명 (아이디)</th>
						<th>등록일</th>
						<th>접속일</th>
						<th></th>
					</tr>
					<?php $_fid_88_var = $this->officers; if ($_fid_88_var == false) $_fid_88_var = array(); $_fid_88_idx = 1; $_fid_88_cnt = count($_fid_88_var); foreach ($_fid_88_var as $officer) { ?><tr>
						<td class="number"><?php echo $officer->getUserId(); ?></td>
						<td><?php echo $officer->user->getRealNameAndIdStr(); ?></td>
						<td class="date"><?php echo date('m.d H:i', $officer->getOfficerDt()); ?> (<?php echo Podo_Util_Date::getDiffDateStr($officer->getOfficerDt()); ?>)</td>
						<td class="date"><?php echo date('m.d H:i', $officer->getLastAccessDt()); ?> (<?php echo Podo_Util_Date::getDiffDateStr($officer->getLastAccessDt()); ?>)</td>
						<td>
							<a href="officerRemoveProc?user_id=<?php echo $this->_escapeAttrib($officer->getUserId()); ?>" onclick="if (confirm('정말로 이 운영자를 삭제하시겠습니까?') === false) return false;">[삭제]</a>
							<a href="log?arg=<?php echo $this->_escapeAttrib($officer->getUniqueCode()); ?>" onclick="alert('준비중입니다.'); return false;">[로그]</a>
						</td>
					</tr><?php $_fid_88_idx++; } ?>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	<?php $this->_tpl_7->printTail(-1, -1); unset($this->_tpl_7); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>