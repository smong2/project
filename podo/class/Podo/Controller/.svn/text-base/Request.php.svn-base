<?php
/**
 * Podo_Controller_Request class
 * 
 * @package Podo.Controller
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.03.19
 * PHP 4.1 이상의 버젼만 고려해서 Parameter 부분 개발.
 */
class Podo_Controller_Request extends pattern_iterator
{
	private $_params;

	public $get     = null;
	public $post    = null;
	public $cookie  = null;
	public $session = null;
	public $file    = null;

	function __construct($arrRequest = null) /*{{{*/
	{
		if ($arrRequest === null) {
			$arrRequest = $_POST + $_GET;
		}

		$this->__items = $arrRequest;

		$this->setPost();
		$this->setGet();
		$this->setCookie();
		$this->setSession();

		// $this->__items =& $_REQUEST;
	} /*}}}*/

	function __destruct() /*{{{*/
	{
	} /*}}}*/

	public function setParam($params) /*{{{*/
	{
		// UnitTest을 위한 함수
		$this->_params = $params;
		// 		echo $param->get("id")." _all<br>";
		// 		echo $param->getGet("id")." _get<br>";
		// 		echo $param->getPost("id")." _post<br>";
	} /*}}}*/

	public function addParam($arrParse) /*{{{*/
	{
		unset($arrParse['CONTROLLER']);
		unset($arrParse['ACTION']);
		unset($arrParse['VIEW']);
		foreach ($arrParse as $key=>$value) {
			$this->_params[$key]['value'] = $value;
			$this->_params[$key]['type']  = 'PATTERN';
			$this->__items[$key]          = $value;
		}
	} /*}}}*/

	public function get($strValue) /*{{{*/
	{
		if (isset($this->__items[$strValue])) {
			return $this->__items[$strValue];
		}

		if (isset($_COOKIE[$strValue])) {
			trigger_error('A cookie cannot be retrieved by this method.', E_USER_ERROR);
		}


		trigger_error('Undefined request index: '.$strValue, E_USER_NOTICE);
		return '';
	} /*}}}*/

	public function getGet($strValue) /*{{{*/
	{
		if ($this->_params[$strValue]['type'] == 'GET') {
			return $this->_params[$strValue]['value'];
		}
		return null;
	} /*}}}*/

	public function getPost($strValue) /*{{{*/
	{
		if ($this->_params[$strValue]['type'] == 'POST') {
			return $this->_params[$strValue]['value'];
		}
		return null;
	} /*}}}*/

	public function getCookie($strName, $strSubKey = null) /*{{{*/
	{
		return Podo_Controller_Cookie::getCookie($strName, $strSubKey);
	} /*}}}*/

	public function getSession($strValue) /*{{{*/
	{
		if ($this->_params[$strValue]['type'] == 'SESSION') {
			return $this->_params[$strValue]['value'];
		}
		return null;
	} /*}}}*/

	public function existFile($strValue) /*{{{*/
	{
		return isset($_FILES[$strValue]);
	} /*}}}*/

	public function getFile($strValue = null) /*{{{*/
	{
		if ($strValue === null) {
			return $_FILES;
		}

		if (isset($_FILES[$strValue]) === false) {
			trigger_error($strValue.' 라는 파일을 찾을 수 없습니다.', E_USER_WARNING);
			return false;
		}

		return $_FILES[$strValue];
	} /*}}}*/

	public function getPattren($strValue) /*{{{*/
	{
		if ($this->_params[$strValue]['type'] == 'PATTERN') {
			return $this->_params[$strValue]['value'];
		}
		return null;
	} /*}}}*/

	public function getDisplay($strValue) /*{{{*/
	{
		return $strValue;
	} /*}}}*/

	public function getAllParams() /*{{{*/
	{
		return $this->_params;
	} /*}}}*/

	private function setPost() /*{{{*/
	{
		foreach ($_POST as $key=>$value) {
			$this->_params[$key]['value'] = $value;
			$this->_params[$key]['type']  = 'POST';
		}
	} /*}}}*/

	private function setGet() /*{{{*/
	{
		foreach ($_GET as $key=>$value) {
			$this->_params[$key]['value'] = $value;
			$this->_params[$key]['type']  = 'GET';
		}
	} /*}}}*/

	private function setCookie() /*{{{*/
	{
		foreach ($_COOKIE as $key=>$value) {
			$this->_params[$key]['value'] = $value;
			$this->_params[$key]['type']  = 'COOKIE';
		}
	} /*}}}*/

	private function setSession() /*{{{*/
	{
		if (isset($_SESSION)) {
			foreach ($_SESSION as $key=>$value) {
				$this->_params[$key]['value'] = $value;
				$this->_params[$key]['type']  = 'SESSION';
			}
		}
	} /*}}}*/

	public function __isset($strName) /*{{{*/
	{
		if (isset($this->__items[$strName])) {
			return true;
		}

		return false;
	} /*}}}*/

	public function __get($strName) /*{{{*/
	{
		return $this->get($strName);
	} /*}}}*/

	public function __set($strName, $strValue) /*{{{*/
	{
		trigger_error('A request value cannot modified.', E_USER_ERROR);
	} /*}}}*/
}
?>
