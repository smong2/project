<?php
class Podo
{
	protected static $_lastAction = '';

	public static function notFound() /*{{{*/
	{
		$objDispatcher = Podo_Dispatcher::instance();
		$arrInfo       = $objDispatcher->getDefaultInfo();

		Podo_Dispatcher_Check::check($arrInfo, 'error');

		$CONTROLLER = self::_executeAction($arrInfo, $_REQUEST);
		self::_executeView($CONTROLLER);
	} /*}}}*/

	public static function execute($pStrAction = null) /*{{{*/
	{
		static $sIntCallCnt = 0;

		$sIntCallCnt++;

		if (isset($_SERVER['SERVER_NAME'])) {
			$strServer = $_SERVER['SERVER_NAME'];
			if ($_SERVER['SERVER_PORT'] != '80') {
				$strServer .= ':' . $_SERVER['SERVER_PORT'];
			}
		}
		else {
			$strServer = 'localhost:80';
		}

		if ($pStrAction === null) {
			// 실수로 파라미터를 잘못 넘겨서 무한루프 도는 것을 방지하기 위함.
			if ($sIntCallCnt > 1) {
				return;
			}

			if (isset($_SERVER['REQUEST_URI'])) {
				$strURL = $strServer . $_SERVER['REQUEST_URI'];
			}
			else {
				$strURL = $strServer . '?action=' .(isset($_REQUEST['action']) ? $_REQUEST['action'] : '');
			}

			self::$_lastAction = isset($_REQUEST['action']) ? $_REQUEST['action'] : '';

			$arrRequest = $_POST + $_GET;
		}
		else {
			if (strlen($pStrAction) > 0 && $pStrAction[0] === '/') {
				$strAction = $pStrAction;
			}
			else {
				$strAction = dirname(self::$_lastAction) . '/' . $pStrAction;
			}

			if (strpos($strAction, '?') !== false) {
				$strAction = str_replace('?', '&', $strAction);
			}
			$strURL = $strServer . '?action=' . $strAction;

			$arrParsedInfo = parse_url($strURL);
			parse_str($arrParsedInfo['query'], $arrRequest);

			self::$_lastAction = $arrRequest['action'];
		}

		$objUrlDispatcher = Podo_Dispatcher::instance();
		$objUrlDispatcher->setAction(self::$_lastAction);
		$arrParse = $objUrlDispatcher->parsePattern($strURL);

		Podo_Dispatcher_Check::check($arrParse);

		$CONTROLLER = self::_executeAction($arrParse, $arrRequest);
		self::_executeView($CONTROLLER);
	} /*}}}*/

	protected static function _executeAction($arrParse, $arrRequest = null) /*{{{*/
	{
		if ($arrRequest === null) {
			$arrRequest = $_POST + $_GET;
		}

		$CONTROLLER = new $arrParse['CONTROLLER']($arrParse, $arrRequest);
		if ($CONTROLLER->isExceptionThrowed() === false) {
			$CONTROLLER->$arrParse['ACTION']();
		}

		return $CONTROLLER;
	} /*}}}*/

	protected static function _executeView($CONTROLLER) /*{{{*/
	{
		$DICT  = $CONTROLLER->getResponse();
		$PARAM = $CONTROLLER->getRequest();

		// Default View 필요할까?
		$jsonVar = $CONTROLLER->getJson();
		if ($jsonVar instanceof Podo_Controller_Json && $jsonVar->isEmpty() === false ||
		        !($jsonVar instanceof Podo_Controller_Json) && $jsonVar !== null) {
			if (ConfigManager::exist('Podo.charset')) {
				header('Content-Type: application/json; charset='.ConfigManager::get('Podo.charset'));
			}
			else {
				header('Content-Type: application/json');
			}
			header('X-JSON: '.json_encode($jsonVar));
			echo json_encode($jsonVar);
			exit;
		}
		if (strlen($DICT->getRedirect()) > 0) {
			header('Location: '.$DICT->getRedirect());
			exit;
		} else if (strlen($DICT->getViewName()) > 0) {
			// include(ConfigManager::get('common.basedir')."/template/".$DICT->getViewName());
			$strViewClassName = $DICT->getViewName();
			$template         = Podo_Template::instance($strViewClassName);
			if (is_null($template)) {
				self::notFound();
				exit;
			}
			foreach ($DICT as $key=>$val) {
				$template->{$key} = $val;
			}
			$template->request = $PARAM;
			$template->display();
		}
		else {
			self::Notfound();
			exit;
		}
	} /*}}}*/

	public static function getActionStr() /*{{{*/
	{
		return self::$_lastAction;
	} /*}}}*/
}
?>
