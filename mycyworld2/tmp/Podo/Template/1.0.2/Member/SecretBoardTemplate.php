<?php /* /home/mong/project/mycyworld2/template/Member/SecretBoard.tpl */ class Member_SecretBoardTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $board; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
<?php $this->_tpl_4 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
<script type="text/javascript">
// <![CDATA[
window.onload = function(){
//  parent.resizeIFrame("id_frmMain", document.body.scrollHeight);

}


var id = <?php echo str_replace('\r', '', json_encode($this->board->getMember()->getUserId())); ?>;
// ]]>


</script>
<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>
<?php $this->_tpl_10 = Podo_Template::instance('Common_Body'); foreach ($this as $__key=>$__val) { $this->_tpl_10->{$__key} = $__val; } $this->_tpl_10->printHead(-1, -1); ?>

<h1>커넥팅</h1>
<div class="iwrap">
	<div class="tit_cntingList">
		<strong><?php echo $this->board->getMember()->getUserId(); ?>(김은영)님의 커넥팅</strong><br />
		<span class="url">http://connect.nate.com/</span>
		<input type="text" value="도메인 입력" onfocus="this.value=''" />
		<a href="#">EDIT</a>
	</div>

	<?php $__strHref = '/member/publicViewConnecting'; $__arrAttr = array(); if (count($__arrAttr) > 0) { if (strpos($__strHref, '?') !== false) $__strHref .= '&'; else $__strHref .= '?'; $arrKeyValue = array(); foreach ($__arrAttr as $__key=>$__value) $arrKeyValue[] = $__key.'='.urlencode($__value); $__strHref .= join('&', $arrKeyValue); }; Podo::execute($__strHref); ?>

	<h2 class="tit_myCnting">
		친구 공개 커넥팅
		<a href="#" class="manage">관리바로가기</a>
		<a href="#" class="buddyAdd">친구 공개 커넥팅 수신자 추가하기</a>
	</h2>
	<ul class="list_myCnting f_clear">
		<li><a href="#none">내가 보내는 일촌/친구 : <strong>1,230</strong>명</a></li>
		<li><a href="#none">내게 보내는 일촌/친구 : <strong>123</strong>명</a></li>
	</ul>

	<h2 class="tit_myCnting">
		네이트온 알림 설정
		<a href="#" class="manage">관리바로가기</a>
	</h2>
	<ul class="list_myCnting f_clear">
		<li>테이트온 토스트 알림 <strong>수신중</strong></li>
	</ul>

	<h2 class="tit_myCnting">
		외부 블로그 등록
		<a href="#" class="manage">관리바로가기</a>
	</h2>
	<ul class="list_myCnting f_clear">
		<li>
			<dl>
				<dt>이글루스</dt>
				<dd>등록완료</dd>
			</dl>
		</li>
		<li>
			<dl>
				<dt>스푼</dt>
				<dd><a href="#none" class="entry">등록하기</a></dd>
			</dl>
		</li>
		<li>
			<dl>
				<dt>트위터</dt>
				<dd><a href="#none" class="entry">등록하기</a></dd>
			</dl>
		</li>
	</ul>

</div>
<?php $this->_tpl_10->printTail(-1, -1); unset($this->_tpl_10); ?>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>