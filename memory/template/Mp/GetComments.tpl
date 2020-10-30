{$this->request->mt_sq}|
<table cellpadding="5" cellspacing="0" border="0">
	<tr podo:foreach="$this->mts as $mt">
		<td>{# $mt->getWriterNick()}님</td>
		<td>{# $mt->getContent()}</td>
		<td>{date('Y.m.d H:i', $mt->getInsertDt())}</td>
	</tr>
</table>

<form action="addCommentProc" method="post">
	<input type="hidden" name="mt_sq" value="{$this->request->mt_sq}" />
	<input type="text" name="content" value="" size="50" />
	<input type="submit" value="확인" />
</form>

