<?php
class Invite1Controller extends Podo_Controller_Base
{
	public function doAccept() /*{{{*/
	{
	} /*}}}*/

	public function doAdd() /*{{{*/
	{
		$this->request->setDefault(
		                              array('cmn' => '',
		                                    'name' => '',
		                                   ));
		$this->response->cmn  = $this->request->cmn;
		$this->response->name = $this->request->name;


		$this->response->group = 'skcomms';
	} /*}}}*/

	public function doSend() /*{{{*/
	{
		$this->request->setDefault(
		                              array('id' => '',
		                                   ));
		$this->response->setRedirect('/invite1/result?id='.$this->request->id);
	} /*}}}*/

	public function doResult() /*{{{*/
	{
		$this->response->id = $this->request->id;
	} /*}}}*/
}
?>
