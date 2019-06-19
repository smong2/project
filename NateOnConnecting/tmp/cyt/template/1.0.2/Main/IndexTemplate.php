<?php /* /home/mong/project/NateOnConnecting/template/Main/Index.tpl */ class Main_IndexTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $myUser; public $request; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
<?php $this->_tpl_4 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
<script <?php echo '/js/prototype.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/prototype.js').'" ' : ''; ?> type="text/javascript"></script>
<script <?php echo '/js/index.js' !== null ? 'src="'.Util::appendFileModifyTime('/js/index.js').'" ' : ''; ?> type="text/javascript"></script>
<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript" language="javascript">
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

		if (sort == <?php echo str_replace('\r', '', json_encode(ContainerAPI::LIST_SORT_TIMELINE)); ?>) {
			document.getElementById('menu').className='tab02';
		}
		else {
			document.getElementById('menu').className='tab01';
		}

		id_frmMain.location.replace('/list?sort='+sort);
	}
</script>
<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

<body onresize="onResize();">
<h1>커넥팅 네이트온 탭</h1>
<div class="wrap">
	<!-- 커넥팅 -->
	<?php $this->_tpl_24 = Podo_Template::instance('Main_PeopleNotice'); foreach ($this as $__key=>$__val) { $this->_tpl_24->{$__key} = $__val; } $this->_tpl_24->printHead(-1, -1); ?><?php $this->_tpl_24->printTail(-1, -1); unset($this->_tpl_24); ?>

	<div id="cnt_connecting">
		<?php $this->_tpl_28 = Podo_Template::instance('Main_PostMessage'); foreach ($this as $__key=>$__val) { $this->_tpl_28->{$__key} = $__val; } $this->_tpl_28->printHead(-1, -1); ?><?php $this->_tpl_28->printTail(-1, -1); unset($this->_tpl_28); ?>
		<div class="tabConnect">
			<ul class="tab01" id="menu">
				<li id="tab_list" class="tab1"><a href="/list" target="id_frmMain" onfocus="this.blur();" onclick="olapStat('CIM07');document.getElementById('menu').className='tab01';">커넥팅</a></li><!-- 활성화 상태일때만 on 처리 -->
				<li id="tab_timeline" class="tab2"><a href="/list?sort=<?php echo $this->_escapeAttrib(ContainerAPI::LIST_SORT_TIMELINE); ?>" target="id_frmMain" onfocus="this.blur();" onclick="olapStat('CIM56');document.getElementById('menu').className='tab02';">실시간 커넥팅</a></li><!-- 활성화 상태일때만 on 처리 -->
				<li id="tab_mine" class="tab3"><a href="/mine" target="id_frmMain" onfocus="this.blur();" onclick="olapStat('CIM09');document.getElementById('menu').className='tab03';">나의 커넥팅 상태</a></li><!-- 활성화 상태일때만 on 처리 -->
			</ul>
			<span class="btnRefresh"><a href="javascript:refresh();" target="id_frmMain" onclick="olapStat('CIM08');refresh(); return false" onfocus="this.blur()" title="새로고침">새로고침</a></span>
		</div>
	</div>

	<div id="contents">
		<iframe id="id_frmMain" name="id_frmMain" src="/list" title="컨텐츠 영역" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
	</div>
<!-- /커넥팅 -->
</div>

<?php if ($this->myUser->isFirstVisit() && $this->request->getCookie('disable_startPage') != 1) { ?><?php $this->_tpl_68 = Podo_Template::instance('Main_Start'); foreach ($this as $__key=>$__val) { $this->_tpl_68->{$__key} = $__val; } $this->_tpl_68->printHead(-1, -1); ?><?php $this->_tpl_68->printTail(-1, -1); unset($this->_tpl_68); ?><?php } ?>

<?php $this->_tpl_70 = Podo_Template::instance('Main_BridgeForm'); foreach ($this as $__key=>$__val) { $this->_tpl_70->{$__key} = $__val; } $this->_tpl_70->printHead(-1, -1); ?><?php $this->_tpl_70->printTail(-1, -1); unset($this->_tpl_70); ?>
</body>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>