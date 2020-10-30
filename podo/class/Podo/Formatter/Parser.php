<?php
class Podo_Formatter_Parser
{
	private $_cursor = 0;
	private $_tokens = array();

	public function setTokens(array $tokens) /*{{{*/
	{
		$this->_cursor = 0;
		$this->_tokens = $tokens;
	} /*}}}*/

	public function scan(array $type = array()) /*{{{*/
	{
		if (isset($this->_tokens[$this->_cursor])) {
			$token = $this->_tokens[$this->_cursor];
			$this->_cursor++;

			if (count($type) > 0 && in_array($token->type, $type) === false) {
				trigger_error('Podo_Formatter_Parser::scan() - 알 수 없는 문법입니다. [기대타입:'.join(', ', $type).', 결과타입:'.$token->type.']', E_USER_ERROR);
			}

			return $token;
		}

		if (count($type) > 0) {
			trigger_error('Podo_Formatter_Parser::scan() - 알 수 없는 문법입니다. [기대타입:'.join(', ', $type).', 결과타입:Not Found]', E_USER_ERROR);
		}

		return false;
	} /*}}}*/

	public function reset() /*{{{*/
	{
		$this->_cursor = 0;
	} /*}}}*/

	public function prev() /*{{{*/
	{
		if (isset($this->_tokens[$this->_cursor-2])) {
			return $this->_tokens[$this->_cursor-2];
		}
		else {
			return false;
		}
	} /*}}}*/

	public function next() /*{{{*/
	{
		if (isset($this->_tokens[$this->_cursor])) {
			return $this->_tokens[$this->_cursor];
		}
		else {
			return false;
		}
	} /*}}}*/

	public function unscan() /*{{{*/
	{
		if ($this->_cursor > 0) {
			$this->_cursor--;
			return true;
		}

		return false;
	} /*}}}*/

	public function scanUntil(array $type) /*{{{*/
	{
		$tokens = array();

		while ($token = $this->scan()) {
			if (in_array($token->type, $type)) {
				$this->unscan();
				break;
			}

			$tokens[] = $token;
		}

		return $tokens;
	} /*}}}*/

	public function scanUntilEnd() /*{{{*/
	{
		$retval = array();

		while ($token = $this->scan()) {
			$retval[] = $token;
		}

		return $retval;
	} /*}}}*/

	public function scanUntilCloseBrace() /*{{{*/
	{
		$tokens = array();

		$depth = 0;
		while ($token = $this->scan()) {
			switch ($token->type) {
				case '{':
					$depth++;
					break;

				case '}':
					if ($depth === 0) {
						$this->unscan();
						break 2;
					}
					else {
						$depth--;
					}
					break;
			}

			$tokens[] = $token;
		}

		return $tokens;
	} /*}}}*/

	public function scanUntilCloseParenthesis() /*{{{*/
	{
		$tokens = array();

		$depth = 0;
		while ($token = $this->scan()) {
			switch ($token->type) {
				case '(':
					$depth++;
					break;

				case ')':
					if ($depth === 0) {
						$this->unscan();
						break 2;
					}
					else {
						$depth--;
					}
					break;
			}

			$tokens[] = $token;
		}

		return $tokens;
	} /*}}}*/

	public function scanTo(array $type) /*{{{*/
	{
		$tokens = array();

		while ($token = $this->scan()) {
			$tokens[] = $token;

			if (in_array($token->type, $type)) {
				break;
			}
		}

		return $tokens;
	} /*}}}*/

	public function scanToCloseBrace($depth = 0) /*{{{*/
	{
		$tokens = array();

		while ($token = $this->scan()) {
			$tokens[] = $token;

			switch ($token->type) {
				case '{':
					$depth++;
					break;

				case '}':
					if ($depth === 0) {
						break 2;
					}
					else {
						$depth--;
					}
					break;
			}
		}

		return $tokens;
	} /*}}}*/

