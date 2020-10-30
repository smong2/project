<?php /* /home/mong/project/memory/template/Mybox/Config/Basic.tpl */ class Mybox_Config_BasicTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $myUser; public $firstMemoryDistance; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
		<script type="text/javascript" language="javascript">
			var before = {
				'NickName' : <?php echo str_replace('\r', '', json_encode($this->myUser->memory->getNickname())); ?>
			}

			function fnNickCheck() // 닉네임 UI 제어
			{
				var nickfl = $("nick_fl").checked;

				if(nickfl===true) {
					$("nick_name").disabled=false;
					$("du_confirm").disabled=false;
				} else if (nickfl===false) {
					$("nick_name").disabled=true;
					$("du_confirm").disabled=true;
				}
			}

			function fnBlog() // 블로그 UI 제어
			{
				var blog_gbn = $("blog_gbn").value;

				switch(blog_gbn) {
					case "0" :	$("blog_text").value = "http://";
					break;
					case "1" : $("blog_text").value = "http://www.cyworld.com/미니홈피";
					break;
					case "2" : $("blog_text").value = "http://www.cyworld.com/블로그";
					break;
				}
			}

			// 닉네임 중복확인 체크
			function fnCheckNick() {
				// 아무것도 입력 안하면 이건 아니지~
				if ($("nick_fl").checked  && $("nick_name").value.length==0) {
					alert("닉네임을 입력해주십시오");
					return false;
				}

				// 중복확인 체크 조건 - 1.닉네임 사용 체크, 2.닉네임이 변경되어 있어야 함 3.중복확인 버튼을 클릭했는가?
				if($("nick_fl").checked && before.NickName != $("nick_name").value && $("checkval").value==0) {
					alert("닉네임을 중복확인이 필요합니다");
					return false;
				}

				// 직접 입력인데 입력란이 공란인 경우 false
				if($("blog_gbn").value=="0" && $("blog_text").value.length==0) {
						alert("운영중인 사이트나 블로그를 입력해주십시오");
						$("blog_text").focus();
						return false;
				}

				/*
				if(!confirm("기본 설정을 수정하시겠습니까?")) {
					return false;
				}
				*/
				return true;
			}

			//신규 에디터 E2추가
			function AttachFile_HTML_E2(frm_name,align, up_domain, flag, file_name, serv, tid){
				//window.open('CyImage?html_flag=Y&img_align=top&flag='+flag+'&align='+align+'&up_domain='+up_domain+'&frm_name=' + frm_name+'&file_name='+file_name+'&serv='+serv+'&tid='+tid,'upload','height=650,width=800,scrollbars=yes,resizable=yes');

				var strAgent = navigator.userAgent.toLowerCase();
				var bFirefox = (strAgent.indexOf("firefox")!= -1);

				if (bFirefox == true) {
					window.open('CyImage?tid='+tid+'&flag='+flag+'&align='+align+'&up_domain='+up_domain+'&frm_name=' + frm_name+'&email=mongt@hanmail.net&FF=' + bFirefox,'upload2','scrollbars=yes,resizable=yes');
				} else {
					window.open('CyImage?tid='+tid+'&flag='+flag+'&align='+align+'&up_domain='+up_domain+'&frm_name=' + frm_name+'&email=mongt@hanmail.net&FF=' + bFirefox,'upload2','width=797,height=650,scrollbars=yes,resizable=yes');
			   }

			}

			function checkdup(nick_name) {
				if(!nick_name) {
					alert('닉네임을 입력해주십시오');
					$('nick_name').focus();
					return false;
				}


				var ajax = new Ajax.Request(
					'duplicate?nick_name='+nick_name,
					{
						method: 'post',
						onSuccess: DuplicateCallback
					}
				);
			}

			function DuplicateCallback(transport, json)
			{
				if(json && json[1]) {
					$("checkval").value=1;
					$("dup_result").innerHTML = "O - 사용가능한 닉네임입니다";
					//alert('사용가능한 닉네임입니다');
				} else {
					$("checkval").value=0;
					//alert('이미 사용중인 닉네임입니다');
					$("dup_result").innerHTML = "<font color=red>X - 이미 사용중인  닉네임입니다</font>";
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
						<td class="title">마이기억함 -> 기본설정</td>
					</tr>
				</table>
			</td></tr>
			<tr><td>
				<form action="basicProc" onsubmit="return fnCheckNick()">
				<table border="0" width="50%" height="270">
				<tr>
					<th width="30%" align="left">* 프로필 사진</th>
					<td>
						<table>
							<tr>
								<td><img id="img_preview" align="top" src="<?php echo $this->_escapeAttrib($this->myUser->memory->getProfileImageUrl()); ?>" width="80" height="80" /></td>
								<td>
									<input type="button" name="profile_img" value="사진 업로드" onclick="AttachFile_HTML_E2('cgifrm', '1', 'minihp.cyworld.com', 'minihpdiary', '', 'Editor','21263090')" />

								<input type="hidden" id="pre_profile_img" name="pre_profile_img" value="<?php echo $this->_escapeAttrib($this->myUser->memory->getProfileImage()); ?>" />
									<br />
									(1MByte 이내의 확장자가 jpb, gif, png 파일만 업로드가 가능합니다.)<br />
									80 X 80 pixel 크기가 제일 예쁘게 보입니다.
									</td>

							</tr>
						</table>
						</td>
				</tr>
				<tr>
					<th align="left">* 처음 기억한날</th>
					<td>
						<?php echo date('Y년 m월 d일', $this->myUser->memory->getInsertDt()); ?> (오늘은 <?php echo $this->firstMemoryDistance; ?> 일째)
					</td>
				</tr>
				<tr>
					<th align="left">* 닉네임</th>
					<td><input type="checkbox" id="nick_fl" name="nick_fl" <?php echo ($this->myUser->memory->getNickEnableFl()) ? 'checked="checked"' : ''; ?> value="1" onclick="fnNickCheck()" ;=";" />
							<input type="text" id="nick_name" name="nick_name" size="10" value="<?php echo $this->_escapeAttrib($this->myUser->memory->getNickname()); ?>" onkeydown="return fnEnterCtl()" onchange="$('checkval').value=0" <?php echo (!$this->myUser->memory->getNickEnableFl()) ? 'disabled="disabled"' : ''; ?> />

							<input type="hidden" id="nick_name_pre" name="nick_name_pre" value="<?php echo $this->_escapeAttrib($this->myUser->memory->getNickname()); ?>" />

							<input type="button" id="du_confirm" value="중복확인" <?php echo (!$this->myUser->memory->getNickEnableFl()) ? 'disabled="disabled"' : ''; ?> onclick="checkdup($('nick_name').value)" />
								<span id="dup_result"></span>

							<input type="hidden" id="checkval" name="checkval" value="0" />
					</td>
				</tr>
				<tr>
					<th align="left">* 운영중인 사이트나 블로그</th>
					<td>
						<table>
							<tr>
								<td valign="top">
									<select id="blog_gbn" name="blog_gbn" onchange="fnBlog()">
										<option value="0">직접입력</option>
										<option value="1">미니홈피</option>
										<option value="2">싸이블로그</option>
									</select>
								</td>
								<td><input type="text" id="blog_text" name="blog_text" size="30" value="<?php echo $this->_escapeAttrib($this->myUser->memory->getHomepage()); ?>" onkeydown="return fnEnterCtl()" /><br />
									<input type="checkbox" id="homepage_link_fl" name="homepage_link_fl" value="1" <?php echo ($this->myUser->memory->getHomepageLinkFl()) ? 'checked="checked"' : ''; ?> />
									글을 쓸 때 내 공간으로 링크 끊기
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th align="left">* 페이지당 글 수</th>
					<td>한 페이지 당
							<select name="per_page">
								<?php $_fid_138_var = array(5, 10, 15, 20, 30); if ($_fid_138_var == false) $_fid_138_var = array(); $_fid_138_idx = 1; $_fid_138_cnt = count($_fid_138_var); foreach ($_fid_138_var as $intPage=>$pageValue) { ?><option value="<?php echo $this->_escapeAttrib($pageValue); ?>" <?php echo ($this->myUser->memory->getViewPerPage()==$pageValue) ? 'selected="selected"' : ''; ?>
><?php echo $pageValue; ?>개</option><?php $_fid_138_idx++; } ?>
							</select>
					</td>
				</tr>

				<tr align="right">
					<td colspan="2">
						<input id="subbtn" type="submit" value="확인" />
					<input type="button" value="취소" onclick="history.back()" ;=";" />
					</td>
				</tr>
				</table>
				</form>
			</td></tr>
			</table>
		<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>