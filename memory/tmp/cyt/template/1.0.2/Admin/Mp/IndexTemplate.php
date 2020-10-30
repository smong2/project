<?php /* /home/mong/project/memory/template/Admin/Mp/Index.tpl */ class Admin_Mp_IndexTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $page; public $maxPage; public $mps = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
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
						<td class="title">MP 목록</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="desc">
				<table cellspacing="0" cellpadding="0" border="0">
					<tr><td class="top-cmd" align="right">
						<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
							<tr><td>
								<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>									
							</td></tr>							
						</table>
					</td></tr>
					<tr><td>
						<table class="list" cellspacing="0" cellpadding="0" border="0">
							<tr align="center">
								<th width="40">번호</th>
								<th width="60">카테고리</th>
								<th width="160" align="left">제목</th>
								<th width="80">생성자</th>
								<th width="80">기억일</th>
								<th width="40">조회수</th>
								<th width="40">공감수</th>
								<th width="40">댓글수</th>
								<th width="120">생성시각</th>
								<th width="40">상태</th>
								<th width="100">&nbsp;</th>
							</tr>
							<?php $_fid_94_var = $this->mps; if ($_fid_94_var == false) $_fid_94_var = array(); $_fid_94_idx = 1; $_fid_94_cnt = count($_fid_94_var); foreach ($_fid_94_var as $mp) { ?><tr class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_94_idx, $_fid_94_cnt) ? 'last' : ''); ?>">
								<td class="number" align="center"><?php echo $mp->getMpSq(); ?></td>
								<td align="center"><?php echo $mp->getCategory()->getCategoryNm(); ?></td>
								<td><?php echo $mp->getMpNm(); ?></td>
								<td align="center"><?php echo $mp->getCreatorNick(); ?></td>
								<td class="date" align="center"><?php echo $mp->getTimeTag()->getTimeTagStr(); ?></td>
								<td class="number" align="center"><?php echo number_format($mp->getHitCnt()); ?></td>
								<td class="number" align="center"><?php echo number_format($mp->getMemorizeCnt()); ?></td>
								<td class="number" align="center"><?php echo number_format($mp->getMtCnt()); ?></td>
								<td class="date"><?php echo date('m.d H:i', $mp->getInsertDt()); ?> (<?php echo Podo_Util_Date::getDiffDateStr($mp->getInsertDt()); ?>)</td>
								<td align="center"><?php echo $mp->getStatusStr(); ?></td>
								<td>
									<a href="modify?mp_sq=<?php echo $this->_escapeAttrib($mp->getMpSq()); ?>">[수정]</a>
									<a href="updateStatus?mp_sq=<?php echo $this->_escapeAttrib($mp->getMpSq()); ?>" onclick="try {window.open('updateStatus?mp_sq=<?php echo $this->_escapeAttrib($mp->getMpSq()); ?>', 'memory_mpUpdateStatus', 'width=378,height=256,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[상태변경]</a>
									<a href="#" onclick="alert('준비중입니다.'); return false;">[로그]</a>
								</td>
							</tr><?php $_fid_94_idx++; } ?>
						</table>
					</td></tr>
					<tr><td class="bottom-cmd" align="right">
						<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
							<tr><td>
								<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
							</td></tr>
						</table>
					</td></tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>