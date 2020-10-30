<?php
class MineController extends BaseController
{
	/** 
	 * 네이트온 토스트창 사용여부 설정
	 */
	public function doUpdateToast()/*{{{*/
	{
		$this->request->setDefault(array(
		                               'toastYN' => '',
		                           ));
		try {
			if ($this->request->toastYN == '') {
				$this->json->result = false;
				return;
			}

			$this->json->toastYN = '';
			$this->myUser->setToastYN($this->request->toastYN);

			if ($this->myUser->updateToast()) {
				$this->json->toastYN = $this->request->toastYN;
				$this->json->result = true;
				return;
			} 

			$this->json->result = false;
		} catch (Exception $e) {
			$this->json->result = false;
		}
	}/*}}}*/

	/**
	 * 사용자 닉네임 설정
	 */
	public function doUpdateShowNickname()/*{{{*/
	{
		$this->request->setDefault(array(
									   'show_nickname' => '',
		                           ));
		try {
			if ($this->request->show_nickname == '') {
				$this->json->result = false;
				return;
			}

			$this->myUser->setShowNickname($this->request->show_nickname);

			if($this->myUser->updateShowNickname()) {
				$this->json->result = true;
				return;
			}

			$this->json->result = false;
		} catch (Exception $e) {
			$this->json->result = false;
		}
	}/*}}}*/
}
?>
