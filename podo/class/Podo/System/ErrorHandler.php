<?php
class_exists('cyt_config');
class_exists('Podo_Template');

if (class_exists('Logger', false) === false) {
	require_once dirname(__FILE__) . '/../../Logger.php';
}

if (defined('E_RECOVERABLE_ERROR') === false) {
	define('E_RECOVERABLE_ERROR', 4096);
}

/**
 * @desc Error Handler
 * 
 * @package catz
 * @author Jonghun Shin <teeroz@nate.com>
 */
class Podo_System_ErrorHandler
{
	static private $_isManaging = false;

	/********************************************************************** 
	 *****   REQUIRE AREA WHEN INHERIT THIS   ***************************** 
	 **********************************************************************/

	public static function instance() /*{{{*/
	{
		$strClassName = __CLASS__;
		return new $strClassName();
	} /*}}}*/

	public static function handle($errno, $errstr, $errfile, $errline) /*{{{*/
	{
		self::instance()->manage($errno, $errstr, $errfile, $errline);
	} /*}}}*/

	/********************************************************************** 
	 *****   PUBLIC AREA   ************************************************ 
	 **********************************************************************/

	const E_EXCEPTION  = 8192;
	const E_SOAP_ERROR = 16384;

	protected $_errno    = 0;
	protected $_errstr   = '';
	protected $_errfile  = '';
	protected $_errline  = 0;
	protected $_arrTrace = array();

	public function manage($errno, $errstr, $errfile, $errline, $arrTrace = null, $isDontExit = false) /*{{{*/
	{
		if (self::$_isManaging) {
			return;
		}

		self::$_isManaging = true;

		$this->_errno    = $errno;
		$this->_errstr   = $errstr;
		$this->_errfile  = $errfile;
		$this->_errline  = $errline;
		$this->_arrTrace = $arrTrace;

		if ($this->_errno === self::E_SOAP_ERROR) {
			if (ConfigManager::get(__CLASS__.'.show.enable', true)) {
				echo $this->_errstr;
			}
		}
		else {
			$this->_errfile = Podo_Template::getErrorTpl($this->_errfile);

			if (basename($this->_errfile) === 'mssql.class.php' && $this->_errno !== E_USER_ERROR) {
				self::$_isManaging = false;
				return;
			}

			if (basename($this->_errfile) === 'DBGClient.class.php' && $this->_errno !== E_USER_ERROR) {
				self::$_isManaging = false;
				return;
			}

			if ($this->_isEnableLevel(ConfigManager::get(__CLASS__.'.logger.level', 'WARNING'))) {
				$this->logErrorToLogger();
			}

			if ($this->_isEnableLevel(ConfigManager::get(__CLASS__.'.show.level', 'NOTICE'))) {
				$this->showError();
			}
		}

		if ($isDontExit == false && $this->_isEnableLevel(ConfigManager::get(__CLASS__.'.exit.level', 'ERROR'))) {
			self::$_isManaging = false;
			exit;
		}

		self::$_isManaging = false;
	} /*}}}*/

	/********************************************************************** 
	 *****   PROTECTED AREA   ********************************************* 
	 **********************************************************************/

	private static $_strErrType = array(
	    E_WARNING => 'Warning',
	    E_NOTICE => 'Notice',
	    E_USER_ERROR => 'User Error',
	    E_USER_WARNING => 'User Warning',
	    E_USER_NOTICE => 'User Notice',
	    E_STRICT => 'Strict Standards',
	    E_RECOVERABLE_ERROR => 'Fatal Error',
	    self::E_SOAP_ERROR => 'Soap Server Error',
	    self::E_EXCEPTION => 'Exception Raised'
	);

	/**
	 * @return bool
	 */
	public static function isScript() /*{{{*/
	{
		if (isset($_SERVER['SERVER_SOFTWARE']) === false ||
		        Podo_Util_String::startWith($_SERVER['SERVER_SOFTWARE'], 'Apache') === false) {
			return true;
		}

		return false;
	} /*}}}*/

