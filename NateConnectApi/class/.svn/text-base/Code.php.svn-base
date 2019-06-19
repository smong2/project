<?php
class Code extends BaseObject
{
	protected $__code;
	protected $__codeDesc;

	const MSG_URI        = 600;
	const MSG_CONNECTION = 601;
	const MSG_UNKNOWN    = 602;
	const MSG_NONE_DATA  = 603; // DB 직접 연결인 경우 에러 코드
	const MSG_SVC_ERROR  = 604;

	const MSG_SUCCESS       = 100;
	const MSG_NONE_USER_CMN = 221;
	const MSG_NONE_SVC_ID   = 201;
	const MSG_NONE_SVC_PWD  = 203;
	const MSG_INVALID_CMN   = 222;

	public static $errmsg = array(
	    self::MSG_URI => 'NOT EXIST URI',
	    self::MSG_CONNECTION => 'CONNECTION ERROR',
	    self::MSG_UNKNOWN => 'UNKNOWN ERROR',
	    self::MSG_NONE_DATA => 'NONE DATA',
	    self::MSG_SUCCESS => 'SUCCESS',
	    self::MSG_NONE_USER_CMN => 'NONE cmn',
	    self::MSG_NONE_SVC_ID => 'NONE svc_id',
	    self::MSG_NONE_SVC_PWD => 'NONE svc_pwd',
	    self::MSG_INVALID_CMN => 'INVALID cmn',
	    self::MSG_SVC_ERROR => 'Svc ID/KEY ERROR',
	);

	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk);
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	protected function __construct($code) /*{{{*/
	{
		$this->__code = $code;
	} /*}}}*/

	/**
	 * 에러 출력
	 */
	public function returnErrMsgByCode($errCd = self::MSG_UNKNOWN) /*{{{*/
	{
		$result = array('code' => $errCd, 'codeMsg' => self::$errmsg[$errCd]);
		return ContainerAPI::xmlGenerator($result);
	} /*}}}*/
}
?>
