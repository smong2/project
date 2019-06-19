<?php
require_once 'XML/Unserializer.php';

class ContainerAPI
{
	/**
	 * Container 서버에 요청한다.
	 * 
	 * @param string $url 요청할 URL, PATH(ex. /message/list.nate)만 넘긴다.
	 * @param array $params {key: value, ...} 형식으로 전달한다.
	 * @param array $forceEnum 한 개짜리 Element 라도 array 로 반환할 태그를 반환한다.
	 * 
	 * @return array XML을 array로 변환하여 반환한다. 에러가 발생할 경우는 false를 반환한다.
	 */
	private function _sendRequest($url, array $params, array $forceEnum = array(), $isTextPlain = false) /*{{{*/
	{
		// HTTP Request
		$request = new HTTP_Request($url);
		$request->setMethod(HTTP_REQUEST_METHOD_POST);
		foreach ($params as $key=>$val) {
			$request->addPostData($key, $val);
		}

		$request->sendRequest();

		if ($request->getResponseCode() != '201') {
			return false;
		}

		// XML Parsing
		$xml = $request->getResponseBody();

		$options      = array(XML_UNSERIALIZER_OPTION_FORCE_ENUM => $forceEnum);
		$unserializer = new XML_Unserializer($options);

		$status = $unserializer->unserialize($xml);
		$xml = json_decode($xml);

		return $xml;
	} /*}}}*/
}
?>
