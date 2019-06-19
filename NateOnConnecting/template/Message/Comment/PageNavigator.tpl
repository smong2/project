<div class="replyPaging" podo:if="$this->request->max > 1">
	<a href="#" class="btn first_page" title="처음 페이지" onclick="getComments({@ $this->request->senderCmn}, {@ $this->request->messageKey}, {@ $this->mode}, {@ $this->twit_id}, {@ $this->dblPrevPage});olapStat('CIM31'); return false;" podo:if="$this->isShowDblPrevBtn"></a>
	<a href="#" class="btn prev_page" title="이전 페이지" onclick="getComments({@ $this->request->senderCmn}, {@ $this->request->messageKey}, {@ $this->mode}, {@ $this->prevPage});olapStat('CIM31'); return false;" podo:if="$this->isShowPrevBtn"></a>
	<span class="paging">
		<dummy podo:for="$i=$this->firstPage; $i<=$this->lastPage; $i++">
			<a href="#" class="{$i == $this->request->curr ? 'current' : ''}" onclick="getComments({@ $this->request->senderCmn}, {@ $this->request->messageKey}, {@ $this->mode}, {@ $this->twit_id}, {@ $i});olapStat('CIM31'); return false;">{$i}</a>
		</dummy>
	</span>
	<a href="#" class="btn next_page" title="다음 페이지" onclick="getComments({@ $this->request->senderCmn}, {@ $this->request->messageKey}, {@ $this->mode}, {@ $this->twit_id}, {@ $this->nextPage});olapStat('CIM31'); return false;" podo:if="$this->isShowNextBtn"></a>
	<a href="#" class="btn last_page" title="마지막 페이지" onclick="getComments({@ $this->request->senderCmn}, {@ $this->request->messageKey}, {@ $this->mode}, {@ $this->twit_id}, {@ $this->dblNextPage});olapStat('CIM31'); return false;" podo:if="$this->isShowDblNextBtn"></a>
</div>
