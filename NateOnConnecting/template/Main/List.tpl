<tpl:Common_Html>
<tpl:Common_Head>
<script type="text/javascript" src="/js/list.js"></script>
<script type="text/javascript" src="/js/prototype.js"></script>
<script type="text/javascript" src="/js/post.js"></script>
<script type="text/javascript">
	// <![CDATA[
	addOnloadHandle(function () {
		try {
			parent.selectPage('tab_list');
			// onScroll 은 setNextStartIdx() 다음에 호출되어야 정상적으로 동작한다.
			// 그래서 addOnloadHandle() 의 우선순위는 9로 설정되어있다.
			parent.onScroll();
		} catch (e) {}
		resizeSelf();
	}, 9);

	commonAttachEvent(document, 'click', function () {
		closeAllOfLayers();
	});

	var lastViewId = null; // 로그인영역 ON친구 레이어	
	function layerOpen(layer) {
		if (lastViewId != layer)
		{
			layerClose(lastViewId);
		}
		var obj = document.getElementById(layer);
		obj.style.display = (obj.style.display == "none") ? "block" : "none";
		lastViewId = layer;

	}

	function layerClose(id) {
		if (id) {
			var obj = document.getElementById(id);
			obj.style.display = "none";
		}
	}

	listQueryParams = {
		sort: {@ $this->request->sort},
		senderCmn: {@ $this->request->senderCmn}
	};
	// ]]>
</script>
</tpl:Common_Head>

<body>
<h1>커넥팅</h1>
<div class="iwrap">
	<p class="realtime" podo:if="strval($this->request->sort) == strval(ContainerAPI::LIST_SORT_TIMELINE)">커넥팅 회원들의 전체공개 글을 실시간으로 확인하세요.</p>
	<div class="title_cntingList" style="display:none" attr-if:style="strval($this->request->sort) == strval(ContainerAPI::LIST_SORT_TIMELINE)">
	<input type="hidden" id="sort" value="{$this->request->sort}"/>

		<a href="javascript:layerOpen('layer_select');" ondblclick="layerOpen('layer_select'); return false;" onfocus="blur();" class="sel_view">{$this->currMenuTitle}</a>
	
		<!-- 보기옵션 레이어 -->
		<div id="layer_select" class="layer_select" style="display:none;">
			<dl class="viewOpt">
				<dt onclick="layerOpen('layer_select'); return false;" ondblclick="layerOpen('layer_select'); return false;"><a href="#" onclick="return false;" onfocus="blur();">{$this->currMenuTitle}</a></dt>

				<dd onclick="olapStat('CIM10'); document.location.href = '?sort={ContainerAPI::LIST_SORT_ALL}'; return false;" podo:if="strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_ALL)"><a href="?sort={ContainerAPI::LIST_SORT_ALL}" onfocus="blur();">전체</a></dd>

				<dd onclick="olapStat('CIM15'); document.location.href = '?sort={ContainerAPI::LIST_SORT_TWITTER}'; return false;" podo:if="strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_TWITTER)"><a href="?sort={ContainerAPI::LIST_SORT_TWITTER}" onfocus="blur();">트위터</a></dd>

				<dd onclick="olapStat('CIM11'); document.location.href = '?sort={ContainerAPI::LIST_SORT_MINE}'; return false;" podo:if="strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_MINE)"><a href="?sort={ContainerAPI::LIST_SORT_MINE}" onfocus="blur();">나의 커넥팅</a></dd>

				<dd onclick="olapStat('CIM12'); document.location.href = '?sort={ContainerAPI::LIST_SORT_FRIEND}'; return false;" podo:if="strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_FRIEND)"><a href="?sort={ContainerAPI::LIST_SORT_FRIEND}" onfocus="blur();">일촌+친구의 커넥팅</a></dd>

				<dd onclick="olapStat('CIM13'); document.location.href = '?sort={ContainerAPI::LIST_SORT_COMMENT}'; return false;" podo:if="strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_COMMENT)"><a href="?sort={ContainerAPI::LIST_SORT_COMMENT}}" onfocus="blur();">전체 최근 댓글 순</a></dd>

				<dd onclick="olapStat('CIM14'); document.location.href = '?sort={ContainerAPI::LIST_SORT_MINE_COMMENT}'; return false;" podo:if="strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_MINE_COMMENT)"><a href="?sort={ContainerAPI::LIST_SORT_MINE_COMMENT}" onfocus="blur();">내 커넥팅의 최근 댓글 순</a></dd>
			</dl>
		</div>
	</div>

	<dummy podo:if="count($this->messages) > 0" >
		<ul id="box_messages" class="cntingList f_clear">
			<podo:execute href="/list/messagesAjax" senderCmn="{$this->request->senderCmn}" sort="{$this->request->sort}" />
		</ul>

		<div id="btn_more" class="cntMore" style="display:none;"><a href="javascript:getMessagesMore();"  onfocus="this.blur();">더보기</a></div>
	</dummy>

		<div id="box_none_msg" class="noneMsg" style="display:{count($this->messages) > 0 ? 'none' : ''};">
		<dummy podo:if="$this->request->sort == strval(ContainerAPI::LIST_SORT_MINE) || $this->request->sort == strval(ContainerAPI::LIST_SORT_MINE_COMMENT)">
			작성한 커넥팅이 없습니다.
		</dummy>
		<dummy podo:elseif="$this->request->sort == strval(ContainerAPI::LIST_SORT_COMMENT)">
			최근에 댓글이 등록된 커넥팅이 없습니다.
		</dummy>
		<dummy podo:elseif="$this->request->sort == strval(ContainerAPI::LIST_SORT_TWITTER)">
			연동된 트위터가 없습니다.
		</dummy>
		<dummy podo:else="else">
			도착한 커넥팅이 없습니다.
		</dummy>
	</div>
</div> 
</body>
</tpl:Common_Html>