	public function scanToCloseParenthesis() /*{{{*/
	{
		$tokens = array();

		$depth = 0;
		while ($token = $this->scan()) {
			$tokens[] = $token;

			switch ($token->type) {
				case '(':
					$depth++;
					break;

				case ')':
					if ($depth === 0) {
						break 2;
					}
					else {
						$depth--;
					}
					break;
			}
		}

		return $tokens;
	} /*}}}*/

	public function exist(array $type) /*{{{*/
	{
		foreach ($this->_tokens as $token) {
			if (in_array($token->type, $type)) {
				return true;
			}
		}

		return false;
	} /*}}}*/

	public function getCursor() /*{{{*/
	{
		return $this->_cursor;
	} /*}}}*/



	public static function parseBlocks(array $tokens) /*{{{*/
	{
		$retval = array();

		$blocks = Podo_Formatter_Parser::explodeBlock($tokens);
		$parser = new Podo_Formatter_Parser;
		foreach ($blocks as $block) {
			$parser->setTokens($block);

			$token = $parser->scan();
			switch ($token->type) {
				case 'T_CLASS':
					$node = new Podo_Formatter_Node_Class;
					$node->parse($block);

					$retval[] = $node;
					break;

					/*
					case 'T_COMMENT':
					case 'T_DOC_COMMENT':
					case 'T_NEWLINE':
					$node = new Podo_Formatter_Node_Data;
					$node->setToken($token);

					$retval[] = $node;
					break;
					*/

				case 'T_SWITCH':
					$node = new Podo_Formatter_Node_Switch;
					$node->parse($block);

					$retval[] = $node;
					break;

				case 'T_FOREACH':
					$node = new Podo_Formatter_Node_Foreach;
					$node->parse($block);

					$retval[] = $node;
					break;

				case 'T_FOR':
					$node = new Podo_Formatter_Node_For;
					$node->parse($block);

					$retval[] = $node;
					break;

				case 'T_IF':
				case 'T_FOREACH':
				case 'T_ELSE':
				case 'T_ELSEIF':
					$node = new Podo_Formatter_Node_Control;
					$node->parse($block);

					$retval[] = $node;
					break;

				case 'T_WHILE':
					if ($parser->exist(array('{'))) {
						$node = new Podo_Formatter_Node_Control;
					}
					else {
						$node = new Podo_Formatter_Node_Statement;
					}
					$node->parse($block);
					$retval[] = $node;
					break;

				case 'T_ABSTRACT':
				case 'T_FINAL':
				case 'T_PUBLIC':
				case 'T_PROTECTED':
				case 'T_PRIVATE':
				case 'T_STATIC':
				case 'T_FUNCTION':
					if ($parser->exist(array('T_FUNCTION')) && $parser->exist(array('{'))) {
						$node = new Podo_Formatter_Node_Function;
						$node->parse($block);

						$retval[] = $node;
					}
					else {
						$parser->unscan();

						$tksDef = $parser->scanUntil(array('T_VARIABLE', 'T_FUNCTION'));
						$node   = new Podo_Formatter_Node_Definition;
						$node->parse($tksDef);
						$tksDef = $node->getTokens();
						// $retval[] = $node;

						$tksStmt = array_merge($tksDef, $parser->scanUntilEnd());
						$node    = new Podo_Formatter_Node_Statement;
						$node->parse($tksStmt);
						$retval[] = $node;
					}
					break;

				default:
					if ($parser->exist(array('{'))) {
						$parser->reset();
						$parser->scanTo(array('{'));
						$prev = $parser->prev();

						if ($prev === false || $prev->type !== 'T_OBJECT_OPERATOR') {
							$node = new Podo_Formatter_Node_Block;
						}
						else {
							$node = new Podo_Formatter_Node_Statement;
						}
					}
					else {
						$node = new Podo_Formatter_Node_Statement;
					}

					$node->parse($block);
					$retval[] = $node;

					break;
			}
		}

		return $retval;
	} /*}}}*/

