<?php
class Podo_Util_String
{
	const TOSTRING_MAXSIZE = 4096;

	public static function startWith($str, $mixWith) /*{{{*/
	{
		if (is_array($mixWith)) {
			foreach ($mixWith as $strWith) {
				if (substr($str, 0, strlen($strWith)) === $strWith) {
					return true;
				}
			}

			return false;
		}
		else {
			return (substr($str, 0, strlen($mixWith)) === $mixWith);
		}
	} /*}}}*/

	public static function startsWith($str, $mixWith) /*{{{*/
	{
		return self::startWith($str, $mixWith);
	} /*}}}*/

	public static function endWith($str, $mixWith) /*{{{*/
	{
		if (is_array($mixWith)) {
			foreach ($mixWith as $strWith) {
				if (substr($str, strlen($strWith)*-1) === $strWith) {
					return true;
				}
			}

			return false;
		}
		else {
			return (substr($str, strlen($mixWith)*-1) === $mixWith);
		}
	} /*}}}*/

	public static function endsWith($str, $mixWith) /*{{{*/
	{
		return self::endWith($str, $mixWith);
	} /*}}}*/

	public static function toString($mixVar, $isHtml = false) /*{{{*/
	{
		static $sIntVarNo = 0;

		$sIntVarNo++;

		if ($mixVar === null) {
			return 'NULL';
		}

		if (is_bool($mixVar)) {
			if ($mixVar === true) {
				return 'TRUE';
			}
			else {
				return 'FALSE';
			}
		}

		if (is_int($mixVar) || is_float($mixVar)) {
			return $mixVar;
		}

		if (is_object($mixVar) || is_array($mixVar)) {
			$text = print_r($mixVar, true);
			if (strlen($text) > self::TOSTRING_MAXSIZE) {
				if (is_object($mixVar)) {
					return get_class($mixVar) . ' object (too big!!)';
				}
				else {
					return 'Array (too big!!)';
				}
			}

			$arrLine = explode("\n", $text);

			if ($isHtml === true) {
				$arrLine = array_map('htmlspecialchars', $arrLine);

				$intLineLength = sizeof($arrLine);

				for ($i=0; $i<$intLineLength; $i++) {
					$strLine = trim($arrLine[$i]);

					if ($strLine === '(') {
						$sIntVarNo++;

						$arrLine[$i-1] = '<span style="cursor:pointer; color:blue; text-decoration:none;" onclick="if (document.getElementById(\'podo_string_a1_' . $sIntVarNo . '\').style.display == \'none\') { document.getElementById(\'podo_string_a1_' . $sIntVarNo . '\').style.display = \'\'; document.getElementById(\'podo_string_a2_' . $sIntVarNo . '\').style.display = \'none\'; } else { document.getElementById(\'podo_string_a1_' . $sIntVarNo . '\').style.display = \'none\'; document.getElementById(\'podo_string_a2_' . $sIntVarNo . '\').style.display = \'\'; } event.cancelBubble = true; return false;">' . ltrim($arrLine[$i-1]);
						$arrLine[$i]   = '(<span id="podo_string_a1_' . $sIntVarNo . '" style="display:;">...</span><span id="podo_string_a2_' . $sIntVarNo . '" style="display:none;">';
					}
					else if ($strLine === ')') {
						$arrLine[$i]   = '</span>)';
						$arrLine[$i+1] = '</span>';
					}
				}

				foreach ($arrLine as $intKey=>&$strLine) {
					$strLine = ltrim($strLine);
					if (isset($arrLine[$intKey+1]) && (preg_match('/\[.*\] =&gt;.*/', $strLine) || $strLine === '</span>')
					        && preg_match('/\[.*\] =&gt;.*/', $arrLine[$intKey+1])) {
						$strLine .= ', ';
					}
				}
			}
			else {
				foreach ($arrLine as $intKey=>&$strLine) {
					$strLine = ltrim($strLine);
					if (isset($arrLine[$intKey+1]) && (preg_match('/\[.*\] =>.*/', $strLine) || $strLine === '')
					        && preg_match('/\[.*\] =>.*/', $arrLine[$intKey+1])) {
						$strLine .= ', ';
					}
				}
			}

			return join(' ', $arrLine);
		}

		// String
		if ($isHtml === true) {
			if (strlen($mixVar) > 30) {
				$retval = '';
				$retval .= '<a id="podo_string_s1_' . $sIntVarNo . '" href="#" onclick="document.getElementById(\'podo_string_s2_' . $sIntVarNo . '\').style.display=\'\'; document.getElementById(\'podo_string_s1_' . $sIntVarNo . '\').style.display=\'none\'; return false;" style="cursor:pointer; color:blue; text-decoration:none; display:;">';
				$retval .= htmlspecialchars('\''.str_replace('\'', '\\\'', mb_substr($mixVar, 0, 27)).'...\'');
				$retval .= '</a>';
				$retval .= '<a id="podo_string_s2_' . $sIntVarNo . '" href="#" onclick="document.getElementById(\'podo_string_s1_' . $sIntVarNo . '\').style.display=\'\'; document.getElementById(\'podo_string_s2_' . $sIntVarNo . '\').style.display=\'none\'; return false;" style="cursor:pointer; color:blue; text-decoration:none; display:none;">';
				$retval .= htmlspecialchars('\''.str_replace('\'', '\\\'', $mixVar).'\'');
				$retval .= '</a>';

				return $retval;
			}
			else {
				return htmlspecialchars('\''.str_replace('\'', '\\\'', $mixVar).'\'');
			}
		}
		else {
			return '\'' . str_replace('\'', '\\\'', $mixVar) . '\'';
		}
	} /*}}}*/

	public static function cutString($pStr, $len, $pSuffix = '') /*{{{*/
	{
		if (strlen($pStr) <= $len) {
			return $pStr;
		}
		$str = substr($pStr, 0, $len);
		$cnt = 0;
		for ($i=0; $i<strlen($str); $i++) {
			if (ord($str[$i]) > 127) {
				$cnt++;
			}
		}
		$str = substr($str, 0, $len-($cnt%3)) . $pSuffix;

		return $str;
	} /*}}}*/

	/**
	 * word_word 의 단어를 WordWord 의 형식으로 변환한다.
	 */
	public static function capitalize($str) /*{{{*/
	{
		$arrWord = explode('_', $str);
		foreach ($arrWord as &$value) {
			$value[0] = strtoupper($value[0]);
		}
		return implode('', $arrWord);
	} /*}}}*/
}
?>
