<?php
/**
 * @desc cookie class
 * 
 * DEPENDANCY
 *     -. ConfigManager
 *     -. catz_interface_cookie
 *     -. catz_crypt
 * 
 * ConfigManager
 *   'cookie.NAME.asp.support'  : bool, if it is asp cookie or not
 *   'cookie.NAME.asp.encoding' : string, if it is asp cookie, then set encoding
 *                              : asp 쿠키인 경우 아직 expire 는 지원 안됨
 * 
 * @package catz
 * @author Jonghun Shin <teeroz@nate.com>
 */
class Podo_Controller_Cookie
{
	/********************************************************************** 
	 *****   REQUIRE AREA WHEN INHERIT THIS   ***************************** 
	 **********************************************************************/

	public static function instance($strName) /*{{{*/
	{
		static $sArrInstance = array();

		if (isset($sArrInstance[$strName]) === false) {
			$strClassName           = __CLASS__;
			$sArrInstance[$strName] = new $strClassName($strName);
		}

		return $sArrInstance[$strName];
	} /*}}}*/

	/********************************************************************** 
	 *****   PUBLIC AREA   ************************************************ 
	 **********************************************************************/

	public $name   = '';
	public $expire = 0;
	public $path   = '';
	public $domain = '';

	public function get($strSubKey = null) /*{{{*/
	{
		if ($this->name === '') {
			return '';
		}

		if ($strSubKey === null) {
			return $this->_strValue;
		}
		else if (isset($this->_arrSubValue[$strSubKey])) {
			return $this->_arrSubValue[$strSubKey];
		}
		else {
			return '';
		}
	} /*}}}*/

	public function set($mixValue) /*{{{*/
	{
		if ($this->name === '') {
			return;
		}

		Logger::log(__CLASS__, 1, 'set()', '$mixValue=', $mixValue);
		if (is_array($mixValue)) {
			$this->_arrSubValue = array_merge($this->_arrSubValue, $mixValue);
			$this->_strValue    = $this->_dumpSubValue($this->_arrSubValue);
		}
		else {
			$this->_strValue    = $mixValue;
			$this->_arrSubValue = $this->_loadSubValue($this->_strValue);
		}

		$strValue = $this->_strValue;
		if ($strValue !== '') {
			if ($this->_isCrypt) {
				$strValue = Podo_Util_Crypt::encrypt($this->_strValue, $this->_strCryptKey, null, $this->_strEncodingIn, $this->_strEncodingOut);
			}
			else if ($this->_strEncodingIn !== $this->_strEncodingOut) {
				Logger::log(__CLASS__, 5, 'The character set is converted from \''.$this->_strEncodingOut.'\' to \''.$this->_strEncodingIn.'\'');
				Logger::log(__CLASS__, 6, 'before converting : '.$this->_strValue);
				$strValue = mb_convert_encoding($this->_strValue, $this->_strEncodingIn, $this->_strEncodingOut);
				Logger::log(__CLASS__, 6, 'after converting : '.$strValue);
			}
		}

		$arrCookieStr   = array();
		$arrCookieStr[] = $this->name.'='.$strValue;
		$arrCookieStr[] = 'path='.$this->path;
		if ($this->domain !== '') {
			$arrCookieStr[] = 'domain='.$this->domain;
		}
		if ($this->expire > 0) {
			$arrCookieStr[] = 'expires='.gmdate('D, d-M-Y H:i:s', time()+$this->expire).' GMT';
		}
		Logger::log(__CLASS__, 3, 'Set-Cookie: '.join('; ', $arrCookieStr));
		header('Set-Cookie: '.join('; ', $arrCookieStr), false);
	} /*}}}*/

	public function exist($strSubKey) /*{{{*/
	{
		if ($this->name === '') {
			return false;
		}

		return isset($this->_arrSubValue[$strSubKey]);
	} /*}}}*/

	public function delete($isFlush = true) /*{{{*/
	{
		if ($this->name === '') {
			return;
		}

		$this->_strValue    = '';
		$this->_arrSubValue = array();

		if ($isFlush) {
			setcookie($this->name, '', time()-60*60, $this->path, $this->domain);
		}
	} /*}}}*/



	public static function getCookie($strName, $strSubKey = null) /*{{{*/
	{
		return Podo_Controller_Cookie::instance($strName)->get($strSubKey);
	} /*}}}*/

