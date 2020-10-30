<tpl:Common_Html>
	<tpl:Admin_Head>
		<script>
			function fncheck()
			{
				if(!$("recieve_email").value) {
					alert('초대장을 받을 친구의 이메일 주소를 입력해 주세요');
					$("recieve_email").focus();
					return false;
				}

				if(!$("invite_email").value) {
					alert('보내는 사람 이메일 주소를 입력해주세요');
					$("invite_email").focus();
					return false;
				}

				if(!$("invite_message").value) {
					alert('초대 메시지를 입력해 주세요.');
					$("invite_message").focus();
					return false;
				}
			}

			function fncancel()
			{
				var chk_box = document.getElementsByName("chk_invite_sq[]");
				var chk_len = chk_box.length;

				cnt=0;
				for(i=0; i<chk_len; i++) {
					if(chk_box[i].checked) {
						cnt=1;
					}
				}
				if(cnt===0) {
					alert('초대를 취소할 항목에 체크표시를 클릭해주세요');
					return false;
				}

				if(!confirm("초대를 취소하시겠습니까?")) {
					return false;
				}

			}

			function fncheckall(chkval) {
				var chk_box = document.getElementsByName("chk_invite_sq[]");
				var chk_len = chk_box.length;


				for(i=0;i<chk_len;i++) {
					if(!chk_box[i].disabled) {
						chk_box[i].checked=chkval.checked;
					}
				}
			}
			function fnEnterCtl()
			{
				var keycode = window.event.keyCode;
				if(keycode==13) {
					return false;
				}
			}
		</script>
	</tpl:Admin_Head>
			<tpl:Common_Body>
				<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td class="title">마이기억함 -> 초대</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<a href="Invite">초대관리</a>
				</td>
			</tr>
			<tr height="30">
				<td></td>
			</tr>
			<tr>
				<td>
					<table>
						<tr>
							<form name="frm" method="post" action="Inviteproc" onsubmit="return fncheck()">
								<input type="hidden" name="remainInvite" value="{$this->remainInvite}"/>
							<td valign="top" width="100">* 초대장 보내기</td>
							<td>기억나 서비스는 클로즈베타 기간 동안, 초대를 받은 사용자만 이용할 수 있습니다.<br>
								새로운 친구를 기억지기로 초대할 수 있습니다.
								<br/><br/>
								현재 보유한 초대장 : {$this->remainInvite}장
								<br/><br/>
								1) 초대장을 받을 친구의 이메일 주소를 입력해 주세요.
								<br/>
									<input type="text" size="20" id="recieve_email" name="recieve_email" onkeydown="return fnEnterCtl()"/> 네이트온 친구 목록에서 추가
								<br/><br/>
								2) 초대 메시지를 입력해 주세요. (최대 400자)
								<br/>
								<textarea cols="100" rows="4" id="invite_message" name="invite_message">{$this->myUser->getRealName()}님이 귀하를 Nate 기억나?로 초대했습니다. 기억나?는 잊고 있었던 축과 기억을 함께 찾아가는 서비스로, 같은 추억을 가지고 있는 사람들과 만날 수 있으며 내 기억을 타임라인으로 제공하는 서비스입니다. 기억나 서비스는 초대를 통해서만 가입이 가능합니다. 잊고 있었던 기억을 오늘 함께 찾아 보시겠어요?</textarea>
								<br/><input type="checkbox" name="share_mp" id="share_mp" onkeydown="return fnEnterCtl()"> 최근 내가 찾은 기억의 제목을 함께 공유합니다.
								<br/><br/>
								3) 보내는 사람 이메일 주소를 입력해주세요.
								<br/>
							<input type="text" size="20" id="invite_email" name="invite_email" value="{$this->myUser->nate->getMail()}" onkeydown="return fnEnterCtl()"/>
								<br/><br/>
								<input type="submit" value="초대" disabled?="$this->remainInvite<=0">
							</td>
							</form>
						</tr>

						<tr>
							<td height="30" colspan="2"></td>
						</tr>

						<tr>
							<td></td>
							<td>
								<table width=100% class="list" cellpadding="0" cellspacing="0">
									<form name="inviteFrm" action="inviteDelProc" onsubmit="return fncancel()">

									<caption>
										<table width=100%>
											<tr>
												<td align="left">지금까지 초대한 친구들 {$this->cntInvite}명</td>
												<td align= "right"><input type="submit" value="초대취소"/></td>
											</tr>
										</table>
									</caption>
									<tr>
										<th><input type="checkbox" id="chkall" onclick="fncheckall(this)"></th>
										<th>초대한 날짜</th>
										<th>받는 사람 이메일</th>
										<th>기억나이</th>
									</tr>
									<tr podo:foreach="$this->Invite as $invite" class="{%ISLAST% ? 'last' : ''}" >
										<td align="center"><input type="checkbox" name="chk_invite_sq[]" value="{$invite->getInviteSq()}" disabled?="$invite->getVisitFl()" /></td>
										<td class="date">{date("Y년 m월 d일",$invite->getInsertDt())}</td>
										<td>{$invite->getRecieveEmail()}</td>
										<td>{$invite->getVisitDesc()}

											</td>
									</tr>

									</form>
								</table>

								<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
									<tr><td>
										<podo:execute href="/common/pageNavigator" curr="{$this->page}" max="{$this->maxPage}" block="10" callback="goPage" />
									</td></tr>
									<tr><td height="5"></td></tr>
								</table>
							</td>
						</tr>
					</table>



				</td>
			</tr>
		</table>
			</tpl:Common_Body>
</tpl:Common_Html>