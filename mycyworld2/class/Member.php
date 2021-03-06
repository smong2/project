<?php
require_once 'XML/Unserializer.php';

class Member extends BaseObject
{
	protected $__userId;
	protected $__name;

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

	protected function __construct($userId) /*{{{*/
	{
		$this->__userId = $userId;
	} /*}}}*/

	public function getUserInfo() /*{{{*/
	{
		$url     = 'http://api.connect.nate.com/user/show';
		$request = new HTTP_Request($url);
		$request->setMethod(HTTP_REQUEST_METHOD_POST);

		$params        = array();
		$params['cmn'] = $this->getUserId();

		foreach ($params as $key=>$val) {
			$request->addPostData($key, $val);
		}

		$request->sendRequest();

		// parsing - start

		$options      = array(XML_UNSERIALIZER_OPTION_FORCE_ENUM => array('post'));
		$unserializer = new XML_Unserializer($options);
		$status       = $unserializer->unserialize($request->getResponseBody());

		if (PEAR::isError($status)) {
			trigger_error('ContainerAPI::getMessageList() - XML 파싱 에러', E_USER_WARNING);
			return false;
		}

		$result = $unserializer->getUnserializedData();
		// parsing - end

		return $result;
	} /*}}}*/
}
?>
