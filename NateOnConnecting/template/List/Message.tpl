<script type="text/javascript">
	increaseMessageCnt();
</script>

<li id="box_message_{$this->message->getMessageKey()}" class="{$this->message->getOpenYN() == Message::OPEN_PEOPLE?'friends':''}">
	<div class="cntView {$this->message->getSender()->getUserId() == $this->myUser->getUserId()?'':'f_clear'}">
		<div class="pfImg">

			<dummy podo:if="$this->message->getOriginMsgCmn()">
				<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getOriginMessage()->getDomain()}')" title="{$this->message->getOriginMessage()->getProfileTitle()}님의 커넥팅으로 이동하기" onclick="olapStat('CIM17'); openWindow('http://connect.nate.com/{$this->message->getOriginMessage()->getDomain()}'); return false;" onfocus="blur()"><img src="{$this->message->getOriginMessage()->getProfileImageUrl()}" width="56" height="56" alt="" /></a>

			</dummy>
			<dummy podo:else>
				<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}')" title="{$this->message->getProfileTitle()}님의 커넥팅으로 이동하기" onclick="olapStat('CIM17'); openWindow('http://connect.nate.com/{$this->message->getDomain()}'); return false;" onfocus="blur()"><img src="{$this->message->getProfileImageUrl()}" width="56" height="56" onerror="this.src='{$this->myUser->generateProfileImageUrl(1)}';" alt="" /></a>
			</dummy>
		</div>
		<dl>
			<dt>
				<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getOriginMsgCmn()?$this->message->getOriginMessage()->getDomain():$this->message->getDomain()}');" onfocus="blur()" onclick="olapStat('CIM18');"><u id="writer_nm_{$this->message->getMessageKey()}">{HTML($this->message->getOriginMsgCmn()?$this->message->getOriginMessage()->getProfileTitle():$this->message->getProfileTitle())}</u></a> 

				<span title="{date('Y.m.d H:i', $this->message->getWriteDt())}"><a href="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}/{$this->message->getMessageId()}');" onclick="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}/{$this->message->getMessageId()}');olapStat('CIM20'); return false;" onfocus="blur();">{$this->message->getWriteDtDiffStr()}</a></span>

			</dt>
			<dd class="btn">
				<span class="friend" podo:if="$this->message->getOpenYN() == Message::OPEN_PEOPLE">친구공개</span>
				<dummy podo:if="$this->message->isRemovable($this->myUser)">
					<a href="#" onclick="olapStat('CIM25'); deleteMessage({@ $this->message->getSender()->getUserId()}, {@ $this->message->getMessageKey()}); return false;" class="del" onfocus="blur();">삭제</a>
				</dummy>
				<dummy podo:if="$this->message->isReconnectable($this->myUser)">
					<a href="javascript:;" onclick="javascript:openReconnecting({@ $this->message->getMessageKey()});olapStat('CIM24'); return false;" ondblclick="javascript:openReconnecting({@ $this->message->getMessageKey()});olapStat('CIM24'); return false;" onfocus="blur()">공유하기</a>
				</dummy>
			</dd>
			<dd class="origin">{$this->message->getSourceTitleStr()}</dd>
			<dd id="message_{$this->message->getMessageId()}" class="{$this->message->isClipped() && $this->message->getThumbUrl() ? 'rcnt' : 'message_cls'}" style="white-space:normal; word-break:break-all; word-wrap:break-word;">
				<dummy podo:if="$this->message->isClipped() && $this->message->getThumbUrl()">
					<a href="{$this->message->getSourceUrl()}" target="_blank" onclick="olapStat('CIM33');" onfocus="blur()"><img src="{$this->message->getThumbUrl()}" attr-if:onerror="$this->message->getAttachType() == Message::ATTACH_TYPE_CLIPPED_VIDEO" onerror="this.src='http://connect.nate.com/img/2.0/ico_youtube.gif';" width="49" alt="{$this->message->getMessage()}" onfocus="blur()" /></a>
				</dummy>

				<img src="/ui/img/{$this->message->getFromIcon()}" podo:if="$this->message->getFromIcon()"/>


				<a href="{$this->message->getSourceUrl()}" target="_blank" onclick="{$this->message->isClipped() && $this->message->getThumbUrl() ? 'olapStat(\'CIM34\');' : 'olapStat(\'CIM33\');'}" podo:cond="$this->message->getSourceUrl()" onfocus="blur();">{HTML($this->message->getMessageHTML())}</a>
			</dd>
		</dl>
		<div class="scrapAlim" podo:if="$this->message->isClipped()">외부사이트에서 스크랩 + 커넥팅한 글입니다.<br/><a href="http://connect.nate.com/index.nate?menu=7" onclick="olapStat('CIM35'); openWindow('http://connect.nate.com/index.nate?menu=7'); return false;" onfocus="blur();" target="_blank">싸이월드스크랩보기</a></div>

		<div class="subTxt">

			<dummy podo:if="$this->message->isReconnected()">
			<div class="reCnting">
				<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}');" onclick="olapStat('CIM23');" onfocus="blur();"><img src="{$this->message->getProfileImageUrl()}" width="30" height="30" class="reimg" alt="" /></a><!-- 이미지 사이즈 : 30*30 -->
				<a href="javascript:openWindow('http://connect.nate.com/{$this->message->getDomain()}');" onclick="olapStat('CIM23');" onfocus="blur();" class="user" id="reconnect_writer_nm_{$this->message->getMessageKey()}">{$this->message->getProfileTitle()}</a>님이 공유한글
			</div>
			</dummy>

			<div class="replyCnt">
				<a href="javascript:;" onclick="olapStat('CIM26'); javascript:openComments({@ $this->message->getSender()->getUserId()}, {@ $this->message->getMessageKey()}); return false;" ondblclick="javascript:openComments({@ $this->message->getSender()->getUserId()}, {@ $this->message->getMessageKey()});olapStat('CIM26'); return false;" class="reply" onfocus="blur();">댓글 <i id="number_totalComments_{$this->message->getMessageKey()}">{number_format($this->message->getCommentCnt())}</i></a>
				<span id="icon_isNew_{$this->message->getMessageKey()}" class="new" style="display:{$this->message->hasNewComments() ? '' : 'none'}">new</span>
			</div>
		</div>
	</div>

	<dummy podo:if="$this->message->isReconnectable($this->myUser)">
	<div id="reconnecting_{$this->message->getMessageKey()}" class="reCntInput" style="display:none">
		<tpl:Main_Reconnecting message="{$this->message}" sort="{$this->request->sort}" />
	</div>
	</dummy>
	<div id="box_comments_{$this->message->getMessageKey()}" class="replyBox" style="display:none;"></div>
</li>
<script type="text/javascript">
	cutStrByPixel("writer_nm_", {@ $this->message->getMessageKey()}, "65", false);
	
	<dummy podo:if="$this->message->isReconnected($this->myUser)">
		cutStrByPixel("reconnect_writer_nm_", {@ $this->message->getMessageKey()}, '65', false);
	</dummy>

</script>
