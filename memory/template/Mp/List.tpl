<tpl:Common_Html>
	<tpl:Common_Head>
		<script type="text/javascript" language="javascript">
		//<!--
			function goPage(page)
			{
				$('listForm').page.value = page;
				$('listForm').submit();
			}

			function onChangeTimeTagData(timetag_gb, timetag_data)
			{
				if (timetag_data == '') {
					return;
				}

				$('listForm').timetag_gb.value = timetag_gb;
				$('listForm').timetag_data.value = timetag_data;
				$('listForm').order.value = '';
				$('listForm').submit();
			}

			function onChangeOrder(order)
			{
				$('listForm').order.value = order;
				$('listForm').submit();
			}
		//-->
		</script>
	</tpl:Common_Head>

	<tpl:Common_Body>
		<form id="listForm" method="get">
			<input type="hidden" name="page" value="{$this->request->page}" />
			<input type="hidden" name="category_sq" value="{$this->request->category_sq}" />
			<input type="hidden" name="timetag_gb" value="{$this->request->timetag_gb}" />
			<input type="hidden" name="timetag_data" value="{$this->request->timetag_data}" />
			<input type="hidden" name="order" value="{$this->request->order}" />
		</form>

		<p>
			<a href="index">기억나 홈</a> |
			<a href="/mybox/index">마이기억함</a>
		</p>
		<p>
			기억일
			<select name="timetag_data_10years" onchange="onChangeTimeTagData({TimeTag::GB_10YEARS}, this.value);">
				<option value="">-- 년대별 선택 --</option>
				<option podo:for="$i=1970; $i<=2000; $i+=10" value="{$i}" selected?="$this->request->timetag_gb == TimeTag::GB_10YEARS && $this->request->timetag_data == $i">{$i}년대</option>
			</select>

			<select name="timetag_data_year" onchange="onChangeTimeTagData({TimeTag::GB_CUSTOM}, this.value);">
				<option value="">-- 년도별 선택 --</option>
				<option podo:for="$i=1970; $i<=date('Y'); $i++" value="{$i}" selected?="$this->request->timetag_gb == TimeTag::GB_CUSTOM && $this->request->timetag_data == $i">{$i}년</option>
			</select>

			<select name="timetag_data_theday" onchange="onChangeTimeTagData({TimeTag::GB_THEDAY}, this.value);">
				<option value="">-- 시절별 선택 --</option>
				<option podo:foreach="TimeTag::$thedays as $thedayGb=>$thedayStr" value="{$thedayGb}" selected?="$this->request->timetag_gb == TimeTag::GB_THEDAY && $this->request->timetag_data == $thedayGb">{$thedayStr}</option>
			</select> 일 때의 기억
		</p>
		<p>
			<dummy podo:foreach="CategoryPeer::retrieveActivatedCategories() as $category">
				<a href="?category_sq={$category->getCategorySq()}">{$category->getCategoryNm()}</a><dummy podo:if="%ISNOTLAST%"> |</dummy>
			</dummy>
		</p>
		<p>
			[{$this->mpCnt}]개의 기억이 있습니다.
			<a href="rss?category_sq={$this->request->category_sq}&timetag_gb={$this->request->timetag_gb}&timetag_data={$this->request->timetag_data}">RSS</a>
			<select name="order" onchange="onChangeOrder(this.value);">
				<option value="mp_sq">최근 기억 Top 100</option>
				<option value="mt_cnt" selected?="$this->request->order == 'mt_cnt'">인기 기억 Top 100</option>
			</select>
		</p>
		<p>
			<table cellspacing="0" cellpadding="5" border="1">
				<tr podo:foreach="$this->mps as $mp">
					<td>{# $mp->getMpNm()}</td>
					<td>{$mp->getCategory()->getCategoryNm()}</td>
					<td>{# $mp->getFirstMt()->getContent()}</td>
					<td>
						<a href="view?mp_sq={$mp->getMpSq()}">자세히보기</a> |
						<a href="#">나도기억나</a>
					</td>
				</tr>
			</table>
		</p>
		<p>
			<podo:execute href="/common/pageNavigator" max="12" curr="{$this->request->page}" block="10" callback="goPage" />
		</p>
		<p>
			<a href="create?category_sq={$this->request->category_sq}&timetag_gb={$this->request->timetag_gb}&timetag_data={$this->request->timetag_data}">
			<dummy podo:if="$this->request->timetag_gb == TimeTag::GB_CUSTOM">{$this->request->timetag_data}년</dummy>
			<dummy podo:elseif="$this->request->timetag_gb == TimeTag::GB_THEDAY">{TimeTag::$thedays[$this->request->timetag_data]} 시절</dummy>
			<dummy podo:elseif="$this->request->timetag_gb == TimeTag::GB_10YEARS">{$this->request->timetag_data}년대</dummy>
			<dummy podo:if="$this->request->category_sq != ''">{Category::instance($this->request->category_sq)->getCategoryNm()}</dummy><br />
			새로운 기억이 떠오르세요?<br />
			함께 이야기 해 보아요.
			</a>
		</p>
	</tpl:Common_Body>
</tpl:Common_Html>

