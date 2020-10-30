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
								<input type="text" name="unique_code" value="" size="20" value="{$this->uniqueCode}" />
								<input type="submit" value="검색하기" />
							</form>
						</td>
						<td class="top-cmd" align="right">
							<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
								<tr><td>
									<podo:execute href="/common/pageNavigator" curr="{$this->page}" max="{$this->maxPage}" block="10" callback="goPage" />
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
							<tr podo:foreach="$this->logs as $log" class="{%ISLAST% ? 'last' : ''}">
								<td class="date">{date('m.d H:i', $log->getInsertDt())} ({Podo_Util_Date::getDiffDateStr($log->getInsertDt())})</td>
								<td>{$log->getOfficer()->user->getRealNameAndIdStr()}</td>
								<td>{$log->getActionStr()}</td>
							</tr>
						</table>
					</td></tr>
					<tr>
						<td class="bottom-cmd">
							<form onsubmit="alert('준비중입니다.'); return false;">
								<strong>검색 코드</strong>
								<input type="text" name="unique_code" value="" size="20" value="{$this->uniqueCode}" />
								<input type="submit" value="검색하기" />
							</form>
						</td>
						<td class="bottom-cmd" align="right">
							<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
								<tr><td>
									<podo:execute href="/common/pageNavigator" curr="{$this->page}" max="{$this->maxPage}" block="10" callback="goPage" />
								</td></tr>
							</table>
						</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
