<tpl:Common_Html>
<tpl:Common_Head>
<meta http-equiv="content-type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="http://cyupload6.cyworld.com/common/E2/css/popup-upload-movv.css" media="all" />
<title>이미지 업로드 테스트</title>
<script Language="JavaScript">

	/* edit mode constants */
	var EDIT_MODE_SINGLE = 1;
	var EDIT_MODE_MULTI  = 2;
	var EDIT_MODE_FLASH  = 3;

	var editor = null; // Editor instance
	var current_menu;

	function setSingleEditMode()
	{
		if (editor == null) return;
		editor.EditMode = EDIT_MODE_SINGLE;
		if (editor.EditMode == EDIT_MODE_SINGLE) {
			/* 성공 */
			chgMenu(EDIT_MODE_SINGLE);
		}
	}

	function setMultiEditMode()
	{
		if (editor == null) return;
		editor.EditMode = EDIT_MODE_MULTI;
		if (editor.EditMode == EDIT_MODE_MULTI) {
			/* 성공 */
			chgMenu(EDIT_MODE_MULTI);
		}
	}

	function setFlashEditMode()
	{
		if (editor == null) return;
		editor.EditMode = EDIT_MODE_FLASH;
		if (editor.EditMode == EDIT_MODE_FLASH) {
			/* 성공 */
			chgMenu(EDIT_MODE_FLASH);
		}
	}

	function addImage()
	{
		if (editor == null) return;

		if (editor.AddFile() == true) {
			/* 성공 */
		} else {
			/* 실패(or 취소) */
		}
	}

	function deleteImage()
	{
		if (editor == null) return;
		if (editor.DeleteFile() == true) {
			/* 성공 */
		} else {
			/* 실패 */
		}
	}

	function showPreview()
	{
		if (editor == null) return;
		if (editor.Preview() == true) {
			/* 성공 */
		} else {
			/* 실패 */
		}
	}

	function saveImage()
	{
		if (editor == null) return;
		if (editor.SaveFile() == true) {
			/* 성공 */
		} else {
			/* 실패(or 취소) */
		}
	}

	function resizeWindow(width, height)
	{
		/* 일단 지정한 크기로 리사이징 */
		window.resizeTo(width, height);

		/* div 객체 삽입 */
		var margin = document.createElement("div");
		margin.style.position = "absolute";
		margin.style.width = "0px";
		margin.style.height = "0px";
		margin.style.right = "0px";
		margin.style.bottom = "0px";
		document.body.appendChild(margin);

		/* 추가로 수정할 크기(델타값) 추정 */
		var dw = width - margin.offsetLeft;
		var dh = height - margin.offsetTop;

		/* 추가 리사이징 */
		window.resizeBy(dw, dh);

		/* 삽입한 객체 삭제 */
		document.body.removeChild(margin);
	}

	function objCyimage(imgserver, flag, SizeList, SingleSizeLimit, MultiSizeLimit, FlashSizeLimit, tid, updomain, edit_url, defalut_size)
	{
		var fileName;
		var osCheck;

	/*
		osCheck = getOSInfoStr();

		if (osCheck == "1")
			fileName = "CyPictureC1233.cab"
		else
			fileName = "CyPictureU1233.cab"
	*/
		FrameString = "http://c1img.cyworld.co.kr/img/sticker/concept_20080530.txt"

		document.writeln("<object id=\"CyImage\" classid=\"CLSID:8DC067B8-911D-473A-90F1-1171B887CDE0\" CODEBASE=\"http://cyimg8.cyworld.com/ImageUpload/CyPictureU1233.cab#version=1,0,2,33\" width=\"800\" height=\"535\" VIEWASTEXT=\"VIEWASTEXT\">");
		document.writeln("	<param name=\"URL\" value=\"" + edit_url +"\" />");
		document.writeln("	<param name=\"SigQuery\" value=\"http://www.cyworld.com/common/interface/getSignData_EditTool.asp?svc="+updomain+"&id="+tid+"\" />");
		document.writeln("	<param name=\"tid\" value=\"" + tid + "\" />");
		document.writeln("	<param name=\"SizeList\" value=\"" + SizeList + "\" />");
		document.writeln("	<param name=\"DefaultSize\" value=\"" + defalut_size + "\" />");
		document.writeln("	<param name=\"SingleSizeLimit\" value=\"" + SingleSizeLimit + "\" />");
		document.writeln("	<param name=\"MultiSizeLimit\" value=\"" + MultiSizeLimit + "\" />");
		document.writeln("	<param name=\"FlashSizeLimit\" value=\"" + FlashSizeLimit + "\" />");
		document.writeln("	<param name=\"Sticker2URL\" value=\"http://c1img.cyworld.co.kr/img/sticker/sticker2_20080423.txt\" />");
		document.writeln("	<param name=\"Sticker3URL\" value=\"http://c1img.cyworld.co.kr/img/sticker/sticker3_20080423.txt\" />");
		document.writeln("	<param name=\"Frame2URL\" value=\"" + FrameString + "\" />");
		document.writeln("	<param name=\"ShowNew\" value=\"true\" />");
		document.writeln("	<param name=\"NameType\" value=\"2\" />");
		document.writeln("</object>");
	}

	function resizeWin(width, height) {

		window.resizeTo(width, height);

		var margin = document.createElement("div");
		margin.style.position = "absolute";
		margin.style.width = "0px";
		margin.style.height = "0px";
		margin.style.right = "0px";
		margin.style.bottom = "0px";
		document.body.appendChild(margin);

		var dw = width - margin.offsetLeft;
		var dh = height - margin.offsetTop;

		window.resizeBy(dw, dh);

		document.body.removeChild(margin);
	}

	function chgMenu(idx) {
		for (i=1;i<4;i++ )
		{
			if (i==idx)
				document.getElementById('SubMenu_'+i).className = "on";
			else
				document.getElementById('SubMenu_'+i).className = "";
		}
	}

	function Sendit(p_frm) {
		if (editor == null) return;

		if(editor.EditMode==EDIT_MODE_SINGLE && editor.ImageCount>3) {
			alert('프로필 이미지는 한장만 업로드 가능합니다');
		}

		document.imgForm.NdrSubMenu.value = editor.EditMode;
		document.imgForm.PhotoCnt.value = editor.ImageCount;

		if(editor.UploadForm(p_frm)==true) {
		}	else {
		}
	}
