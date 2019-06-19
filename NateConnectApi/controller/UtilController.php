<?php
class UtilController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	/**
	 * 단축 URL
	 */
	public function doShorten() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'url' => '',
		                               'type' => '',
		                               'service' => '',
		                           ));
		$result = ContainerAPI::shorten($this->user, $this->request->url, $this->request->type, $this->request->service, $this->svcAccount);

		$this->display($result);
	} /*}}}*/
}
?>
