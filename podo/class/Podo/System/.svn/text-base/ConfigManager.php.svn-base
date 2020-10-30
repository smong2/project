<?php
if (defined('PODO_CONFIG_BASEDIR') === false) {
	define('PODO_CONFIG_BASEDIR', getcwd());
}

if (defined('PODO_CONFIG_CACHEDIR') === false) {
	if (PHP_OS === 'WINNT') {
		define('PODO_CONFIG_CACHEDIR', 'C:\Temp');
	}
	else {
		define('PODO_CONFIG_CACHEDIR', '/tmp/Podo/System/ConfigManager');
	}
}

if (defined('PODO_CONFIG_TTL') === false) {
	define('PODO_CONFIG_TTL', 0);
}

if (class_exists('Podo_Util_String', false) === false) {
	require_once dirname(__FILE__).'/../Util/String.php';
}

if (class_exists('Podo_Util_File', false) === false) {
	require_once dirname(__FILE__).'/../Util/File.php';
}

// PODO_CONFIG_READ_CACHE : true 일 경우 무조건 캐쉬 데이타만 읽도록 한다.
// PODO_CONFIG_BASEDIR    : 환경 파일을 읽을 때 상대 경로의 기본 경로
// PODO_CONFIG_CACHEDIR   : 캐쉬 데이타를 저장하는 디렉토리, BASEDIR 의 상대 경로

class Podo_System_ConfigManager
{
	const VERSION       = '.v3';
	const REG_REFERENCE = '{\$(\w+(?:\.\w+)*)}';

	public static $data = null;

	protected static $_arrIsLoaded = array();

	public static function load($strFilePath) /*{{{*/
	{
		if (isset(self::$_arrIsLoaded[$strFilePath])) {
			return;
		}

		self::$_arrIsLoaded[$strFilePath] = true;

		$strSrcFile = self::_getRealPath($strFilePath);
		$strDesFile = self::_getCacheFilePath($strFilePath);

		if (Podo_Util_File::checkTimeToLive($strSrcFile, $strDesFile, PODO_CONFIG_TTL) === false) {
			if (self::compile($strSrcFile, $strDesFile) === false) {
				trigger_error(__CLASS__.'::load() - To compile of '.$strSrcFile.' is failed.', E_USER_ERROR);
			}
		}

		ob_start();
		require_once $strDesFile;
		ob_end_clean();

		return;
	} /*}}}*/

