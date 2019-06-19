<?php
class FollowController Extends BaseController
{
	const SORT_BY_DATE = 1;
	const SORT_BY_NAME = 2;

	/**
	 * Follow 목록 조회
	 */
	public function doFollowerList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'domain' => '',
		                               'page' => 1,
		                               'rows' => 10,
		                               'sort_type' => self::SORT_BY_DATE,
		                               'sch_type' => '',
		                               'sch_value' => '',
		                           ));


		$result = $this->user->getFollowerList($this->request->domain, $this->request->page, $this->request->rows, $this->request->sort_type, $this->request->sch_type, $this->request->sch_value, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * Following 목록 조회
	 */
	public function doFollowingList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'domain' => '',
		                               'page' => 1,
		                               'rows' => 10,
		                               'sort_type' => self::SORT_BY_DATE,
		                               'sch_type' => '',
		                               'sch_value' => '',
		                           ));


		$result = $this->user->getFollowingList($this->request->domain, $this->request->page, $this->request->rows, $this->request->sort_type, $this->request->sch_type, $this->request->sch_value, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * Following 맺기
	 */
	public function doAdd() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'user_name' => '',
		                               'user_nate_id' => '',
		                               'following_cmn' => '',
		                           ));

		$result = $this->user->addFollow($this->request->user_name, $this->request->user_nate_id, $this->request->following_cmn, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * Following 끊기
	 */
	public function doDelete() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'following_cmn' => '',
		                           ));
		$result = $this->user->deleteFollow($this->request->following_cmn, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * Following 관계 여부 확인
	 */
	public function doIsFollowing() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'cmn_list' => '',
		                           ));

		$result = ContainerAPI::IsFollowing($this->user, $this->request->cmn_list, $this->svcAccount);
		$this->display($result);
	} /*}}}*/
}
?>
