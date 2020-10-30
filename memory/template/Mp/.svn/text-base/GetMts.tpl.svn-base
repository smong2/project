<p podo:foreach="$this->mts as $mt">
	{$mt->getTimeTag()->getShortStr()}에 {$mt->getWriterNick()}님은
	<br />
	{$mt->getContent()}
	<br />
	<a href="?mp_sq={$this->request->mp_sq}&mt_sq={$mt->getMtSq()}" onclick="toggleMtChildren({$mt->getMtSq()}); return false;" ondblclick="toggleMtChildren({$mt->getMtSq()}); return false;">댓글 ({$mt->getChildMtCnt()})</a>
	<br />
	{date('Y.m.d H:i', $mt->getInsertDt())} <a href="#">주소복사</a>

	<div id="mt_children_{$mt->getMtSq()}" style="display:none; border-left: 2px solid gray; margin-top: 10px; margin-left: 30px; padding-left: 10px;"></div>
</p>
