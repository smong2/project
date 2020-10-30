<?php
class Podo_Formatter_Node_Statement extends Podo_Formatter_Node
{
	/**
	 * EXPR1: 왼쪽, 오른쪽 모두 띄어쓰기
	 */
	private static $_expr1 = array /*{{{*/
	                         (
	                             '<',
	                             '>',
	                             '=',
	                             '?',
	                             ',',
	                             ':',
	                             '|',
	                             '&',
	                             'T_IS_GREATER_OR_EQUAL',
	                             'T_IS_SMALLER_OR_EQUAL',
	                             'T_IS_IDENTICAL',
	                             'T_IS_EQUAL',
	                             'T_IS_NOT_EQUAL',
	                             'T_IS_NOT_IDENTICAL',
	                             'T_BOOLEAN_AND',
	                             'T_BOOLEAN_OR',
	                             'T_LOGICAL_AND',
	                             'T_LOGICAL_OR',
	                             'T_AS',
	                             'T_DOUBLE_ARROW',
	                             'T_INSTANCEOF',

	                             'T_RETURN',

	                             'T_NEWLINE',
	                             'T_START',
	                         ); /*}}}*/

	public function parse(array $tokens) /*{{{*/
	{
		$this->children = $tokens;
	} /*}}}*/

	public function toString($depth) /*{{{*/
	{
		return $this->_toString($depth, $this->children);
	} /*}}}*/

