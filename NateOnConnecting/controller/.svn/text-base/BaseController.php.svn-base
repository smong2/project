<?php
class BaseController extends Podo_Controller_Base
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();

		if (Podo_Util_String::startWith(Podo::getActionStr(), array('/routinCheck', '/temperCheck')) === false) {

			$this->request->setDefault(array(
										   't' => '',
									   ));

			// 토큰 값을 읽어와서 템플릿에 전달한다.
			if ($this->request->t) {
				$this->cookie->setCookie('token', $this->request->t);
				$this->response->token = $this->token = $this->request->t;
			}
			else {
				$this->response->token = $this->token = $this->cookie->getCookie('token');
			}
			$t                          = nateon_ticket($this->token);
			$this->response->expireTime = $t['utcexpire'];

			if ($t == false || isset($t) == false) {
				$this->alertAndClose('네이트온 탭을 통해서만 접근 가능합니다');
			}

			// 로그인 유저 정보를 읽어온다.
			$this->response->myUser = $this->myUser = $this->_retrieveMyUser();
			
			// 로그인 하지 않은 경우 처리
			if ($this->myUser->isLogged() === false) {
				$this->response->setRedirect('http://xo.nate.com/login.jsp?redirect='.$this->_getRequestUrl());
			}

			// Only 싸이 사용자일 경우 처리
			if (Podo_Util_String::startWith(Podo::getActionStr(), array('/main/ssoRequired')) === false && $this->myUser->isNateAccount() == false) {
				$this->response->setRedirect('/main/ssoRequired');
			}
		}
			// Request 배열 처리
			$this->response->request = $this->request;
	} /*}}}*/

	private function _getRequestUrl() /*{{{*/
	{
		parse_str($_SERVER['QUERY_STRING'], $params);
		$action = '';
		if (isset($params['action'])) {
			$action = $params['action'];
			unset($params['action']);
		}

		$queryString = '';
		if (count($params) > 0) {
			$queryString = '?' . http_build_query($params);
		}

		return 'http://' . $_SERVER['HTTP_HOST'] . $action . urlencode($queryString);
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

	private function _retrieveMyUser() /*{{{*/
	{
		static $sCacne;

		if (isset($sCacne) === false) {
			try {
				/***** 네이트 로그인 정보 처리 *****/
				if (isset($_COOKIE['GUID']) && isset($_COOKIE['ENC'])) {
					// ENC 쿠키를 복호화해서 정보를 읽어온다.
					$strEnc = decrypt($_COOKIE['GUID'], $_COOKIE['ENC']);
					$arrEnc = explode(';', $strEnc);
					foreach ($arrEnc as $knv) {
						if (strpos($knv, '=') === false) {
							continue;
						}

						list($key, $value) = explode('=', $knv, 2);
						$arrUserInfo[$key] = $value;
					}

					// 실명은 cp949 로 저장되어있어서 utf-8 로 변환한다.
					$arrUserInfo['cn'] = mb_convert_encoding(enc_get_value($strEnc, 'cn'), 'utf-8', 'cp949');
				}
				else {
					$arrUserInfo['cust_mng_num'] = '';
				}

				/***** 싸이월드 로그인 정보 처리 *****/
				// 로그인 한 경우는 CFN 쿠키는 항상 있다.
				if (isset($_COOKIE['CFN']) === false) {
					throw new Exception();
				}

				// CFN 쿠키를 복호화해서 정보를 읽어온다.
				$strCfn = cfn_decrypt($_COOKIE['CFN']);
				$strCfn = mb_convert_encoding($strCfn, 'utf-8', 'cp949');
				$arrCfn = explode('|^|', $strCfn);
				foreach ($arrCfn as $knv) {
					if (strpos($knv, '|=|') === false) {
						continue;
					}

					list($key, $value) = explode('|=|', $knv);
					if (isset($arrUserInfo[$key])) {
						continue;
					}

					$arrUserInfo[$key] = $value;
				}

				// cust_mng_num 이 없으면 로그인을 안한 경우이다.
				if (isset($arrUserInfo['cmn']) == false || $arrUserInfo['cmn'] == '') {
					throw new Exception();
				}

				/***** expire_tm 체크 *****/
				if (date('YmdHis') > $arrUserInfo['exp_tm']) {
					$this->response->setRedirect('http://xso.nate.com/exp_logout.jsp?redirect='.urlencode($this->_getRequestUrl()));
				}

				/***** User 객체 생성 *****/
				$myUser = User::instance($arrUserInfo['cust_mng_num']);
				$myUser->setIsLogged(1);
				if ($arrUserInfo['cust_mng_num']) {
					$myUser->setNateId($arrUserInfo['user_id']);
					$myUser->setEmail($arrUserInfo['mail']);
					$myUser->setGender($arrUserInfo['gender']);
					$myUser->setBirthday($arrUserInfo['dob']);
					$myUser->setLunar($arrUserInfo['lunar']);
					$myUser->setRealAge($arrUserInfo['realage']);
					$myUser->setRealname($arrUserInfo['cn']);
					$myUser->setRealnameCd($arrUserInfo['realnm_cd']);
				}
				$myUser->setType($arrUserInfo['type']);
				$myUser->setLink($arrUserInfo['link']);

				$cyworldId = $this->request->getCookie('ETC', 'cj');
				$nickname  = $this->_unescape($this->request->getCookie('ETC', 'nick'));

				$myUser->setCyworldId($cyworldId);
				$myUser->setNateNick($nickname);
				$myUser->getUserInfo();
			}
			catch (Exception $e) {
				$myUser = User::instance('');
			}

			$sCache = $myUser;
		}
		return $sCache;
	} /*}}}*/

	protected function alertAndClose($msg) /*{{{*/
	{
		echo '<script>alert(' . json_encode($msg) . ');window.close();</script>';
		exit;
	} /*}}}*/
}
?>
