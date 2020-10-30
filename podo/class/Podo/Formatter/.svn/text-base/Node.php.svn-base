<?php
class Podo_Formatter_Node
{
	protected $depth    = 0;
	protected $children = array();

	public function setChildren(array $nodes) /*{{{*/
	{
		$this->children = $nodes;
	} /*}}}*/

	public function toString($depth) /*{{{*/
	{
		return $this->toStringOf($depth, $this->children);
	} /*}}}*/

	protected function toStringOf($depth, array $tokens, $glue = '') /*{{{*/
	{
		$this->_setPattern($tokens);

		$arrStr = array();
		foreach ($tokens as $child) {
			$arrStr[] = $child->toString($depth);
		}

		for ($i=1; $i<count($arrStr); $i++) {
			// Statement 사이에 New Line 이나 Space 문자가 없는 경우에는
			// 중간에 Space 문자를 삽입해준다.
			if (rtrim($arrStr[$i-1]) === $arrStr[$i-1] && ltrim($arrStr[$i]) === $arrStr[$i]) {
				$arrStr[$i-1] .= ' ';
			}
		}

		return preg_replace("/\n[ \t]+\n/", "\n\n", join($glue, $arrStr));
	} /*}}}*/

	const PATTERN_ASSIGN  = 1;
	const PATTERN_COMMENT = 2;
	const PATTERN_FUNC_1  = 11;
	const PATTERN_FUNC_2  = 12;
	const PATTERN_FUNC_3  = 13;
	const PATTERN_FUNC_4  = 14;

	private function _setPattern($tokens) /*{{{*/
	{
		$this->_setPatternAssign($tokens);
		$this->_setPatternComment($tokens);
		$this->_setPatternFunction($tokens);
	} /*}}}*/

	private function _setPatternAssign($tokens) /*{{{*/
	{
		$tks = array();
		$p1  = array();

		foreach ($tokens as $key=>$token) {
			if ($token instanceof Podo_Formatter_Node_Statement
			        && ($res = $token->isPatternAssign()) !== false) {
				$tks[] = $token;
				$p1[]  = $res;
			}

			if (count($tks) > 0) {
				// 패턴이 끝났거나 마지막 토큰이거나
				// Statement 가 아닌 문장이 나타나거나
				// 현재 토큰이 두 줄 이상으로 되어있거나
				// 한 줄에 여러 Statement 가 나타난 경우
				// 한 그룹이 끝난 것으로 간주한다.
				if ($res === false
				        || count($tokens)-1 == $key
				        || !($token instanceof Podo_Formatter_Node_Statement)
				        || $token->isOneMoreNewLine()
				        || $token->isNoneNewLine()) {
					if (count($tks) > 1) {
						$max = max($p1);
						foreach ($tks as $k=>$tk) {
							$tk->isPatternAssign($max-$p1[$k]);
						}
					}

					$tks = array();
					$p1  = array();
				}
			}
		}
	} /*}}}*/

	private function _setPatternComment($nodes) /*{{{*/
	{
		$tks = array();
		$p1  = array();

		foreach ($nodes as $key=>$node) {
			if ($node instanceof Podo_Formatter_Node_Statement
			        && ($res = $node->isPatternComment()) !== false) {
				if ($res == 0) {
					if ($key > 0
					        && (!($nodes[$key-1] instanceof Podo_Formatter_Node_Statement) || $nodes[$key-1]->isOneMoreNewLine())
					        || count($tks) <= 0) {
						$res = false;
					}
				}

				if ($res !== false) {
					$tks[] = $node;
					$p1[]  = $res;
				}
			}

			if (count($tks) > 0) {
				// 패턴이 끝났거나 마지막 토큰이거나
				// Statement 가 아닌 문장이 나타나거나
				// 한 줄에 여러 Statement 가 나타난 경우
				// 한 그룹이 끝난 것으로 간주한다.
				if ($res === false
				        || count($nodes)-1 == $key
				        || !($node instanceof Podo_Formatter_Node_Statement)
				        || $node->isNoneNewLine()) {
					if (count($tks) > 1) {
						$max = max($p1);
						foreach ($tks as $k=>$tk) {
							$tk->isPatternComment($max-$p1[$k]);
						}
					}

					$tks = array();
					$p1  = array();
				}
			}
		}
	} /*}}}*/

	private function _applyPatternFunction($tokens, $results) /*{{{*/
	{
		if (count($results) <= 1) {
			return;
		}

		$pos = array();
		$max = array();
		for ($i=1; $i<count($results[0]); $i++) {
			for ($j=0; $j<count($results); $j++) {
				$pos[$i][$j] = $results[$j][$i];
			}
		}

		for ($i=1; $i<count($results[0]); $i++) {
			$max[$i] = max($pos[$i]);
		}

		for ($i=0; $i<count($results); $i++) {
			$diff = array();
			for ($j=1; $j<count($results[0]); $j++) {
				$diff[$j] = $max[$j] - $results[$i][$j];
			}

			$tokens[$i]->isPatternFunction($diff);
		}
	} /*}}}*/

	private function _setPatternFunction($tokens) /*{{{*/
	{
		$tks = array();
		$p1  = array();

		$currToken  = null;
		$currResult = null;
		foreach ($tokens as $key=>$token) {
			if ($token instanceof Podo_Formatter_Node_Statement
			        && count($res = $token->isPatternFunction()) > 1) {
				$currToken  = $token;
				$currResult = $res;
			}
			else {
				$currToken  = null;
				$currResult = null;
			}

			if ($currToken !== null
			        && (count($p1) <= 0 || ($currResult[0] === $p1[0][0]
			                                && count($currResult) === count($p1[0])))) {
				$tks[] = $currToken;
				$p1[]  = $currResult;

				if (count($tokens)-1 == $key
				        || $token->isOneMoreNewLine()
				        || $token->isNoneNewLine()) {
					$this->_applyPatternFunction($tks, $p1);

					$tks = array();
					$p1  = array();
				}
			}
			else {
				$this->_applyPatternFunction($tks, $p1);

				if ($currResult === null) {
					$tks = array();
					$p1  = array();
				}
				else {
					$tks = array($currToken);
					$p1  = array($currResult);
				}
			}
		}
	} /*}}}*/
}
?>
