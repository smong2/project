<?php
class UserController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	/**
	 ******************************************** 
	 *********** 커넥팅 사용자 정보 조회 ********
	 ********************************************/
	public function doShow() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'domain' => '',
		                               'nickname' => '',
		                           ));
		$this->user->setDomain($this->request->domain);
		$this->user->setNickname($this->request->nickname);
		$result = $this->user->getUserInfo($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 *********** 도메인 닉네임 존재 여부  *******
	 ********************************************/
	public function doExist() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'domain' => '',
		                               'nickname' => '',
		                           ));
		$this->user->setDomain($this->request->domain);
		$this->user->setNickname($this->request->nickname);
		$result = $this->user->checkExistDomainOrNickname($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 *********** 사용자 정보 수정  *******
	 ********************************************/
	public function doUpdate() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'domain' => '',
		                               'nickname' => '',
		                               'profile_image' => '',
		                               'name' => '',
		                               'id' => '',
		                               'toast_yn' => '',
		                               'thome_tl_yn' => '',
		                               'tuser_tl_yn' => '',
		                               'introduce' => '',
		                               'show_nickname' => User::SHOW_NICKNAME_N,
		                           ));
		$this->user->setDomain($this->request->domain);
		$this->user->setNickname($this->request->nickname);
		$this->user->setProfileImage($this->request->profile_image);
		$this->user->setRealname($this->request->name);
		$this->user->setNateId($this->request->id);
		$this->user->setToastYn($this->request->toast_yn);
		$this->user->setTHomeTlYn($this->request->thome_tl_yn);
		$this->user->setTUserTlYn($this->request->tuser_tl_yn);
		$this->user->setIntroduce($this->request->introduce);
		$this->user->setShowNickname($this->request->show_nickname);

		$result = $this->user->update($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 ********** 토스트창 수정하기 ***************
	 *******************************************/
	public function doUpdateToast() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'name' => '',
		                               'id' => '',
		                               'toast_yn' => '',
		                           ));
		$this->user->setRealname($this->request->name);
		$this->user->setNateId($this->request->id);
		$this->user->setToastYn($this->request->toast_yn);
		$result = $this->user->updateToast($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * *****************************************
	 * **** 메시지 보내기 default 값 가져오기 **
	 * ****************************************/
	public function doGetMessageDefault() /*{{{*/
	{
		$result = $this->user->getMessageDefault($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 ****** 커넥팅 상태 - 최초 방문 여부 가려내기 위함
	 ********************************************/
	// status -> 작동 안하고 있음
	public function doStatus() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'mode' => User::VIEW_STAT_MODE_ALL
		                           ));

		$result = $this->user->getStatus($this->request->mode, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 ****** 프로필 이미지 리스트 ****************
	 ********************************************/
	public function doProfileImgs() /*{{{*/
	{
		$result = ContainerAPI::profileImgs($this->user, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 *********** 블로그 연동정보  ***************
	 ********************************************/
	public function doLinkedBlogs() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'page' => 1,
		                               'rows' => 5,
		                           ));

		$result = $this->user->getLinkedBlogs($this->request->page, $this->request->rows, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 *********** 말풍선 보기  *******
	 ********************************************/
	public function doBalloonView() /*{{{*/
	{
		$result = $this->user->getBalloonView($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 ******************************************** 
	 *********** 말풍선 확인  *******
	 ********************************************/
	public function doBalloonCheck() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'balloon_type' => ''
		                           ));
		$result = $this->user->getBalloonCheck($this->request->balloon_type, $this->svcAccount);
		$this->display($result);
	} /*}}}*/
}
?>
