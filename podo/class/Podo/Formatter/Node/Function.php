<?php
class Podo_Formatter_Node_Function extends Podo_Formatter_Node_Block
{
	private $_definition = null;
	private $_nameNparam = null;
	private $_comments   = array();

	public function addComment(array $tokens) /*{{{*/
	{
		foreach ($tokens as $token) {
			$t = Podo_Formatter_Parser::removeMarkerComment($token);

			if ($t !== null) {
				$this->_comments[] = $t;
			}
		}
	} /*}}}*/

	protected function parseBefore(array $tokens) /*{{{*/
	{
		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		$definition = $parser->scanUntil(array('T_FUNCTION'));
		$parser->scan(array('T_FUNCTION'));

		$before = $parser->scanUntilEnd();

		$this->_parseDefinition($definition);
		$this->_parseNameAndParameters($before);
	} /*}}}*/

	protected function parseBody(array $tokens) /*{{{*/
	{
		if (isset($tokens[0]) && $tokens[0]->type === 'T_COMMENT') {
			$tokens[0] = Podo_Formatter_Parser::removeMarkerComment($tokens[0]);
			if ($tokens[0] === null) {
				$tokens = array_slice($tokens, 1);
			}
		}

		parent::parseBody($tokens);
	} /*}}}*/

	protected function parseAfter(array $tokens) /*{{{*/
	{
		$this->addComment(Podo_Formatter_Parser::extract($tokens, array('T_COMMENT')));
		// $tokens = Podo_Formatter_Parser::remove($tokens, array('T_NEWLINE', 'T_COMMENT'));
		$tokens = Podo_Formatter_Parser::remove($tokens, array('T_COMMENT'));

		parent::parseAfter($tokens);

		/*
		if (count($tokens) > 0) {
		trigger_error('Podo_Formatter_Node_Function::_parseAfter() - 알 수 없는 문법입니다. 제작자에게 문의하세요. [after]', E_USER_ERROR);
		}
		*/
	} /*}}}*/

	protected function toStringBefore($depth) /*{{{*/
	{
		$retval = '';
		$retval .= $this->_toStringComments($depth);
		$retval .= $this->_toStringDefinition($depth).'function ';
		$retval .= $this->_nameNparam->toString($depth);
		$retval .= ' /*{'.'{{*/';
		$retval .= "\n".str_repeat("\t", $depth);

		return $retval;
	} /*}}}*/

	protected function toStringAfter($depth) /*{{{*/
	{
		$retval = '';
		$retval .= ' /*}'.'}}*/';
		if ($this->after !== null) {
			$retval .= $this->after->toString($depth);
		}

		return $retval;
	} /*}}}*/

	private function _parseDefinition(array $tokens) /*{{{*/
	{
		if (count($tokens) <= 0) {
			return;
		}

		$tokens = Podo_Formatter_Parser::trim($tokens);

		$node = new Podo_Formatter_Node_Definition;
		$node->parse($tokens);

		$this->_definition = $node;
	} /*}}}*/

	private function _parseNameAndParameters(array $tokens) /*{{{*/
	{
		$this->addComment(Podo_Formatter_Parser::extract($tokens, array('T_COMMENT')));
		$tokens = Podo_Formatter_Parser::remove($tokens, array('T_NEWLINE', 'T_COMMENT'));

		$node = new Podo_Formatter_Node_Statement;
		$node->parse($tokens);
		$this->_nameNparam = $node;
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

	private function _toStringDefinition($depth) /*{{{*/
	{
		$retval = '';

		if ($this->_definition !== null) {
			$retval .= trim($this->_definition->toString($depth));
			$retval .= ' ';
		}

		return $retval;
	} /*}}}*/
}
?>
