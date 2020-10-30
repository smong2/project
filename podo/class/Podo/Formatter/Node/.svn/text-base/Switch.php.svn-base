<?php
class Podo_Formatter_Node_Switch extends Podo_Formatter_Node_Control
{
	private $_arrCase = array();

	protected function parseBody(array $tokens) /*{{{*/
	{
		$nodeComment = null;

		$tokens = Podo_Formatter_Parser::trim($tokens);

		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		while ($token = $parser->next()) {
			switch ($token->type) {
				case 'T_DOC_COMMENT':
				case 'T_COMMENT':
					$tksBody = Podo_Formatter_Parser::trim($parser->scanUntil(array('T_CASE', 'T_DEFAULT')));

					$nodeComment = new Podo_Formatter_Node_Statement;
					$nodeComment->parse($tksBody);

				case 'T_CASE':
				case 'T_DEFAULT':
					$tksCase = Podo_Formatter_Parser::trim($parser->scanUntil(array(':')));
					$parser->scan(array(':'));

					$tksBody = array();
					while (true) {
						$tksBody = array_merge($tksBody, $parser->scanUntil(array('T_CASE', 'T_DEFAULT', '{')));
						$token   = $parser->next();
						if ($token === false || $token->type !== '{') {
							break;
						}
						else {
							$tksBody = array_merge($tksBody, $parser->scanToCloseBrace(-1));
						}
					}

					$tksBody = Podo_Formatter_Parser::ltrim($tksBody);

					$nodeCase = new Podo_Formatter_Node_Statement;
					$nodeCase->parse($tksCase);

					if (count($tksBody) > 0) {
						if ($tksBody[count($tksBody)-1]->type === 'T_NEWLINE') {
							$tksBody[count($tksBody)-1] = new Podo_Formatter_Token('T_NEWLINE', substr($tksBody[count($tksBody)-1]->data, -1));
						}
						else {
							$tksBody[] = new Podo_Formatter_Token('T_NEWLINE', "\n");
						}

						$nodeBody = Podo_Formatter_Parser::parseBlocks($tksBody);
					}
					else {
						$nodeBody = null;
					}

					$this->_arrCase[] = array($nodeComment, $nodeCase, $nodeBody);

					$nodeComment = null;

					break;

				default:
					trigger_error('Podo_Formatter_Node_Switch::parse() - 알 수 없는 문법입니다. 제작자에게 문의하세요. ['.$token->type.']', E_USER_ERROR);
					break;
			}
		}

		$tokens         = Podo_Formatter_Parser::trim($tokens);
		$this->children = Podo_Formatter_Parser::parseBlocks($tokens);
	} /*}}}*/

	protected function toStringBody($depth) /*{{{*/
	{
		$arrCaseStr = array();
		foreach ($this->_arrCase as $case) {
			$strCase = '';
			if (isset($case[0])) {
				$strCase .= $case[0]->toString($depth+1);
				$strCase .= "\n".str_repeat("\t", $depth+1);
			}
			$strCase .= $case[1]->toString($depth+1).':';
			if (count($case[2]) > 0) {
				$strCase .= "\n".str_repeat("\t", $depth+2).$this->toStringOf($depth+2, $case[2]);
			}
			$arrCaseStr[] = $strCase;
		}

		return "\n".str_repeat("\t", $depth+1).trim(join("\n".str_repeat("\t", $depth+1), $arrCaseStr));
	} /*}}}*/
}
?>
