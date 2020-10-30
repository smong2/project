<?php
/**
 * Podo_Controller_Response class
 * 
 * @package Podo.Controller
 * @version 1.0
 * @author kimgua<kimgua@nate.com>
 * @copyright SK Communications. all rights reserved
 * @createDate 2007.04.18
 */

class Podo_Controller_Response
{
	private $_DICT;

	public function __construct() /*{{{*/
	{
		$this->creatDICT();
		// $this->__items =& $this->_DICT["RESULTS"];
	} /*}}}*/

	public function __destruct() /*{{{*/
	{
	} /*}}}*/

	private function creatDICT() /*{{{*/
	{
		$DICT['RESULTS']        = Array();
		$DICT['TARGET']['URL']  = null;
		$DICT['TARGET']['VIEW'] = null;
		$this->_DICT            = $DICT;
	} /*}}}*/

	public function __get($strName) /*{{{*/
	{
		return $this->$strName;
		// return $this->_DICT["RESULTS"][$strName];
	} /*}}}*/

	public function __set($strName, $strValue) /*{{{*/
	{
		$this->$strName = $strValue;
		// $this->_DICT["RESULTS"][$strName] = $strValue;
	} /*}}}*/

	public function setViewName($strView) /*{{{*/
	{
		$this->_DICT['TARGET']['VIEW'] = $strView;
	} /*}}}*/

	public function getViewName() /*{{{*/
	{
		return $this->_DICT['TARGET']['VIEW'];
	} /*}}}*/

	public function getRedirect() /*{{{*/
	{
		return $this->_DICT['TARGET']['URL'];
	} /*}}}*/

	public function setRedirect($strUrl, $isPass = false, $isLocal = false, $isSameUrl = false) /*{{{*/
	{
		if ($isSameUrl) {
			if ($strUrl == $_REQUEST['action']) {
				return;
			}
		}

		if ($isLocal) {
			Podo::execute($strUrl);
			exit;
		}

		if ($isPass) {
			$this->_DICT['TARGET']['URL'] = $strUrl;
		} else {
			header('Location: '.$strUrl);
			exit;
		}
	} /*}}}*/

	// public void setCookie(string $strName, string $strValue)
	// public void setCookie(string $strName, string $strSubKey, string $strValue)
	public function setCookie($strName, $strSubKey, $strValue = null) /*{{{*/
	{
		if ($strValue === null) {
			return Podo_Controller_Cookie::instance($strName)->set($strSubKey);
		}
		else {
			return Podo_Controller_Cookie::instance($strName)->set(array($strSubKey => $strValue));
		}
	} /*}}}*/

	public function deleteCookie($strName, $isFlush = true) /*{{{*/
	{
		Podo_Controller_Cookie::instance($strName)->delete($isFlush);
	} /*}}}*/
}
?>
