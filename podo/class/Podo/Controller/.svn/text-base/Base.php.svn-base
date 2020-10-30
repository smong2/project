<?php
class Podo_Controller_Json
{
	public function isEmpty() /*{{{*/
	{
		if (count(get_object_vars($this)) > 0) {
			return false;
		}
		else {
			return true;
		}
	} /*}}}*/
}

/**
 * Podo_Controller_Base class
 * 
 * @package Podo_Controller
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.04.08
 */

class Podo_Controller_Base
{
	protected $request;
	protected $response;
	protected $cookie;
	protected $json;
	protected $_isExceptionThrowed = false;

	public function __construct($arrParse, $arrRequest = null) /*{{{*/
	{
		if ($arrRequest === null) {
			$arrRequest = $_REQUEST;
		}

		$this->json = new Podo_Controller_Json;

		$strRequestClassName = ConfigManager::get(__CLASS__.'.custom.request', 'Podo_Controller_Request');
		$this->request       = new $strRequestClassName($arrRequest);
		$this->request->addParam($arrParse);

		$strResponseClassName = ConfigManager::get(__CLASS__.'.custom.response', 'Podo_Controller_Response');
		$this->response       = new $strResponseClassName;

		$strCookieClassName = ConfigManager::get(__CLASS__.'.custom.cookie', 'Podo_Controller_Cookie');
		$this->cookie       = new $strCookieClassName;

		if (isset($arrParse['VIEW'])) {
			$this->response->setViewName($arrParse['VIEW']);
		}

		try {
			$this->__preProcessor();
		} catch (Podo_Controller_Exception $e) {
			$this->_isExceptionThrowed = true;
		}
	} /*}}}*/

	public function __destruct() /*{{{*/
	{
		$this->__postProcessor();
	} /*}}}*/

	public function isExceptionThrowed() /*{{{*/
	{
		return $this->_isExceptionThrowed;
	} /*}}}*/

	protected function __preProcessor() /*{{{*/
	{
	} /*}}}*/

	protected function __postProcessor() /*{{{*/
	{
		// xprofiler에서 podo 기반 url의 action path 별로 수 있게 하기 위해서..
		if (function_exists('xprofiler_set_script_name') && !isset($GLOBALS['__XPROFILER_SCRIPT_NAME_SET'])) {
			xprofiler_set_script_name($this->request->action);
			$GLOBALS['__XPROFILER_SCRIPT_NAME_SET'] = true;
		}
	} /*}}}*/

	public function getResponse() /*{{{*/
	{
		return $this->response;
	} /*}}}*/

	public function getRequest() /*{{{*/
	{
		return $this->request;
	} /*}}}*/

	public function getJson() /*{{{*/
	{
		return $this->json;
	} /*}}}*/
}
?>
