<?php
class Podo_Formatter_Node_Block extends Podo_Formatter_Node
{
	protected $comments = array();
	protected $before   = null;
	protected $after    = null;

	public function parse(array $tokens) /*{{{*/
	{
		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		$before = Podo_Formatter_Parser::trim($parser->scanUntil(array('{')));
		$parser->scan(array('{'));
		$body = Podo_Formatter_Parser::trim($parser->scanUntilCloseBrace());
		$parser->scan(array('}'));
		$after = $parser->scanUntilEnd();

		$this->parseBefore($before);
		$this->parseBody($body);
		$this->parseAfter($after);
	} /*}}}*/

	public function toString($depth) /*{{{*/
	{
		$retval = '';
		$retval .= $this->toStringBefore($depth);
		$retval .= '{';
		$retval .= $this->toStringBody($depth);
		$retval .= "\n".str_repeat("\t", $depth).'}';
		$retval .= $this->toStringAfter($depth);

		return $retval;
	} /*}}}*/

	protected function parseBefore(array $tokens) /*{{{*/
	{
		$this->addComment(Podo_Formatter_Parser::extract($tokens, array('T_COMMENT')));
		$tokens = Podo_Formatter_Parser::remove($tokens, array('T_COMMENT'));

		if (count($tokens) > 0) {
			$node = new Podo_Formatter_Node_Statement;
			$node->parse($tokens);
			$this->before = $node;
		}
	} /*}}}*/

	protected function parseBody(array $tokens) /*{{{*/
	{
		$tokens         = Podo_Formatter_Parser::trim($tokens);
		$this->children = Podo_Formatter_Parser::parseBlocks($tokens);
	} /*}}}*/

	protected function parseAfter(array $tokens) /*{{{*/
	{
		if (count($tokens) > 0) {
			$node = new Podo_Formatter_Node_Statement;
			$node->parse($tokens);
			$this->after = $node;
		}
	} /*}}}*/

	public function addComment(array $tokens) /*{{{*/
	{
		$this->comments = array_merge($this->comments, $tokens);
	} /*}}}*/

	protected function toStringBefore($depth) /*{{{*/
	{
		$retval = '';
		$retval .= $this->toStringComments($depth);
		if (isset($this->before)) {
			$retval .= $this->before->toString($depth).' ';
		}

		return $retval;
	} /*}}}*/

	protected function toStringBody($depth) /*{{{*/
	{
		if (count($this->children) > 0) {
			return "\n".str_repeat("\t", $depth+1).$this->toStringOf($depth+1, $this->children);
		}
		else {
			return '';
		}
	} /*}}}*/

	protected function toStringAfter($depth) /*{{{*/
	{
		if (isset($this->after)) {
			$strAfter = $this->after->toString($depth);
			if ($strAfter[0] === "\n") {
				return $strAfter;
			}
			else {
				return ' '.$strAfter;
			}
		}
		else {
			return '';
		}
	} /*}}}*/

	protected function toStringComments($depth) /*{{{*/
	{
		$retval = '';

		if (count($this->comments) > 0) {
			$retval .= '/* ';
			// $retval .= "\n".str_repeat("\t", $depth).' * ';

			foreach ($this->comments as $comment) {
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

			// $retval .= "\n".str_repeat("\t", $depth).' */';
			$retval .= ' */';
			$retval .= "\n".str_repeat("\t", $depth);
		}

		return $retval;
	} /*}}}*/
}
?>
