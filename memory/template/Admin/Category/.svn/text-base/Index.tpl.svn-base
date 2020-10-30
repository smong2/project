<tpl:Common_Html>
	<tpl:Admin_Head>
	</tpl:Admin_Head>

	<tpl:Common_Body>
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
					<tr align="center" podo:foreach="$this->categories as $category" class="{%ISLAST% ? 'last' : ''}">
						<td class="number">{$category->getCategorySq()}</td>
						<td>{$category->getCategoryNm()}</td>
						<td class="number">{number_format($category->getMpCnt())}</td>
						<td>{$category->getActivateFl() ? 'O' : 'X'}</td>
						<td class="date">{date('m.d H:i', $category->getInsertDt())} ({Podo_Util_Date::getDiffDateStr($category->getInsertDt())})</td>
						<td class="date">{date('m.d H:i', $category->getUpdateDt())} ({Podo_Util_Date::getDiffDateStr($category->getUpdateDt())})</td>
						<td align="left">
							<a href="modify?category_sq={$category->getCategorySq()}">[수정]</a>
							<a href="remove?category_sq={$category->getCategorySq()}" podo:cond="$category->getMpCnt() <= 0" onclick="if (confirm('이 카테고리를 삭제하시겠습니까?') == false) return false;">[삭제]</a>
							<a href="/admin/log?arg={$category->getUniqueCode()}" onclick="alert('준비 중입니다.'); return false;">[로그]</a>
						</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
