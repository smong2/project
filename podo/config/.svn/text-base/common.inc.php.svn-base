<?php
function printRequiredVariablesMsg() /*{{{*/
{
	echo '<pre>
- ERROR
	common.inc.php 에서 필요한 변수를 설정하지 않았습니다.
	다음 변수들이 올바르게 설정되어있는지 확인해주시기 바랍니다.

- VARIABLES
	$gStrInstallerFilePath  : 인스톨러 파일 경로
	$gStrCommonBaseFilePath : common_base.inc.php 의 파일 경로
	$gArrDevConfFile        : 개발서버용 환경설정 파일 목록
	$gArrLiveConfFile       : 실서버용 환경설정 파일 목록

- EXAMPLE
	$gStrInstallerFilePath = dirname(__FILE__).\'/Installer.php\';
	$gStrCommonBaseFilePath = dirname(__FILE__).\'/common_base.inc.php\';
	$gArrLiveConfFile = array(\'config/common.cfg\');
	$gArrDevConfFile = array_merge(array(\'config/dev.cfg\'), $gArrLiveConfFile);
</pre>';
} /*}}}*/

if (isset($gStrInstallerFilePath) === false ||
        isset($gStrCommonBaseFilePath) === false ||
        isset($gArrDevConfFile) === false ||
        isset($gArrLiveConfFile) === false) {
	printRequiredVariablesMsg();
	exit;
}

if (file_exists($gStrInstallerFilePath) === false) {
	echo '<pre>
- ERROR
	Installer 클래스 정의 파일을 찾을 수 없습니다.
	$gStrInstallerFilePath 값이 올바르게 설정되어있는지 확인해주시기 바랍니다.
	만약 아직 Installer 클래스를 만들지 않았다면 podo/class/Installer.php 파일을 참조하여
	클래스 파일을 생성하시기 바랍니다.
</pre>';
	exit;
}

date_default_timezone_set('Asia/Seoul');

if (file_exists($gStrCommonBaseFilePath) === false) {
	echo '<pre>
- ERROR
	Common Base 포함 파일을 찾을 수 없습니다.
	문제 해결을 위해서 다음 사항을 체크해보시기 바랍니다.
	1) \'config/init-prj [ dev | live ]\' 를 실행해보세요.
	2) 그래도 안되면 $gStrCommonBaseFilePath 값이 올바르게 설정되어있는지 확인하세요.
</pre>';
	exit;
}

ob_start();
require_once $gStrCommonBaseFilePath;
require_once $gStrInstallerFilePath;

$installer = new Installer;
$installer->check();

ob_end_clean();


if (defined('PODO_CONFIG_ISLIVE') === false && isset($gArrDevHostName) === false) {
	printRequiredVariablesMsg();
	exit;
}

ob_start();

/***************************************************************************
 ***** Print HTTP Header ***************************************************
 **************************************************************************/

if (defined('COMMON_CACHE') === false) {
	define('COMMON_CACHE', false);
}
if (defined('COMMON_CONTENT_TYPE') === false) {
	define('COMMON_CONTENT_TYPE', 'text/html');
}
if (defined('COMMON_CHARSET') === false) {
	define('COMMON_CHARSET', 'utf-8');
}

if (COMMON_CACHE === false) {
	header('Pragma: no-cache');
	header('Cache-Control: no-store, no-cache, must-revalidate');
	header('Cache-Control: post-check=0, pre-check=0', false);
	header('Cache-Control: max-age=0');
}
if (COMMON_CONTENT_TYPE) {
	header('Content-Type: '.COMMON_CONTENT_TYPE .'; charset='.COMMON_CHARSET);
}

define('CYT_CONTENT_TYPE', COMMON_CONTENT_TYPE);

/***************************************************************************
 ***** Initialize **********************************************************
 **************************************************************************/

if (isset($_REQUEST) === false) {
	$_REQUEST = $_GET + $_POST + $_COOKIE;
}

/***************************************************************************
 ***** Require Common Library **********************************************
 **************************************************************************/

require_once(dirname(__FILE__).'/../class/ConfigManager.php');
require_once(dirname(__FILE__).'/../class/Podo/System/Autoloader.php');

spl_autoload_register(array('Podo_System_Autoloader', 'autoload'));

/***************************************************************************
 ***** Load Configuration Files ********************************************
 **************************************************************************/

function getHostName() /*{{{*/
{
	if (isset($_ENV['HOST']) && $_ENV['HOST'] !== '') {
		return $_ENV['HOST'];
	}

	if (isset($_ENV['HOSTNAME']) && $_ENV['HOSTNAME'] !== '') {
		return $_ENV['HOSTNAME'];
	}

	return trim(`hostname`);
} /*}}}*/

// Loading Configuration
// live server
if (defined('PODO_CONFIG_ISLIVE') && PODO_CONFIG_ISLIVE
        || defined('PODO_CONFIG_ISLIVE') === false && in_array(getHostName(), $gArrDevHostName) === false) {
	$arrConfFile = $gArrLiveConfFile;
}
// dev server
else {
	$arrConfFile = $gArrDevConfFile;
}

ConfigManager::loadPackage($arrConfFile, dirname(__FILE__).'/default.cfg');

set_include_path(get_include_path().PATH_SEPARATOR .join(PATH_SEPARATOR, ConfigManager::get('Podo_System_Autoloader.dirs', array())));

/***************************************************************************
 ***** Debug Setting and FileName Check ************************************
 **************************************************************************/

// Handler Setting and misc.
if (ConfigManager::get('Podo_System_ErrorHandler.enable', false)) {
	require_once(dirname(__FILE__).'/../class/Podo/System/ErrorHandler.php');
	function errorHandle($errno, $errstr, $errfile, $errline) /*{{{*/
	{
		Podo_System_ErrorHandler::handle($errno, $errstr, $errfile, $errline);
	} /*}}}*/
	set_error_handler('errorHandle');
}

if (ConfigManager::get('Podo_System_Logger.enable', false)) {
	Logger::instance('debug');
	if (ConfigManager::get('Podo_System_Logger.logger.debug.print.execinfo') && isset($_REQUEST['action'])) {
		Logger::debug('ACTION: '.$_REQUEST['action'], '');
	}
}

$gPrevExceptionHandler = null;
function PODO_exceptionHandler($e) /*{{{*/
{
	if ($e instanceof PDO_DBGate_Exception || $GLOBALS['gPrevExceptionHandler'] === null) {
		Logger::log('exception', 1, 'Uncaught Exception['.get_class($e).']: '.$e->getMessage());
		if (ConfigManager::get('Podo_System_ErrorHandler.enable', false)) {
			Podo_System_ErrorHandler::instance()->manage(Podo_System_ErrorHandler::E_EXCEPTION, 'Uncaught Exception['.get_class($e).']: '.$e->getMessage(), $e->getFile(), $e->getLine(), $e->getTrace());
		}
		exit;
	}
	else {
		$GLOBALS['gPrevExceptionHandler']($e);
	}
} /*}}}*/

if (ConfigManager::get('Podo_Plugin.use.exceptionHandler', false)) {
	$gPrevExceptionHandler = set_exception_handler('PODO_exceptionHandler');
}
ob_end_clean();
?>
