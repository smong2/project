<?php
class Podo_Formatter_Node_For extends Podo_Formatter_Node_Control
{
	private $_tksBefore = array();

	protected function parseBefore(array $tokens) /*{{{*/
	{
		$this->_tksBefore = Podo_Formatter_Parser::remove($tokens, array('T_NEWLINE'));
	} /*}}}*/

	protected function toStringBefore($depth) /*{{{*/
	{
		$retval = '';

		foreach ($this->_tksBefore as $key=>$token) {
			switch ($token->type) {
				case 'T_FOR':
				case ',':
				case ';':
					$retval .= $token->toString().' ';
					break;

				default:
					$retval .= $token->toString();
					break;
			}
		}

		$retval .= ' ';

		return $retval;
	} /*}}}*/
}
?>
