<tpl:Common_Html>
	<tpl:Admin_Head>
		<style type="text/css">
			table.basicfields, table.basicfields tr, table.basicfields tr td, table.basicfields tr th {
				padding: 2px;
				background: none;
			}
		</style>
	</tpl:Admin_Head>

	<tpl:Common_Body>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">카테고리 관리 > 정보 수정</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="desc">
				<form action="modifyProc">
				<input type="hidden" name="category_sq" value="{$this->category->getCategorySq()}" />

				<table cellspacing="0" cellpadding="0" border="0">
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<th class="form">카테고리명</th>
								<td><input type="text" name="category_nm" value="{$this->category->getCategoryNm()}" size="30" /></td>
							</tr>
							<tr>
								<th class="form">노출여부</th>
								<td>
									<input type="checkbox" id="activate_fl" name="activate_fl" value="1" checked?="$this->category->getActivateFl()" disabled?="$this->category->getMpCnt() > 0" />
									<label class="middle" for="activate_fl">
									<dummy podo:if="$this->category->getMpCnt() > 0">
										<input type="hidden" name="activate_fl" value="1" />
										<span style="color:#666666;">이 카테고리에 등록된 MP가 있어서 비활성화 할 수 없습니다.</span>
									</dummy>
									<dummy podo:else>
										이 카테고리를 활성화 시켜서 서비스에서 보여지도록 합니다.
									</dummy>
									</label>
								</td>
							</tr>
							<tr>
								<th class="form">기본정보</th>
								<td>
									<table class="basicfields" cellspacing="0" cellpadding="0" border="0">
										<col width="120" align="left" />
										<col width="120" align="left" />
										<col width="180" align="left" />

										<tr>
											<th style="text-align:left;">타이틀</th>
											<th style="text-align:left;">필드타입</th>
											<td style="text-align:left;"><a href="addBasicField?category_sq={$this->category->getCategorySq()}" onclick="try {window.open('addBasicField?category_sq={$this->category->getCategorySq()}', 'memory_categoryAddBasicField', 'width=286,height=190,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[항목추가]</a></td>
										</tr>
										<tr height="1"><td colspan="3" style="background-color:black;"></td></tr>
										<tr height="2"><td colspan="3"></td></tr>
										<tr podo:foreach="$this->category->getBasicFields() as $basicField">
											<td>{$basicField->getTitle()}</td>
											<td>{$basicField->getFieldGbStr()} / {$basicField->getFieldLengthStr()}</td>
											<td>
												<a href="upBasicFieldProc?category_sq={$this->category->getCategorySq()}&module_config_sq={$basicField->getModuleConfigSq()}">[위로]</a>
												<a href="downBasicFieldProc?category_sq={$this->category->getCategorySq()}&module_config_sq={$basicField->getModuleConfigSq()}">[아래로]</a>
												<a href="addBasicField?category_sq={$this->category->getCategorySq()}&module_config_sq={$basicField->getModuleConfigSq()}" onclick="try {window.open('modifyBasicField?category_sq={$this->category->getCategorySq()}&module_config_sq={$basicField->getModuleConfigSq()}', 'memory_categoryModifyBasicField', 'width=286,height=190,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[수정]</a>
												<a href="removeBasicFieldProc?category_sq={$this->category->getCategorySq()}&module_config_sq={$basicField->getModuleConfigSq()}" onclick="if (confirm('정말로 이 기본정보 항목을 삭제하시겠습니까?') == false) return false;">[삭제]</a>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<th class="form">모듈사용여부</th>
								<td>
									<table class="normal" cellspacing="0" cellpadding="0" border="0">
										<col width="120" />
										<col width="120" />
										<col width="120" />
										<col width="120" />

										<tr>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_LINK}" name="modules[]" value="{ModuleConfig::GB_LINK}" checked?="$this->category->haveModule(ModuleConfig::GB_LINK)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_LINK}">{ModuleConfig::$modules[ModuleConfig::GB_LINK]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_COMMUNITY}" name="modules[]" value="{ModuleConfig::GB_COMMUNITY}" checked?="$this->category->haveModule(ModuleConfig::GB_COMMUNITY)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_COMMUNITY}">{ModuleConfig::$modules[ModuleConfig::GB_COMMUNITY]}</label>
											</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_IMAGE}" name="modules[]" value="{ModuleConfig::GB_IMAGE}" checked?="$this->category->haveModule(ModuleConfig::GB_IMAGE)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_IMAGE}">{ModuleConfig::$modules[ModuleConfig::GB_IMAGE]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_VIDEO}" name="modules[]" value="{ModuleConfig::GB_VIDEO}" checked?="$this->category->haveModule(ModuleConfig::GB_VIDEO)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_VIDEO}">{ModuleConfig::$modules[ModuleConfig::GB_VIDEO]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_MUSIC}" name="modules[]" value="{ModuleConfig::GB_MUSIC}" checked?="$this->category->haveModule(ModuleConfig::GB_MUSIC)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_MUSIC}">{ModuleConfig::$modules[ModuleConfig::GB_MUSIC]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_MAP}" name="modules[]" value="{ModuleConfig::GB_MAP}" checked?="$this->category->haveModule(ModuleConfig::GB_MAP)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_MAP}">{ModuleConfig::$modules[ModuleConfig::GB_MAP]}</label>
											</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_PLOT}" name="modules[]" value="{ModuleConfig::GB_PLOT}" checked?="$this->category->haveModule(ModuleConfig::GB_PLOT)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_PLOT}">{ModuleConfig::$modules[ModuleConfig::GB_PLOT]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_CHARACTER}" name="modules[]" value="{ModuleConfig::GB_CHARACTER}" checked?="$this->category->haveModule(ModuleConfig::GB_CHARACTER)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_CHARACTER}">{ModuleConfig::$modules[ModuleConfig::GB_CHARACTER]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_LINES}" name="modules[]" value="{ModuleConfig::GB_LINES}" checked?="$this->category->haveModule(ModuleConfig::GB_LINES)" onclick="if (this.checked) { $('lines_config').show(); } else { $('lines_config').hide(); }" /> 
												<label class="middle" for="module_{ModuleConfig::GB_LINES}">{ModuleConfig::$modules[ModuleConfig::GB_LINES]}</label>
											</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_HISTORY}" name="modules[]" value="{ModuleConfig::GB_HISTORY}" checked?="$this->category->haveModule(ModuleConfig::GB_HISTORY)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_HISTORY}">{ModuleConfig::$modules[ModuleConfig::GB_HISTORY]}</label>
											</td>
											<td>
												<input type="checkbox" id="module_{ModuleConfig::GB_RELATED}" name="modules[]" value="{ModuleConfig::GB_RELATED}" checked?="$this->category->haveModule(ModuleConfig::GB_RELATED)" /> 
												<label class="middle" for="module_{ModuleConfig::GB_RELATED}">{ModuleConfig::$modules[ModuleConfig::GB_RELATED]}</label>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="lines_config" style="{$this->category->haveModule(ModuleConfig::GB_LINES) ? '' : 'display:none;'}">
								<th class="form">명대사 설정</th>
								<td>
									<input type="radio" id="lines_title_1" name="lines_title" value="명대사" checked?="$this->category->getLinesModuleTitle() === '명대사'" /> 
									<label class="middle" for="lines_title_1" style="margin-right:10px;">명대사</label>
									<input type="radio" id="lines_title_2" name="lines_title" value="명구절" checked?="$this->category->getLinesModuleTitle() === '명구절'" /> 
									<label class="middle" for="lines_title_2" style="margin-right:10px;">명구절</label>
									<input type="radio" id="lines_title_3" name="lines_title" value="명가사" checked?="$this->category->getLinesModuleTitle() === '명가사'" /> 
									<label class="middle" for="lines_title_3" style="margin-right:10px;">명가사</label>
									<input type="radio" id="lines_title_4" name="lines_title" value="직접입력" checked?="in_array($this->category->getLinesModuleTitle(), array('명대사', '명구절', '명가사')) === false" /> 
									<label class="middle" for="lines_title_4">
										직접입력 
										<input type="text" name="lines_title_custom" value="{in_array($this->category->getLinesModuleTitle(), array('명대사', '명구절', '명가사')) === false ? $this->category->getLinesModuleTitle() : ''}" size="12" onclick="$('lines_title_4').click();" />
									</label>
								</td>
							</tr>
							<tr class="last">
								<th>등록된 MP 수</th>
								<td>{$this->category->getMpCnt()}</td>
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
				</table>
				</form>
			</td></tr>

			<tr height="30"><td></td></tr>
		</table>
	</tpl:Common_Body>
</tpl:Common_Html>

