<?php
class Podo_Formatter_Tokenizer
{
	public function tokenize($contents) /*{{{*/
	{
		$tokens = $this->_retrieveTokenClasses($contents);
		$tokens = $this->_modifyStringTokens($tokens);
		$tokens = $this->_modifyCommentTokens($tokens);
		return $this->_modifyWhitespaceTokens($tokens);
	} /*}}}*/

	private function _retrieveTokenClasses($contents) /*{{{*/
	{
		$retval = array();

		$before = token_get_all($contents);
		foreach ($before as $token) {
			if (is_array($token)) {
				$token_name = token_name($token[0]);
				$token_data = $token[1];
			}
			else {
				$token_name = $token;
				$token_data = $token;
			}

			$retval[] = new Podo_Formatter_Token($token_name, $token_data);
		}

		return $retval;
	} /*}}}*/

	private function _modifyStringTokens(array $tokens) /*{{{*/
	{
		$retval = array();

		$isInString  = false;
		$isCurlyOpen = 0;
		foreach ($tokens as $key=>$token) {
			if ($token->type === '"') {
				$isInString = $isInString ? false : true;
				continue;
			}

			if ($isInString === false) {
				$retval[] = $token;
				continue;
			}

			if ($token->type === 'T_ENCAPSED_AND_WHITESPACE') {
				if (isset($tokens[$key-1]) && $tokens[$key-1]->type !== '"') {
					$retval[] = new Podo_Formatter_Token('.', '.');
				}
				$retval[] = new Podo_Formatter_Token('T_CONSTANT_ENCAPSED_STRING', '"'.$token->data.'"');
				if (isset($tokens[$key+1]) && $tokens[$key+1]->type !== '"') {
					$retval[] = new Podo_Formatter_Token('.', '.');
				}
				continue;
			}

			if ($token->type === 'T_CURLY_OPEN') {
				$isCurlyOpen++;
				continue;
			}

			if ($isCurlyOpen > 0 && $token->type === '}') {
				$isCurlyOpen--;
				continue;
			}

			$retval[] = $token;
		}

		return $retval;
	} /*}}}*/

	private function _modifyCommentTokens(array $tokens) /*{{{*/
	{
		$retval = array();

		foreach ($tokens as $key=>$token) {
			if ($token->type === 'T_COMMENT' && substr($token->data, 0, 2) === '//' && substr($token->data, -1) === "\n") {
				$token->data = trim($token->data);
				$retval[]    = $token;

				if (isset($tokens[$key+1]) && $tokens[$key+1]->type === 'T_WHITESPACE') {
					$tokens[$key+1]->data = "\n".$tokens[$key+1]->data;
					continue;
				}
				else {
					$retval[] = new Podo_Formatter_Token('T_WHITESPACE', "\n");
					continue;
				}
			}
			else {
				$retval[] = $token;
			}
		}

		return $retval;
	} /*}}}*/

	private function _modifyWhitespaceTokens(array $tokens) /*{{{*/
	{
		$retval = array();

		foreach ($tokens as $token) {
			if ($token->type !== 'T_WHITESPACE') {
				$retval[] = $token;
				continue;
			}

			$cntNewLine = substr_count($token->data, "\n");
			if ($cntNewLine > 0) {
				$retval[] = new Podo_Formatter_Token('T_NEWLINE', str_repeat("\n", $cntNewLine));
			}

			continue;
		}

		return $retval;
	} /*}}}*/
}
?>
