<?php /* /home/mong/project/memory/template/Admin/Mp/Trash.tpl */ class Admin_Mp_TrashTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $req; public $cnt; public $page; public $maxPage; public $mpPolices = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>		
		<script language="javascript" type="text/javascript">//<!--
			function onDeleteWait() {
				if(!confirm('영구삭제 되어\n다시 복구 할 수 없습니다.\n정말 삭제 하시겠습니까?')) return false;;
			}	
			function goPage(page)
			{
				$('fo_page').page.value = page;				
				$('fo_page').submit();
			}
			//-->
		</script>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<form id="fo_page">
			<input type="hidden" name="mp_nm" value="<?php echo $this->_escapeAttrib($this->req->mp_nm); ?>" />
			<input type="hidden" name="reason_gb" value="<?php echo $this->_escapeAttrib($this->req->reason_gb); ?>" />
			<input type="hidden" name="status_gb" value="<?php echo $this->_escapeAttrib($this->req->status_gb); ?>" />
			<input type="hidden" name="page" />
		</form>
	
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">MP 관리 > 삭제대기함</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>			
			<tr><td class="desc">				
				<table cellspacing="0" cellpadding="0" border="0">
					<caption align="right">
						<table border="0" width="100%">
							<tr title="검색할 내용을 입력하시고 검색버튼을 클릭해주십시오"><td align="right" valign="bottom"></td>								
									<form id="Trash">
									<td width="540">MP 제목 : <input type="text" name="mp_nm" size="15" value="<?php echo $this->_escapeAttrib($this->req->mp_nm); ?>" />
										 / 사유 : <select name="reason_gb">
										 						<option value="">---모두---</option>
										 						<?php $_fid_64_var = Police::$reasons; if ($_fid_64_var == false) $_fid_64_var = array(); $_fid_64_idx = 1; $_fid_64_cnt = count($_fid_64_var); foreach ($_fid_64_var as $reasonGb=>$reasonNm) { ?><option value="<?php echo $this->_escapeAttrib($reasonGb); ?>" <?php echo ($this->req->reason_gb == $reasonGb) ? 'selected="selected"' : ''; ?>
>
										 							<?php echo $reasonNm; ?></option><?php $_fid_64_idx++; } ?></select>
										 / 처리현황 : <select name="status_gb">
										 							<option value="">--모두--</option>
										 							<?php $_fid_72_var = Police::$status; if ($_fid_72_var == false) $_fid_72_var = array(); $_fid_72_idx = 1; $_fid_72_cnt = count($_fid_72_var); foreach ($_fid_72_var as $statusGb=>$statusNm) { ?><option <?php echo ($this->req->status_gb == $statusGb) ? 'selected="selected"' : ''; ?> value="<?php echo $this->_escapeAttrib($statusGb); ?>"

><?php echo $statusNm; ?></option><?php $_fid_72_idx++; } ?></select>
										 <input type="submit" value="검색" class="search-send" />
									</td>
									</form>
							</tr>
							<tr height="10"></tr>
							<tr><td align="left">Total Rows : <?php echo $this->cnt; ?></td>
							<td>
								<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">							
									<tr><td>
										<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
									</td></tr>
									<tr><td height="5"></td></tr>
								</table>						
							</td></tr>
						</table>
				</caption>
					<tr><td>
						<table class="list" cellspacing="0" cellpadding="0" border="0">
							<col />
							<tr>
								<th>MP번호</th>								
								<th>MP제목</th>								
								<th>작성자</th>
								<th>사유</th>
								<th>집행자</th>
								<th>삭제대기사유</th>
								<th>처리현황</th>
								<th>상태시각</th>
								<th title="상태변경은 완전삭제시에 작동하지 않으며, 삭제는 삭제대기인 경우에만 작동합니다">처리</th>
							</tr>
							<?php $_fid_140_var = $this->mpPolices; if ($_fid_140_var == false) $_fid_140_var = array(); $_fid_140_idx = 1; $_fid_140_cnt = count($_fid_140_var); foreach ($_fid_140_var as $mpPolice) { ?><tr class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_140_idx, $_fid_140_cnt) ? 'last' : ''); ?>">
								<td><?php echo $mpPolice->getMpSq(); ?></td>
								<td><?php echo $mpPolice->getMp()->getMpNm(); ?></td>
								<td title="완전삭제된 자료는 작성자가 닉네임이 아닌 ID로 표시됨"><?php echo $mpPolice->getMp()->getCreatorNick(); ?></td>
								<td><?php echo $mpPolice->getReasonStr(); ?></td>
								<td><?php echo $mpPolice->getOfficer()->user->getRealNameAndIdStr(); ?></td>
								<td><?php echo $mpPolice->getContent(); ?></td>
								<td><?php echo $mpPolice->getStatusStr(); ?></td>
								<td class="date"><?php echo date('m.d H:i', $mpPolice->getUpdateDt()); ?> 
									(<?php echo Podo_Util_Date::getDiffDateStr($mpPolice->getUpdateDt()); ?>)</td>

								<td><?php $this->_isCondResult1 =  ($mpPolice->getStatusGb()<>MpPolice::STATUS_GB_REMOVED); if ($this->_isCondResult1) { ?><a href="updateStatus?mp_sq=<?php echo $this->_escapeAttrib($mpPolice->getMpSq()); ?>" onclick="try {window.open('updateStatus?mp_sq=<?php echo $this->_escapeAttrib($mpPolice->getMpSq()); ?>', 'memory_mpUpdateStatus', 'width=378,height=256,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;"

><?php } ?>[상태변경]<?php if ($this->_isCondResult1) { ?></a><?php } ?>
								<?php $this->_isCondResult2 =  ($mpPolice->getStatusGb()==MpPolice::STATUS_GB_TRASH); if ($this->_isCondResult2) { ?><a href="TrashRemoveProc?MpSq=<?php echo $this->_escapeAttrib($mpPolice->getMpSq()); ?>&amp;page=<?php echo $this->_escapeAttrib($this->page); ?>" onclick="if (confirm('영구삭제 되어\n다시 복구 할 수 없습니다.\n정말 삭제 하시겠습니까?') == false) return false;" title="처리현황이 삭제 대기일 때 활성화"
><?php } ?>[삭제] <?php if ($this->_isCondResult2) { ?></a><?php } ?></td>
							</tr><?php $_fid_140_idx++; } ?>
						</table>
					</td></tr>
					<tr height="10"><td></td></tr>
					<tr><td align="right">
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