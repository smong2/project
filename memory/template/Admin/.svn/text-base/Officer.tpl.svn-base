<tpl:Common_Html>
	<tpl:Admin_Head>
	</tpl:Admin_Head>

	<tpl:Common_Body>
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
					<tr podo:foreach="$this->officers as $officer">
						<td class="number">{$officer->getUserId()}</td>
						<td>{$officer->user->getRealNameAndIdStr()}</td>
						<td class="date">{date('m.d H:i', $officer->getOfficerDt())} ({Podo_Util_Date::getDiffDateStr($officer->getOfficerDt())})</td>
						<td class="date">{date('m.d H:i', $officer->getLastAccessDt())} ({Podo_Util_Date::getDiffDateStr($officer->getLastAccessDt())})</td>
						<td>
							<a href="officerRemoveProc?user_id={$officer->getUserId()}" onclick="if (confirm('정말로 이 운영자를 삭제하시겠습니까?') === false) return false;">[삭제]</a>
							<a href="log?arg={$officer->getUniqueCode()}" onclick="alert('준비중입니다.'); return false;">[로그]</a>
						</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
