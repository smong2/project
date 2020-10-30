<?php
class Podo_Util_Debugger
{
	public static function getTraceText($arrTrace = null, $isHtml = false) /*{{{*/
	{
		if ($arrTrace === null) {
			$arrTrace = self::_filterTrace(debug_backtrace(), $isHtml);
		}
		else {
			$arrTrace = self::_filterTrace($arrTrace, $isHtml);
		}

		$arrText = array();

		if ($isHtml) {
			$arrText[] = '<p><strong>CALL STACK:</strong>';
			$arrText[] = '<ol style="margin-top:10px; margin-left:40px;">';
			foreach ($arrTrace as $dictTrace) {
				$arrText[] = '<li>'.$dictTrace['content'].' <i>called at</i> <strong>'.$dictTrace['file'].'</strong> <i>on line</i> <strong>'.$dictTrace['line'].'</strong></li>';
			}
			$arrText[] = '</ol></p>';
		}
		else {
			foreach ($arrTrace as $intNo=>$dictTrace) {
				$arrText[] = '#'.$intNo.'  '.$dictTrace['content'].' called at ['.$dictTrace['file'].':'.$dictTrace['line'].']';
			}
		}

		return join("\n", $arrText);
	} /*}}}*/

	protected static function _filterTrace(array $arrTrace, $isHtml = false) /*{{{*/
	{
		$retval = array();

		foreach ($arrTrace as $intNo=>$dictTrace) {
			// self function
			if ($intNo == 0) {
				continue;
			}

			// self class
			if (isset($dictTrace['class']) === true && in_array($dictTrace['class'], array('Podo_System_ErrorHandler', 'Podo_Util_Debugger'))) {
				continue;
			}

			// trigger_error()
			if (isset($dictTrace['class']) === false &&
			        in_array($dictTrace['function'], array('trigger_error', 'errorHandle'))) {
				continue;
			}

			// get strContent
			$strContent = '';
			if (isset($dictTrace['class'])) {
				$strContent .= $dictTrace['class'].$dictTrace['type'];
			}
			$strContent .= $dictTrace['function'].'(';
			if (isset($dictTrace['args']) && count($dictTrace['args']) > 0) {
				$arrArgs = array();
				foreach ($dictTrace['args'] as $strArgs) {
					$arrArgs[] = Podo_Util_String::toString($strArgs, $isHtml);
				}
				$strContent .= join(', ', $arrArgs);
			}
			$strContent .= ')';

			$dictReturn['content'] = $strContent;

			// get file and line info
			if (isset($dictTrace['file'])) {
				$strFile = $dictTrace['file'];
				if (Podo_Util_String::startWith($strFile, ConfigManager::get('Podo.basedir'))) {
					$strFile = substr($strFile, strlen(ConfigManager::get('Podo.basedir'))+1);
				}
				$dictReturn['file'] = $strFile;
				$dictReturn['line'] = $dictTrace['line'];
			}
			else {
				$dictReturn['file'] = '';
				$dictReturn['line'] = 0;
			}

			// add return info
			$retval[] = $dictReturn;
		}

		return $retval;
	} /*}}}*/
}
?>
