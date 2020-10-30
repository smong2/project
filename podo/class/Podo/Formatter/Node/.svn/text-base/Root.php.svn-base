<?php
class Podo_Formatter_Node_Root extends Podo_Formatter_Node
{
	public function parse(array $tokens) /*{{{*/
	{
		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		while ($token = $parser->scan()) {
			switch ($token->type) {
				case 'T_OPEN_TAG':
					$parser->unscan();
					$tokens = $parser->scanTo(array('T_CLOSE_TAG'));
					$node   = new Podo_Formatter_Node_Php;
					$node->parse($tokens);

					break;

				default:
					/*
					$node = new Podo_Formatter_Node_Data;
					$node->setToken($token);
					*/

					$node = $token;

					break;
			}

			$this->children[] = $node;
		}
	} /*}}}*/
}
?>
