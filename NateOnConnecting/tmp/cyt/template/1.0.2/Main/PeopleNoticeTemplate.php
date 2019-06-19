<?php /* /home/mong/project/NateOnConnecting/template/Main/PeopleNotice.tpl */ class Main_PeopleNoticeTemplate extends Podo_Template_Base { const HAVE_CDATA = FALSE; public $request; public $memberCnt; public $myUser; public function printHead($p_intLine, $p_intCol) { ?><div <?php if ($this->request->getCookie('disable_followerNotice') == 1) { ?>style="display:none"<?php } ?>>
	<h2 id="box_follower_notice" class="cnting" <?php if ($this->memberCnt['follower_cnt']<=0) { ?>style="display:none"<?php } ?>>
	  <a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=84');" onclick="olapStat('CIM02'); openWindow('http://connect.nate.com/index.nate?menu=84'); closeBalloon(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode(User::BALLOON_FOLLOWER))); ?>); return false;" onfocus="this.blur()">최근 3일, <strong id="number_follower_notice_cnt"><?php echo htmlspecialchars(number_format($this->memberCnt['follower_cnt'])); ?></strong>명이 <strong><?php echo htmlspecialchars($this->myUser->getRealname()); ?></strong>님을 Following 했어요.</a>

	  <a href="#" class="del" onclick="closeFollowerNoticeBox(); return false;" onfocus="this.blur()">삭제</a>
	</h2>
</div>

<div <?php if ($this->request->getCookie('disable_peopleNotice') == 1) { ?>style="display:none"<?php } ?>>
	<h2 id="box_people_notice" class="cnting" <?php if ($this->memberCnt['r_friend_cnt']<=0) { ?>style="display:none"<?php } ?>>
	  <a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=82');" onclick="olapStat('CIM02'); openWindow('http://connect.nate.com/index.nate?menu=82');  closeBalloon(<?php echo $this->_escapeAttrib(str_replace('\r', '', json_encode(User::BALLOON_RPEOPLE))); ?>); return false;" onfocus="blur();">최근 3일, <strong id="number_people_notice_cnt"><?php echo htmlspecialchars(number_format($this->memberCnt['r_friend_cnt'])); ?></strong>명이 <strong><?php echo htmlspecialchars($this->myUser->getRealname()); ?></strong>님에게 커넥팅을 나누기 시작했어요.</a>

	  <a href="#" class="del" onclick="closePeopleNoticeBox(); return false;" onfocus="this.blur()">삭제</a>
	</h2>
</div><?php } public function printTail($p_intLine, $p_intCol) { ?><?php } } ?>