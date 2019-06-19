<?php
class BaseController extends Podo_Controller_Base
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();

		header('Content-Type: text/xml; charset='.ConfigManager::get('Podo.charset'));

		$this->request->setDefault(array(
									'svc_id' => 'open_api',
									'svc_pwd' => 'open_api!',
									'cmn' => '',
									));

		if (trim($this->request->svc_id) == "") {
			$this->display(Code::returnErrMsgByCode(Code::MSG_NONE_SVC_ID));
		}
		if (trim($this->request->svc_pwd) == "") {
			$this->display(Code::returnErrMsgByCode(Code::MSG_NONE_SVC_PWD));
		}
		if (trim($this->request->cmn) == '') {
			$this->display(Code::returnErrMsgByCode(Code::MSG_NONE_USER_CMN));
		}
		if (strlen(trim($this->request->cmn)) != User::CMN_LENGTH) {
			$this->display(Code::returnErrMsgByCode(Code::MSG_INVALID_CMN));
		}

		$this->response->svcAccount = $this->svcAccount = $this->_retrieveSvcAccount();
		$this->response->user =  $this->user = $this->_retrieveUser();

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

	private function _retrieveUser() /*{{{*/
	{
		static $sCache;

		if (isset($sCache) === false) {
			$user = User::instance($this->request->cmn);

			$sCache = $user;
		}
		return $sCache;
	} /*}}}*/

	/** 
	 * service 계정을 처리함
	 */
	private function _retrieveSvcAccount()/*{{{*/
	{
		static $sCacheAcc;

		if (isset($sCacheAcc) === false) {
			$service = Service::instance($this->request->svc_id);
			$service->setServiceKey($this->request->svc_pwd);
			if ($service->isAuth() != true) {
				$this->display(Code::returnErrMsgByCode(Code::MSG_SVC_ERROR));
			}
			$sCacheAcc = $service;
		}
		return $sCacheAcc;
	}/*}}}*/

	/** 
	 * 리턴 결과 출력
	 */
	public function display($xmlData)/*{{{*/
	{
		print_r($xmlData);
		exit;
	}/*}}}*/
}
?>
