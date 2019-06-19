<?php
class TwitterController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 연동하기
	 */
	public function doLink() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'name' => '',
		                               'nate_id' => '',
		                               'token' => '',
		                               'token_secret' => '',
		                               'screen_name' => '',
		                           ));

		$this->user->setRealname($this->request->name);
		$this->user->setNateId($this->request->nate_id);
		$result = $this->user->linkAtTwitter($this->request->token, $this->request->token_secret, $this->request->screen_name, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 연동해제
	 */
	public function doUnlink() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'blog_url' => '',
		                           ));

		$result = $this->user->unlinkAtTwitter($this->request->blog_url, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 홈타임라인 가져오기
	 */
	public function doHomeTimeline() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'page' => 1,
		                               'rows' => 10,
		                               'since_id' => '',
		                               'max_id' => '',
		                           ));
		$result = $this->user->getHomeTimelineAtTwitter($this->request->page, $this->request->rows, $this->request->since_id, $this->request->max_id, $this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 유저타임라인 가져오기
	 */
	public function doUserTimeline() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'page' => 1,
		                               'rows' => 10,
		                               'since_id' => '',
		                               'max_id' => '',
		                           ));
		$result = $this->user->getUserTimelineAtTwitter($this->request->page, $this->request->rows, $this->request->since_id, $this->request->max_id, $this->svcAccount);
		$this->display($result);
	} /*}}}*/
}
?>
