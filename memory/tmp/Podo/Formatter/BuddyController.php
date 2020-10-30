<?php
class BuddyController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	/**
	 * 내가 추가한 피플 목록 조회하기
	 */
	public function doFList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'rows' => 10,
		                               'page' => 1,
		                               'sort_type' => '',
		                               'select_type' => '',
		                               'sch_type' => '',
		                               'sch_value' => '',
									   'm_info_yn' => Buddy::M_INFO_Y,
		                           ));

		$result = ContainerAPI::getFriendList($this->user, $this->request->rows, $this->request->page, $this->request->sort_type, $this->request->select_type, $this->request->sch_type, $this->request->sch_value, $this->request->m_info_yn, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 나를 추가한 친구 목록 조회하기 - 역피플
	 */
	public function doReverseFList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'rows' => 10,
		                               'page' => 1,
		                               'sort_type' => Buddy::SORT_BY_DATE,
		                               'select_type' => '',
		                               'sch_type' => '',
		                               'sch_value' => '',
		                               'block_yn' => '',
		                           ));

		$result = ContainerAPI::getReverseFriendList($this->user, $this->request->rows, $this->request->page, $this->request->sort_type, $this->request->select_type, $this->request->sch_type, $this->request->sch_value, $this->request->block_yn, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 친구 제외하기
	 */
	public function doDelete() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'f_cmn' => '',
		                           ));

		$buddy = Buddy::instance($this->request->f_cmn);
		$result = $buddy->deleteFriend($this->user, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 수신, 수신거부 설정
	 */
	public function doUpdateRecieve() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'f_cmn' => '',
		                               'block_yn' => '',
		                           ));
		$buddy = Buddy::instance($this->request->f_cmn);
		$buddy->setBlockYn($this->request->block_yn);

		$result = ContainerAPI::updateRecieve($this->user, $buddy, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 친구 추가하기
	 */
	public function doAdd() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'name' => '',
		                               'nate_id' => '',
		                               'f_name' => '',
		                               'f_nate_id' => '',
		                               'f_cmn' => '',
		                               'f_tid' => '',
		                               'reg_source' => '',
		                               'user_ip' => '',
		                           ));


		$buddy = Buddy::instance($this->request->f_cmn);
		$buddy->setName($this->request->name);
		$buddy->setNateId($this->request->nate_id);
		$buddy->setFName($this->request->f_name);
		$buddy->setFNateId($this->request->f_nate_id);
		$buddy->setFTid($this->request->f_tid);
		$buddy->setRegSource($this->request->reg_source);
		$buddy->setUserIp($this->request->user_ip);

		$result = $buddy->addFriend($this->user, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 친구 여부 확인
	 */
	public function doIsFriend()/*{{{*/
	{
		$this->request->setDefault(array(
		                               'cmn_list' => '',
								   ));

		$result = ContainerAPI::IsFriend($this->user, $this->request->cmn_list, $this->svcAccount);
		$this->display($result);
	}/*}}}*/
}
?>
