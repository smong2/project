<tpl:Common_Html>
	<tpl:Admin_Head>
		<script type="text/javascript" language="javascript">
		//<!--
			function onSelectFieldGb(tg)
			{
				if (tg.value == '{ModuleConfig::FIELD_GB_TEXT}') {
					$('field_length').show();
					$('field_date').hide();
				}
				else {
					$('field_length').hide();
					$('field_date').show();
				}
			}
		//-->
		</script>

		<script for="window" event="onload">
			resizePopupWindow(286, 190);
			$('title').focus();
		</script>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="popup contents" cellpadding="0" cellspacing="0" border="0">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">카테고리 > 기본정보 {isset($this->moduleConfig) ? '수정' : '추가'}</td>
					</tr>
				</table>
			</td></tr>

			<tr height="15"><td></td></tr>

			<tr><td class="desc">
				<form action="{isset($this->moduleConfig) ? 'modifyBasicFieldProc' : 'addBasicFieldProc'}">
				<input type="hidden" name="category_sq" value="{$this->category->getCategorySq()}" />
				<input type="hidden" name="module_config_sq" value="{isset($this->moduleConfig) ? $this->moduleConfig->getModuleConfigSq() : ''}" />

				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<th>카테고리명</th>
								<td>{$this->category->getCategoryNm()}</td>
							</tr>
							<tr>
								<th class="form">타이틀</th>
								<td><input id="title" type="text" name="title" value="{isset($this->moduleConfig) ? $this->moduleConfig->getTitle() : ''}" size="20" style="ime-mode: active;" /></td>
							</tr>
							<tr class="last">
								<th class="form">데이타 타입</th>
								<td>
									<select name="field_gb" onchange="onSelectFieldGb(this);">
										<option value="{ModuleConfig::FIELD_GB_TEXT}" selected?="$this->selectedFieldGb == ModuleConfig::FIELD_GB_TEXT">텍스트</option>
										<option value="{ModuleConfig::FIELD_GB_DATE}" selected?="$this->selectedFieldGb == ModuleConfig::FIELD_GB_DATE">날짜</option>
										<option value="{ModuleConfig::FIELD_GB_PERIOD}" selected?="$this->selectedFieldGb == ModuleConfig::FIELD_GB_PERIOD">기간</option>
									</select>
									<span id="field_length" style="{$this->selectedFieldGb == ModuleConfig::FIELD_GB_TEXT ? '' : 'display:none;'}">
									<input type="text" name="field_length" value="{$this->selectedFieldGb == ModuleConfig::FIELD_GB_TEXT ? $this->selectedFieldLength : '20'}" size="2" />자
									</span>
									<select id="field_date" name="field_date" style="{$this->selectedFieldGb != ModuleConfig::FIELD_GB_TEXT ? '' : 'display:none;'}">
										<option value="{ModuleConfig::FIELD_DATE_YMD}" selected?="$this->selectedFieldGb == ModuleConfig::FIELD_GB_TEXT || $this->selectedFieldLength == ModuleConfig::FIELD_DATE_YMD">년월일</option>
										<option value="{ModuleConfig::FIELD_DATE_YM}" selected?="$this->selectedFieldGb != ModuleConfig::FIELD_GB_TEXT && $this->selectedFieldLength == ModuleConfig::FIELD_DATE_YM">년월</option>
										<option value="{ModuleConfig::FIELD_DATE_Y}" selected?="$this->selectedFieldGb != ModuleConfig::FIELD_GB_TEXT && $this->selectedFieldLength == ModuleConfig::FIELD_DATE_Y">년</option>
									</select>
								</td>
							</tr>
						</table>
					</td></tr>
					<tr height="10"><td></td></tr>
					<tr><td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr><td align="right">
								<input type="submit" value="확인" />
								<input type="button" value="취소" onclick="window.close();" />
							</td></tr>
						</table>
					</td></tr>
				</table>
				</form>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>


