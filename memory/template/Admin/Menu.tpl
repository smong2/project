<tpl:Common_Html>
	<tpl:Admin_Head>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<h3>운영자 관리</h3>
		<hr />

		<div>
			<h4>운영자 추가하기</h4>

			<form action="officerAddProc">
			<table cellspacing="0" cellpadding="5" border="1">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="nate_id" value="" size="60" /></td>
				</tr>
				<tr>
					<th>회원번호</th>
					<td><input type="text" name="user_id" value="" size="60" /></td>
				</tr>
				<tr>
					<th>실명</th>
					<td><input type="text" name="realname" value="" size="60" /></td>
				</tr>
				<tr>
					<td colspan="2">* 회원 정보 조회 인터페이스 연동 전까지는 회원번호와 실명을 직접 입력해줘야 합니다.</td>
				</tr>
				<tr>
					<td colspan="2" align="right"><input type="submit" value="추가하기" /></td>
				</tr>
			</table>
			</form>
		</div>

		<div>
			<h4>운영자 목록</h4>
			<table cellspacing="0" cellpadding="5" border="1">
				<tr>
					<th>회원번호</th>
					<th>실명 (아이디)</th>
					<th>등록일</th>
					<th>접속일</th>
					<th></th>
				</tr>
				<tr podo:foreach="$this->officers as $officer">
					<td>{$officer->getUserId()}</td>
					<td>{$officer->user->getRealNameAndIdStr()}</td>
					<td>{date('Y.m.d H:i:s', $officer->getOfficerDt())}</td>
					<td>{date('Y.m.d H:i:s', $officer->getLastAccessDt())}</td>
					<td>
						<a href="officerRemoveProc?user_id={$officer->getUserId()}" onclick="if (confirm('정말로 이 운영자를 삭제하시겠습니까?') === false) return false;">삭제</a>
						<a href="log?arg={$officer->getUniqueCode()}" onclick="alert('준비중입니다.'); return false;">로그</a>
					</td>
				</tr>
			</table>
		</div>
	</tpl:Common_Body>
</tpl:Common_Html>
