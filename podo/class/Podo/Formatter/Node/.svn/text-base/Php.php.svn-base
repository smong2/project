<?php
class Podo_Formatter_Node_Php extends Podo_Formatter_Node
{
	public function parse(array $tokens) /*{{{*/
	{
		$tksChildren    = Podo_Formatter_Parser::trim(array_slice($tokens, 1, -1));
		$this->children = Podo_Formatter_Parser::parseBlocks($tksChildren);
	} /*}}}*/

	public function toString($depth) /*{{{*/
	{
		$retval = '';
		$retval .= '<?php';
		$retval .= "\n".str_repeat("\t", $depth).trim($this->toStringOf($depth, $this->children));
		$retval .= "\n".str_repeat("\t", $depth).'?>';

		return $retval;
	} /*}}}*/
}

/*
* test
*/
?>
