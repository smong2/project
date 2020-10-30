<?php /* /home/mong/project/memory/template/Admin/Category/Index.tpl */ class Admin_Category_IndexTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $categories = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_7 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_7->{$__key} = $__val; } $this->_tpl_7->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">카테고리 관리</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="subtitle">
				카테고리 추가
			</td></tr>

			<tr height="10"><td></td></tr>

			<tr><td class="desc">
				<form action="addProc">
				<table class="detail" cellspacing="0" cellpadding="0" border="0">
					<tr class="last">
						<th class="form">카테고리명</th>
						<td><input type="text" name="category_nm" value="" size="30" /></td>
						<td><input type="submit" value="추가하기" /></td>
					</tr>
				</table>
				</form>
			</td></tr>

			<tr height="50"><td></td></tr>

			<tr><td class="subtitle">
				카테고리 목록
			</td></tr>

			<tr height="10"><td></td></tr>

			<tr><td class="desc">
				<table class="list" cellspacing="0" cellpadding="0" border="0">
					<tr align="center">
						<th>번호</th>
						<th>카테고리명</th>
						<th>MP수</th>
						<th>노출</th>
						<th>등록일</th>
						<th>수정일</th>
						<th>&nbsp;</th>
					</tr>
					<?php $_fid_95_var = $this->categories; if ($_fid_95_var == false) $_fid_95_var = array(); $_fid_95_idx = 1; $_fid_95_cnt = count($_fid_95_var); foreach ($_fid_95_var as $category) { ?><tr align="center" class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_95_idx, $_fid_95_cnt) ? 'last' : ''); ?>">
						<td class="number"><?php echo $category->getCategorySq(); ?></td>
						<td><?php echo $category->getCategoryNm(); ?></td>
						<td class="number"><?php echo number_format($category->getMpCnt()); ?></td>
						<td><?php echo $category->getActivateFl() ? 'O' : 'X'; ?></td>
						<td class="date"><?php echo date('m.d H:i', $category->getInsertDt()); ?> (<?php echo Podo_Util_Date::getDiffDateStr($category->getInsertDt()); ?>)</td>
						<td class="date"><?php echo date('m.d H:i', $category->getUpdateDt()); ?> (<?php echo Podo_Util_Date::getDiffDateStr($category->getUpdateDt()); ?>)</td>
						<td align="left">
							<a href="modify?category_sq=<?php echo $this->_escapeAttrib($category->getCategorySq()); ?>">[수정]</a>
							<?php $this->_isCondResult1 =  ($category->getMpCnt() <= 0); if ($this->_isCondResult1) { ?><a href="remove?category_sq=<?php echo $this->_escapeAttrib($category->getCategorySq()); ?>" onclick="if (confirm('이 카테고리를 삭제하시겠습니까?') == false) return false;"><?php } ?>[삭제]<?php if ($this->_isCondResult1) { ?></a><?php } ?>
							<a href="/admin/log?arg=<?php echo $this->_escapeAttrib($category->getUniqueCode()); ?>" onclick="alert('준비 중입니다.'); return false;">[로그]</a>
						</td>
					</tr><?php $_fid_95_idx++; } ?>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	<?php $this->_tpl_7->printTail(-1, -1); unset($this->_tpl_7); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>