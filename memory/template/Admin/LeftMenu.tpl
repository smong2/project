<tpl:Common_Html>
	<tpl:Admin_Head>
		<style>
			body {margin: 10px 10px;}
			dt {font-weight: bold; margin-bottom: 4px;}
			dd {margin-left: 8px;}
			ul {margin-left: 0px; padding-left: 12px;}
			li {margin-bottom: 4px; }
		</style>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<dl>
			<dt>기억나 관리</dt>
			<dd>
				<ul>
					<li><a href="home" target="body">Home</a></li>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt>MP 관리</dt>
			<dd>
				<ul>
					<li><a href="category/index" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_CATEGORY)">카테고리 관리</a></li>
					<li><a href="mp/index" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_MP)">MP 목록</a></li>
					<li><a href="mp/add" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_MP)">MP 추가</a></li>
					<li><a href="mp/trash" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_MP)">삭제대기함</a></li>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt>운영자 관리</dt>
			<dd>
				<ul>
					<li><a href="officer" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_OFFICER)">운영자 관리</a></li>
					<li><a href="authByOfficer" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_AUTH)">권한 관리 (운영자별)</a></li>
					<li><a href="authByMenu" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_AUTH)">권한 관리 (메뉴별)</a></li>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt>기타</dt>
			<dd>
				<ul>
					<li><a href="log" target="body" podo:cond="$this->myOfficer->haveAuthOf(AdminMenu::GB_LOG)">관리 로그 보기</a></li>
				</ul>
			</dd>
		</dl>
	</tpl:Common_Body>
</tpl:Common_Html>