	/**
	 * @desc 여러개의 환경설정 값을 한꺼번에 읽는다.
	 * 
	 * 이 함수는 성능향상 및 기본설정값을 처리하기 위하여 만들어졌다.
	 */
	public static function loadPackage($arrUserConfFile, $strDefaultConfFile = null) /*{{{*/
	{
		// 이미 읽은 설정값이 있다면 백업 해둔다.
		// 백업 해둔 설정값은 중복 체크를 하지 않는다.
		if (count(self::$data) > 0) {
			$arrOldData = self::$data;
			self::$data = array();
		}

		// Default 설정 파일을 목록에 추가한다.
		$arrConfFile = $arrUserConfFile;
		if ($strDefaultConfFile !== null) {
			$arrConfFile[] = $strDefaultConfFile;
		}

		// 설정 파일들의 절대 경로를 구한다.
		$arrConfPath = array();
		foreach ($arrConfFile as $strConfFile) {
			$arrConfPath[] = self::_getRealPath($strConfFile);
		}

		// 캐쉬 파일 경로를 구한다.
		$strDesPath = PODO_CONFIG_CACHEDIR.DIRECTORY_SEPARATOR.substr(md5(serialize($arrConfFile)), 0, 32).self::VERSION.'.serialize';

		// 변경된 설정 파일이 있는 경우
		if (Podo_Util_File::checkTimeToLive($arrConfPath, $strDesPath, PODO_CONFIG_TTL) === false) {
			/*
			// 일반 설정 파일을 컴파일 한다.
			foreach ($arrUserConfFile as $strConfFile) {
			$strConfPath  = self::_getRealPath($strConfFile);
			$strCachePath = self::_getCacheFilePath($strConfFile);
			self::compile($strConfPath, $strCachePath);
			require_once $strCachePath;
			}

			// Default 설정 파일을 컴파일 한다.
			if ($strDefaultConfFile !== null) {
			$strConfPath  = self::_getRealPath($strDefaultConfFile);
			$strCachePath = self::_getCacheFilePath($strDefaultConfFile);
			self::compile($strConfPath, $strCachePath, true);
			require_once $strCachePath;
			}
			*/

			$contents = '';
			foreach ($arrConfPath as $strConfPath) {
				$contents .= file_get_contents($strConfPath);
			}
			$pkgFilePath = PODO_CONFIG_CACHEDIR.DIRECTORY_SEPARATOR.'/package.cfg';
			self::write($pkgFilePath, $contents);

			// 설정 파일을 컴파일 한다.
			/*
			foreach ($arrConfFile as $strConfFile) {
			$strConfPath  = self::_getRealPath($strConfFile);
			$strCachePath = self::_getCacheFilePath($strConfFile);
			self::compile($strConfPath, $strCachePath, true);
			require_once $strCachePath;
			}
			*/
			self::compile($pkgFilePath, $strDesPath, true);

			// 설정 파일을 캐쉬 파일에 저장한다.
			// self::write($strDesPath, serialize(self::$data));
		}
		// 변경된 설정 파일이 없는 경우
		else {
			// 캐쉬 파일로부터 설정을 읽어온다.
			// self::$data = unserialize(file_get_contents($strDesPath));
		}
		require_once $strDesPath;

		// 백업한 설정값을 다시 가져온다.
		if (isset($arrOldData)) {
			self::$data = array_merge(self::$data, $arrOldData);
		}
	} /*}}}*/

	public static function get($strName = '', $mixDefaultValue = null) /*{{{*/
	{
		if (isset(self::$data[$strName])) {
			return self::$data[$strName];
		}

		if ($mixDefaultValue !== null) {
			return $mixDefaultValue;
		}

		echo '<pre>';
		debug_print_backtrace();
		echo '</pre>';
		trigger_error(__CLASS__.'::get() - \''.$strName.'\' is not defined.', E_USER_ERROR);
	} /*}}}*/

	public static function exist($strName) /*{{{*/
	{
		return (isset(self::$data[$strName]));
	} /*}}}*/

	public static function set($strName, $mixValue) /*{{{*/
	{
		if (Podo_Util_String::endWith($strName, '[]')) {
			self::$data[substr($strName, 0, -2)][] = $mixValue;
		}
		else {
			self::$data[$strName] = $mixValue;
		}
	} /*}}}*/

	public static function getArrayValue($strName = '', $strDefaultValue = null) /*{{{*/
	{
		$retval = self::get($strName, $strDefaultValue);

		if (is_array($retval)) {
			return $retval;
		}

		return array($retval);
	} /*}}}*/



	protected static function _getRealPath($strFilePath) /*{{{*/
	{
		if (PHP_OS === 'WINNT') {
			if (substr($strFilePath, 1, 2) !== ':\\') {
				return PODO_CONFIG_BASEDIR.DIRECTORY_SEPARATOR.$strFilePath;
			}
			else {
				return $strFilePath;
			}
		}
		else {
			if ($strFilePath[0] !== DIRECTORY_SEPARATOR) {
				return PODO_CONFIG_BASEDIR.DIRECTORY_SEPARATOR.$strFilePath;
			}
			else {
				return $strFilePath;
			}
		}
	} /*}}}*/

