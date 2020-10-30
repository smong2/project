<?php
class Podo_Formatter_Node_Class extends Podo_Formatter_Node_Block
{
	private $_comments = array();

	public function addComment(array $tokens) /*{{{*/
	{
		$this->_comments = array_merge($this->_comments, $tokens);
	} /*}}}*/

	protected function parseBefore(array $tokens) /*{{{*/
	{
		$this->addComment(Podo_Formatter_Parser::extract($tokens, array('T_COMMENT')));
		$tokens = Podo_Formatter_Parser::remove($tokens, array('T_NEWLINE', 'T_COMMENT'));

		parent::parseBefore($tokens);
	} /*}}}*/

	protected function toStringBefore($depth) /*{{{*/
	{
		$retval = '';
		$retval .= $this->_toStringComments($depth);
		$retval .= $this->before->toString($depth);
		$retval .= "\n".str_repeat("\t", $depth);

		return $retval;
	} /*}}}*/

	private function _toStringComments($depth) /*{{{*/
	{
		$retval = '';

		if (count($this->_comments) > 0) {
			$retval .= '/**';
			$retval .= "\n".str_repeat("\t", $depth).' * ';

			foreach ($this->_comments as $comment) {
				if (substr($comment->data, 0, 2) === '//') {
					$strCmt = substr($comment->data, 2);
				}
				else {
					$strCmt = substr($comment->data, 2, -2);
				}

				$strCmt = trim($strCmt);
				$strCmt = preg_replace('/\/\*\s*\*\//m', '', $strCmt);
				$strCmt = str_replace('*/', '* /', $strCmt);

				$retval .= preg_replace("/\n[ \t]*(?:\* )?/", "\n".str_repeat("\t", $depth).' * ', $strCmt);
			}

			$retval .= "\n".str_repeat("\t", $depth).' */';
			$retval .= "\n".str_repeat("\t", $depth);
		}

		return $retval;
	} /*}}}*/
}
?>
