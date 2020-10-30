<tpl:Common_Html>
	<tpl:Admin_Head>
		<script type="text/javascript" language="javascript">
		//<!--
			function onChangeCategorySq(tg)
			{
				if (tg.options[tg.selectedIndex].innerHTML == '기타') {
					$('category_misc_nm').show();
				}
				else {
					$('category_misc_nm').hide();
				}
			}

			function setMainImage(mainimg_gb, mainimg_url) 
			{
				$('mainimg_gb').value = mainimg_gb;
				$('mainimg_url').value = mainimg_url;
				$('mainimg_imgtag').src = mainimg_url;
			}

			function onClickEditGb(edit_gb)
			{
				if (edit_gb == {ModuleBasic::EDIT_GB_NORMAL}) {
					$('form_edit_{ModuleBasic::EDIT_GB_NORMAL}').show();
					$('form_edit_{ModuleBasic::EDIT_GB_CUSTOM}').hide();
				}
				else {
					$('form_edit_{ModuleBasic::EDIT_GB_NORMAL}').hide();
					$('form_edit_{ModuleBasic::EDIT_GB_CUSTOM}').show();
				}
			}
		//-->
		</script>
		
		<style type="text/css">
			table.basicfields, table.basicfields tr, table.basicfields tr td, table.basicfields tr th {
				padding: 2px;
				background: none;
			}

			table.basicfields tr .form {
				padding-top:6px;
			}
		</style>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">MP 관리 > 정보 수정</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="desc">
				<table cellspacing="0" cellpadding="0" border="0">
					<form action="modifyProc">
					<input type="hidden" name="mp_sq" value="{$this->mp->getMpSq()}" />

					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0">
							<col width="90" />
							<col width="160" />
							<col width="90" />
							<col width="160" />
							<col width="90" />
							<col width="160" />

							<tr>
								<th class="form">카테고리</th>
								<td colspan="5">
									<select name="category_sq" onchange="onChangeCategorySq(this)">
										<dummy podo:foreach="$this->categories as $category">
										<option podo:if="$category->getActivateFl()" value="{$category->getCategorySq()}" selected?="$category->getCategorySq() == $this->mp->getCategory()->getCategorySq()">{$category->getCategoryNm()}</option>
										</dummy>
									</select>
									<input id="category_misc_nm" type="text" name="category_misc_nm" value="{$this->mp->getCategoryMiscNm()}" size="15" style="{$this->mp->getCategory()->getCategoryNm() === '기타' ? '' : 'display:none;'}" />
								</td>
							</tr>
							<tr>
								<th>제목</th>
								<td colspan="3">{#$this->mp->getMpNm()}</td>
								<th>상태</th>
								<td>{$this->mp->getStatusStr()}</td>
							</tr>
							<tr>
								<th>생성자</th>
								<td colspan="3">{$this->mp->getCreatorNick()}</td>
								<th>등록일</th>
								<td>{date('m.d H:i', $this->mp->getInsertDt())} ({Podo_Util_Date::getDiffDateStr($this->mp->getInsertDt())})</td>
							</tr>
							<tr>
								<th>조회수</th>
								<td>{number_format($this->mp->getHitCnt())}</td>
								<th>공감수</th>
								<td>{number_format($this->mp->getMemorizeCnt())}</td>
								<th>댓글수</th>
								<td>{number_format($this->mp->getMtCnt())}</td>
							</tr>
							<tr>
								<th>기억일</th>
								<td colspan="5">
									<input id="timetag_gb_custom" type="radio" name="timetag_gb" value="{TimeTag::GB_CUSTOM}" checked?="$this->mp->getTimeTag()->getTimeTagGb() == TimeTag::GB_CUSTOM" /> 
									<label for="timetag_gb_custom">
										직접입력
										<input type="text" name="timetag_year" value="{$this->mp->getTimeTag()->getYear()}" size="4" />년
										<input type="text" name="timetag_month" value="{$this->mp->getTimeTag()->getMonth()}" size="2" />월
										<input type="text" name="timetag_day" value="{$this->mp->getTimeTag()->getDay()}" size="2" />일 
									</label>
									<br />
									<input id="timetag_gb_theday" type="radio" name="timetag_gb" value="{TimeTag::GB_THEDAY}" checked?="$this->mp->getTimeTag()->getTimeTagGb() == TimeTag::GB_THEDAY" /> 
									<label for="timetag_gb_theday">
										나의 <select name="timetag_theday">
											<option value="" selected?="$this->mp->getTimeTag()->getTimeTagGb() != TimeTag::GB_THEDAY">-- 시절 --</option>
											<option podo:foreach="TimeTag::$thedays as $thedayGb=>$thedayStr" value="{$thedayGb}" selected?="$this->mp->getTimeTag()->getTheDay() == $thedayGb">{$thedayStr}</option>
										</select> 시절
									</label>
									<br />
									<input id="timetag_gb_ago" type="radio" name="timetag_gb" value="{TimeTag::GB_AGO}" checked?="$this->mp->getTimeTag()->getTimeTagGb() == TimeTag::GB_AGO" />
									<label for="timetag_gb_ago">
										지금으로부터 약 <input type="text" name="timetag_ago" value="{$this->mp->getTimeTag()->getAgo()}" size="2" />년 전
									</label>
									<br />
									<input id="timetag_gb_ages" type="radio" name="timetag_gb" value="{TimeTag::GB_AGES}" checked?="$this->mp->getTimeTag()->getTimeTagGb() == TimeTag::GB_AGES" />
									<label for="timetag_gb_ages">
										내가 <input type="text" name="timetag_ages" value="{$this->mp->getTimeTag()->getAges()}" size="2" />살 때
									</label>
									<br />
									<input id="timetag_gb_unknown" type="radio" name="timetag_gb" value="{TimeTag::GB_UNKNOWN}" checked?="$this->mp->getTimeTag()->getTimeTagGb() == TimeTag::GB_UNKNOWN" />
									<label for="timetag_gb_unknown">기억나지 않음</label>
								</td>
							</tr>
							<tr class="last">
								<th class="form">설명</th>
								<td colspan="5">
									<textarea name="content" cols="80" rows="5">{#$this->mp->getContent()}</textarea>
								</td>
							</tr>
						</table>
					</td></tr>
					<tr height="10"><td></td></tr>
					<tr><td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr><td align="right">
								<input type="submit" value="수정하기" />
								<input type="button" value="목록으로" onclick="window.location.href = 'index'" />
							</td></tr>
						</table>
					</td></tr>
					</form>

					<tr height="30"><td></td></tr>

					<form action="modifyBasicProc">
					<input type="hidden" name="mp_sq" value="{$this->mp->getMpSq()}" />
					<input id="mainimg_gb" type="hidden" name="mainimg_gb" value="{$this->moduleBasic->getMainImgGb()}" />
					<input id="mainimg_url" type="hidden" name="mainimg_url" value="{$this->moduleBasic->getMainImgUrl()}" />
					<input podo:if="count($this->mp->getCategory()->getBasicFields()) <= 0" type="hidden" name="edit_gb" value="{ModuleBasic::EDIT_GB_CUSTOM}" />

					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0" width="100%">
							<col width="90" />
							<col width="160" />
							<col width="90" />
							<col width="410" />

							<tr podo:if="count($this->mp->getCategory()->getBasicFields()) > 0">
								<th class="form">입력 방법</th>
								<td colspan="3">
									<dummy podo:foreach="ModuleBasic::$editGbs as $editGb=>$editGbStr">
									<input id="edit_gb_{$editGb}" type="radio" name="edit_gb" value="{$editGb}" checked?="$this->editGb == $editGb" onclick="onClickEditGb({$editGb});" /> <label for="edit_gb_{$editGb}">{$editGbStr}</label>
									</dummy>
								</td>
							</tr>
							<tr id="form_edit_{ModuleBasic::EDIT_GB_NORMAL}" podo:if="count($this->mp->getCategory()->getBasicFields()) > 0" class="last" style="{$this->editGb == ModuleBasic::EDIT_GB_CUSTOM ? 'display:none;' : ''}">
								<th class="form">메인이미지</th>
								<td>
									<img id="mainimg_imgtag" src="{$this->moduleBasic->getMainImgUrl()}" width="80" height="80" />
									<a href="addMainImage" onclick="try {window.open('addMainImage', 'memory_addMainImage', 'width=286,height=129,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[수정]</a>
								</td>
								<th class="form">기본정보</th>
								<td>
									<table class="basicfields" cellspacing="0" cellpadding="0" border="0">
										<col width="90" />
										<col width="320" />

										<tr podo:foreach="$this->mp->getCategory()->getBasicFields() as $moduleConfig">
											<td class="form">{$moduleConfig->getTitle()}</td>
											<td>
												<dummy podo:if="$moduleConfig->getFieldGb() != ModuleConfig::FIELD_GB_TEXT">
												<input type="text" name="start_year[{$moduleConfig->getModuleConfigSq()}]" size="4" value="{$this->moduleBasic->getStartYearOf($moduleConfig->getTitle())}"> 년
												<input type="text" name="start_month[{$moduleConfig->getModuleConfigSq()}]" size="2" value="{$this->moduleBasic->getStartMonthOf($moduleConfig->getTitle())}"> 월
												<input type="text" name="start_day[{$moduleConfig->getModuleConfigSq()}]" size="2" value="{$this->moduleBasic->getStartDayOf($moduleConfig->getTitle())}"> 일
												</dummy>
												<dummy podo:if="$moduleConfig->getFieldGb() == ModuleConfig::FIELD_GB_PERIOD">
												~ <input type="text" name="end_year[{$moduleConfig->getModuleConfigSq()}]" size="4" value="{$this->moduleBasic->getEndYearOf($moduleConfig->getTitle())}"> 년
												<input type="text" name="end_month[{$moduleConfig->getModuleConfigSq()}]" size="2" value="{$this->moduleBasic->getEndMonthOf($moduleConfig->getTitle())}"> 월
												<input type="text" name="end_day[{$moduleConfig->getModuleConfigSq()}]" size="2" value="{$this->moduleBasic->getEndDayOf($moduleConfig->getTitle())}"> 일
												</dummy>
												<dummy podo:if="$moduleConfig->getFieldGb() == ModuleConfig::FIELD_GB_TEXT">
												<input type="text" name="text[{$moduleConfig->getModuleConfigSq()}]" size="30" value="{$this->moduleBasic->getTextOf($moduleConfig->getTitle())}">
												</dummy>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="form_edit_{ModuleBasic::EDIT_GB_CUSTOM}" class="last" style="{$this->editGb != ModuleBasic::EDIT_GB_CUSTOM ? 'display:none;' : ''}">
								<th class="form">직접 편집</th>
								<td colspan="3">
									<textarea name="content" cols="80" rows="5">{#$this->moduleBasic->getContent()}</textarea>
								</td>
							</tr>
						</table>
					</td></tr>
					<tr height="10"><td></td></tr>
					<tr><td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr><td align="right">
								<input type="submit" value="수정하기" />
								<input type="button" value="목록으로" onclick="window.location.href = 'index'" />
							</td></tr>
						</table>
					</td></tr>

					</form>

					<tr height="30"><td></td></tr>
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0" width="100%">
							<col width="80" />
							<col width="600" />

							<tr class="last">
								<th>관령 링크</th>
								<td>
									<table class="basicfields" cellspacing="0" cellpadding="0" border="0">
										<tr>
											<td>네이트</td>
											<td><a href="http://www.nate.com/">http://www.nate.com/</a></td>
										</tr>
										<tr>
											<td>네이트</td>
											<td><a href="http://www.nate.com/">http://www.nate.com/</a></td>
										</tr>
										<tr>
											<td>네이트</td>
											<td><a href="http://www.nate.com/">http://www.nate.com/</a></td>
										</tr>
									</table>
								</td>
								<td align="right">
									[추가] [관리]
								</td>
							</tr>
						</table>
					</td></tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>
