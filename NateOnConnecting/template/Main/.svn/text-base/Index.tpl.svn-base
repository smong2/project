<tpl:Common_Html>
<tpl:Common_Head>
<script type="text/javascript" src="/js/prototype.js"></script>
<script type="text/javascript" src="/js/index.js"></script>
<script type="text/javascript" language="javascript">
	addOnloadHandle(function() {//{{{
		ndrStat('connecting_tab');
		commonAttachEvent(window, 'scroll', onScroll);
		// 스마트폰에서 동작하도록... 더 좋은 방법 없을려나?
		if (Prototype.Browser.WebKit) {
			window.scrollTo(0, 1);
			//setInterval(onScroll, 100);
			var iframeWindow = document.getElementById('id_frmMain').contentWindow;
			iframeWindow.document.getElementById('btn_more').style.display = 'block';
		}
	});//}}}

	function onScroll() /*{{{*/
	{
		if (typeof(document.getElementById('id_frmMain').contentWindow.getMessagesMore) != 'function') {
			return;
		}

		var scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight;
		var scrollTop = document.documentElement.scrollTop || document.body.scrollTop;
		var clientHeight = document.documentElement.clientHeight;
		//alert('1: '+scrollHeight+', 2:'+scrollTop+', 3:'+clientHeight);

		if (scrollTop + clientHeight + 15 >= scrollHeight) {
			var iframeWindow = document.getElementById('id_frmMain').contentWindow;
			try {
				iframeWindow.getMessagesMore();
			} catch (e) {
				if (iframeWindow.nextStartIdx == '' && Prototype.Browser.WebKit == false) {
					iframeWindow.document.getElementById('btn_more').style.display = 'none';
				}
				else {
					iframeWindow.document.getElementById('btn_more').style.display = 'block';
				}
				iframeWindow.resizeSelf();
			}
		}
	}/*}}}*/

	function refresh()
	{
		if (document.getElementById('menu').className != 'tab03') {
			var sort = id_frmMain.document.getElementById('sort').value;
		}
		else {
			var sort = 1;
		}

		if (sort == {@ ContainerAPI::LIST_SORT_TIMELINE}) {
			document.getElementById('menu').className='tab02';
		}
		else {
			document.getElementById('menu').className='tab01';
		}

		id_frmMain.location.replace('/list?sort='+sort);
	}
</script>
</tpl:Common_Head>

<body onresize="onResize();">
<h1>커넥팅 네이트온 탭</h1>
<div class="wrap">
	<!-- 커넥팅 -->
	<tpl:Main_PeopleNotice />

	<div id="cnt_connecting">
		<tpl:Main_PostMessage />
		<div class="tabConnect">
			<ul class="tab01" id='menu'>
				<li id="tab_list" class="tab1"><a href="/list" target="id_frmMain" onfocus="this.blur();" onclick="olapStat('CIM07');document.getElementById('menu').className='tab01';">커넥팅</a></li><!-- 활성화 상태일때만 on 처리 -->
				<li id="tab_timeline" class="tab2"><a href="/list?sort={ContainerAPI::LIST_SORT_TIMELINE}" target="id_frmMain" onfocus="this.blur();" onclick="olapStat('CIM56');document.getElementById('menu').className='tab02';">실시간 커넥팅</a></li><!-- 활성화 상태일때만 on 처리 -->
				<li id="tab_mine" class="tab3"><a href="/mine" target="id_frmMain" onfocus="this.blur();" onclick="olapStat('CIM09');document.getElementById('menu').className='tab03';">나의 커넥팅 상태</a></li><!-- 활성화 상태일때만 on 처리 -->
			</ul>
			<span class="btnRefresh" ><a href="javascript:refresh();" target="id_frmMain" onclick="olapStat('CIM08');refresh(); return false" onfocus="this.blur()" title="새로고침">새로고침</a></span>
		</div>
	</div>

	<div id="contents">
		<iframe id="id_frmMain" name="id_frmMain" src="/list" title="컨텐츠 영역" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
	</div>
<!-- /커넥팅 -->
</div>

<tpl:Main_Start podo:if="$this->myUser->isFirstVisit() && $this->request->getCookie('disable_startPage') != 1"/>

<tpl:Main_BridgeForm />
</body>
</tpl:Common_Html>
