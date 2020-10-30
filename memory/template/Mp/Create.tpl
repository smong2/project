<tpl:Common_Html>
	<tpl:Common_Head>
		<script type="text/javascript" language="javascript">
		//<!--
			var disabledCategorySq = {};
			var categorySqOfMisc = 0;

			function getCategoryValue()
			{
				for (var i=0; i<$('createForm').category_sq.length; i++) {
					if ($('createForm').category_sq[i].checked) {
						return $('createForm').category_sq[i].value;
					}
				}

				return null;
			}

			function getTimeTagGbValue()
			{
				for (var i=0; i<$('createForm').timetag_gb.length; i++) {
					if ($('createForm').timetag_gb[i].checked) {
						return $('createForm').timetag_gb[i].value;
					}
				}

				return null;
			}

			function onChangeMpNm()
			{
				var mpNm = $('createForm').mp_nm.value;
				var categorySq = getCategoryValue();

				if (mpNm == '') {
					return;
				}

				var options = {
					method: 'get',
					onSuccess: onSuccessGetSimilarMps,
					parameters: {category_sq: categorySq, mp_nm: mpNm}
			    };
				new Ajax.Request('getSimilarMps', options);
			}

			function onSuccessGetSimilarMps(transport, json)
			{
				if (json.result) {
					$('similar_mp_list').innerHTML = json.html;
					disableCategory(json.arrDisableCategorySq);
				}
			}

			function disableCategory(arrCategorySq)
			{
				disabledCategorySq = arrCategorySq;

				for (var i=0; i<$('createForm').category_sq.length; i++) {
					$('createForm').category_sq[i].disabled = false;
				}

				for (var k in arrCategorySq) {
					$('radiobtn_category_'+arrCategorySq[k]).disabled = true;
				}
			}

			function onEnter(e, tg)
			{
				if (getKeyCode(e) == 13) {
					tg.focus();
					return false;
				}

				return true;
			}

			function onSubmitCreateForm()
			{
				if ($('createForm').mp_nm.value == '') {
					alert('제목을 입력해 주세요.');
					$('createForm').mp_nm.focus();
					return false;
				}

				var categorySq = getCategoryValue();
				if (categorySq == null) {
					alert('카테고리를 선택해 주세요.');
					return false;
				}

				for (var k in disabledCategorySq) {
					if (disabledCategorySq[k] == categorySq) {
						alert($('createForm').mp_nm.value+"에 대한 기억은 이미 만들어져 있습니다.\n다른 기억을 만들어 주세요!");
						$('createForm').mp_nm.focus();
						return false;
					}
				}

				if (categorySq == categorySqOfMisc && $('createform').category_misc_nm.value == '') {
					// 체크 안함
				}

				var timeTagGb = getTimeTagGbValue();
				if (timeTagGb == {TimeTag::GB_CUSTOM}) {
					if ($('createForm').timetag_year.value == '') {
						alert('언제의 기억인지 입력해 주세요.');
						$('createForm').timetag_year.focus();
						return false;
					}
				}
				else if (timeTagGb == {TimeTag::GB_THEDAY}) {
					if ($('createForm').timetag_theday.value == '') {
						alert('나의 시절을 선택해 주세요.');
						return false;
					}
				}
				else if (timeTagGb == {TimeTag::GB_AGO}) {
					if ($('createForm').timetag_ago.value == '') {
						alert('몇 년 전 기억인지 입력해 주세요.');
						$('createForm').timetag_ago.focus();
						return false;
					}
				}
				else if (timeTagGb == {TimeTag::GB_AGES}) {
					if ($('createForm').timetag_ages.value == '') {
						alert('몇 살 때 기억인지 입력해 주세요.');
						$('createForm').timetag_ages.focus();
						return false;
					}
				}

				if ($('createForm').content.value == '') {
					alert('간략한 소개말을 남겨주세요.');
					$('createForm').content.focus();
					return false;
				}

				return true;
			}
		//-->
		</script>

		<script for="window" event="onload">
		//<!--
			$('createForm').mp_nm.focus();
		//-->
		</script>
	</tpl:Common_Head>

	<tpl:Common_Body>
		<h2>> 기억 만들기</h2>

		<form id="createForm" action="createProc" method="post" onsubmit="return onSubmitCreateForm();">

		<h3>▶ 1. 어떤 기억을 함께 모아 이야기하고 싶으세요?</h3>
		<input type="text" name="mp_nm" value="" style="width:600px;" onchange="onChangeMpNm();" onkeypress="return onEnter(event, $('createForm').content);" />
		<div id="similar_mp_list" style="width:600px; height:120px; border:1px solid gray; overflow:auto;"></div>

		<h4>카테고리 선택</h4>
		<table cellspacing="0" cellpadding="0" border="0">
			<tr podo:for="$i=0; $i<(count($this->categories)-1)/5; $i++">
				<td podo:foreach="array_slice($this->categories, $i*5, 5) as $category">
					<input id="radiobtn_category_{$category->getCategorySq()}" type="radio" name="category_sq" value="{$category->getCategorySq()}" onclick="onChangeMpNm(); {$category->getCategoryNm() === Category::MISC_NM ? '$(\'createForm\').category_misc_nm.focus();' : ''}" checked?="$category->getCategorySq() == $this->request->category_sq" /> 
					<label for="radiobtn_category_{$category->getCategorySq()}">
						{$category->getCategoryNm()}
						<dummy podo:if="$category->getCategoryNm() === Category::MISC_NM">
						<input type="text" name="category_misc_nm" value="" size="10" onkeypress="return onEnter(event, $('createForm').content);" onclick="$('radiobtn_category_{$category->getCategorySq()}').click();" />

						<script type="text/javascript" language="javascript">
						//<!--
							categorySqOfMisc = {$category->getCategorySq()};
						//-->
						</script>
						</dummy>
					</label>

				</td>
			</tr>
		</table>

		<h3>▶ 2. 언제의 기억인가요?</h3>
		※ 아래 [ ] 안에 하나만 입력하셔도 그때를 보다 쉽게 기억할 수 있어요.
		<p>
			<input id="timetag_gb_custom" type="radio" name="timetag_gb" value="{TimeTag::GB_CUSTOM}" checked?="$this->request->timetag_gb != TimeTag::GB_THEDAY" /> 
			<label for="timetag_gb_custom">
				직접입력
				<input type="text" name="timetag_year" value="{$this->request->timetag_gb == TimeTag::GB_CUSTOM ? $this->request->timetag_data : ''}" size="4" onkeypress="return onEnter(event, $('createForm').timetag_month);" />년
				<input type="text" name="timetag_month" value="" size="2" onkeypress="return onEnter(event, $('createForm').timetag_day);" />월
				<input type="text" name="timetag_day" value="" size="2" onkeypress="return onEnter(event, $('createForm').content);" />일 
			</label>
			<br />
			<input id="timetag_gb_theday" type="radio" name="timetag_gb" value="{TimeTag::GB_THEDAY}" checked?="$this->request->timetag_gb == TimeTag::GB_THEDAY" /> 
			<label for="timetag_gb_theday">
				나의 <select name="timetag_theday">
					<option value="" selected="selected">-- 시절 --</option>
					<option podo:foreach="TimeTag::$thedays as $thedayGb=>$thedayStr" value="{$thedayGb}" selected?="$this->request->timetag_data == $thedayGb">{$thedayStr}</option>
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
		</p>

		<h3>▶ 3. 간략한 소개말을 남겨주세요.</h3>
		※ 회원님의 프로필 이미지와 함께 커버스토리 상단에서 항상 보여집니다.

		<p>
			<img src="about:blank" width="80" height="80" />
			<textarea name="content" cols="80" rows="5"></textarea>
		</p>

		<input type="button" value="부가정보 추가" />
		<input type="submit" value="완료" />
		</form>
	</tpl:Common_Body>
</tpl:Common_Html>

