<?php
class PDO_MSSQL extends PDO
{
	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk, ConfigManager::get('DBGate.mssql.ip'), ConfigManager::get('DBGate.mssql.port'), 'PDO_DBGate_MSSQL');
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	public function __construct($dbid, $ip = null, $port = null, $driver = null) /*{{{*/
	{
		$dsn = 'user:driver=' . $driver . ';ip=' . $ip . ';port=' . $port . ';dbid=' . $dbid;
		parent::__construct($dsn);

		if (isset($_REQUEST['action'])) {
			$this->setAttribute(PDO_DBGate::ATTR_LOG_SCRIPTNAME, $_REQUEST['action']);
		}
		else {
			$this->setAttribute(PDO_DBGate::ATTR_LOG_SCRIPTNAME, $_SERVER['SCRIPT_FILENAME']);
		}

		$this->setAttribute(PDO_DBGate::ATTR_CHARSET_IN, 'cp949');
		$this->setAttribute(PDO_DBGate::ATTR_CHARSET_OUT, ConfigManager::get('Podo.charset'));

		$this->setAttribute(PDO_DBGate::ATTR_LOG_PREPARE_ENABLE, ConfigManager::get('DBGate.log.prepare.enable'));
		$this->setAttribute(PDO_DBGate::ATTR_LOG_EXECUTE_ENABLE, ConfigManager::get('DBGate.log.execute.enable'));
		$this->setAttribute(PDO_DBGate::ATTR_LOG_ERROR_ENABLE,   ConfigManager::get('DBGate.log.error.enable'));

		$strPrepareFilePath = ConfigManager::get('DBGate.log.prepare.filepath');
		if (ConfigManager::get('DBGate.log.prepare.postfix', false)) {
			$strPrepareFilePath .= '.' . date(ConfigManager::get('DBGate.log.prepare.postfix'));
		}

		$strExecuteFilePath = ConfigManager::get('DBGate.log.execute.filepath');
		if (ConfigManager::get('DBGate.log.execute.postfix', false)) {
			$strExecuteFilePath .= '.' . date(ConfigManager::get('DBGate.log.execute.postfix'));
		}

		$strErrorFilePath = ConfigManager::get('DBGate.log.error.filepath');
		if (ConfigManager::get('DBGate.log.error.postfix', false)) {
			$strErrorFilePath .= '.' . date(ConfigManager::get('DBGate.log.error.postfix'));
		}

		$this->setAttribute(PDO_DBGate::ATTR_LOG_PREPARE_FILEPATH, $strPrepareFilePath);
		$this->setAttribute(PDO_DBGate::ATTR_LOG_EXECUTE_FILEPATH, $strExecuteFilePath);
		$this->setAttribute(PDO_DBGate::ATTR_LOG_ERROR_FILEPATH,   $strErrorFilePath);

		$this->setAttribute(PDO_DBGate::ATTR_TIMEOUT, 1);
	} /*}}}*/
}
?>
