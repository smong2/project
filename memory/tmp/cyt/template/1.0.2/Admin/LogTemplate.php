<?php /* /home/mong/project/memory/template/Admin/Log.tpl */ class Admin_LogTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $page; public $uniqueCode; public $maxPage; public $logs = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
		<script language="javascript" type="text/javascript">//<!--
			function goPage(page)
			{
				$('fo_page').page.value = page;
				$('fo_page').submit();
			}
		//--></script>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<form id="fo_page">
			<input type="hidden" name="page" value="<?php echo $this->_escapeAttrib($this->page); ?>" />
		</form>

		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">관리 로그</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="desc">
				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr>
						<td class="top-cmd">
							<form onsubmit="alert('준비중입니다.'); return false;">
								<strong>검색 코드</strong>
								<input type="text" name="unique_code" value="<?php echo $this->_escapeAttrib($this->uniqueCode); ?>" size="20" />
								<input type="submit" value="검색하기" />
							</form>
						</td>
						<td class="top-cmd" align="right">
							<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
								<tr><td>
									<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
								</td></tr>
							</table>
						</td>
					</tr>
					<tr><td colspan="2">
						<table class="list" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr align="center">
								<th width="120">일시</th>
								<th width="200" align="left">운영자</th>
								<th align="left">내용</th>
							</tr>
							<?php $_fid_85_var = $this->logs; if ($_fid_85_var == false) $_fid_85_var = array(); $_fid_85_idx = 1; $_fid_85_cnt = count($_fid_85_var); foreach ($_fid_85_var as $log) { ?><tr class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_85_idx, $_fid_85_cnt) ? 'last' : ''); ?>">
								<td class="date"><?php echo date('m.d H:i', $log->getInsertDt()); ?> (<?php echo Podo_Util_Date::getDiffDateStr($log->getInsertDt()); ?>)</td>
								<td><?php echo $log->getOfficer()->user->getRealNameAndIdStr(); ?></td>
								<td><?php echo $log->getActionStr(); ?></td>
							</tr><?php $_fid_85_idx++; } ?>
						</table>
					</td></tr>
					<tr>
						<td class="bottom-cmd">
							<form onsubmit="alert('준비중입니다.'); return false;">
								<strong>검색 코드</strong>
								<input type="text" name="unique_code" value="<?php echo $this->_escapeAttrib($this->uniqueCode); ?>" size="20" />
								<input type="submit" value="검색하기" />
							</form>
						</td>
						<td class="bottom-cmd" align="right">
							<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
								<tr><td>
									<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
								</td></tr>
							</table>
						</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>