	public static function setCookie($strName, $strSubKey, $strValue = null) /*{{{*/
	{
		if ($strValue === null) {
			return Podo_Controller_Cookie::instance($strName)->set($strSubKey);
		}
		else {
			return Podo_Controller_Cookie::instance($strName)->set(array($strSubKey => $strValue));
		}
	} /*}}}*/

	public static function deleteCookie($strName, $isFlush = true) /*{{{*/
	{
		Podo_Controller_Cookie::instance($strName)->delete($isFlush);
	} /*}}}*/

	/********************************************************************** 
	 *****   PROTECTED AREA   ********************************************* 
	 **********************************************************************/

	protected $_strValue    = '';
	protected $_arrSubValue = array();

	protected $_strEncodingIn  = 'utf-8';
	protected $_strEncodingOut = 'utf-8';
	protected $_isCrypt        = false;
	protected $_strCryptKey    = '';

	public function __construct($strName = null) /*{{{*/
	{
		if ($strName === null) {
			return;
		}

		$this->name = $strName;

		$this->expire          = $this->_getConfigValue($this->name, 'expire', 0);
		$this->path            = $this->_getConfigValue($this->name, 'path', '/');
		$this->domain          = $this->_getConfigValue($this->name, 'domain', '');
		$this->_strEncodingIn  = $this->_getConfigValue($this->name, 'encoding.in', 'utf-8');
		$this->_strEncodingOut = $this->_getConfigValue($this->name, 'encoding.out', 'utf-8');
		$this->_isCrypt        = $this->_getConfigValue($this->name, 'crypt', false);
		$this->_strCryptKey    = Podo_Util_Crypt::generateKey($this->_getConfigValue($this->name, 'crypt.key', ''));

		if (isset($_COOKIE[$this->name])) {
			$this->_strValue = $_COOKIE[$this->name];
			Logger::log(__CLASS__, 9, 'construct-raw cookie: '.$this->_strValue);

			if ($this->_strValue !== '') {
				if ($this->_isCrypt) {
					$this->_strValue = Podo_Util_Crypt::decrypt($this->_strValue, $this->_strCryptKey, null, $this->_strEncodingOut, $this->_strEncodingIn);
				}
				else if ($this->_strEncodingIn !== $this->_strEncodingOut) {
					if (strtolower(mb_detect_encoding($this->_strValue, $this->_strEncodingOut)) !== strtolower($this->_strEncodingOut)) {
						$this->_strValue = mb_convert_encoding($this->_strValue, $this->_strEncodingOut, $this->_strEncodingIn);
					}
				}
			}
			Logger::log(__CLASS__, 9, 'construct-converted: '.$this->_strValue);
		}

		$this->_arrSubValue = $this->_loadSubValue($this->_strValue);
	} /*}}}*/

	protected function _loadSubValue($strValue) /*{{{*/
	{
		parse_str($strValue, $retval);

		if ($this->_strEncodingIn !== $this->_strEncodingOut) {
			foreach ($retval as $k=>&$v) {
				if (strtolower(mb_detect_encoding($v, $this->_strEncodingOut)) !== strtolower($this->_strEncodingOut)) {
					$v = mb_convert_encoding($v, $this->_strEncodingOut, $this->_strEncodingIn);
				}
			}
		}

		return $retval;
	} /*}}}*/

	protected function _dumpSubValue($arrSubValue) /*{{{*/
	{
		$arrCookieStr = array();

		foreach ($arrSubValue as $strKey=>$strValue) {
			if ($this->_strEncodingIn !== $this->_strEncodingOut) {
				$strValue = mb_convert_encoding($strValue, $this->_strEncodingIn, $this->_strEncodingOut);
			}
			$arrCookieStr[] = $strKey.'='.urlencode($strValue);
		}

		return join('&', $arrCookieStr);
	} /*}}}*/

	protected static function _getConfigValue($strCookieName, $strConfigName, $mixDefaultValue = null) /*{{{*/
	{
		return ConfigManager::get(__CLASS__.'.cookie.'.$strCookieName.'.'.$strConfigName, ConfigManager::get(__CLASS__.'.default.'.$strConfigName, $mixDefaultValue));
	} /*}}}*/
}
?>