	private function _toString($depth, array $tokens) /*{{{*/
	{
		$retval = '';

		$arrLine               = array();
		$arrWord               = array();
		$exprDepth             = 0;
		$exprPrefixPos         = 0;
		$exprPrefixPosStack    = array();
		$exprPrefixIndent      = 0;
		$exprPrefixIndentStack = array();
		$exprPrefixIsArray     = array();
		$assignPrefixPos       = 0;

		foreach ($tokens as $key=>$child) {
			if (isset($tokens[$key-1])) {
				$prev = $tokens[$key-1];
			}
			else {
				$prev = new Podo_Formatter_Token('T_START', '');
			}
			if (isset($tokens[$key+1])) {
				$next = $tokens[$key+1];
			}
			else {
				$next = new Podo_Formatter_Token('T_END', '');
			}

			switch ($child->type) {
				case '(':
					$exprDepth++;
					array_push($exprPrefixPosStack,    $exprPrefixPos);
					array_push($exprPrefixIndentStack, $exprPrefixIndent);

					if ($prev->type === 'T_ARRAY' && $next->type === 'T_NEWLINE') {
						array_push($exprPrefixIsArray, true);

						$exprPrefixPos    = $exprPrefixPos + 4;
						$exprPrefixIndent = 4;
					}
					else {
						array_push($exprPrefixIsArray, false);

						$strBefore = ltrim(join('', $arrWord));
						do {
							$strBefore = preg_replace('/\(([^\(\)]*)\)/', '.$1.', $strBefore, -1, $count);
						} while ($count > 0);
						if (strpos($strBefore, '(') !== false) {
							$strBefore = substr($strBefore, strrpos($strBefore, '(')+1);
						}

						if ($next->type === 'T_NEWLINE') {
							$exprPrefixPos    = $exprPrefixPos + strlen($strBefore) + 4;
							$exprPrefixIndent = 4;
						}
						else {
							$exprPrefixPos    = $exprPrefixPos + strlen($strBefore) + 1;
							$exprPrefixIndent = 1;
						}

						if ($prev->type === 'T_IF' || $prev->type === 'T_ELSEIF') {
							$exprPrefixPos += 4;
							$exprPrefixIndent += 4;
						}

						if (in_array($prev->type, self::$_expr1) === false) {
							$exprPrefixPos--;
							// $exprPrefixIndent--;
						}
					}

					break;

				case ')':
					if ($prev->type === 'T_NEWLINE' && $exprPrefixIndent > 0) {
						$arrLine[count($arrLine)-1] = substr($arrLine[count($arrLine)-1], 0, -1*$exprPrefixIndent);
					}

					$exprDepth--;
					$exprPrefixPos    = array_pop($exprPrefixPosStack);
					$exprPrefixIndent = array_pop($exprPrefixIndentStack);
					array_pop($exprPrefixIsArray);
					break;

				case '=':
					// '=' 이 나오면 여기에 줄을 맞추도록 한다.
					if ($exprDepth === 0) {
						$assignPrefixPos = strlen(ltrim(join('', $arrWord))) + 2;
					}
					break;

				case ';':
					// statement 가 종료된 경우 '=' 에 줄맞추는 것을 취소한다.
					if ($exprDepth === 0) {
						$assignPrefixPos = 0;
						$exprPrefixPos   = 0;
					}
					break;

				case '[':
					$exprDepth++;
					break;

				case ']':
					$exprDepth--;
					break;
			}

			switch ($child->type) {
				case '-':
				case '+':
				case '*':
				case '/':
				case '%':
					if ($exprDepth > 0 && in_array($prev->type, self::$_expr1) === false) {
						$arrWord = $this->_removeLastRightSpace($arrWord);
					}
					break;

				case '(':
					if (in_array($prev->type, self::$_expr1) === false) {
						$arrWord = $this->_removeLastRightSpace($arrWord);
					}
					break;

				case ')':
				case '}':
				case '[':
				case ']':
				case ',':
				case ';':
				case 'T_INC':
				case 'T_DEC':
				case 'T_DOUBLE_COLON':
				case 'T_OBJECT_OPERATOR':
					$arrWord = $this->_removeLastRightSpace($arrWord);
					break;
			}

			switch ($child->type) {
				case 'T_IF':
				case 'T_WHILE':
					// case 'T_FOREACH':
					// case 'T_FOR':

				case 'T_CATCH':
				case 'T_ELSEIF':
				case 'T_SWITCH':
					$arrWord[] = $child->toString($depth) . '  ';
					break;

				case 'T_ELSE':
					if ($next->type === 'T_IF') {
						$arrWord[] = $child->toString($depth) . ' ';
					}
					else {
						$arrWord[] = $child->toString($depth) . '  ';
					}
					break;

				case '-':
				case '+':
					// -T_LNUMBER, +T_LNUMBER 의 경우, 뒷 단어 붙여쓰기
					if (count($arrWord) > 0) {
						if (in_array($prev->type, array(')', ']', 'T_LNUMBER', 'T_VARIABLE', 'T_STRING'))) {
							if ($exprDepth <= 0) {
								$arrWord[] = $child->toString($depth) . ' ';
							}
							else {
								$arrWord[] = $child->toString($depth);
							}
						}
						else {
							$arrWord[] = $child->toString($depth);
						}
					}
					else {
						$arrWord[] = $child->toString($depth);
					}
					break;

				case '(':
				case '{':
				case '[':
				case '!':
				case '@':
				case 'T_DOUBLE_COLON':
				case 'T_OBJECT_OPERATOR':
					$arrWord[] = $child->toString($depth);
					break;

				case 'T_NEWLINE':
					// '=' 에 줄을 맞춰야 하는 경우
					if ($assignPrefixPos > 0) {
						// '=' 에 맞춰서 줄을 변경하도록 $exprPrefixPos 값을 변경한다.
						if ($exprDepth <= 0) {
							$exprPrefixPos = $assignPrefixPos;
						}
						// 그리고 $assignPrefixPos 는 초기화환다.
						$assignPrefixPos = 0;
					}

					$arrLine[] = rtrim(join('', $arrWord)) . $child->data . str_repeat("\t", $depth) . str_repeat(' ', $exprPrefixPos);
					$arrWord   = array();

					break;

				case ',':
				case ';':
				case 'T_STRING':
				case 'T_ARRAY':
					$arrWord[] = $child->toString($depth) . ' ';
					break;

				case '&':
					if ($prev->type === ',') {
						$arrWord[] = $child->toString($depth);
					}
					else {
						if ($exprDepth <= 0 || $prev->type === 'T_NEWLINE' || substr($arrWord[count($arrWord)-1], -1) === ' ') {
							$arrWord[] = $child->toString($depth) . ' ';
						}
						else {
							$arrWord[] = ' ' . $child->toString($depth) . ' ';
						}
					}
					break;

				case '<':
				case '>':
				case '=':
				case '?':
				case ':':
				case '|':
				case 'T_IS_GREATER_OR_EQUAL':
				case 'T_IS_SMALLER_OR_EQUAL':
				case 'T_IS_IDENTICAL':
				case 'T_IS_EQUAL':
				case 'T_IS_NOT_EQUAL':
				case 'T_IS_NOT_IDENTICAL':
				case 'T_BOOLEAN_AND':
				case 'T_BOOLEAN_OR':
				case 'T_LOGICAL_AND':
				case 'T_LOGICAL_OR':
				case 'T_AS':
				case 'T_DOUBLE_ARROW':
				case 'T_INSTANCEOF':
					if ($exprDepth <= 0 || $prev->type === 'T_NEWLINE' || substr($arrWord[count($arrWord)-1], -1) === ' ') {
						$arrWord[] = $child->toString($depth) . ' ';
					}
					else {
						$arrWord[] = ' ' . $child->toString($depth) . ' ';
					}
					break;

				default:
					if ($exprDepth <= 0) {
						$arrWord[] = $child->toString($depth) . ' ';
					}
					else {
						$arrWord[] = $child->toString($depth);
					}
					break;
			}
		}

		$arrLine[] = rtrim(join('', $arrWord));
		// return preg_replace("/\n\s+\n/", "\n\n", join('', $arrLine));
		return join('', $arrLine);
	} /*}}}*/

