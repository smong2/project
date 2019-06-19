<script type="text/javascript">
	try {
		// podo:execute 로 처음 부르는 경우를 위해
		// addOnloadHandle 도 하고 그냥 호출도 한다.
		CONNECTINGImg.PLAINTEXT = "Y";
		CONNECTINGImg.setStatCode("olapStat(&#39;CIM21&#39;);","olapStat(&#39;CIM22&#39;);");
		CONNECTINGImg.LINKCLASS = "link";
		addOnloadHandle(function () {
			listView();
		});

		listView();
	} catch (e) { }

	imgSize = 56;            // 클릭 전 이미지 크기
	clickedImgSize = 205;    // 클릭 후 이미지 크기

	// 리스트 초기화
	// 1. 이모티콘 가져오기, 2. 단축 URL 생성 3. 이미지뷰
	function listView() 
	{
		CONNECTINGImg.setImgViewer("", {@ $this->nextStartIdx}, "dd", "message_cls", "upload", imgSize, clickedImgSize, "<br/>", "<br/>");
		NOEmoticons.setEmoticons("", "dd","message_cls");

		setNextStartIdx({@ $this->nextStartIdx})
		setTimeout(function () { resizeSelf(); }, 700);
	}

	// 이미지뷰 사이즈 조절
	function ExpIt(ob)
	{
		if(ob.getAttribute("width") == clickedImgSize) {
			ob.setAttribute("width", imgSize);
		}
		else {
			ob.setAttribute("width", clickedImgSize);
		}
	}

	function txtClear(reconnect_txt)
	{
		if (reconnect_txt.value == "담는 말을 입력해주세요 (150자까지 입력 가능합니다)") {
			reconnect_txt.value = '';
		}
	}
</script>
<span id="{$this->nextStartIdx}">
	<dummy podo:if="$this->sort == ContainerAPI::LIST_SORT_TWITTER">
		<dummy podo:foreach="$this->messages as $message">
			<tpl:List_Twitter message="{$message}" />
		</dummy>
	</dummy>
	<dummy podo:else>
		<dummy podo:foreach="$this->messages as $message">
			<tpl:List_Message message="{$message}" />
		</dummy>
	</dummy>
</span>
