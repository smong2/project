<?php
class Podo_Formatter_Node_Definition extends Podo_Formatter_Node
{
	private $_comments   = array();
	private $_abstract   = null;
	private $_final      = null;
	private $_visibility = null;
	private $_static     = null;

	public function parse(array $tokens) /*{{{*/
	{
		$this->_addComment(Podo_Formatter_Parser::extract($tokens, array('T_COMMENT')));
		$tokens = Podo_Formatter_Parser::remove($tokens, array('T_NEWLINE', 'T_COMMENT'));

		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		while ($token = $parser->scan()) {
			switch ($token->type) {
				case 'T_ABSTRACT':
					$this->_setAbstract($token);
					break;

				case 'T_FINAL':
					$this->_setFinal($token);
					break;

				case 'T_PRIVATE':
				case 'T_PROTECTED':
				case 'T_PUBLIC':
					$this->_setVisibility($token);
					break;

				case 'T_STATIC':
					$this->_setStatic($token);
					break;

				default:
					trigger_error('Podo_Formatter_Node_Definition::parse() - 알 수 없는 문법입니다. 제작자에게 문의하세요. ['.$token->type.']', E_USER_ERROR);
					break;
			}
		}
	} /*}}}*/

	public function toString($depth) /*{{{*/
	{
		$retval = '';
		$retval .= $this->_toStringComments($depth);
		$retval .= $this->_toStringAbstract();
		$retval .= $this->_toStringFinal();
		$retval .= $this->_toStringVisibility();
		$retval .= $this->_toStringStatic();

		return $retval;
	} /*}}}*/

	public function getTokens() /*{{{*/
	{
		$retval = array();

		$retval = array_merge($retval, $this->_comments);
		if ($this->_abstract !== null) {
			$retval[] = $this->_abstract;
		}
		if ($this->_final !== null) {
			$retval[] = $this->_final;
		}
		if ($this->_visibility !== null) {
			$retval[] = $this->_visibility;
		}
		if ($this->_static !== null) {
			$retval[] = $this->_static;
		}

		return $retval;
	} /*}}}*/

	private function _addComment(array $tokens) /*{{{*/
	{
		$this->_comments = array_merge($this->_comments, $tokens);
	} /*}}}*/

	private function _setAbstract(Podo_Formatter_Token $token) /*{{{*/
	{
		$this->_abstract = $token;
	} /*}}}*/

	private function _setFinal(Podo_Formatter_Token $token) /*{{{*/
	{
		$this->_final = $token;
	} /*}}}*/

	private function _setVisibility(Podo_Formatter_Token $token) /*{{{*/
	{
		$this->_visibility = $token;
	} /*}}}*/

	private function _setStatic(Podo_Formatter_Token $token) /*{{{*/
	{
		$this->_static = $token;
	} /*}}}*/

	private function _toStringComments($depth) /*{{{*/
	{
		$retval = '';
		if (count($this->_comments) > 0) {
			trigger_error('Podo_Formatter_Node_Function::_toStringComments() 는 아직 구현하지 않았습니다. 제작자에게 문의하세요.', E_USER_ERROR);
		}

		return $retval;
	} /*}}}*/

	private function _toStringAbstract() /*{{{*/
	{
		if ($this->_abstract !== null) {
			return 'abstract ';
		}

		return '';
	} /*}}}*/

	private function _toStringFinal() /*{{{*/
	{
		if ($this->_final !== null) {
			return 'final ';
		}

		return '';
	} /*}}}*/

	private function _toStringVisibility() /*{{{*/
	{
		if ($this->_visibility !== null) {
			return strtolower($this->_visibility->data).' ';
		}

		return '';
	} /*}}}*/

	private function _toStringStatic() /*{{{*/
	{
		if ($this->_static !== null) {
			return 'static ';
		}

		return '';
	} /*}}}*/
}
?>
