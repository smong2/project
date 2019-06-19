<tpl:Common_Html>
<tpl:Common_Head>
<script type="text/javascript">
// <![CDATA[
window.onload = function(){
	try {
		parent.resizeIFrame("id_frmMain", document.body.scrollHeight+30);
		parent.selectPage('tab_mine');
	} catch (e) { }
}
// ]]>
</script>
</tpl:Common_Head>

<body>
<h1>커넥팅</h1>
<div class="iwrap">
<div class="tit_cntingList">
	<dummy podo:if="$this->myUser->getNickname()">
		<strong>{$this->myUser->getNickname()}({$this->myUser->getRealname()})님의 커넥팅</strong>
	</dummy>
	<dummy podo:else>
		<strong>{$this->myUser->getRealname()}님의 커넥팅</strong>
	</dummy>
		<span class="url">http://connect.nate.com/{$this->myUser->getDomain()?$this->myUser->getDomain():'도메인입력'}</span>
		<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=18')" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=18');olapStat('CIM38'); return false;">EDIT</a>
</div>

<h2 class="tit_myCnting">
	전체 공개 커넥팅
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=83')" class="manage" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=83');olapStat('CIM40'); return false">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=83')" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=83');olapStat('CIM41'); return false;">Following  : <strong>{number_format($this->myUser->getFollowingCnt())}</strong>명</a></li>
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=84')" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=84');olapStat('CIM42'); return false;">Follower   : <strong>{number_format($this->myUser->getFollowerCnt())}</strong>명</a></li>
</ul>
	 
<h2 class="tit_myCnting">
	친구 공개 커넥팅
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=81')" target="_blank" class="manage" onclick="openWindow('http://connect.nate.com/index.nate?menu=81');olapStat('CIM43'); return false;" onfocus="blur()">관리바로가기</a>
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=88')" target="_blank" class="buddyAdd" onclick="openWindow('http://connect.nate.com/index.nate?menu=88');olapStat('CIM46'); return false;" onfocus="blur()">친구 공개 커넥팅 수신자 추가하기</a>
</h2>
<ul class="list_myCnting f_clear">
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=81')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=81');olapStat('CIM44'); return false;" onfocus="blur()">내가 보내는 일촌/친구  : <strong>{number_format($this->myUser->getFriendCnt())}</strong>명</a></li>
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=82')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=82');olapStat('CIM45'); return false;" onfocus="blur()">내게 보내는 일촌/친구   : <strong>{number_format($this->myUser->getReverseFriendCnt())}</strong>명</a></li>
</ul>
				 
<h2 class="tit_myCnting">
	네이트온 알림 설정
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=85')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=85');olapStat('CIM47'); return false;" class="manage" onfocus="blur()">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<li>네이트온 토스트 알림 <a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=85')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=85');olapStat('CIM47'); return false;" onfocus="blur();"><strong>{$this->myUser->getToastYN() == 'y'?'수신중':'수신 거부 중'}</strong></a></li>
</ul>
																					 
<h2 class="tit_myCnting">
	외부 블로그 등록
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=86')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=86');olapStat('CIM48'); return false;" class="manage" onfocus="blur()">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<dummy podo:foreach="$this->enableExtBlogs as $blog">
		<li>
			<dl>
				<dt>{$blog->getBlogNm()}</dt>
				<dd>					
					<dummy podo:if="$this->myBlogs && in_array($blog->getBlogId(), $this->myBlogs)">
						등록완료
					</dummy>
					<dummy podo:else>
						<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=86')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=86');olapStat('CIM49'); return false;" class="entry" onfocus="blur()">등록하기</a>
					</dummy>
				</dd>
			</dl>
		</li>
	</dummy>
</ul>
</div>
<tpl:Main_BridgeForm />
</body>
</tpl:Common_Html>
