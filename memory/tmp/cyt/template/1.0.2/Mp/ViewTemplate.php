<?php /* /home/mong/project/memory/template/Mp/View.tpl */ class Mp_ViewTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $isLogged; public $mp; public $myUser; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
		<script type="text/javascript" language="javascript">
		//<!--
			function toggleMtChildren(mt_sq) 
			{
				if ($('mt_children_'+mt_sq).style.display == 'none') {
					$('mt_children_'+mt_sq).show();
				}
				else {
					$('mt_children_'+mt_sq).hide();
				}

				if ($('mt_children_'+mt_sq).innerHTML == '') {
					loadMtChildren(mt_sq);
				}
			}

			function loadMtChildren(mt_sq)
			{
				var options = {
					method: 'get',
					onSuccess: onSuccessLoadMtChildren,
					parameters: {mt_sq: mt_sq}
			    };
				new Ajax.Request('getMtChildren', options);
			}

			function onSuccessLoadMtChildren(transport, json)
			{
				var responseText = transport.responseText;
				var mt_sq = responseText.substr(0, responseText.indexOf('|'));
				var innerHTML = responseText.substr(responseText.indexOf('|')+1);

				$('mt_children_'+mt_sq).innerHTML = innerHTML;
			}

			function toggleComments(mt_sq) 
			{
				if ($('mt_children_'+mt_sq).style.display == 'none') {
					$('mt_children_'+mt_sq).show();
				}
				else {
					$('mt_children_'+mt_sq).hide();
				}

				if ($('mt_children_'+mt_sq).innerHTML == '') {
					loadComments(mt_sq);
				}
			}

			function loadComments(mt_sq)
			{
				var options = {
					method: 'get',
					onSuccess: onSuccessLoadComments,
					parameters: {mt_sq: mt_sq}
			    };
				new Ajax.Request('getComments', options);
			}

			function onSuccessLoadComments(transport, json)
			{
				var responseText = transport.responseText;
				var mt_sq = responseText.substr(0, responseText.indexOf('|'));
				var innerHTML = responseText.substr(responseText.indexOf('|')+1);

				$('mt_children_'+mt_sq).innerHTML = innerHTML;
			}
		//-->
		</script>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<p>
			<a href="index">기억나 홈</a> |
			<a href="/mybox/index">마이기억함</a> |
			<?php if ($this->isLogged == false) { ?><a href="http://xo.nate.com/login.jsp?redirect=<?php echo $this->_escapeAttrib(Util::getRequestUri()); ?>">로그인</a><?php } 
			else { ?><a href="http://xso.nate.com/rlogout.jsp?redirect=http://memory.nate.com/admin/index" target="_top">로그아웃</a><?php } ?>
		</p>
		<h2><?php echo $this->mp->getMpNm(); ?></h2>
		<p>
			<?php $this->_isCondResult1 =  ($this->isLogged && $this->myUser->isMemorize($this->mp) === false); if ($this->_isCondResult1) { ?><a href="#"><?php } ?>나도기억나<?php if ($this->_isCondResult1) { ?></a><?php } ?> |
			<a href="#">RSS</a>
		</p>
		<p>
			<?php if ($this->mp->getMemorizeCnt() > 0) { ?>
				"<?php echo $this->mp->getMemorizeCnt(); ?>명"의 사람들이 <?php echo $this->mp->getMpNm(); ?>에 대해 <?php echo date('Y년 n월 j일', $this->mp->getInsertDt()); ?>부터 <?php echo $this->mp->getMtCnt(); ?>개의 이야기를 하고 있습니다.
				<br />
				<div id="memorize_users">
					<?php $__strHref = 'getMemorizeUsers'; $__arrAttr = array('page'=>'1', 'mp_sq'=>$this->mp->getMpSq()); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
				</div>
			<?php } 
			else { ?>
				아직 <?php echo $this->mp->getMpNm(); ?>를 기억하신 분이 없습니다.
			<?php } ?>
		</p>
		<?php if ($this->isLogged) { ?><p>
			<form action="addTalkProc" method="post">
			<input type="hidden" name="mp_sq" value="<?php echo $this->_escapeAttrib($this->mp->getMpSq()); ?>" />
			<table cellpadding="0" cellspacing="0" border="0" style="border:1px solid black;"><tr><td>
				<textarea name="content" cols="50" rows="5"></textarea> 
				<input type="submit" value="저장" />
				<br />
				언제의 기억인가요? <span id="memory_date">년 월 일</span>
				<br />
				<input id="timetag_gb_custom" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_CUSTOM); ?>" /> 
				<label for="timetag_gb_custom">
					직접입력
					<input type="text" name="timetag_year" value="" size="4" onkeypress="return onEnter(event, $('createForm').timetag_month);" />년
					<input type="text" name="timetag_month" value="" size="2" onkeypress="return onEnter(event, $('createForm').timetag_day);" />월
					<input type="text" name="timetag_day" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />일 
				</label>
				<br />
				<input id="timetag_gb_theday" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_THEDAY); ?>" /> 
				<label for="timetag_gb_theday">
					나의 <select name="timetag_theday">
						<option value="" selected="selected">-- 시절 --</option>
						<?php $_fid_98_var = TimeTag::$thedays; if ($_fid_98_var == false) $_fid_98_var = array(); $_fid_98_idx = 1; $_fid_98_cnt = count($_fid_98_var); foreach ($_fid_98_var as $thedayGb=>$thedayStr) { ?><option value="<?php echo $this->_escapeAttrib($thedayGb); ?>"><?php echo $thedayStr; ?></option><?php $_fid_98_idx++; } ?>
					</select> 시절
				</label>
				<br />
				<input id="timetag_gb_ago" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_AGO); ?>" />
				<label for="timetag_gb_ago">
					지금으로부터 약 <input type="text" name="timetag_ago" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />년 전
				</label>
				<br />
				<input id="timetag_gb_ages" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_AGES); ?>" />
				<label for="timetag_gb_ages">
					내가 <input type="text" name="timetag_ages" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />살 때
				</label>
				<br />
				<input id="timetag_gb_unknown" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_UNKNOWN); ?>" />
				<label for="timetag_gb_unknown">기억나지 않음</label>
				<br />
			</td></tr></table>
			</form>
		</p><?php } ?>
		<p>
			"<?php echo $this->mp->getMpNm(); ?>"에 대한 우리의 추억
			<br />
			최근순 | 인기순
			<br />
			<div id="mts">
				<?php $__strHref = 'getMts'; $__arrAttr = array('page'=>'1', 'mp_sq'=>$this->mp->getMpSq(), 'order'=>'mt_sq'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
			</div>
		</p>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>