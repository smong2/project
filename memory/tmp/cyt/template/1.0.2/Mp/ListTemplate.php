<?php /* /home/mong/project/memory/template/Mp/List.tpl */ class Mp_ListTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $request; public $mpCnt; public $mps = array(); public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
	<?php $this->_tpl_4 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
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
	<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

	<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>
		<form id="listForm" method="get">
			<input type="hidden" name="page" value="<?php echo $this->_escapeAttrib($this->request->page); ?>" />
			<input type="hidden" name="category_sq" value="<?php echo $this->_escapeAttrib($this->request->category_sq); ?>" />
			<input type="hidden" name="timetag_gb" value="<?php echo $this->_escapeAttrib($this->request->timetag_gb); ?>" />
			<input type="hidden" name="timetag_data" value="<?php echo $this->_escapeAttrib($this->request->timetag_data); ?>" />
			<input type="hidden" name="order" value="<?php echo $this->_escapeAttrib($this->request->order); ?>" />
		</form>

		<p>
			<a href="index">기억나 홈</a> |
			<a href="/mybox/index">마이기억함</a>
		</p>
		<p>
			기억일
			<select name="timetag_data_10years" onchange="onChangeTimeTagData(<?php echo $this->_escapeAttrib(TimeTag::GB_10YEARS); ?>, this.value);">
				<option value="">-- 년대별 선택 --</option>
				<?php for ($i=1970; $i<=2000; $i+=10) { ?><option value="<?php echo $this->_escapeAttrib($i); ?>" <?php echo ($this->request->timetag_gb == TimeTag::GB_10YEARS && $this->request->timetag_data == $i) ? 'selected="selected"' : ''; ?>><?php echo $i; ?>년대</option><?php } ?>
			</select>

			<select name="timetag_data_year" onchange="onChangeTimeTagData(<?php echo $this->_escapeAttrib(TimeTag::GB_CUSTOM); ?>, this.value);">
				<option value="">-- 년도별 선택 --</option>
				<?php for ($i=1970; $i<=date('Y'); $i++) { ?><option value="<?php echo $this->_escapeAttrib($i); ?>" <?php echo ($this->request->timetag_gb == TimeTag::GB_CUSTOM && $this->request->timetag_data == $i) ? 'selected="selected"' : ''; ?>><?php echo $i; ?>년</option><?php } ?>
			</select>

			<select name="timetag_data_theday" onchange="onChangeTimeTagData(<?php echo $this->_escapeAttrib(TimeTag::GB_THEDAY); ?>, this.value);">
				<option value="">-- 시절별 선택 --</option>
				<?php $_fid_59_var = TimeTag::$thedays; if ($_fid_59_var == false) $_fid_59_var = array(); $_fid_59_idx = 1; $_fid_59_cnt = count($_fid_59_var); foreach ($_fid_59_var as $thedayGb=>$thedayStr) { ?><option value="<?php echo $this->_escapeAttrib($thedayGb); ?>" <?php echo ($this->request->timetag_gb == TimeTag::GB_THEDAY && $this->request->timetag_data == $thedayGb) ? 'selected="selected"' : ''; ?>><?php echo $thedayStr; ?></option><?php $_fid_59_idx++; } ?>
			</select> 일 때의 기억
		</p>
		<p>
			<?php $_fid_66_var = CategoryPeer::retrieveActivatedCategories(); if ($_fid_66_var == false) $_fid_66_var = array(); $_fid_66_idx = 1; $_fid_66_cnt = count($_fid_66_var); foreach ($_fid_66_var as $category) { ?>
				<a href="?category_sq=<?php echo $this->_escapeAttrib($category->getCategorySq()); ?>"><?php echo $category->getCategoryNm(); ?></a><?php if ($this->_foreachIsNotLast($_fid_66_idx, $_fid_66_cnt)) { ?> |<?php } ?>
			<?php $_fid_66_idx++; } ?>
		</p>
		<p>
			[<?php echo $this->mpCnt; ?>]개의 기억이 있습니다.
			<a href="rss?category_sq=<?php echo $this->_escapeAttrib($this->request->category_sq); ?>&amp;timetag_gb=<?php echo $this->_escapeAttrib($this->request->timetag_gb); ?>&amp;timetag_data=<?php echo $this->_escapeAttrib($this->request->timetag_data); ?>">RSS</a>
			<select name="order" onchange="onChangeOrder(this.value);">
				<option value="mp_sq">최근 기억 Top 100</option>
				<option value="mt_cnt" <?php echo ($this->request->order == 'mt_cnt') ? 'selected="selected"' : ''; ?>>인기 기억 Top 100</option>
			</select>
		</p>
		<p>
			<table cellspacing="0" cellpadding="5" border="1">
				<?php $_fid_94_var = $this->mps; if ($_fid_94_var == false) $_fid_94_var = array(); $_fid_94_idx = 1; $_fid_94_cnt = count($_fid_94_var); foreach ($_fid_94_var as $mp) { ?><tr>
					<td><?php echo htmlspecialchars($mp->getMpNm()); ?></td>
					<td><?php echo $mp->getCategory()->getCategoryNm(); ?></td>
					<td><?php echo htmlspecialchars($mp->getFirstMt()->getContent()); ?></td>
					<td>
						<a href="view?mp_sq=<?php echo $this->_escapeAttrib($mp->getMpSq()); ?>">자세히보기</a> |
						<a href="#">나도기억나</a>
					</td>
				</tr><?php $_fid_94_idx++; } ?>
			</table>
		</p>
		<p>
			<?php $__strHref = '/common/pageNavigator'; $__arrAttr = array('max'=>'12', 'curr'=>$this->request->page, 'block'=>'10', 'callback'=>'goPage'); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>
		</p>
		<p>
			<a href="create?category_sq=<?php echo $this->_escapeAttrib($this->request->category_sq); ?>&amp;timetag_gb=<?php echo $this->_escapeAttrib($this->request->timetag_gb); ?>&amp;timetag_data=<?php echo $this->_escapeAttrib($this->request->timetag_data); ?>">
			<?php if ($this->request->timetag_gb == TimeTag::GB_CUSTOM) { ?><?php echo $this->request->timetag_data; ?>년<?php } 
			else if ($this->request->timetag_gb == TimeTag::GB_THEDAY) { ?><?php echo TimeTag::$thedays[$this->request->timetag_data]; ?> 시절<?php } 
			else if ($this->request->timetag_gb == TimeTag::GB_10YEARS) { ?><?php echo $this->request->timetag_data; ?>년대<?php } ?>
			<?php if ($this->request->category_sq != '') { ?><?php echo Category::instance($this->request->category_sq)->getCategoryNm(); ?><?php } ?><br />
			새로운 기억이 떠오르세요?<br />
			함께 이야기 해 보아요.
			</a>
		</p>
	<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>