	protected static function _getCacheFilePath($strFilePath) /*{{{*/
	{
		if (PHP_OS === 'WINNT') {
			if (substr($strFilePath, 1, 2) === ':\\') {
				return PODO_CONFIG_CACHEDIR.DIRECTORY_SEPARATOR.str_replace(array('/', DIRECTORY_SEPARATOR), '_', substr($strFilePath, 2)).self::VERSION.'.php';
			}
			else {
				return PODO_CONFIG_CACHEDIR.DIRECTORY_SEPARATOR.str_replace(array('/', DIRECTORY_SEPARATOR), '_', $strFilePath).self::VERSION.'.php';
			}
		}
		else {
			return PODO_CONFIG_CACHEDIR.DIRECTORY_SEPARATOR.str_replace(array('/', DIRECTORY_SEPARATOR), '_', $strFilePath).self::VERSION.'.php';
		}
	} /*}}}*/



	public static function compile($strSrcFile, $strDesFile, $isDefaultCfg = false) /*{{{*/
	{
		$txtContent = self::parse($strSrcFile, $isDefaultCfg);
		return self::write($strDesFile, $txtContent);
	} /*}}}*/

	public static function write($strDesFile, $txtContent) /*{{{*/
	{
		umask(0000);

		if (file_exists(dirname($strDesFile)) === false) {
			mkdir(str_replace('/', DIRECTORY_SEPARATOR, dirname($strDesFile)), 0777, true);
		}

		return Podo_Util_File::file_put_contents($strDesFile, $txtContent, 0666);
	} /*}}}*/

	protected static function _parseString($strValue) /*{{{*/
	{
		if (strlen($strValue) >= 2 && (
		                                      Podo_Util_String::startWith($strValue, '"') && Podo_Util_String::endWith($strValue, '"') ||
		                                      Podo_Util_String::startWith($strValue, '\'') && Podo_Util_String::endWith($strValue, '\''))) {
			$strValue = substr($strValue, 1, -1);
		}
		else {
			$strValue = addslashes($strValue);
		}

		$isStartQuot = true;
		$isEndQuot   = true;

		// {$xxx.xxx} 구문 처리하기
		if (preg_match('/^'.self::REG_REFERENCE.'$/', $strValue)) {
			$strValue    = preg_replace('/^'.self::REG_REFERENCE.'$/', '$__data[\'$1\']', $strValue);
			$isStartQuot = false;
			$isEndQuot   = false;
		}

		if (preg_match('/^'.self::REG_REFERENCE.'/', $strValue)) {
			$strValue    = preg_replace('/^'.self::REG_REFERENCE.'/', '$__data[\'$1\'].\'', $strValue);
			$isStartQuot = false;
		}

		if (preg_match('/'.self::REG_REFERENCE.'$/', $strValue)) {
			$strValue  = preg_replace('/'.self::REG_REFERENCE.'$/', '\'.$__data[\'$1\']', $strValue);
			$isEndQuot = false;
		}

		if (preg_match('/'.self::REG_REFERENCE.'/', $strValue)) {
			$strValue = preg_replace('/'.self::REG_REFERENCE.'/', '\'.$__data[\'$1\'].\'', $strValue);
		}

		if ($isStartQuot && $isEndQuot) {
			$strValue = '\''.$strValue.'\'';
		}
		else if ($isStartQuot && $isEndQuot === false) {
			$strValue = '\''.$strValue;
		}
		else if ($isStartQuot === false && $isEndQuot) {
			$strValue = $strValue.'\'';
		}

		return $strValue;
	} /*}}}*/

	public static function parse($strSrcFile, $isDefaultCfg = false) /*{{{*/
	{
		if (file_exists($strSrcFile) === false) {
			trigger_error(__CLASS__.'::parse() - '.$strSrcFile.' 파일이 없습니다.', E_USER_ERROR);
		}

		$arrLine = array_map('trim', file($strSrcFile));

		return self::_parse($arrLine, $isDefaultCfg, $strSrcFile);
	} /*}}}*/

