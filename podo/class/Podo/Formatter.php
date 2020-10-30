<?php
class Podo_Formatter
{
	public function executeFile($filepath) /*{{{*/
	{
		return $this->executeStr(file_get_contents($filepath));
	} /*}}}*/

	public function executeStr($code) /*{{{*/
	{
		$tokenizer = new Podo_Formatter_Tokenizer;
		$root      = new Podo_Formatter_Node_Root;

		$tokens = $tokenizer->tokenize(preg_replace("/$/m", '', $code));
		$root->parse($tokens);

		return $root->toString(0);
	} /*}}}*/
}
?>
