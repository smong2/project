<?php
if (class_exists('Podo_Util_String', false) === false) {
	require_once dirname(__FILE__).'/../Util/String.php';
}

/*
* ConfigManager
*      [Podo_System_Autoloader]
*      cache.file : file that have a list of classes
*      dirs : directories where there is classes
*      checkCache : default is FALSE
*
*  dependancy
*      ConfigManager
*      cyt
*/

/**
 * @desc class autoloader
 * 
 * @package catz
 * @author Shin Jonghun <teeroz@nate.com>
 */
class Podo_System_Autoloader
{
	/**
	 * @desc autoload class
	 * 
	 * @param string $strClassName name of class
	 * @return bool if success, then return TRUE, or return FALSE
	 */
	public static function autoload($strClassName) /*{{{*/
	{
		static $sIsCheckCache;

		if (isset($sIsCheckCache) === false) {
			$sIsCheckCache = ConfigManager::get(__CLASS__.'.cache.check', false);
		}

		self::_loadAutoloaderCache();

		if (defined(__CLASS__.'_Cache::x_'.$strClassName)) {
			$strClassFilePath = constant(__CLASS__.'_Cache::x_'.$strClassName);
			if ($sIsCheckCache === false || file_exists($strClassFilePath)) {
				ob_start();
				require_once $strClassFilePath;
				ob_end_clean();
				return true;
			}
		}

		$strRelativeFilePath = str_replace('_', DIRECTORY_SEPARATOR, $strClassName);

		$arrDir = ConfigManager::getArrayValue(__CLASS__.'.dirs', array());
		$arrExt = ConfigManager::getArrayValue(__CLASS__.'.ext', array('.class.php'));

		foreach ($arrDir as $strDir) {
			if (PHP_OS == 'WINNT') {
				$strDir = str_replace('/', DIRECTORY_SEPARATOR, $strDir);
			}

			foreach ($arrExt as $strExt) {
				$strAbsoluteFilePath = $strDir.DIRECTORY_SEPARATOR.$strRelativeFilePath.$strExt;

				if (file_exists($strAbsoluteFilePath)) {
					ob_start();
					require_once $strAbsoluteFilePath;
					ob_end_clean();

					if (PHP_OS == 'WINNT') {
						self::_checkCaseSensitive($strClassName);
					}

					self::_addAutoloaderList($strClassName, $strAbsoluteFilePath);

					return true;
				}
			}
		}

		return false;
	} /*}}}*/

	protected static function _createAutoloaderCacheClass() /*{{{*/
	{
		$strListFilePath = ConfigManager::get(__CLASS__.'.cache.file');

		if (file_exists(dirname($strListFilePath)) === false) {
			umask(0000);
			mkdir(str_replace('/', DIRECTORY_SEPARATOR, dirname($strListFilePath)), 0777, true);
		}

		$txtCode =
		           '<?php
    class '.__CLASS__.'_Cache {
    }
?>';
		file_put_contents($strListFilePath, $txtCode);
		chmod($strListFilePath, 0666);
	} /*}}}*/

	protected static function _loadAutoloaderCache() /*{{{*/
	{
		if (class_exists(__CLASS__.'_Cache', false) === false) {
			if (file_exists(ConfigManager::get(__CLASS__.'.cache.file')) === false) {
				self::_createAutoloaderCacheClass();
			}

			ob_start();
			require_once ConfigManager::get(__CLASS__.'.cache.file');
			ob_end_clean();
		}
	} /*}}}*/

	protected static function _addAutoloaderList($strAddClassName, $strAddFilePath) /*{{{*/
	{
		static $sArrClassConstant;

		if (isset($sArrClassConstant) === false) {
			$objReflect        = new ReflectionClass(__CLASS__.'_Cache');
			$sArrClassConstant = $objReflect->getConstants();
		}
		$sArrClassConstant['x_'.$strAddClassName] = $strAddFilePath;

		$strListFilePath = ConfigManager::get(__CLASS__.'.cache.file');

		$txtCode =
		           "<?php\n    class ".__CLASS__."_Cache {\n";

		foreach ($sArrClassConstant as $strClassName=>$strClassFilePath) {
			$txtCode .= '        const '.$strClassName.' = \''.$strClassFilePath."';\n";
		}

		$txtCode .= "    }\n?>";

		file_put_contents($strListFilePath, $txtCode);

		return true;
	} /*}}}*/

	protected static function _checkCaseSensitive($strClassName) /*{{{*/
	{
		$arrDeclaredClass = array_merge(get_declared_classes(), get_declared_interfaces());

		if (in_array($strClassName, $arrDeclaredClass) === false) {
			$intKey            = array_search(strtolower($strClassName), array_map('strtolower', $arrDeclaredClass));
			$strValidClassName = $arrDeclaredClass[$intKey];
			trigger_error(__CLASS__.': Be careful. Class name is CASE SENSITIVE. Valid class name is ['.$strValidClassName.'].', E_USER_ERROR);
		}
	} /*}}}*/
}
?>
