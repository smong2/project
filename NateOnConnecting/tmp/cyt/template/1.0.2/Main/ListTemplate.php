<?php /* /home/mong/project/NateOnConnecting/template/Main/List.tpl */ class Main_ListTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $request; public $currMenuTitle; public $messages; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
<?php $this->_tpl_4 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
<script <?php echo '/js/list.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/list.js').'" ' : ''; ?> type="text/javascript"></script>
<script <?php echo '/js/prototype.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/prototype.js').'" ' : ''; ?> type="text/javascript"></script>
<script <?php echo '/js/post.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/post.js').'" ' : ''; ?> type="text/javascript"></script>
<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
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
		sort: <?php echo str_replace('\r', '', json_encode($this->request->sort)); ?>,
		senderCmn: <?php echo str_replace('\r', '', json_encode($this->request->senderCmn)); ?>
	};
	// ]]>
</script>
<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

<body>
<h1>커넥팅</h1>
<div class="iwrap">
	<?php if (strval($this->request->sort) == strval(ContainerAPI::LIST_SORT_TIMELINE)) { ?><p class="realtime">커넥팅 회원들의 전체공개 글을 실시간으로 확인하세요.</p><?php } ?>
	<div class="title_cntingList" <?php if (strval($this->request->sort) == strval(ContainerAPI::LIST_SORT_TIMELINE)) { ?>style="display:none"<?php } ?>>
	<input type="hidden" id="sort" value="<?php echo $this->_escapeAttrib($this->request->sort); ?>" />

		<a href="javascript:layerOpen('layer_select');" ondblclick="layerOpen('layer_select'); return false;" onfocus="blur();" class="sel_view"><?php echo htmlspecialchars($this->currMenuTitle); ?></a>
	
		<!-- 보기옵션 레이어 -->
		<div id="layer_select" class="layer_select" style="display:none;">
			<dl class="viewOpt">
				<dt onclick="layerOpen('layer_select'); return false;" ondblclick="layerOpen('layer_select'); return false;"><a href="#" onclick="return false;" onfocus="blur();"><?php echo htmlspecialchars($this->currMenuTitle); ?></a></dt>

				<?php if (strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_ALL)) { ?><dd onclick="olapStat('CIM10'); document.location.href = '?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_ALL); ?>'; return false;"><a href="?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_ALL); ?>" onfocus="blur();">전체</a></dd><?php } ?>

				<?php if (strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_TWITTER)) { ?><dd onclick="olapStat('CIM15'); document.location.href = '?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_TWITTER); ?>'; return false;"><a href="?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_TWITTER); ?>" onfocus="blur();">트위터</a></dd><?php } ?>

				<?php if (strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_MINE)) { ?><dd onclick="olapStat('CIM11'); document.location.href = '?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_MINE); ?>'; return false;"><a href="?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_MINE); ?>" onfocus="blur();">나의 커넥팅</a></dd><?php } ?>

				<?php if (strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_FRIEND)) { ?><dd onclick="olapStat('CIM12'); document.location.href = '?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_FRIEND); ?>'; return false;"><a href="?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_FRIEND); ?>" onfocus="blur();">일촌+친구의 커넥팅</a></dd><?php } ?>

				<?php if (strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_COMMENT)) { ?><dd onclick="olapStat('CIM13'); document.location.href = '?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_COMMENT); ?>'; return false;"><a href="?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_COMMENT); ?>}" onfocus="blur();">전체 최근 댓글 순</a></dd><?php } ?>

				<?php if (strval($this->request->sort) != strval(ContainerAPI::LIST_SORT_MINE_COMMENT)) { ?><dd onclick="olapStat('CIM14'); document.location.href = '?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_MINE_COMMENT); ?>'; return false;"><a href="?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_MINE_COMMENT); ?>" onfocus="blur();">내 커넥팅의 최근 댓글 순</a></dd><?php } ?>
			</dl>
		</div>
	</div>

	<?php if (count($this->messages) > 0) { ?>
		<ul id="box_messages" class="cntingList f_clear">
			<?php $__strHref = '/list/messagesAjax'; $__arrAttr = array('senderCmn'=>$this->request->senderCmn, 'sort'=>$this->request->sort); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
		</ul>

		<div id="btn_more" class="cntMore" style="display:none;"><a href="javascript:getMessagesMore();" onfocus="this.blur();">더보기</a></div>
	<?php } ?>

		<div id="box_none_msg" class="noneMsg" style="display:<?php echo $this->_escapeAttrib(count($this->messages) > 0 ? 'none' : ''); ?>;">
		<?php if ($this->request->sort == strval(ContainerAPI::LIST_SORT_MINE) || $this->request->sort == strval(ContainerAPI::LIST_SORT_MINE_COMMENT)) { ?>
			작성한 커넥팅이 없습니다.
		<?php } 
		else if ($this->request->sort == strval(ContainerAPI::LIST_SORT_COMMENT)) { ?>
			최근에 댓글이 등록된 커넥팅이 없습니다.
		<?php } 
		else if ($this->request->sort == strval(ContainerAPI::LIST_SORT_TWITTER)) { ?>
			연동된 트위터가 없습니다.
		<?php } 
		else { ?>
			도착한 커넥팅이 없습니다.
		<?php } ?>
	</div>
</div> 
</body>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>