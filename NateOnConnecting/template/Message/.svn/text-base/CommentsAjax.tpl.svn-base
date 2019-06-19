<script type="text/javascript">
	try { 
		document.getElementById('textbox_comment_'+{@ $this->message->getMessageKey()}).focus(); 
	} catch (e) { }
	try { 
		setTotalComments({@ $this->message->getMessageKey()}, {@ $this->totalComments}, {@ number_format($this->totalComments)}); 
	} catch (e) { }
</script>
<ul class="viewReply">
	<dummy podo:foreach="$this->comments as $comment">
		<tpl:Message_Comment comment="{$comment}" message="{$this->message}" mode="{$this->mode}" />
	</dummy>
</ul>

<dummy podo:if="$this->totalPages > 1">
	<podo:execute href="/message/comment/pageNavigator" max="{$this->totalPages}" curr="{$this->page}" senderCmn="{$this->request->senderCmn}" messageKey="{$this->request->messageKey}" mode="{$this->mode}" twit_id="{$this->twit_id}" />
</dummy>

<tpl:Message_PostComment id="{$this->message->getMessageKey()}" messageKey="{$this->message->getMessageKey()}"  commentKey="" userId="{$this->message->getSender()->getUserId()}" parentId=""  mode="{$this->mode}" twitId="{$this->twit_id}"/>
