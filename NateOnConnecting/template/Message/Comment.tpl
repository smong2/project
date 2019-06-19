<li style="white-space:normal; word-break:break-all; word-wrap:break-word;" class="{$this->comment->isReComment()?'rereple':'reply'}{$this->comment->getIsSecret()?' secret':''}">
	<u>
	  <img src="/ui/img/ico_lock.gif" alt="비밀" podo:if="$this->comment->getIsSecret()"/>
	  <a href="javascript:openWindow('http://connect.nate.com/{$this->comment->getDomain()}');" onclick="javascript:openWindow('http://connect.nate.com/{$this->comment->getDomain()}'); olapStat('CIM27'); return false" id="comment_writer_nm_{$this->comment->getCommentKey()}" onfocus="blur();" >{$this->comment->getProfileTitle()}</a></u>

	<span class="private" attr-if:class="$this->comment->getVisible() == 'false'">
			{HTML($this->comment->getContentHTML())}
		<b title="{date('Y.m.d H:i', $this->comment->getWriteDt())}">{HTML($this->comment->getWriteDtDiffHTML())}</b>

		<a href="javascript:openAddReComment({@ $this->comment->getCommentKey()}); return false;" id="re_reply" onclick="openReComment({@ $this->comment->getCommentKey()}); return false;" podo:if="($this->comment->isReComment() == false && $this->mode != Comment::COMMENT_TYPE_TWIT)" onfocus="blur();">재댓글</a>
		<a href="#" onclick="deleteComment({@ $this->comment->getMessage()->getSender()->getUserId()}, {@ $this->comment->getMessage()->getMessageKey()}, {@ $this->comment->getCommentKey()}, {@ $this->page}, {@ $this->totalPages}, {@ $this->totalComments}, {@ $this->mode}, {@ $this->twit_id});olapStat('CIM28'); return false;" class="re_del" title="댓글삭제" podo:if="$this->comment->isRemovable($this->myUser) && $this->comment->getDeletedYN() == 'n'" onfocus="blur();">삭제</a>
		<img src="/ui/img/ic_n.gif" width="8" height="8" alt="new" podo:if="$this->comment->isNew()" />
	</span>
	
	<dummy podo:if="$this->comment->isReComment() == false">
		<div class="re_reply" id="box_recomments_{$this->comment->getCommentKey()}" style="display:none">
			<tpl:Message_PostComment id="{$this->comment->getCommentKey()}" messageKey="{$this->message->getMessageKey()}"  commentKey="{$this->comment->getCommentKey()}" userId="{$this->message->getSender()->getUserId()}" parentId="{$this->comment->getCommentId()}"  mode="{Comment::COMMENT_TYPE_RECOMMENT}" twitId=""/>
		</div>
	</dummy>
</li>
<script type="text/javascript" language="javascript">
	cutStrByPixel("comment_writer_nm_", {@ $this->comment->getCommentKey()}, "59", false);
</script>
