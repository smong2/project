<?php
class ApiController extends Podo_Controller_Base
{
	public function doShorten() /*{{{*/
	{
		$this->request->setDefault(
		                              array('url' => '',
		                                   ));
		$api = Api::instance(0);
		$api->setUrl($this->request->url);
		$jsonResult = $api->shorten();
		$this->response->shortenUrl = $jsonResult;
		$this->response->url        = $this->request->url;
	} /*}}}*/

	public function doHttpRequest()/*{{{*/
	{
		$this->request->setDefault(
		                              array('url' => '',
		                                   ));

		$result = ContainerAPI::getUrl($this->request->url);
		$this->response->result = $result?$result->short_url:'';
	}/*}}}*/
}
?>
