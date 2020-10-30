<tpl:Common_Html>
	<tpl:Admin_Head>
		<script type="text/javascript" language="javascript">
		//<!--
			resizePopupWindow(378, 241+15);
		//-->
		</script>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="popup contents" cellpadding="0" cellspacing="0" border="0">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">MP 관리 > 상태 변경</td>
					</tr>
				</table>
			</td></tr>

			<tr height="15"><td></td></tr>

			<tr><td class="desc">
				<form action="updateStatusProc">
				<input type="hidden" name="mp_sq" value="{$this->mp->getMpSq()}" />

				<table cellspacing="0" cellpadding="0" border="0" width="100%">
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr>
								<th>MP 제목</th>
								<td>{$this->mp->getMpNm()}</td>
							</tr>
							<tr>
								<th class="form">상태</th>
								<td>
									<select name="status_gb">
										<dummy podo:foreach="MpPolice::$status as $statusGb=>$statusStr">
										<option value="{$statusGb}" podo:if="$statusGb !== MpPolice::STATUS_GB_REMOVED" selected?="$this->mp->getPolice()->getStatusGb() == $statusGb">{$statusStr}</option>
										</dummy>
									</select>
								</td>
							</tr>
							<tr>
								<th class="form">유형</th>
								<td>
									<select name="reason_gb">
										<option value="" selected?="$this->mp->getPolice()->getReasonGb() == 0">-- 유형 --</option>
										<option podo:foreach="MpPolice::$reasons as $reasonGb=>$reasonStr" value="{$reasonGb}" selected?="$this->mp->getPolice()->getReasonGb() == $reasonGb">{$reasonStr}</option>
									</select>
								</td>
							</tr>
							<tr class="last">
								<th class="form">사유</th>
								<td>
									<textarea name="content" cols="30" rows="3">{#$this->mp->getPolice()->getContent()}</textarea>
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
