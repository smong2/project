<tpl:Common_Html>
<tpl:Common_Head>
<script type="text/javascript">
// <![CDATA[
function resizeIFrame(psID, piHeight){
	var iHeight = document.getElementById(psID).getAttribute("height");
	 if(piHeight != iHeight) document.getElementById(psID).setAttribute("height", piHeight);
}
// ]]>
</script>
</tpl:Common_Head>

<body>
<h1>커넥팅 네이트온 탭</h1>
<div class="wrap">
	<!-- 커넥팅 -->
	<div id="cnt_connecting">
		<dl class="cntInput" onmouseover="document.getElementById('aa').style.display='block'" onmouseout="document.getElementById('aa').style.display='none'">
			<dt>
				<a href="javascript:;" onmouseover="document.getElementById('pfManage').style.display='block'" onmouseout="document.getElementById('pfManage').style.display='none'">
				<img src="/ui/img/thumb_56x56.gif" width="56" height="56" alt="" />
				<img src="/ui/img/btn_manage.gif" id="pfManage" class="pf_mng" alt="관리" />
				</a>
			</dt>
			<dd class="write"><textarea cols="50" rows="3" readonly="readonly">네이트 계정과 연동해야 사용할 수 있습니다.</textarea></dd>
			<dd id="aa" class="writeSend" style="display:none;">
			  <div class="writeSendbox">
				<span class="count">(50/150)</span>
				<div class="sendtype">
					<input type="radio" id="open_all"  onfocus="blur()"/><label for="open_all" class="openall">전체공개</label>
					<input type="radio" id="open_buddy"  onfocus="blur()"/><label for="open_buddy" class="openbuddy">친구공개</label>
					<input type="checkbox" id="open_twitter" onfocus="blur()" disabled="disabled" /><label for="open_twitter" class="opentwitter">트위터 보내기</label>
				</div>
				<button type="button" class="btn" onclick="alert('네이트 계정과 연동해야 사용할 수 있습니다.');" onfocus="blur()">보내기</button>
				</div>
			</dd>
		</dl>

		<div class="tabConnect">
			<ul>
				<li class="tab01 on"><a href="#" onfocus="blur()">커넥팅</a></li>
				<li class="tab02"><a href="#" onfocus="blur()">나의 커넥팅 상태</a></li>
			</ul>
			<span class="btnRefresh" style="cursor:pointer">&nbsp;</span>
		</div>
	</div>

	<div class="layer_desc" style="top:120px;left:0;">
		<div class="layer_enjoy">
			<h3 class="tit02">일촌, 친구들과  함께하는 150자의 즐거움! </h3>
			<p class="info">
				커넥팅 서비스를 이용하기 위해서는 네이트 계정과 연동이 필요합니다.
				<a href="javascript:openWindow('http://happy.nate.com/contents/2010_connect04.asp');" onclick="javascript:openWindow('http://happy.nate.com/contents/2010_connect04.asp');olapStat('CIM55'); return false;" class="intro">커넥팅이란?</a>
			</p>
			<p><a href="https://cymember.cyworld.com/member/sso/registNateSSO.jsp?r_url=http%3A%2F%2Fnateon.connect.nate.com&isPopUp=Y" onclick="olapStat('CIM54'); openPopupWindow('https://cymember.cyworld.com/member/sso/registNateSSO.jsp?r_url={urlencode('http://nateon.connect.nate.com/')}&isPopUp=Y', 510,630); return false;" target="_blank" class="connect">네이트 계정 연동하기</a></p>
		</div>
	</div>
	<!-- /커넥팅 -->
</div>
<tpl:Main_BridgeForm />
</body>
</tpl:Common_Html>
