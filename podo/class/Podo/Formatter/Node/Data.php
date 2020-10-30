<?php
class Podo_Formatter_Node_Data extends Podo_Formatter_Node
{
	private $_token = null;

	public function setToken(Podo_Formatter_Token $token) /*{{{*/
	{
		$this->_token = $token;
	} /*}}}*/

	public function toString($depth) /*{{{*/
	{
		$retval = '';
		$retval .= $this->_token->toString($depth);
		// $retval .= preg_replace("/^\s*/m", str_repeat("\t", $depth), $this->_token->data);

		return $retval;
	} /*}}}*/
}
?>
