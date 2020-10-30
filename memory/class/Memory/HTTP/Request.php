<?php
class Memory_HTTP_Request extends HTTP_Request
{
	public function __construct($url = '', $params = array())
	{
		if (isset($params['readTimeout']) === false) {
			$params['readTimeout'] = array(ConfigManager::get('Memory_HTTP_Request.timeout'), 0);
		}
		if (isset($params['timeout']) === false) {
			$params['timeout'] = ConfigManager::get('Memory_HTTP_Request.timeout');
		}

		parent::__construct($url, $params);
	}

	function sendRequest($saveBody = true) /*{{{*/
	{
		$stm    = microtime(true);
		$retval = parent::sendRequest($saveBody);
		$etm    = microtime(true);

		Logger::log('http_request', 1, '['.date('Y-m-d H:i:s')."]\t".$this->getResponseCode()."\t".number_format(($etm-$stm)*1000, 2)." ms\t".$this->_url->url);

		return $retval;
	} /*}}}*/
}
?>
