<tpl:Common_Html>
	<tpl:Admin_Head>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">권한 관리 (메뉴별)</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="cmd" style="padding-left:20px;">
				<table cellpadding="0" cellspacing="0" border="0" width="260">
					<tr><td>
						<form id="form_menu">
							메뉴
							<select name="menu_gb" onchange="$('form_menu').submit();">
								<option podo:foreach="AdminMenu::$arrMenu as $menuGb=>$menuNm" value="{$menuGb}" attr-if:selected="$this->currMenu->getMenuGb() === $menuGb">{$menuNm}</option>
							</select>
						</form>
					</td></tr>
				</table>
			</td></tr>

			<tr height="10"><td></td></tr>

			<form action="authByMenuUpdateProc" method="post">
			<input type="hidden" name="menu_gb" value="{$this->currMenu->getMenuGb()}" />
			<tr><td class="desc">
				<table class="list" cellspacing="0" cellpadding="0" border="0" width="260">
					<tr>
						<th width="200">실명(아이디)</th>
						<th>권한</th>
					</tr>
					<tr podo:foreach="$this->officers as $officer" class="{%ISLAST% ? 'last' : ''}">
						<td><label for="officers_{$officer->getUserId()}">{$officer->user->getRealNameAndIdStr()}</label></td>
						<td align="center"><input type="checkbox" id="officers_{$officer->getUserId()}" name="officers[]" value="{$officer->getUserId()}" attr-if:checked="$this->currMenu->isGrantedTo($officer)"/></td>
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
