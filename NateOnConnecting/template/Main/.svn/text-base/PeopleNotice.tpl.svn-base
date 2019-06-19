<div style="display:none" attr-if:style="$this->request->getCookie('disable_followerNotice') == 1">
	<h2 id="box_follower_notice" style="display:none" class="cnting" attr-if:style="$this->memberCnt['follower_cnt']<=0">
	  <a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=84');" onclick="olapStat('CIM02'); openWindow('http://connect.nate.com/index.nate?menu=84'); closeBalloon({@ User::BALLOON_FOLLOWER}); return false;" onfocus="this.blur()">최근 3일, <strong id="number_follower_notice_cnt">{number_format($this->memberCnt['follower_cnt'])}</strong>명이 <strong>{$this->myUser->getRealname()}</strong>님을 Following 했어요.</a>

	  <a href="#" class="del" onclick="closeFollowerNoticeBox(); return false;" onfocus="this.blur()">삭제</a>
	</h2>
</div>

<div style="display:none" attr-if:style="$this->request->getCookie('disable_peopleNotice') == 1">
	<h2 id="box_people_notice" style="display:none" class="cnting" attr-if:style="$this->memberCnt['r_friend_cnt']<=0">
	  <a href="javascript:openWindow('http://connect.nate.com/index.nate?menu=82');" onclick="olapStat('CIM02'); openWindow('http://connect.nate.com/index.nate?menu=82');  closeBalloon({@ User::BALLOON_RPEOPLE}); return false;" onfocus="blur();">최근 3일, <strong id="number_people_notice_cnt">{number_format($this->memberCnt['r_friend_cnt'])}</strong>명이 <strong>{$this->myUser->getRealname()}</strong>님에게 커넥팅을 나누기 시작했어요.</a>

	  <a href="#" class="del" onclick="closePeopleNoticeBox(); return false;" onfocus="this.blur()">삭제</a>
	</h2>
</div>