	public static function getErrorType($errno) /*{{{*/
	{
		if (isset(self::$_strErrType[$errno])) {
			return self::$_strErrType[$errno];
		}
		else {
			return 'Unknown Error';
		}
	}/*}}}*/

	protected function _getTraceText($isHtml = false) /*{{{*/
	{
		if ($this->_arrTrace === null) {
			$arrTrace = $this->_filterTrace(debug_backtrace(), $isHtml);
		}
		else {
			$arrTrace = $this->_filterTrace($this->_arrTrace, $isHtml);
		}

		$arrText = array();

		if ($isHtml) {
			$arrText[] = '<p><strong>CALL STACK:</strong>';
			$arrText[] = '<ol style="margin-top:10px; margin-left:40px;">';
			foreach ($arrTrace as $dictTrace) {
				$arrText[] = '<li>' . $dictTrace['content'] . ' <i>called at</i> <strong>' . $dictTrace['file'] . '</strong> <i>on line</i> <strong>' . $dictTrace['line'] . '</strong></li>';
			}
			$arrText[] = '</ol></p>';
		}
		else {
			foreach ($arrTrace as $intNo=>$dictTrace) {
				$arrText[] = '#' . $intNo . '  ' . $dictTrace['content'] . ' called at [' . $dictTrace['file'] . ':' . $dictTrace['line'] . ']';
			}
		}

		return join("\n", $arrText);
	} /*}}}*/

	protected function _filterTrace(array $arrTrace, $isHtml = false) /*{{{*/
	{
		$retval = array();

		foreach ($arrTrace as $intNo=>$dictTrace) {
			// self function
			if ($intNo == 0) {
				continue;
			}

			// self class
			if (isset($dictTrace['class']) === true && in_array($dictTrace['class'], array(__CLASS__))) {
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
				$strContent .= $dictTrace['class'] . $dictTrace['type'];
			}
			$strContent .= $dictTrace['function'] . '(';
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

	protected function _isEnableLevel($strLevel) /*{{{*/
	{
		switch ($strLevel) {
			case 'ALL':
			case 'STRICT':
				if (defined(E_STRICT) && ($this->_errno & E_STRICT)) {
					return true;
				}

			case 'NOTICE':
				if ($this->_errno & (E_NOTICE | E_USER_NOTICE)) {
					return true;
				}

			case 'WARNING':
				if ($this->_errno & (E_WARNING | E_USER_WARNING | self::E_SOAP_ERROR | self::E_EXCEPTION)) {
					return true;
				}

			case 'ERROR':
				if ($this->_errno & (E_USER_ERROR | E_RECOVERABLE_ERROR)) {
					return true;
				}

			default:
			case 'NONE':
				return false;
		}
	} /*}}}*/

	protected function logErrorToLogger() /*{{{*/
	{
		Logger::log(ConfigManager::get(__CLASS__.'.logger.name', 'debug'), 0, self::$_strErrType[$this->_errno].': '.$this->_errstr .' in '.$this->_errfile .' on line '.$this->_errline ."\n");
		if (ConfigManager::get(__CLASS__.'.trace.enable', false)) {
			Logger::log(ConfigManager::get(__CLASS__.'.logger.name', 'debug'), 0, $this->_getTraceText()."\n");
		}
	} /*}}}*/

	protected function showError() /*{{{*/
	{
		if (self::isScript()) {
			echo self::$_strErrType[$this->_errno] . ': ' . $this->_errstr . ' in ' . $this->_errfile . ' on line ' . $this->_errline . "\n\n";
		}
		else {
			echo '<p><strong>' . self::$_strErrType[$this->_errno] . '</strong>: ' . htmlspecialchars($this->_errstr) . ' <i>in</i> <strong>' . $this->_errfile . '</strong> <i>on line</i> <strong>' . $this->_errline . "</strong></p>\n";
		}

		if (ConfigManager::get(__CLASS__.'.trace.enable', false)) {
			echo $this->_getTraceText(!(self::isScript())) . "\n";
		}
	} /*}}}*/
}
?>
