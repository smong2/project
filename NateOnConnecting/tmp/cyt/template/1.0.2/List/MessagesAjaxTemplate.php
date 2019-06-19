<?php /* /home/mong/project/NateOnConnecting/template/List/MessagesAjax.tpl */ class List_MessagesAjaxTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $nextStartIdx; public $sort; public $messages = array(); public function printHead($p_intLine, $p_intCol) { ?><script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
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
		CONNECTINGImg.setImgViewer("", <?php echo str_replace('\r', '', json_encode($this->nextStartIdx)); ?>, "dd", "message_cls", "upload", imgSize, clickedImgSize, "<br/>", "<br/>");
		NOEmoticons.setEmoticons("", "dd","message_cls");

		setNextStartIdx(<?php echo str_replace('\r', '', json_encode($this->nextStartIdx)); ?>)
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
<span id="<?php echo $this->_escapeAttrib($this->nextStartIdx); ?>">
	<?php if ($this->sort == ContainerAPI::LIST_SORT_TWITTER) { ?>
		<?php $_fid_108_var = $this->messages; if ($_fid_108_var == false) $_fid_108_var = array(); $_fid_108_idx = 1; $_fid_108_cnt = count($_fid_108_var); foreach ($_fid_108_var as $message) { ?>
			<?php $this->_tpl_110 = Podo_Template::instance('List_Twitter'); foreach ($this as $__key=>$__val) { $this->_tpl_110->{$__key} = $__val; } $this->_tpl_110->message = $message; $this->_tpl_110->printHead(-1, -1); ?><?php $this->_tpl_110->printTail(-1, -1); unset($this->_tpl_110); ?>
		<?php $_fid_108_idx++; } ?>
	<?php } 
	else { ?>
		<?php $_fid_116_var = $this->messages; if ($_fid_116_var == false) $_fid_116_var = array(); $_fid_116_idx = 1; $_fid_116_cnt = count($_fid_116_var); foreach ($_fid_116_var as $message) { ?>
			<?php $this->_tpl_118 = Podo_Template::instance('List_Message'); foreach ($this as $__key=>$__val) { $this->_tpl_118->{$__key} = $__val; } $this->_tpl_118->message = $message; $this->_tpl_118->printHead(-1, -1); ?><?php $this->_tpl_118->printTail(-1, -1); unset($this->_tpl_118); ?>
		<?php $_fid_116_idx++; } ?>
	<?php } ?>
</span><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>