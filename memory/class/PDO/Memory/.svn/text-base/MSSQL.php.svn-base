<?php
class PDO_Memory_MSSQL extends PDO_Memory
{
	public static function instance($dbid) /*{{{*/
	{
		static $sInstance = array();

		if (isset($sInstance[$dbid]) === false) {
			$sInstance[$dbid] = new PDO_Memory_MSSQL($dbid, ConfigManager::get('DBGate.mssql.ip'), ConfigManager::get('DBGate.mssql.port'), 'PDO_DBGate_MSSQL');
		}

		return $sInstance[$dbid];
	} /*}}}*/

	public function __construct($dbid, $ip, $port, $driver) /*{{{*/
	{
		parent::__construct($dbid, $ip, $port, $driver);
		$this->setAttribute(PDO_DBGate::ATTR_CHARSET_IN,  'cp949');
		$this->setAttribute(PDO_DBGate::ATTR_CHARSET_OUT, 'utf-8');
	} /*}}}*/
}
?>
