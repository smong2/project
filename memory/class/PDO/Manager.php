<?php
class PDO_Manager
{
	/**
	 * @example 
	 * $pdo = PDO_Manager::getMemoryDB();
	 */
	public static function getMemoryDB() /*{{{*/
	{
		static $sInstance;

		if (isset($sInstance) === false) {
			if (ConfigManager::get('DBGate.disable', false)) {
				$sInstance = new PDO('mysql:host=192.168.248.155;port=3306;dbname=memory', 'memory', 'rldjrsk');
			}
			else {
				$sInstance = PDO_Memory_MySQL::instance('MEM01');
			}
		}
		
		return $sInstance;
	} /*}}}*/
}
?>
