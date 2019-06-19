<tpl:Common_Html>
<tpl:Common_Head>
<script type="text/javascript">
// <![CDATA[
window.onload = function(){
//  parent.resizeIFrame("id_frmMain", document.body.scrollHeight);

}


var id = {@ $this->board->getMember()->getUserId()};
// ]]>


</script>
</tpl:Common_Head>
<tpl:Common_Body>

<h1>커넥팅</h1>
<div class="iwrap">
	<div class="tit_cntingList">
		<strong>{$this->board->getMember()->getUserId()}(김은영)님의 커넥팅</strong><br />
		<span class="url">http://connect.nate.com/</span>
		<input type="text" value="도메인 입력" onfocus="this.value=''" />
		<a href="#">EDIT</a>
	</div>

	<podo:execute href="/member/publicViewConnecting" />

	<h2 class="tit_myCnting">
		친구 공개 커넥팅
		<a href="#" class="manage">관리바로가기</a>
		<a href="#" class="buddyAdd">친구 공개 커넥팅 수신자 추가하기</a>
	</h2>
	<ul class="list_myCnting f_clear">
		<li><a href="#none">내가 보내는 일촌/친구 : <strong>1,230</strong>명</a></li>
		<li><a href="#none">내게 보내는 일촌/친구 : <strong>123</strong>명</a></li>
	</ul>

	<h2 class="tit_myCnting">
		네이트온 알림 설정
		<a href="#" class="manage">관리바로가기</a>
	</h2>
	<ul class="list_myCnting f_clear">
		<li>테이트온 토스트 알림 <strong>수신중</strong></li>
	</ul>

	<h2 class="tit_myCnting">
		외부 블로그 등록
		<a href="#" class="manage">관리바로가기</a>
	</h2>
	<ul class="list_myCnting f_clear">
		<li>
			<dl>
				<dt>이글루스</dt>
				<dd>등록완료</dd>
			</dl>
		</li>
		<li>
			<dl>
				<dt>스푼</dt>
				<dd><a href="#none" class="entry">등록하기</a></dd>
			</dl>
		</li>
		<li>
			<dl>
				<dt>트위터</dt>
				<dd><a href="#none" class="entry">등록하기</a></dd>
			</dl>
		</li>
	</ul>

</div>
</tpl:Common_Body>
</tpl:Common_Html>
