<?php
class BaseController extends Podo_Controller_Base
{
	public $myUser;

	public function __preProcessor() /*{{{*/
	{
		$this->myUser           = $this->_retrieveLoggedUser();
		$this->response->myUser = $this->myUser;

		$this->response->isLogged = false;
		if ($this->myUser) {
			$this->response->isLogged = true;
		}

		$this->response->req = $this->req = new Memory_Request;
	} /*}}}*/

	/**
	 * @return User 로긴했으면 User 객체를 반환하고, 비로긴 상태면 null 을 반환한다.
	 */
	private function _retrieveLoggedUser() /*{{{*/
	{
		if (isset($_COOKIE['GUID']) === false || isset($_COOKIE['ENC']) === false) {
			return null;
		}

		$strEnc = exec(dirname(dirname(__FILE__)).'/bin/xso_decrypt "'.$_COOKIE['GUID'].'" "'.$_COOKIE['ENC'].'"');
		$arrEnc = explode(';', substr(trim($strEnc), 1, -2));
		foreach ($arrEnc as $knv) {
			list($key, $value) = explode('=', $knv, 2);
			$arrUserInfo[$key] = $value;
		}

		$arrUserInfo['realname'] = mb_convert_encoding(exec(dirname(dirname(__FILE__)).'/bin/enc_get_value "'.$strEnc.'" "cn"'), 'utf-8', 'euc-kr');

		if (date('YmdHis') > $arrUserInfo['exp_tm']) {
			Logger::debug('expired');
			$this->response->setRedirect('http://xso.nate.com/exp_logout.jsp?redirect='.urlencode($this->_getRequestUri()));
		}

		$user = User::instance($arrUserInfo['cust_mng_num']);
		$user->nate->setNateId($arrUserInfo['user_id']);
		$user->nate->setMail($arrUserInfo['mail']);
		$user->setGender($arrUserInfo['gender']);
		$user->setBirthday($arrUserInfo['dob']);
		$user->setLunar($arrUserInfo['lunar']);
		$user->setRealAge($arrUserInfo['realage']);
		$user->setRealName($arrUserInfo['realname']);

		$cyId     = $this->request->getCookie('ETC', 'cj');
		$nickname = $this->_unescape($this->request->getCookie('ETC', 'nick'));

		$user->cyworld->setCyId($cyId);
		$user->nate->setNickName($nickname);

		return $user;
	} /*}}}*/

	private function _unescape($source) /*{{{*/
	{
		$decodedStr = '';
		$pos        = 0;
		$len        = strlen($source);
		while ($pos < $len) {
			$charAt = $source[$pos];
			if ($charAt == '%') {
				$pos++;
				$charAt = $source[$pos];
				if ($charAt == 'u') {
					// we got a unicode character
					$pos++;
					$unicodeHexVal = substr($source, $pos, 4);
					$decodedStr .= mb_convert_encoding(pack('H*', $unicodeHexVal), 'utf-8', 'utf-16');
					/*
					$unicode       = hexdec($unicodeHexVal);
					$entity        = '&#' . $unicode . ';';
					$decodedStr .= utf8_encode($entity);
					*/
					$pos += 4;
				}
				else {
					// we have an escaped ascii character
					$hexVal = substr($source, $pos, 2);
					$decodedStr .= chr(hexdec($hexVal));
					$pos += 2;
				}
			} else {
				$decodedStr .= $charAt;
				$pos++;
			}
		}
		return $decodedStr;
	} /*}}}*/

	private function _getRequestUri() /*{{{*/
	{
		parse_str($_SERVER['QUERY_STRING'], $arrUrl);
		unset($arrUrl['action']);

		$queryString = '';
		if (count($arrUrl) > 0) {
			$queryString = '?' . http_build_query($arrUrl);
		}

		return 'http://' . $_SERVER['HTTP_HOST'] . Podo::getActionStr() . $queryString;
	} /*}}}*/

	protected function redirectLoginPage() /*{{{*/
	{
		if ($this->myUser !== null) {
			return;
		}

		$this->response->setRedirect('http://xo.nate.com/login.jsp?redirect='.$this->_getRequestUri());
	} /*}}}*/

	protected function alertAndGoBack($msg) /*{{{*/
	{
		echo '<script>alert(' . json_encode($msg) . ');window.history.back();</script>';
		exit;
	} /*}}}*/
}
?>
