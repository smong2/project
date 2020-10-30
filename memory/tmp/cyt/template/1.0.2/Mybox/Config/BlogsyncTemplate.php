<?php /* /home/mong/project/memory/template/Mybox/Config/Blogsync.tpl */ class Mybox_Config_BlogsyncTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $page; public $maxPage; public $blogsync = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>
		<script>
			var httpReq=null;

				function getInstance() {
					var httpReq=null;
					try {
						httpReq = new ActiveXObject("Msxml2.XMLHTTP");
					} catch(Ex) {
						try{
							httpReq = new ActiveXObject("Microsoft.XMLHTTP");
						} catch(Ex2) {
							httpReq = null;
						}
					}
					return httpReq;
				}

				function sendData(blogId,processMode) // 데이터 가져오기
				{
					httpReq = getInstance();

					var surl = "Blogreg?blogId="+blogId+"&processMode="+processMode;
					httpReq.open("GET",surl, true);
					httpReq.onreadystatechange = handleStateChange;
					httpReq.send();
				}

				function handleStateChange() // 카테고리에 뿌려주기
				{
					if(httpReq.readyState==4) {
						document.getElementById("detail_blog").innerHTML = httpReq.responseText;
					}
				}

				function checkall(chkval)
				{
					var chk_box = document.getElementsByName("chk_blog_id[]");
					var chk_len = chk_box.length;

					for(i=0; i<chk_len; i++) {
						chk_box[i].checked = chkval.checked;
					}
				}

				function fnchk() {
					var chk_box = document.getElementsByName("chk_blog_id[]");
					var chk_len = chk_box.length;

					cnt=0;
					for(i=0; i<chk_len; i++) {
						if(chk_box[i].checked) cnt=1;
					}

					if(!cnt) {
						alert("삭제할 항목을 선택해주십시오");
						return 0;
					} else {

						if(!confirm('블로그를 리스트에서 삭제하면, 해당\n블로그로의 자동전송이 중단됩니다.\n정말 삭제하시겠습니까?'))
						{
							return false;
						} else {
							document.check_form.submit();
						}
					}
				}

				function fnRegBlog() {
					for(i=0;i<$('blogReg').elements.length;i++) { // blogReg 안에서의 text, password form에 대해서 모든 항목을 입력 받도록 유도
						if($('blogReg').elements[i].type=="text" || $('blogReg').elements[i].type=="password") {
							if($('blogReg').elements[i].value=="" || $('blogReg').elements[i].value==null) {
								alert('모든 항목을 입력해주십시오');
								$('blogReg').elements[i].focus();
								return false;
							}
						}
					}

					if(!confirm("저장하시겠습니까?")) {
						return false;
					}
				}
		</script>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td class="title">마이기억함 -> 기억 외부공유</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<a href="Blogsync">기억배달</a> | <a href="Widget">위젯가져가기</a>
				</td>
			</tr>
			<tr height="40">
				<td>
					<table class="paging-wrap" cellpadding="0" cellspacing="0" border="0">
						<tr><td>
							<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('curr'=>$this->page, 'max'=>$this->maxPage, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
						</td></tr>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					마이 기억함에 추가된 기억이 외부 블로그에 자동 전송됩니다.
				<table class="list" border="0" cellpadding="0" cellspacing="0" width="70%">
					<form name="check_form" action="BlogsyncDelete">
					<tr bgcolor="#dadada">
						<th width="30"><input type="checkbox" name="check_all" onclick="checkall(this)" /></th>
						<th>사이트명</th>
						<th>등록일</th>
						<th>공유한 기억 수</th>
						<th>수정</th>
					</tr>
					<?php $_fid_81_var = $this->blogsync; if ($_fid_81_var == false) $_fid_81_var = array(); $_fid_81_idx = 1; $_fid_81_cnt = count($_fid_81_var); foreach ($_fid_81_var as $blogSync) { ?><tr align="center" class="<?php echo $this->_escapeAttrib($this->_foreachIsLast($_fid_81_idx, $_fid_81_cnt) ? 'last' : ''); ?>">
						<td><input type="checkbox" name="chk_blog_id[]" value="<?php echo $this->_escapeAttrib($blogSync->getBlogSeq()); ?>" /></td>
						<td><?php echo $blogSync->getBlogNm(); ?></td>
						<td><?php echo date("Y년 m월 d일",$blogSync->getInsertDt()); ?></td>
						<td><?php echo $blogSync->getMpCnt(); ?>개</td>
						<td><input type="button" value="수정" onclick="$('reg').style.display='block';sendData(<?php echo $this->_escapeAttrib($blogSync->getBlogId()); ?>,<?php echo $this->_escapeAttrib($blogSync->getBlogSeq()); ?>);$('blog_gbn').value=<?php echo $this->_escapeAttrib($blogSync->getBlogId()); ?>;" /></td>
					</tr><?php $_fid_81_idx++; } ?>
					</form>
				</table>

				<table width="70%">
				<tr>
						<td style="border-style:none;" width="30"> </td>

						<td style="border-style:none;">
							<span id="reg" style="display:none">
								<br />
								<table>
									<form id="blogReg" name="blogReg" action="blogregProc">
									<tr align="left">
										<th colspan="3" align="left"><i>외부 블로그 새로 등록</i></th>
									</tr>
									<tr>
										<td rowspan="2" width="15"></td>
										<td>* 블로그 선택</td>
										<td>
											<select id="blog_gbn" name="blog_gbn" onchange="sendData(this.value,0)">
												<?php $_fid_136_var = Blogsync::$blogGbn; if ($_fid_136_var == false) $_fid_136_var = array(); $_fid_136_idx = 1; $_fid_136_cnt = count($_fid_136_var); foreach ($_fid_136_var as $intblog=>$blogNm) { ?><option value="<?php echo $this->_escapeAttrib($intblog); ?>"><?php echo $blogNm; ?></option><?php $_fid_136_idx++; } ?>
											</select>
										</td>
									</tr>
									<tr>
										<td colspan="2">
											<span id="detail_blog"></span>
										</td>
									</tr>
									</form>
								</table>
							</span>
						</td>
					</tr>
				</table>

				<table width="70%">
					<tr align="right"><td>
				<input type="button" value="외부 블로그 등록" onclick="$('reg').style.display='block';sendData(0,0);$('blog_gbn').value=0" />
						<input type="button" value="삭제" onclick="return fnchk()" />
					</td></tr>
				</table>
			</td></tr>
		</table>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>