	public static function _parse($arrLine, $isDefaultCfg = false, $strSrcFile = null) /*{{{*/
	{
		if ($strSrcFile === null) {
			$strSrcFile = 'ANY CONFIG FILE';
		}

		// $target 초기화
		$intLineNo    = 0;
		$arrCreated   = array();
		$txtReturn    = "<?php\n\$__data =& ".__CLASS__."::\$data;\n";
		$strCurrGroup = '';

		foreach ($arrLine as $strLine) {
			$intLineNo++;

			$strLine = trim(preg_replace('/([^(?:\\\\|;#)]|^)[;#].*$/', '$1', $strLine));

			// 주석이거나 빈줄일 경우 패스
			if ($strLine === '') {
				continue;
			}

			$strLine = preg_replace('/\\\\([;#])/', '$1', $strLine);

			// 클래스 시작일 경우
			if (Podo_Util_String::startWith($strLine, '[') && Podo_Util_String::endWith($strLine, ']')) {
				$strCurrGroup = trim(substr($strLine, 1, strlen($strLine)-2));
				continue;
			}

			if (strpos($strLine, '=') === false) {
				trigger_error('invalied line - '.$strLine.' in '.$strSrcFile.' at line '.$intLineNo, E_USER_ERROR);
				continue;
			}

			// 키와 값 분리
			list($strName, $strValue) = array_map('trim', explode('=', $strLine, 2));
			if ($strCurrGroup !== '') {
				$strName = $strCurrGroup.'.'.$strName;
			}

			// 중복된 변수명이 존재할 경우
			if (Podo_Util_String::endWith($strName, '[]') === false && (isset($arrCreated[$strName]) || isset(self::$data[$strName]))) {
				if ($isDefaultCfg) {
					continue;
				}

				trigger_error(__CLASS__.'::parse() - duplicated variable '.$strName.' in '.$strSrcFile.' at line '.$intLineNo, E_USER_WARNING);
			}

			if ($isDefaultCfg && $strValue === '{MANDATORY}') {
				trigger_error(__CLASS__.'::parse() - A mandatory field is not defined. : '.$strName, E_USER_ERROR);
			}

			// 값 치환 (문자열과 부울변수 치환)
			if ($isDefaultCfg && Podo_Util_String::startWith($strValue, '[') && Podo_Util_String::endWith($strValue, ']')) {
				// todo
				// ['a,b,c,d','e,f,g'] 와 같이 따옴표 안에 들어있는 , 콤마는
				// 앞에 역슬래쉬가 없어도 알아서 , 콤마로 인식하자.
				$strValue = substr($strValue, 1, -1);
				str_replace('\,', '#', $strValue);
				$arrValue = explode(',', $strValue);
				foreach ($arrValue as &$strValue) {
					$strValue = str_replace('#', ',', $strValue);
					$strValue = trim($strValue);
					$strValue = self::_parseString($strValue);
				}

				$strValue = 'array('.join(', ', $arrValue).')';
			}
			else if (strtolower($strValue) !== 'true' && strtolower($strValue) !== 'false') {
				$strValue = self::_parseString($strValue);
			}
			else {
				$strValue = strtoupper($strValue);
			}

			// code 에 기록하기
			$strConfName = $strName;
			if (Podo_Util_String::endWith($strConfName, '[]')) {
				$strConfName = substr($strConfName, 0, -2);
			}

			/*
			if ($isDefaultCfg) {
			$txtReturn .= '    if (isset($__data[\''.$strConfName.'\']) === false) {'."\n    ";
			}
			*/

			if (Podo_Util_String::endWith($strName, '[]')) {
				$txtReturn .= '$__data[\''.substr($strName, 0, -2).'\'][] = '.$strValue.";\n";
			}
			else {
				$txtReturn .= '$__data[\''.$strName.'\'] = '.$strValue.";\n";
			}

			/*
			if ($isDefaultCfg) {
			$txtReturn .= "    }\n";
			}
			*/

			// 생성된 변수 체크
			if (Podo_Util_String::endsWith($strName, '[]')) {
				$arrCreated[substr($strName, 0, -2)] = true;
			}
			else {
				$arrCreated[$strName] = true;
			}
		}

		$txtReturn .= "unset(\$__data);\n?>";

		return $txtReturn;
	} /*}}}*/
}
?>
