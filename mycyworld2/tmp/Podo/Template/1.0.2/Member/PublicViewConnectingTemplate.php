<?php /* /home/mong/project/mycyworld2/template/Member/PublicViewConnecting.tpl */ class Member_PublicViewConnectingTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $arr = array(); public function printHead($p_intLine, $p_intCol) { ?><?php if (1==2) { ?>
<h2 class="tit_myCnting">
	전체 공개 커넥팅
	<a href="#" class="manage">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<?php $_fid_12_var = $this->arr; if ($_fid_12_var == false) $_fid_12_var = array(); $_fid_12_idx = 1; $_fid_12_cnt = count($_fid_12_var); foreach ($_fid_12_var as $ar) { ?><li>
		<a <?php if ($ar!=3) { ?>href="#none"<?php } ?>>Following : <strong><?php echo $ar; ?>/<?php echo $_fid_12_cnt; ?></strong>명</a>
	</li><?php $_fid_12_idx++; } ?>
</ul>
<?php } ?>
<h2 class="tit_myCnting">
	전체 공개 커넥팅
	<a href="#" class="manage">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<iframe src="http://www.nate.com"></iframe>
</ul><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>