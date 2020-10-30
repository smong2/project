<?php
class Podo_Template
{
	const VERSION = '1.0.2';

	public static function instance($strTplName) /*{{{*/
	{
		if (self::_autoload($strTplName) === false) {
			trigger_error('The template file is not exist. - '.$strTplName, E_USER_WARNING);
			return null;
		}

		$strClassName = self::_getClassName($strTplName);

		if (class_exists($strClassName, false) === false) {
			unlink(self::_getClassPath($strTplName));

			self::_compile($strTplName);
			require self::_getClassPath($strTplName);

			Logger::log('debug', 0, 'Error - Class not found <path : '.self::_getClassPath($strTplName).'> <class name : '.$strClassName.'>');

			if (class_exists($strClassName, false) === false) {
				trigger_error('The template file cannot autoload. - '.$strTplName, E_USER_WARNING);
				return null;
			}
		}

		$strClassName = self::_getClassName($strTplName);
		return new $strClassName;
	} /*}}}*/

	public static function getErrorTpl($errfile) /*{{{*/
	{
		if (cyt_config::get('cyt.basedir.class', null) === null || cyt_config::get('cyt.basedir.tpl', null) === null) {
			return $errfile;
		}


		if (Podo_Util_String::startsWith($errfile, cyt_config::Get('cyt.basedir.class')) === false) {
			return $errfile;
		}

		$templateName = str_replace(array('/', '\\'), '_', substr($errfile, strlen(cyt_config::get('cyt.basedir.class'))+1+strlen(self::VERSION)+1, -4-strlen(cyt_config::get('cyt.generate.postfix', ''))));

		return self::_getTplPath($templateName);
	} /*}}}*/

	protected static function _getClassName($strTplName) /*{{{*/
	{
		return $strTplName . cyt_config::get('cyt.generate.postfix', '');
	} /*}}}*/

	protected static function _getTplPath($strTplName) /*{{{*/
	{
		static $sArrCache = array();

		if (isset($sArrCache[$strTplName]) === false) {
			$strDirPrefix           = str_replace('/', DIRECTORY_SEPARATOR, cyt_config::get('cyt.basedir.tpl'));
			$sArrCache[$strTplName] = $strDirPrefix . DIRECTORY_SEPARATOR . str_replace('_', DIRECTORY_SEPARATOR, $strTplName) . '.tpl';
		}

		return $sArrCache[$strTplName];
	} /*}}}*/

	protected static function _getClassPath($strTplName) /*{{{*/
	{
		static $sArrCache = array();

		$strClassName = self::_getClassName($strTplName);

		if (isset($sArrCache[$strTplName]) === false) {
			$strDirPrefix = str_replace('/', DIRECTORY_SEPARATOR, cyt_config::get('cyt.basedir.class'));
			$strFilePath  = str_replace('_', DIRECTORY_SEPARATOR, $strClassName) . cyt_config::get('cyt.generate.ext', '.class.php');

			$sArrCache[$strTplName] = $strDirPrefix . DIRECTORY_SEPARATOR . self::VERSION . DIRECTORY_SEPARATOR . $strFilePath;
		}

		return $sArrCache[$strTplName];
	} /*}}}*/

	protected static function _isNeedCompile($strTplName) /*{{{*/
	{
		static $sTmCheckFileLastUpdated;

		$strClassPath = self::_getClassPath($strTplName);
		$strTplPath   = self::_getTplPath($strTplName);

		if (cyt_config::get('cyt.compile.always', false)) {
			return true;
		}

		if (isset($_REQUEST['cytcompile'])) {
			return true;
		}

		if (cyt_config::get('cyt.compile.ttl', 0) < 0) {
			return false;
		}

		if (Podo_Util_File::checkTimeToLive($strTplPath, $strClassPath, cyt_config::get('cyt.compile.ttl', 0)) === false) {
			return true;
		}

		if (isset($sTmCheckFileLastUpdated) === false) {
			$arrCheckFilePath = array_merge(cyt_config::get('cyt.customtag', array()), cyt_config::get('cyt.compile.checkfile', array())); ;

			$sTmCheckFileLastUpdated = 0;
			foreach ($arrCheckFilePath as $strCustomTagPath) {
				if ($sTmCheckFileLastUpdated < filemtime($strCustomTagPath)) {
					$sTmCheckFileLastUpdated = filemtime($strCustomTagPath);
				}
			}
		}

		if (filemtime($strClassPath)+cyt_config::get('cyt.compile.ttl', 0) < $sTmCheckFileLastUpdated) {
			return true;
		}

		return false;
	} /*}}}*/

	protected static function _compile($strTplName, $isHideErrMsg = false, $isIgnoreTagMatch = false) /*{{{*/
	{
		$strClassPath = self::_getClassPath($strTplName);
		$strTplPath   = self::_getTplPath($strTplName);

		if (file_exists($strTplPath) === false) {
			return false;
		}

		if (self::_isNeedCompile($strTplName) === false) {
			return true;
		}

		$objCompiler                      = new cyt_compiler;
		$objCompiler->ignoreError         = $isHideErrMsg;
		$objCompiler->cfgIsIgnoreTagMatch = $isIgnoreTagMatch;

		return $objCompiler->compile($strTplName, $strTplPath, $strClassPath);
	} /*}}}*/

	protected static function _autoload($strTplName) /*{{{*/
	{
		if (self::_compile($strTplName) === true) {
			require_once self::_getClassPath($strTplName);
			return true;
		}

		return false;
	} /*}}}*/
}
?>