	private function _removeLastRightSpace($arrWord) /*{{{*/
	{
		if (count($arrWord) <= 0) {
			return $arrWord;
		}

		$lastWord = &$arrWord[count($arrWord)-1];

		if (strlen($lastWord) <= 0) {
			return $arrWord;
		}

		$lastChar = $lastWord[strlen($lastWord)-1];

		if ($lastChar !== ' ') {
			return $arrWord;
		}

		$lastWord = substr($lastWord, 0, -1);
		return $arrWord;
	} /*}}}*/

	public function isPatternAssign($add = null) /*{{{*/
	{
		$state = 1;
		foreach ($this->children as $key=>&$child) {
			switch ($state) {
				case 1:
					// START
					switch ($child->type) {
						case 'T_FINAL':
						case 'T_ABSTRACT':
						case 'T_PUBLIC':
						case 'T_PROTECTED':
						case 'T_PRIVATE':
						case 'T_STATIC':
							break;

						case 'T_CONST':
							$state = 41;
							break;

						case 'T_VARIABLE':
							$state = 11;
							break;

						case 'T_STRING':
							$state = 21;
							break;

						default:
							return false;
					}
					break;

				case 11:
					// $var
					switch ($child->type) {
						case 'T_OBJECT_OPERATOR':
							$state = 12;
							break;

						case '[':
							$state = 31;
							break;

						case '=':
							if ($add === null) {
								return strlen($this->_toString(0, array_slice($this->children, 0, $key))) + 1;
							}
							else {
								$child->data = str_repeat(' ', $add) . '=';
								return true;
							}

						default:
							return false;
					}
					break;

				case 12:
					// $var->
					switch ($child->type) {
						case 'T_STRING':
						case 'T_VARIABLE':
							$state = 11;
							break;

						default:
							return false;
					}
					break;

				case 21:
					// class
					switch ($child->type) {
						case 'T_DOUBLE_COLON':
							$state = 22;
							break;

						default:
							return false;
					}
					break;

				case 22:
					// class::
					switch ($child->type) {
						case 'T_STRING':
						case 'T_VARIABLE':
							$state = 11;
							break;

						default:
							return false;
					}
					break;

				case 31:
					// $var[
					switch ($child->type) {
						case ']':
							$state = 11;
							break;

						default:
							break;
					}
					break;

				case 41:
					// const
					switch ($child->type) {
						case 'T_STRING':
							$state = 42;
							break;

						default:
							return false;
					}
					break;

				case 42:
					// const CONSTATANT
					switch ($child->type) {
						case '=':
							if ($add === null) {
								return strlen($this->_toString(0, array_slice($this->children, 0, $key))) + 1;
							}
							else {
								$child->data = str_repeat(' ', $add) . '=';
								return true;
							}

						default:
							return false;
					}
					break;
			}
		}

		return false;
	} /*}}}*/

