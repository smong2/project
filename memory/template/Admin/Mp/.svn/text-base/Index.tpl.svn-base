<tpl:Common_Html>
	<tpl:Admin_Head>
		<script language="javascript" type="text/javascript">//<!--
			function goPage(page)
			{
				$('fo_page').page.value = page;
				$('fo_page').submit();
			}
		//--></script>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<form id="fo_page">
			<input type="hidden" name="page" value="{$this->page}" />
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
								<podo:execute href="/common/pageNavigator" curr="{$this->page}" max="{$this->maxPage}" block="10" callback="goPage" />									
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
							<tr podo:foreach="$this->mps as $mp" class="{%ISLAST% ? 'last' : ''}">
								<td class="number" align="center">{$mp->getMpSq()}</td>
								<td align="center">{$mp->getCategory()->getCategoryNm()}</td>
								<td>{$mp->getMpNm()}</td>
								<td align="center">{$mp->getCreatorNick()}</td>
								<td class="date" align="center">{$mp->getTimeTag()->getTimeTagStr()}</td>
								<td class="number" align="center">{number_format($mp->getHitCnt())}</td>
								<td class="number" align="center">{number_format($mp->getMemorizeCnt())}</td>
								<td class="number" align="center">{number_format($mp->getMtCnt())}</td>
								<td class="date">{date('m.d H:i', $mp->getInsertDt())} ({Podo_Util_Date::getDiffDateStr($mp->getInsertDt())})</td>
								<td align="center">{$mp->getStatusStr()}</td>
								<td>
									<a href="modify?mp_sq={$mp->getMpSq()}">[수정]</a>
									<a href="updateStatus?mp_sq={$mp->getMpSq()}" onclick="try {window.open('updateStatus?mp_sq={$mp->getMpSq()}', 'memory_mpUpdateStatus', 'width=378,height=256,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[상태변경]</a>
									<a href="#" onclick="alert('준비중입니다.'); return false;">[로그]</a>
								</td>
							</tr>
						</table>
					</td></tr>
					<tr><td class="bottom-cmd" align="right">
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
