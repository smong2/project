<script type="text/javascript">
	increaseMessageCnt();
</script>

<li id="box_message_{$this->message->getMessageKey()}">
	<div class="cntView {$this->message->getSender()->getUserId() == $this->myUser->getUserId()?'':'f_clear'}">
		<div class="pfImg">
				<a href="http://twitter.com/{$this->message->getTwitId()}" target="_blank" title="{$this->message->getWriterNm()}님의 트위터로 이동하기" onclick="olapStat('CIM17');" onfocus="blur()"><img src="{$this->message->getProfileImageUrl()}" width="56" height="56" alt="" /></a>
		</div>
		<dl>
			<dt>
				<a href="http://twitter.com/{$this->message->getTwitId()}" target="_blank" onfocus="blur()" onclick="olapStat('CIM18');"><u>{$this->message->getWriterNm()}</u></a> 
				<span title="{date('Y.m.d H:i', $this->message->getWriteDt())}"><a href="http://twitter.com/{$this->message->getTwitId()}/status/{$this->message->getMessageId()}" onfocus="blur()" target="_blank" onclick="olapStat('CIM20');">{$this->message->getWriteDtDiffStr()}</a>  </span>
				<a href="http://twitter.com" onfocus="blur()" target="_blank" onclick="olapStat('CIM19');"><img src="/ui/img/{$this->message->getTwitterIcon()}" alt="트위터"/></a>

				<img src="/ui/img/ic_openbuddy.gif" alt="" podo:if="$this->message->getOpenYN() == Message::OPEN_PEOPLE"/>
			</dt>
			<dd class="btn">
			</dd>
			<dd class="origin"><a href="http://twitter.com" target="_blank" title="트위터"  onfocus="blur()" onclick="olapStat('CIM19');">{$this->message->getSourceTitleStr()}</a></dd>

			<dd id="message_{$this->message->getMessageId()}" class="{$this->message->isClipped() && $this->message->getThumbUrl() ? 'rcnt' : 'message_cls'}" style="white-space:normal; word-break:break-all; word-wrap:break-word;">
				<img src="/ui/img/{$this->message->getFromIcon()}" podo:if="$this->message->getFromIcon()"/>

				{HTML($this->message->getMessageHTML())}
			</dd>
		</dl>

		<div class="subTxt {$this->message->getSender()->getUserId() == $this->myUser->getUserId()?'':'f_clear'}">
			<div class="replyCnt">
				<a href="javascript:;" onclick="olapStat('CIM26'); javascript:openComments({@ $this->message->getSender()->getUserId()}, {@ $this->message->getMessageKey()}, {@ Comment::COMMENT_TYPE_TWIT}, {@ $this->message->getTwitId()}); return false;" ondblclick="javascript:openComments({@ $this->message->getSender()->getUserId()}, {@ $this->message->getMessageKey()}, {@ Comment::COMMENT_TYPE_TWIT}, {@ $this->message->getTwitId()});olapStat('CIM26'); return false;" class="reply" onfocus="blur();">댓글 <i id="number_totalComments_{$this->message->getMessageKey()}">{number_format($this->message->getCommentCnt())}</i></a>
				<span id="icon_isNew_{$this->message->getMessageKey()}" class="new" style="display:{$this->message->hasNewComments() ? '' : 'none'}">new</span>
			</div>
		</div>
	</div>

	<div id="box_comments_{$this->message->getMessageKey()}" class="replyBox" style="display:none;"></div>
</li>