	public function isPatternComment($add = null) /*{{{*/
	{
		$state = 1;
		foreach ($this->children as $key=>&$child) {
			switch ($state) {
				case 1:
					// START
					switch ($child->type) {
						case 'T_COMMENT':
							if (isset($this->children[$key+1]) && $this->children[$key+1]->type !== 'T_NEWLINE') {
								return false;
							}

							if ($add === null) {
								if (strpos($child->data, "\n")) {
									return false;
								}

								if ($key === 0) {
									return 0;
								}
								else {
									// return strlen($this->_toString(0, array_slice($this->children, 0, $key))) + 1;
									$strBefore = $this->_toString(0, array_slice($this->children, 0, $key));
									$arrBefore = explode("\n", $strBefore);
									$strBefore = $arrBefore[count($arrBefore)-1];
									return strlen($strBefore) + 1;
								}
							}
							else {
								$child->data = str_repeat(' ', $add) . $child->data;
								return true;
							}
							break;

						default:
							break;
					}
					break;
			}
		}

		return false;
	} /*}}}*/

	public function isPatternFunction($add = null) /*{{{*/
	{
		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($this->children);

		$state      = 1;
		$lastCursor = 0;
		$retval     = array();
		$commaCnt   = 0;

		while ($child = $parser->scan()) {
			switch ($state) {
				case 1:
					// START
					switch ($child->type) {
						case 'T_VARIABLE':
							$state = 11;
							break;

						case 'T_STRING':
							$state = 21;
							break;

						default:
							return array();
					}
					break;

				case 11:
					// $var
					switch ($child->type) {
						case 'T_OBJECT_OPERATOR':
							$state = 12;
							break;

						case '[':
							$state = 31;
							break;

						case '(':
							$tksFunctionName = array_slice($this->children, 0, $parser->getCursor()-1);
							$retval[]        = $this->_toString(0, $tksFunctionName);
							$lastCursor      = $parser->getCursor();

							$state = 41;
							break;

						default:
							return array();
					}
					break;

				case 12:
					// $var->
					switch ($child->type) {
						case 'T_STRING':
						case 'T_VARIABLE':
							$state = 11;
							break;

						default:
							return array();
					}
					break;

				case 21:
					// class or function
					switch ($child->type) {
						case 'T_DOUBLE_COLON':
							$state = 22;
							break;

						case '(':
							$tksFunctionName = array_slice($this->children, 0, $parser->getCursor()-1);
							$retval[]        = $this->_toString(0, $tksFunctionName);
							$lastCursor      = $parser->getCursor();

							$state = 41;
							break;

						default:
							return array();
					}
					break;

				case 22:
					// class::
					switch ($child->type) {
						case 'T_STRING':
						case 'T_VARIABLE':
							$state = 11;
							break;

						default:
							return array();
					}
					break;

				case 31:
					// $var[
					switch ($child->type) {
						case ']':
							$state = 11;
							break;

						default:
							break;
					}
					break;

				case 41:
					// function(
					switch ($child->type) {
						case ',':
							$commaCnt++;

							if ($add === null) {
								$tksParameter = array_slice($this->children, $lastCursor, $parser->getCursor()-$lastCursor-1);
								$retval[]     = strlen($this->_toString(0, $tksParameter));
								$lastCursor   = $parser->getCursor();
							}
							else {
								$child->data .= str_repeat(' ', $add[$commaCnt]);
							}
							break;

						case '(':
							$parser->scanToCloseParenthesis();
							break;

						case ')':
							return $retval;

						default:
							break;
					}
			}
		}

		return $retval;
	} /*}}}*/

	public function isOneMoreNewLine() /*{{{*/
	{
		if (count($this->children) <= 0) {
			return false;
		}

		return (strpos($this->children[count($this->children)-1]->data, "\n\n") !== false);
	} /*}}}*/

	public function isNoneNewLine() /*{{{*/
	{
		if (count($this->children) <= 0) {
			return true;
		}

		return (strpos($this->children[count($this->children)-1]->data, "\n") === false);
	} /*}}}*/
}
?>