</script>

<script LANGUAGE=JavaScript FOR=CyImage EVENT="OnImageCountChanged(count)">
	alert("count:" + count);
</script>

<script type="text/javascript" language="javascript" for="window" event="onload">
//<!--
	editor = document.CyImage;
	resizePopupWindow(800, 650);
//-->
</script>
</tpl:Common_Head>

<tpl:Common_Body>

	<form name="imgForm" action="http://memory.nate.com/mybox/config/basicImgUp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="flag" value="img2"/>
		<input type="hidden" name="frm_name" value="photo"/>
		<input type="hidden" name="up_domain" value="www.cyworld.com"/>
		<input type="hidden" name="tid" value="{$this->myUser->cyworld->getcyId()}"/>
		<input type="hidden" name="NdrSubMenu"/>
		<input type="hidden" name="PhotoCnt"/>
		<div class="upload-wrap upload-photo">
			<div id="Topbox">
				<ul class="tab">
					<li class="uploadoff" style="display='none'">
						<a href="#" onFocus="this.blur();" >바로 올리기</a>
					</li>
					<li class="photoediton">
						<a href="#" onFocus="this.blur();" ><strong>사진 편집하기</strong></a>
					</li>
				</ul>
			</div>
			<!-- 사진 편집하기 추가 삭제 버튼 -->

			<div class="subtop-wrap f_clear">
				<div class="btn">
					<a href="#" class="add" onFocus="this.blur();" onclick="addImage();">파일 추가</a>
					<a href="#" id="delbtn" class="del" onFocus="this.blur();" onclick="deleteImage();">파일 삭제</a>
				</div>
				<p class="file-capacity">
				<span id="uploadDescription">
				가로 <strong><span class="num">580</span>px</strong> 이하로 자동 조절, 프로필 사진은 <strong><span class="num">1</span>장</strong>만 업로드 가능
				</span>
				</p>
			</div>
			<!-- // 사진 편집하기 추가 삭제 버튼 -->
			<script type="text/javascript">
				objCyimage("cyimg7", "MinihompyPhoto", "580;400;350;300;250;200;140","500", "500", "500","{$this->myUser->cyworld->getcyId()}","www.cyworld.com","","400")
			</script>
			<!-- 등록 버튼 -->
			<div class="foot-wrap f_clear">
				<div class="btn-prev">
					<a href="#" onFocus="this.blur();" onclick="showPreview();">
						<img src="http://cyupload6.cyworld.com/common/e2/img/btn_preview.gif" width="67" height="26" alt="미리보기" />
					</a>
					<a href="#" onFocus="this.blur();"  onclick="saveImage();">
						<img src="http://cyupload6.cyworld.com/common/e2/img/btn_pcsave.gif" width="86" height="26" alt="PC 저장하기" />
					</a>
				</div>

				<div class="btn-post">
					<a href="#" onFocus="this.blur();"  onclick="javascript:Sendit(imgForm);">
						<img src="http://cyupload6.cyworld.com/common/e2/img/btn_post2.gif" width="73" height="26" alt="등록하기" />
					</a>
					<p class="note"><span id="catDescription">사진첩에서 이미지는 하나씩 등록됩니다.</span></p>
				</div>
			</div>
			<!-- // 등록 버튼 -->
		</div>
	</form>
</tpl:Common_Body>
</tpl:Common_Html>
