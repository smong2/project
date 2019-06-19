<?php /* /home/mong/project/NateOnConnecting/template/Main/Mine.tpl */ class Main_MineTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $myUser; public $enableExtBlogs = array(); public $myBlogs; public function printHead($p_intLine, $p_intCol) { ?><?php $this->_tpl_2 = Podo_Template::instance('Common_Html'); foreach ($this as $__key=>$__val) { $this->_tpl_2->{$__key} = $__val; } $this->_tpl_2->printHead(-1, -1); ?>
<?php $this->_tpl_4 = Podo_Template::instance('Common_Head'); foreach ($this as $__key=>$__val) { $this->_tpl_4->{$__key} = $__val; } $this->_tpl_4->printHead(-1, -1); ?>
<script <?php echo null !== null ? 'src="'.Util::appendFileModifyTime(null).'" ' : ''; ?> type="text/javascript">
// <![CDATA[
window.onload = function(){
	try {
		parent.resizeIFrame("id_frmMain", document.body.scrollHeight+30);
		parent.selectPage('tab_mine');
	} catch (e) { }
}
// ]]>
</script>
<?php $this->_tpl_4->printTail(-1, -1); unset($this->_tpl_4); ?>

<body>
<h1>커넥팅</h1>
<div class="iwrap">
<div class="tit_cntingList">
	<?php if ($this->myUser->getNickname()) { ?>
		<strong><?php echo htmlspecialchars($this->myUser->getNickname()); ?>(<?php echo htmlspecialchars($this->myUser->getRealname()); ?>)님의 커넥팅</strong>
	<?php } 
	else { ?>
		<strong><?php echo htmlspecialchars($this->myUser->getRealname()); ?>님의 커넥팅</strong>
	<?php } ?>
		<span class="url">http://connect.nate.com/<?php echo htmlspecialchars($this->myUser->getDomain()?$this->myUser->getDomain():'도메인입력'); ?></span>
		<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=18')" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=18');olapStat('CIM38'); return false;">EDIT</a>
</div>

<h2 class="tit_myCnting">
	전체 공개 커넥팅
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=83')" class="manage" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=83');olapStat('CIM40'); return false">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=83')" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=83');olapStat('CIM41'); return false;">Following  : <strong><?php echo htmlspecialchars(number_format($this->myUser->getFollowingCnt())); ?></strong>명</a></li>
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=84')" onfocus="blur()" onclick="openWindow('http://connect.nate.com/index.nate?menu=84');olapStat('CIM42'); return false;">Follower   : <strong><?php echo htmlspecialchars(number_format($this->myUser->getFollowerCnt())); ?></strong>명</a></li>
</ul>
	 
<h2 class="tit_myCnting">
	친구 공개 커넥팅
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=81')" target="_blank" class="manage" onclick="openWindow('http://connect.nate.com/index.nate?menu=81');olapStat('CIM43'); return false;" onfocus="blur()">관리바로가기</a>
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=88')" target="_blank" class="buddyAdd" onclick="openWindow('http://connect.nate.com/index.nate?menu=88');olapStat('CIM46'); return false;" onfocus="blur()">친구 공개 커넥팅 수신자 추가하기</a>
</h2>
<ul class="list_myCnting f_clear">
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=81')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=81');olapStat('CIM44'); return false;" onfocus="blur()">내가 보내는 일촌/친구  : <strong><?php echo htmlspecialchars(number_format($this->myUser->getFriendCnt())); ?></strong>명</a></li>
	<li><a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=82')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=82');olapStat('CIM45'); return false;" onfocus="blur()">내게 보내는 일촌/친구   : <strong><?php echo htmlspecialchars(number_format($this->myUser->getReverseFriendCnt())); ?></strong>명</a></li>
</ul>
				 
<h2 class="tit_myCnting">
	네이트온 알림 설정
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=85')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=85');olapStat('CIM47'); return false;" class="manage" onfocus="blur()">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<li>네이트온 토스트 알림 <a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=85')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=85');olapStat('CIM47'); return false;" onfocus="blur();"><strong><?php echo htmlspecialchars($this->myUser->getToastYN() == 'y'?'수신중':'수신 거부 중'); ?></strong></a></li>
</ul>
																					 
<h2 class="tit_myCnting">
	외부 블로그 등록
	<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=86')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=86');olapStat('CIM48'); return false;" class="manage" onfocus="blur()">관리바로가기</a>
</h2>
<ul class="list_myCnting f_clear">
	<?php $_fid_110_var = $this->enableExtBlogs; if ($_fid_110_var == false) $_fid_110_var = array(); $_fid_110_idx = 1; $_fid_110_cnt = count($_fid_110_var); foreach ($_fid_110_var as $blog) { ?>
		<li>
			<dl>
				<dt><?php echo htmlspecialchars($blog->getBlogNm()); ?></dt>
				<dd>					
					<?php if ($this->myBlogs && in_array($blog->getBlogId(), $this->myBlogs)) { ?>
						등록완료
					<?php } 
					else { ?>
						<a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=86')" target="_blank" onclick="openWindow('http://connect.nate.com/index.nate?menu=86');olapStat('CIM49'); return false;" class="entry" onfocus="blur()">등록하기</a>
					<?php } ?>
				</dd>
			</dl>
		</li>
	<?php $_fid_110_idx++; } ?>
</ul>
</div>
<?php $this->_tpl_136 = Podo_Template::instance('Main_BridgeForm'); foreach ($this as $__key=>$__val) { $this->_tpl_136->{$__key} = $__val; } $this->_tpl_136->printHead(-1, -1); ?><?php $this->_tpl_136->printTail(-1, -1); unset($this->_tpl_136); ?>
</body>
<?php $this->_tpl_2->printTail(-1, -1); unset($this->_tpl_2); ?><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>