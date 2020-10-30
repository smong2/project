<?php
class DBCacheServ extends BaseObject 
{
	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk, ConfigManager::get('DBCache_Info.Host'));
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	public function __construct()
	{
		$cache = new SimpleDBCache();
		$cache->connect(ConfigManager::get('DBCache_Info.Host'), 0, 0);

		return $cache;
	}

}
