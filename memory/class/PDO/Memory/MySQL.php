<?php
class PDO_Memory_MySQL extends PDO_Memory
{
	public static function instance($dbid) /*{{{*/
	{
		static $sInstance = array();

		if (isset($sInstance[$dbid]) === false) {
			$sInstance[$dbid] = new PDO_Memory_MySQL($dbid, ConfigManager::get('DBGate.mysql.ip'), ConfigManager::get('DBGate.mysql.port'), 'PDO_DBGate_MySQL');
		}

		return $sInstance[$dbid];
	} /*}}}*/

	public function __construct($dbid, $ip, $port, $driver) /*{{{*/
	{
		parent::__construct($dbid, $ip, $port, $driver);
	} /*}}}*/
}
?>
