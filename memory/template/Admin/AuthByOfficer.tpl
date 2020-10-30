<tpl:Common_Html>
	<tpl:Admin_Head>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">권한 관리 (운영자별)</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="cmd" style="padding-left:20px;">
				<table cellpadding="0" cellspacing="0" border="0" width="260">
					<tr><td>
						<form id="form_officer">
							운영자
							<select name="user_id" onchange="$('form_officer').submit();">
								<option podo:foreach="$this->officers as $officer" value="{$officer->getUserId()}" attr-if:selected="$this->currUser->getUserId() === $officer->getUserId()">{$officer->user->getRealNameAndIdStr()}</option>
							</select>
						</form>
					</td></tr>
				</table>
			</td></tr>

			<tr height="10"><td></td></tr>

			<form action="authByOfficerUpdateProc" method="post">
			<input type="hidden" name="user_id" value="{$this->currUser->getUserId()}" />
			<tr><td class="desc">
				<table class="list" cellspacing="0" cellpadding="0" border="0" width="260">
					<tr>
						<th width="200">메뉴명</th>
						<th>권한</th>
					</tr>
					<tr podo:foreach="AdminMenu::$arrMenu as $menuGb=>$menuNm">
						<td><label for="menus_{$menuGb}">{$menuNm}</label></td>
						<td><input type="checkbox" id="menus_{$menuGb}" name="menus[]" value="{$menuGb}" attr-if:checked="$this->currUser->haveAuthOf($menuGb)"/></td>
					</tr>
				</table>
			</td></tr>

			<tr height="10"><td></td></tr>

			<tr><td class="cmd">
				<table cellpadding="0" cellspacing="0" border="0" width="250">
					<tr><td align="right">
						<input type="submit" value="변경" />
					</td></tr>
				</table>
			</td></tr>
			</form>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
