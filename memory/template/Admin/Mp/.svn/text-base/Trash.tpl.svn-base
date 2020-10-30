<tpl:Common_Html>
	<tpl:Admin_Head>		
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
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<form id="fo_page">
			<input type="hidden" name="mp_nm" value="{$this->req->mp_nm}" />
			<input type="hidden" name="reason_gb" value="{$this->req->reason_gb}" />
			<input type="hidden" name="status_gb" value="{$this->req->status_gb}" />
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
						<table  border=0 width=100%>
							<tr title="검색할 내용을 입력하시고 검색버튼을 클릭해주십시오"><td align=right valign=bottom></td>								
									<form id=Trash>
									<td width=540>MP 제목 : <input type="text" name=mp_nm size=15 value="{$this->req->mp_nm}"/>
										 / 사유 : <select name="reason_gb">
										 						<option value="">---모두---</option>
										 						<option podo:foreach="Police::$reasons as $reasonGb=>$reasonNm" value="{$reasonGb}"
										 							attr-if:selected="$this->req->reason_gb == $reasonGb">
										 							{$reasonNm}</option></select>
										 / 처리현황 : <select name="status_gb">
										 							<option value="">--모두--</option>
										 							<option podo:foreach="Police::$status as $statusGb=>$statusNm" 
										 								attr-if:selected="$this->req->status_gb == $statusGb"
										 								value="{$statusGb}">{$statusNm}</option></select>
										 <input type=submit value=검색 class="search-send">
									</td>
									</form>
							</tr>
							<tr height=10></tr>
							<tr><td align=left>Total Rows : {$this->cnt}</td>
							<td>
								<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">							
									<tr><td>
										<podo:execute href="/common/pageNavigator" curr="{$this->page}" max="{$this->maxPage}" block="10" callback="goPage" />
									</td></tr>
									<tr><td height="5"></td></tr>
								</table>						
							</td></tr>
						</table>
				</caption>
					<tr><td>
						<table class="list" cellspacing="0" cellpadding="0" border="0">
							<col>
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
							<tr podo:foreach="$this->mpPolices as $mpPolice" class="{%ISLAST% ? 'last' : ''}">
								<td>{$mpPolice->getMpSq()}</td>
								<td>{$mpPolice->getMp()->getMpNm()}</td>
								<td title="완전삭제된 자료는 작성자가 닉네임이 아닌 ID로 표시됨">{$mpPolice->getMp()->getCreatorNick()}</td>
								<td>{$mpPolice->getReasonStr()}</td>
								<td>{$mpPolice->getOfficer()->user->getRealNameAndIdStr()}</td>
								<td>{$mpPolice->getContent()}</td>
								<td>{$mpPolice->getStatusStr()}</td>
								<td  class="date">{date('m.d H:i', $mpPolice->getUpdateDt())} 
									({Podo_Util_Date::getDiffDateStr($mpPolice->getUpdateDt())})</td>

								<td><a href="updateStatus?mp_sq={$mpPolice->getMpSq()}" 
								podo:cond="$mpPolice->getStatusGb()<>MpPolice::STATUS_GB_REMOVED"
								onclick="try {window.open('updateStatus?mp_sq={$mpPolice->getMpSq()}', 'memory_mpUpdateStatus', 'width=378,height=256,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[상태변경]</a>
								<a href="TrashRemoveProc?MpSq={$mpPolice->getMpSq()}&page={$this->page}" 
									podo:cond="$mpPolice->getStatusGb()==MpPolice::STATUS_GB_TRASH" onclick="if (confirm('영구삭제 되어\n다시 복구 할 수 없습니다.\n정말 삭제 하시겠습니까?') == false) return false;" title="처리현황이 삭제 대기일 때 활성화">[삭제] </a></td>
							</tr>
						</table>
					</td></tr>
					<tr height="10"><td></td></tr>
					<tr><td align="right">
						<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
							<tr><td>
								<podo:execute href="/common/pageNavigator" curr="{$this->page}" max="{$this->maxPage}" block="10" callback="goPage" />
							</td></tr>
						</table>
					</td></tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
