<?php /* /home/mong/project/memory/template/Admin/Mp/Add.tpl */ class Admin_Mp_AddTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $categories = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Admin_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
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
		//-->
		</script>
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<table class="contents" cellpadding="0" cellspacing="0" border="0" width="100%">
			<tr><td class="headline">
				<table cellpadding="0" cellspacing="0" border="0" width="100%">
					<tr>
						<td class="title">MP 관리 > MP 추가</td>
					</tr>
				</table>
			</td></tr>

			<tr height="30"><td></td></tr>

			<tr><td class="desc">
				<form action="addProc">

				<table cellspacing="0" cellpadding="0" border="0">
					<tr><td>
						<table class="detail" cellspacing="0" cellpadding="0" border="0">
							<tr>
								<th class="form">카테고리</th>
								<td>
									<select name="category_sq" onchange="onChangeCategorySq(this)">
										<option value="">-- 카테고리 --</option>
										<?php $_fid_54_var = $this->categories; if ($_fid_54_var == false) $_fid_54_var = array(); $_fid_54_idx = 1; $_fid_54_cnt = count($_fid_54_var); foreach ($_fid_54_var as $category) { ?>
										<?php if ($category->getActivateFl()) { ?><option value="<?php echo $this->_escapeAttrib($category->getCategorySq()); ?>"><?php echo $category->getCategoryNm(); ?></option><?php } ?>
										<?php $_fid_54_idx++; } ?>
									</select>
									<input id="category_misc_nm" type="text" name="category_misc_nm" value="" size="15" style="display:none;" />
								</td>
							</tr>
							<tr>
								<th class="form">MP 제목</th>
								<td><input type="text" name="mp_nm" value="" size="30" /></td>
							</tr>
							<tr>
								<th class="form">기억일</th>
								<td>
									<input id="timetag_gb_custom" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_CUSTOM); ?>" checked="checked" /> 
									<label for="timetag_gb_custom">
										직접입력
										<input type="text" name="timetag_year" value="" size="4" />년
										<input type="text" name="timetag_month" value="" size="2" />월
										<input type="text" name="timetag_day" value="" size="2" />일 
									</label>
									<br />
									<input id="timetag_gb_theday" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_THEDAY); ?>" /> 
									<label for="timetag_gb_theday">
										나의 <select name="timetag_theday">
											<option value="" selected="selected">-- 시절 --</option>
											<?php $_fid_103_var = TimeTag::$thedays; if ($_fid_103_var == false) $_fid_103_var = array(); $_fid_103_idx = 1; $_fid_103_cnt = count($_fid_103_var); foreach ($_fid_103_var as $thedayGb=>$thedayStr) { ?><option value="<?php echo $this->_escapeAttrib($thedayGb); ?>"><?php echo $thedayStr; ?></option><?php $_fid_103_idx++; } ?>
										</select> 시절
									</label>
									<br />
									<input id="timetag_gb_ago" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_AGO); ?>" />
									<label for="timetag_gb_ago">
										지금으로부터 약 <input type="text" name="timetag_ago" value="" size="2" />년 전
									</label>
									<br />
									<input id="timetag_gb_ages" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_AGES); ?>" />
									<label for="timetag_gb_ages">
										내가 <input type="text" name="timetag_ages" value="" size="2" />살 때
									</label>
									<br />
									<input id="timetag_gb_unknown" type="radio" name="timetag_gb" value="<?php echo $this->_escapeAttrib(TimeTag::GB_UNKNOWN); ?>" />
									<label for="timetag_gb_unknown">기억나지 않음</label>
								</td>
							</tr>
							<tr class="last">
								<th class="form">설명</th>
								<td>
									<textarea name="content" cols="80" rows="5"></textarea>
								</td>
							</tr>
						</table>
					</td></tr>
					<tr height="10"><td></td></tr>
					<tr><td>
						<table cellspacing="0" cellpadding="0" border="0" width="100%">
							<tr><td align="right">
								<input type="submit" value="추가하기" />
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