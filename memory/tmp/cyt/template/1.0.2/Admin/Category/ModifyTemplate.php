<?php /* /home/mong/project/memory/template/Admin/Category/Modify.tpl */ class Admin_Category_ModifyTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $category = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
		<style type="text/css">
			table.basicfields, table.basicfields tr, table.basicfields tr td, table.basicfields tr th {
				padding: 2px;
				background: none;
			}
		</style>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
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
				<input type="hidden" name="category_sq" value="<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>" />

				<table cellspacing="0" cellpadding="0" border="0">
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<th class="form">카테고리명</th>
								<td><input type="text" name="category_nm" value="<?php echo $this->_escapeAttrib($this->category->getCategoryNm()); ?>" size="30" /></td>
							</tr>
							<tr>
								<th class="form">노출여부</th>
								<td>
									<input type="checkbox" id="activate_fl" name="activate_fl" value="1" <?php echo ($this->category->getActivateFl()) ? 'checked="checked"' : ''; ?> <?php echo ($this->category->getMpCnt() > 0) ? 'disabled="disabled"' : ''; ?> />
									<label class="middle" for="activate_fl">
									<?php if ($this->category->getMpCnt() > 0) { ?>
										<input type="hidden" name="activate_fl" value="1" />
										<span style="color:#666666;">이 카테고리에 등록된 MP가 있어서 비활성화 할 수 없습니다.</span>
									<?php } 
									else { ?>
										이 카테고리를 활성화 시켜서 서비스에서 보여지도록 합니다.
									<?php } ?>
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
											<td style="text-align:left;"><a href="addBasicField?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>" onclick="try {window.open('addBasicField?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>', 'memory_categoryAddBasicField', 'width=286,height=190,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[항목추가]</a></td>
										</tr>
										<tr height="1"><td colspan="3" style="background-color:black;"></td></tr>
										<tr height="2"><td colspan="3"></td></tr>
										<?php $_fid_112_var = $this->category->getBasicFields(); if ($_fid_112_var == false) $_fid_112_var = array(); $_fid_112_idx = 1; $_fid_112_cnt = count($_fid_112_var); foreach ($_fid_112_var as $basicField) { ?><tr>
											<td><?php echo $basicField->getTitle(); ?></td>
											<td><?php echo $basicField->getFieldGbStr(); ?> / <?php echo $basicField->getFieldLengthStr(); ?></td>
											<td>
												<a href="upBasicFieldProc?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>&amp;module_config_sq=<?php echo $this->_escapeAttrib($basicField->getModuleConfigSq()); ?>">[위로]</a>
												<a href="downBasicFieldProc?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>&amp;module_config_sq=<?php echo $this->_escapeAttrib($basicField->getModuleConfigSq()); ?>">[아래로]</a>
												<a href="addBasicField?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>&amp;module_config_sq=<?php echo $this->_escapeAttrib($basicField->getModuleConfigSq()); ?>" onclick="try {window.open('modifyBasicField?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>&amp;module_config_sq=<?php echo $this->_escapeAttrib($basicField->getModuleConfigSq()); ?>', 'memory_categoryModifyBasicField', 'width=286,height=190,toolbar=no,menubar=no,resizable=yes').focus();} catch (e) { } return false;">[수정]</a>
												<a href="removeBasicFieldProc?category_sq=<?php echo $this->_escapeAttrib($this->category->getCategorySq()); ?>&amp;module_config_sq=<?php echo $this->_escapeAttrib($basicField->getModuleConfigSq()); ?>" onclick="if (confirm('정말로 이 기본정보 항목을 삭제하시겠습니까?') == false) return false;">[삭제]</a>
											</td>
										</tr><?php $_fid_112_idx++; } ?>
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
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_LINK); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_LINK); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_LINK)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_LINK); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_LINK]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_COMMUNITY); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_COMMUNITY); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_COMMUNITY)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_COMMUNITY); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_COMMUNITY]; ?></label>
											</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_IMAGE); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_IMAGE); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_IMAGE)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_IMAGE); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_IMAGE]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_VIDEO); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_VIDEO); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_VIDEO)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_VIDEO); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_VIDEO]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_MUSIC); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_MUSIC); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_MUSIC)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_MUSIC); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_MUSIC]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_MAP); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_MAP); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_MAP)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_MAP); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_MAP]; ?></label>
											</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_PLOT); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_PLOT); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_PLOT)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_PLOT); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_PLOT]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_CHARACTER); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_CHARACTER); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_CHARACTER)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_CHARACTER); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_CHARACTER]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_LINES); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_LINES); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_LINES)) ? 'checked="checked"' : ''; ?> onclick="if (this.checked) { $('lines_config').show(); } else { $('lines_config').hide(); }" /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_LINES); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_LINES]; ?></label>
											</td>
										</tr>
										<tr>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_HISTORY); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_HISTORY); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_HISTORY)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_HISTORY); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_HISTORY]; ?></label>
											</td>
											<td>
												<input type="checkbox" id="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_RELATED); ?>" name="modules[]" value="<?php echo $this->_escapeAttrib(ModuleConfig::GB_RELATED); ?>" <?php echo ($this->category->haveModule(ModuleConfig::GB_RELATED)) ? 'checked="checked"' : ''; ?> /> 
												<label class="middle" for="module_<?php echo $this->_escapeAttrib(ModuleConfig::GB_RELATED); ?>"><?php echo ModuleConfig::$modules[ModuleConfig::GB_RELATED]; ?></label>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr id="lines_config" style="<?php echo $this->_escapeAttrib($this->category->haveModule(ModuleConfig::GB_LINES) ? '' : 'display:none;'); ?>">
								<th class="form">명대사 설정</th>
								<td>
									<input type="radio" id="lines_title_1" name="lines_title" value="명대사" <?php echo ($this->category->getLinesModuleTitle() === '명대사') ? 'checked="checked"' : ''; ?> /> 
									<label class="middle" for="lines_title_1" style="margin-right:10px;">명대사</label>
									<input type="radio" id="lines_title_2" name="lines_title" value="명구절" <?php echo ($this->category->getLinesModuleTitle() === '명구절') ? 'checked="checked"' : ''; ?> /> 
									<label class="middle" for="lines_title_2" style="margin-right:10px;">명구절</label>
									<input type="radio" id="lines_title_3" name="lines_title" value="명가사" <?php echo ($this->category->getLinesModuleTitle() === '명가사') ? 'checked="checked"' : ''; ?> /> 
									<label class="middle" for="lines_title_3" style="margin-right:10px;">명가사</label>
									<input type="radio" id="lines_title_4" name="lines_title" value="직접입력" <?php echo (in_array($this->category->getLinesModuleTitle(), array('명대사', '명구절', '명가사')) === false) ? 'checked="checked"' : ''; ?> /> 
									<label class="middle" for="lines_title_4">
										직접입력 
										<input type="text" name="lines_title_custom" value="<?php echo $this->_escapeAttrib(in_array($this->category->getLinesModuleTitle(), array('명대사', '명구절', '명가사')) === false ? $this->category->getLinesModuleTitle() : ''); ?>" size="12" onclick="$('lines_title_4').click();" />
									</label>
								</td>
							</tr>
							<tr class="last">
								<th>등록된 MP 수</th>
								<td><?php echo $this->category->getMpCnt(); ?></td>
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
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>