	public static function removeMarkerComment(Podo_Formatter_Token $token) /*{{{*/
	{
		if (strpos($token->data, '{{{') === false && strpos($token->data, '}}}') === false) {
			return $token;
		}

		$t       = clone $token;
		$t->data = str_replace(array('{{{', '}}}'), '', $t->data);
		if (preg_match('/^(?:\/\*\s*\*\/|\/\/\s*)$/', $t->data)) {
			return null;
		}

		return $t;
	} /*}}}*/

	public static function extract(array $tokens, array $type) /*{{{*/
	{
		$retval = array();

		foreach ($tokens as $token) {
			if (in_array($token->type, $type)) {
				$retval[] = $token;
			}
		}

		return $retval;
	} /*}}}*/

	public static function remove(array $tokens, array $type) /*{{{*/
	{
		$retval = array();

		foreach ($tokens as $token) {
			if (in_array($token->type, $type) === false) {
				$retval[] = $token;
			}
		}

		return $retval;
	} /*}}}*/

	public static function explode(array $tokens, array $type) /*{{{*/
	{
		$retval = array();

		$buffer = array();
		foreach ($tokens as $token) {
			if (in_array($token->type, $type)) {
				$retval[] = $buffer;
				$buffer   = array();
				continue;
			}

			$buffer[] = $token;
		}
		$retval[] = $buffer;

		return $retval;
	} /*}}}*/

	public static function explodeBlock(array $tokens) /*{{{*/
	{
		$retval = array();

		$parser = new Podo_Formatter_Parser;
		$parser->setTokens($tokens);

		while ($token = $parser->scan()) {
			switch ($token->type) {
				case 'T_COMMENT':
				case 'T_DOC_COMMENT':
					$next = $parser->scan();

					if ($next !== false && $next->type === 'T_NEWLINE') {
						$retval[] = array($token, $next);
					}
					else {
						if ($next !== false) {
							$parser->unscan();
						}
						$retval[] = array($token);
					}
					break;

				case 'T_NEWLINE':
					$retval[] = array($token);
					break;

					/*
					case 'T_DO':
					// TODO: DO 처리 해줘야 함
					break;
					*/

				default:
					$parser->unscan();

					$block = array();
					while (true) {
						$block = array_merge($block, $parser->scanUntil(array(';', '(', '{')));

						$token = $parser->scan();

						if ($token === false) {
							break;
						}

						$block[] = $token;

						if ($token->type === ';') {
							break;
						}

						if ($token->type === '(') {
							$block = array_merge($block, $parser->scanToCloseParenthesis());
							continue;
						}

						if ($token->type === '{') {
							$block = array_merge($block, $parser->scanToCloseBrace());
							break;
						}
					}

					while ($token = $parser->scan()) {
						switch ($token->type) {
							case 'T_COMMENT':
							case 'T_DOC_COMMENT':
								$block[] = $token;
								break;

							case 'T_NEWLINE':
								$block[] = $token;
								break 2;

							default:
								$parser->unscan();
								break 2;
						}
					}

					$retval[] = $block;

					break;
			}
		}

		return $retval;
	} /*}}}*/

	public static function ltrim(array $tokens) /*{{{*/
	{
		if (count($tokens) <= 0) {
			return $tokens;
		}

		$retval = $tokens;
		if ($retval[0]->type === 'T_NEWLINE') {
			$retval = array_slice($retval, 1);
		}

		return $retval;
	} /*}}}*/

	public static function trim(array $tokens) /*{{{*/
	{
		if (count($tokens) <= 0) {
			return $tokens;
		}

		$retval = $tokens;
		if ($retval[0]->type === 'T_NEWLINE') {
			$retval = array_slice($retval, 1);
		}

		if (count($retval) > 0 && $retval[count($retval)-1]->type === 'T_NEWLINE') {
			$retval = array_slice($retval, 0, -1);
		}

		return $retval;
	} /*}}}*/
}
?>
