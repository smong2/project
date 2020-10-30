<tpl:Common_Html>
	<tpl:Admin_Head>
		<script type="text/javascript" language="javascript">
		//<!--
			function onSubmit()
			{
				try {
					opener.setMainImage($('mainimg_gb').value, $('mainimg_url').value);
				}
				catch (e) {
				}

				window.close();
			}
		//-->
		</script>

		<script for="window" event="onload">
			resizePopupWindow(286, 129);
		</script>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="popup contents" cellpadding="0" cellspacing="0" border="0">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">MP 관리 > 정보 수정 > 메인 이미지 수정</td>
					</tr>
				</table>
			</td></tr>

			<tr height="15"><td></td></tr>

			<tr><td class="desc">
				<form action="{isset($this->moduleConfig) ? 'modifyBasicFieldProc' : 'addBasicFieldProc'}" onsubmit="onSubmit();">
				<input id="mainimg_gb" type="hidden" name="mainimg_gb" value="{Image::GB_LINK}" />

				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0" width="270">
							<col width="70" />
							<col width="152" />

							<tr class="last">
								<th class="form">이미지 URL</th>
								<td><input id="mainimg_url" type="text" name="mainimg_url" value="" size="20" /></td>
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


