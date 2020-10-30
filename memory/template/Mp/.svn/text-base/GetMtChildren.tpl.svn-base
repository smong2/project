{$this->request->mt_sq}|
<p podo:foreach="$this->mts as $mt">
	{$mt->getTimeTag()->getShortStr()}에 {#$mt->getWriterNick()}님은
	<br />
	{#$mt->getContent()}
	<br />
	<a href="?mp_sq={$mt->getMp()->getMpSq()}&mt_sq={$mt->getMtSq()}" onclick="toggleComments({$mt->getMtSq()}); return false;" ondblclick="toggleComments({$mt->getMtSq()}); return false;">댓글 ({$mt->getChildMtCnt()})</a>
	<br />
	{date('Y.m.d H:i', $mt->getInsertDt())} <a href="#">주소복사</a>

	<div id="mt_children_{$mt->getMtSq()}" style="display:none; border-left: 2px solid gray; margin-top: 10px; margin-left: 30px; padding-left: 10px;">
	</div>
</p>

<form action="addTalkChildProc" method="post">
	<input type="hidden" name="mt_sq" value="{$this->request->mt_sq}" />

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
	<input id="timetag_gb_ago" type="radio" name="timetag_gb" value="{TimeTag::GB_AGO}" />
	<label for="timetag_gb_ago">
		지금으로부터 약 <input type="text" name="timetag_ago" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />년 전
	</label>
	<input id="timetag_gb_ages" type="radio" name="timetag_gb" value="{TimeTag::GB_AGES}" />
	<label for="timetag_gb_ages">
		내가 <input type="text" name="timetag_ages" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />살 때
	</label>
	<br />
	<input id="timetag_gb_unknown" type="radio" name="timetag_gb" value="{TimeTag::GB_UNKNOWN}" />
	<label for="timetag_gb_unknown">기억나지 않음</label>
	<br />
</form>
