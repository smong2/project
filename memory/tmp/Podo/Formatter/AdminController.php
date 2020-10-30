<?php
class AdminController extends Podo_Controller_Base
{
	public function __preProcessor()
	{
		parent::__preProcessor();

	}

	public function doIndex()
	{
		$services = Service::getServices();
		$this->response->services = $services;
	}

	public function doAddSvc()
	{
		$this->request->setDefault(array(
									   'svc_id' => null,
									   'svc_pwd' => null,
								   ));

		if (isset($this->request->svc_id) == false || isset($this->request->svc_pwd) == false) {
			$this->alertAndGoBack('계정을 입력해주십시오');
		}

		$service = Service::instance($this->request->svc_id);
		$service->setServiceKey($this->request->svc_pwd);

		if ($service->isDuplicate() == true) {
			$this->alertAndGoBack('이미 등록된 계정입니다');
		}

		$service->add();
		$this->alertAndGoBack('등록되었습니다');

	}

	public function doDelete()
	{
		$this->request->setDefault(array(
									'svc_id' => null,
									));

		if (isset($this->request->svc_id) == false) {
			$this->alertAndGoBack('잘못된 접근입니다');
		}

		$service = Service::instance($this->request->svc_id);
		$service->delete();
		$this->response->setRedirect('/admin/index');
	}

	public function doUpdateUse()
	{
		$this->request->setDefault(array(
									'svc_id' => null,
									'use_fl' => null,
									));

		if (isset($this->request->svc_id) == false || isset($this->request->use_fl) == false) {
			$this->alertAndGoBack('잘못된 접근입니다');
		}

		$service = Service::instance($this->request->svc_id);
		
		if ($this->request->use_fl == Service::USE_Y) {
			$service->updateUseN();
		} else {
			$service->updateUseY();
		}

		$this->response->setRedirect('/admin/index');
	}

	protected function alertAndGoBack($msg) /*{{{*/
	{
		echo '<script>alert(' . json_encode($msg) . ');window.history.back();</script>';
		exit;
	} /*}}}*/

	}
?>
