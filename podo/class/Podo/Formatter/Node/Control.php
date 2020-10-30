<?php
class Podo_Formatter_Node_Control extends Podo_Formatter_Node_Block
{
	public function parse(array $tokens) /*{{{*/
	{
		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		if ($parser->exist(array('{'))) {
			$before = Podo_Formatter_Parser::trim($parser->scanUntil(array('{')));
			$parser->scan(array('{'));
			$body = Podo_Formatter_Parser::trim($parser->scanUntilCloseBrace());
			$parser->scan(array('}'));
			$after = $parser->scanUntilEnd();
		}
		else {
			$token = $parser->scan();

			switch ($token->type) {
				case 'T_DO':
					$before = array($token);
					break;

				case 'T_ELSE':
					$next = $parser->next();
					if ($next->type !== 'T_IF') {
						$before = array($token);
						break;
					}
					else {
						// 계속 진행
					}

				default:
					$parser->unscan();
					$before = $parser->scanTo(array('('));
					$before = array_merge($before, $parser->scanToCloseParenthesis());
					$before = Podo_Formatter_Parser::trim($before);
					break;
			}

			$body  = Podo_Formatter_Parser::trim($parser->scanTo(array(';')));
			$after = $parser->scanUntilEnd();
		}

		$this->parseBefore($before);
		$this->parseBody($body);
		$this->parseAfter($after);
	} /*}}}*/
}
?>
