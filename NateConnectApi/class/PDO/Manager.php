<?php
class PDO_Manager
{
	/**
	 * @example $pdo = PDO_Manager::getConnectDB();
	 *
	 * @return PDO
	 */
	public static function getConnectDB() /*{{{*/
	{
		static $sInstance;

		if (isset($sInstance) === false) {
			if (ConfigManager::get('DBGate.disable', false)) {
				$sInstance = new PDO('dblib:host='.ConfigManager::get('connecting.db.service.ip').':3673;dbname=NC_SERVICE', ConfigManager::get('connecting.db.service.id'), ConfigManager::get('connecting.db.service.pwd'));
			}
			else {
				$sInstance = PDO_MSSQL::instance('CN101');
			}
		}

		return $sInstance;
	} /*}}}*/

	/**
	 * @example $pdo = PDO_Manager::getBuddyDB();
	 *
	 * @return PDO
	 */
	public static function getBuddyDB() /*{{{*/
	{
		static $sInstance;

		if (isset($sInstance) === false) {
			if (ConfigManager::get('DBGate.disable', false)) {
				$sInstance = new PDO('dblib:host='.ConfigManager::get('connecting.db.buddy.ip').':3673;dbname=NC_BUDDY', ConfigManager::get('connecting.db.buddy.id'), ConfigManager::get('connecting.db.buddy.pwd'));
			}
			else {
				$sInstance = PDO_MSSQL::instance('CN101');
			}
		}

		return $sInstance;
	} /*}}}*/
}
?>
