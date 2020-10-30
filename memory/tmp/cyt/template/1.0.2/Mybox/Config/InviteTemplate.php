<?php /* /home/mong/project/memory/template/Mybox/Config/Invite.tpl */ class Mybox_Config_InviteTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $remainInvite; public $myUser; public $cntInvite; public $Invite = array(); public $page; public $maxPage; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
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
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>
			<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
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
								<input type="hidden" name="remainInvite" value="<?php echo $this->_escapeAttrib($this->remainInvite); ?>" />
							<td valign="top" width="100">* 초대장 보내기</td>
							<td>기억나 서비스는 클로즈베타 기간 동안, 초대를 받은 사용자만 이용할 수 있습니다.<br />
								새로운 친구를 기억지기로 초대할 수 있습니다.
								<br /><br />
								현재 보유한 초대장 : <?php echo $this->remainInvite; ?>장
								<br /><br />
								1) 초대장을 받을 친구의 이메일 주소를 입력해 주세요.
								<br />
									<input type="text" size="20" id="recieve_email" name="recieve_email" onkeydown="return fnEnterCtl()" /> 네이트온 친구 목록에서 추가
								<br /><br />
								2) 초대 메시지를 입력해 주세요. (최대 400자)
								<br />
								<textarea cols="100" rows="4" id="invite_message" name="invite_message"><?php echo $this->myUser->getRealName(); ?>님이 귀하를 Nate 기억나?로 초대했습니다. 기억나?는 잊고 있었던 축과 기억을 함께 찾아가는 서비스로, 같은 추억을 가지고 있는 사람들과 만날 수 있으며 내 기억을 타임라인으로 제공하는 서비스입니다. 기억나 서비스는 초대를 통해서만 가입이 가능합니다. 잊고 있었던 기억을 오늘 함께 찾아 보시겠어요?</textarea>
								<br /><input type="checkbox" name="share_mp" id="share_mp" onkeydown="return fnEnterCtl()" /> 최근 내가 찾은 기억의 제목을 함께 공유합니다.
								<br /><br />
								3) 보내는 사람 이메일 주소를 입력해주세요.
								<br />
							<input type="text" size="20" id="invite_email" name="invite_email" value="<?php echo $this->_escapeAttrib($this->myUser->nate->getMail()); ?>" onkeydown="return fnEnterCtl()" />
								<br /><br />
								<input type="submit" value="초대" <?php echo ($this->remainInvite<=0) ? 'disabled="disabled"' : ''; ?> />
							</td>
							</form>
						</tr>

						<tr>
							<td height="30" colspan="2"></td>
						</tr>

						<tr>
							<td></td>
							<td>
								<table width="100%" class="list" cellpadding="0" cellspacing="0">
									<form name="inviteFrm" action="inviteDelProc" onsubmit="return fncancel()">

									<caption>
										<table width="100%">
											<tr>
												<td align="left">지금까지 초대한 친구들 <?php echo $this->cntInvite; ?>명</td>
												<td align="right"><input type="submit" value="초대취소" /></td>
											</tr>
										</table>
									</caption>
									<tr>
										<th><input type="checkbox" id="chkall" onclick="fncheckall(this)" /></th>
										<th>초대한 날짜</th>
										<th>받는 사람 이메일</th>
										<th>기억나이</th>
									</tr>
									<?php $_fid_142_var = $this->Invite; if ($_fid_142_var == false) $_fid_142_var = array(); $_fid_142_idx = 1; $_fid_142_cnt = count($_fid_142_var); foreach ($_fid_142_var as $invite) { ?><tr class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_142_idx, $_fid_142_cnt) ? 'last' : ''); ?>">
										<td align="center"><input type="checkbox" name="chk_invite_sq[]" value="<?php echo $this->_escapeAttrib($invite->getInviteSq()); ?>" <?php echo ($invite->getVisitFl()) ? 'disabled="disabled"' : ''; ?> /></td>
										<td class="date"><?php echo date("Y년 m월 d일",$invite->getInsertDt()); ?></td>
										<td><?php echo $invite->getRecieveEmail(); ?></td>
										<td><?php echo $invite->getVisitDesc(); ?>

											</td>
									</tr><?php $_fid_142_idx++; } ?>

									</form>
								</table>

								<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
									<tr><td>
										<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
									</td></tr>
									<tr><td height="5"></td></tr>
								</table>
							</td>
						</tr>
					</table>



				</td>
			</tr>
		</table>
			<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>