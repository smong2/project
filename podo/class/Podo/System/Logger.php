<?php
if (class_exists('Podo_Util_String', false) === false) {
	require_once dirname(__FILE__).'/../Util/String.php';
}

if (class_exists('Podo_Util_File', false) === false) {
	require_once dirname(__FILE__).'/../Util/File.php';
}

class Podo_System_Logger
{
	protected $_strLogName;
	protected $_strLog = '';
	protected $_dictTime;

	public static function log() /*{{{*/
	{
		$arrArg      = func_get_args();
		$strLogName  = $arrArg[0];
		$intLogLevel = $arrArg[1];
		$arrParam    = array_slice($arrArg, 2);

		if (self::_isEnable($strLogName, $intLogLevel) === false) {
			return;
		}

		self::instance($strLogName)->_log($intLogLevel, $arrParam);
	} /*}}}*/

	public static function debug() /*{{{*/
	{
		$arrParam = func_get_args();

		if (self::_isEnable('debug', 0) === false) {
			return;
		}

		self::instance('debug')->_log(0, $arrParam);
	} /*}}}*/



	public static function instance($strLogName) /*{{{*/
	{
		static $sArrInstance;

		if (isset($sArrInstance[$strLogName]) === false) {
			$strClassName              = __CLASS__;
			$sArrInstance[$strLogName] = new $strClassName($strLogName);
		}

		return $sArrInstance[$strLogName];
	} /*}}}*/

	protected function __construct($strLogName) /*{{{*/
	{
		if ($this->_isEnable($strLogName, 0) === false) {
			return;
		}

		$this->_strLogName = $strLogName;

		if (self::_getConfigValue($this->_strLogName, 'print.execinfo', false)) {
			$this->_logFileInfo();
		}
	} /*}}}*/

	public function __destruct() /*{{{*/
	{
		if ($this->_isEnable($this->_strLogName, 0) === false) {
			return;
		}

		if (self::_getConfigValue($this->_strLogName, 'print.execinfo', false)) {
			$this->_logElapsedTime();
		}

		if (self::_getConfigValue($this->_strLogName, 'flush', false) === false) {
			$this->_flush($this->_strLog);
		}
	} /*}}}*/

	protected function _log($intLogLevel, array $arrArg) /*{{{*/
	{
		if (self::_isEnable($this->_strLogName, $intLogLevel) === false) {
			return;
		}

		foreach ($arrArg as &$mixArg) {
			if (is_object($mixArg) || is_array($mixArg)) {
				$mixArg = print_r($mixArg, true);
			}

			if ($intLogLevel >= 1) {
				$mixArg = '['.$this->_strLogName.':'.$intLogLevel.'] '.$mixArg;
				$mixArg = str_replace("\n", "\n".str_repeat(' ', strlen($this->_strLogName)+3), $mixArg);
			}
		}

		$strLog = join("\n", $arrArg)."\n";

		if (self::_getConfigValue($this->_strLogName, 'print.callstack')) {
			$strLog .= "This log is called in \n".Podo_Util_Debugger::getTraceText()."\n";
		}

		if (self::_getConfigValue($this->_strLogName, 'flush', false)) {
			$this->_flush($strLog);
		}
		else {
			$this->_strLog .= $strLog;
		}
	} /*}}}*/

	protected function _flush($strLog) /*{{{*/
	{
		$strFile = self::_getConfigValue($this->_strLogName, 'file', '/tmp/debug.log');

		Podo_Util_File::touch($strFile, 0666, 0777);

		if (filesize($strFile) > self::_getConfigValue($this->_strLogName, 'file.maxsize', 10*1024*1024)) {
			@file_put_contents($strFile, "-- it is up to maxsize. so, it is remaked. --\n");
		}

		@file_put_contents($strFile, $strLog, FILE_APPEND);
	} /*}}}*/

	protected function _logFileInfo() /*{{{*/
	{
		$this->_dictTime['tot'] = microtime(true);

		if (PHP_OS !== 'WINNT') {
			$dictResUsage           = getrusage();
			$this->_dictTime['usr'] = $dictResUsage['ru_utime.tv_sec'] + $dictResUsage['ru_utime.tv_usec'] / 1000000;
			$this->_dictTime['sys'] = $dictResUsage['ru_stime.tv_sec'] + $dictResUsage['ru_stime.tv_usec'] / 1000000;
		}

		if (isset($_SERVER['SCRIPT_NAME'])) {
			$this->_log(0, array('', substr('===== ['.$_SERVER['SCRIPT_NAME'].' '.date('H:i:s').'] ============================================================', 0, 120)));
		}
		else if (isset($_SERVER['argv'])) {
			$this->_log(0, array('', substr('===== ['.$_SERVER['argv'][0].' '.date('H:i:s').'] ============================================================', 0, 120)));
		}
		$this->_log(0, array(''));
	} /*}}}*/

	protected function _logElapsedTime() /*{{{*/
	{
		$dictElapsed['tot'] = number_format((microtime(true)-$this->_dictTime['tot'])*1000, 2);

		if (PHP_OS !== 'WINNT') {
			$dictResUsage             = getrusage();
			$dblUsrTime               = $dictResUsage['ru_utime.tv_sec'] + $dictResUsage['ru_utime.tv_usec'] / 1000000;
			$dblSysTime               = $dictResUsage['ru_stime.tv_sec'] + $dictResUsage['ru_stime.tv_usec'] / 1000000;
			$dictElapsed['usr']       = number_format(($dblUsrTime-$this->_dictTime['usr'])*1000, 2);
			$dictElapsed['usrPerTot'] = number_format(($dictElapsed['usr']/$dictElapsed['tot'])*100, 1);
			$dictElapsed['sys']       = number_format(($dblSysTime-$this->_dictTime['sys'])*1000, 2);
			$dictElapsed['sysPerTot'] = number_format(($dictElapsed['sys']/$dictElapsed['tot'])*100, 1);

			$this->_log(0, array('', '..... Elapsed Time: TOTAL '.$dictElapsed['tot'].' msec, USR '.$dictElapsed['usr'].' msec ('.$dictElapsed['usrPerTot'].'%), SYS '.$dictElapsed['sys'].' msec ('.$dictElapsed['sysPerTot'].'%)'));
		}
		else {
			$this->_log(0, array('', '..... Elapsed Time: '.$dictElapsed['tot'].' msec'));
		}
	} /*}}}*/



	protected static function _getConfigValue($strLogName, $strConfigName, $mixDefaultValue = null) /*{{{*/
	{
		return ConfigManager::get(__CLASS__.'.logger.'.$strLogName.'.'.$strConfigName, ConfigManager::get(__CLASS__.'.default.'.$strConfigName, $mixDefaultValue));
	} /*}}}*/

	/**
	 * return whether debug option is enabled
	 * 
	 * @return bool
	 */
	protected static function _isEnable($strLogName, $intLogLevel) /*{{{*/
	{
		static $sArrCache = array();

		if (isset($sArrCache[$strLogName][$intLogLevel]) === false) {
			if (defined('PODO_LOG_ENABLE') && PODO_LOG_ENABLE == false ||
			        ConfigManager::get(__CLASS__.'.enable', false) == false ||
			        self::_getConfigValue($strLogName, 'enable', false) == false ||
			        self::_getConfigValue($strLogName, 'level', -1) < $intLogLevel) {
				$sArrCache[$strLogName][$intLogLevel] = false;
			}
			else {
				$sArrCache[$strLogName][$intLogLevel] = true;
			}
		}

		return $sArrCache[$strLogName][$intLogLevel];
	} /*}}}*/
}
?>
