<tpl:Common_Html>
	<tpl:Common_Head>
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
	</tpl:Common_Head>

	<tpl:Common_Body>
		<p>
			<a href="index">기억나 홈</a> |
			<a href="/mybox/index">마이기억함</a> |
			<a podo:if="$this->isLogged == false" href="http://xo.nate.com/login.jsp?redirect={Util::getRequestUri()}">로그인</a>
			<a podo:else href="http://xso.nate.com/rlogout.jsp?redirect=http://memory.nate.com/admin/index" target="_top">로그아웃</a>
		</p>
		<h2>{$this->mp->getMpNm()}</h2>
		<p>
			<a href="#" podo:cond="$this->isLogged && $this->myUser->isMemorize($this->mp) === false">나도기억나</a> |
			<a href="#">RSS</a>
		</p>
		<p>
			<dummy podo:if="$this->mp->getMemorizeCnt() > 0">
				"{$this->mp->getMemorizeCnt()}명"의 사람들이 {$this->mp->getMpNm()}에 대해 {date('Y년 n월 j일', $this->mp->getInsertDt())}부터 {$this->mp->getMtCnt()}개의 이야기를 하고 있습니다.
				<br />
				<div id="memorize_users">
					<podo:execute href="getMemorizeUsers" page="1" mp_sq="{$this->mp->getMpSq()}" />
				</div>
			</dummy>
			<dummy podo:else>
				아직 {$this->mp->getMpNm()}를 기억하신 분이 없습니다.
			</dummy>
		</p>
		<p podo:if="$this->isLogged">
			<form action="addTalkProc" method="post">
			<input type="hidden" name="mp_sq" value="{$this->mp->getMpSq()}" />
			<table cellpadding="0" cellspacing="0" border="0"  style="border:1px solid black;"><tr><td>
				<textarea name="content" cols="50" rows="5"></textarea> 
				<input type="submit" value="저장" />
				<br />
				언제의 기억인가요? <span id="memory_date">년 월 일</span>
				<br />
				<input id="timetag_gb_custom" type="radio" name="timetag_gb" value="{TimeTag::GB_CUSTOM}" /> 
				<label for="timetag_gb_custom">
					직접입력
					<input type="text" name="timetag_year" value="" size="4" onkeypress="return onEnter(event, $('createForm').timetag_month);" />년
					<input type="text" name="timetag_month" value="" size="2" onkeypress="return onEnter(event, $('createForm').timetag_day);" />월
					<input type="text" name="timetag_day" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />일 
				</label>
				<br />
				<input id="timetag_gb_theday" type="radio" name="timetag_gb" value="{TimeTag::GB_THEDAY}" /> 
				<label for="timetag_gb_theday">
					나의 <select name="timetag_theday">
						<option value="" selected="selected">-- 시절 --</option>
						<option podo:foreach="TimeTag::$thedays as $thedayGb=>$thedayStr" value="{$thedayGb}">{$thedayStr}</option>
					</select> 시절
				</label>
				<br />
				<input id="timetag_gb_ago" type="radio" name="timetag_gb" value="{TimeTag::GB_AGO}" />
				<label for="timetag_gb_ago">
					지금으로부터 약 <input type="text" name="timetag_ago" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />년 전
				</label>
				<br />
				<input id="timetag_gb_ages" type="radio" name="timetag_gb" value="{TimeTag::GB_AGES}" />
				<label for="timetag_gb_ages">
					내가 <input type="text" name="timetag_ages" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />살 때
				</label>
				<br />
				<input id="timetag_gb_unknown" type="radio" name="timetag_gb" value="{TimeTag::GB_UNKNOWN}" />
				<label for="timetag_gb_unknown">기억나지 않음</label>
				<br />
			</td></tr></table>
			</form>
		</p>
		<p>
			"{$this->mp->getMpNm()}"에 대한 우리의 추억
			<br />
			최근순 | 인기순
			<br />
			<div id="mts">
				<podo:execute href="getMts" page="1" mp_sq="{$this->mp->getMpSq()}" order="mt_sq" />
			</div>
		</p>
	</tpl:Common_Body>
</tpl:Common_Html>

