<?php
class MainController extends BaseController
{
	const NATEON_BRIDGE_CODE = 'G120';

	/**
	 * 네이트온 커넥팅 탭 메인
	 * 
	 * @param string $t 네이트온에서 전달해주는 토큰, 로그인을 유지하기 위해 필요하다.
	 * @param int $listType 나의 커넥팅 보기 할 때 사용
	 */
	public function doIndex() /*{{{*/
	{
		$this->request->setDefault(array(
		                               't' => '',
		                           ));
		$this->response->memberCnt = $this->myUser->balloonView();
	} /*}}}*/

	public function doNotFound() /*{{{*/
	{
	} /*}}}*/

	/**
	 * 네이트온 커넥팅 탭 메인 > IFRAME 내부 메시지 목록 창
	 * 
	 * @param int $sort 정렬 순서
	 * @param int $listType 나의 커넥팅 보기 할 때 사용
	 * @param int $senderCmn 특정 사용자가 보낸 커넥팅만 볼 때 사용
	 */
	public function doList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'sort' => ContainerAPI::LIST_SORT_ALL,
		                               'senderCmn' => '',
		                           ));

		if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_ALL) {
			$currMenuTitle = '전체';
		} 
		else if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_MINE_COMMENT) {
			$currMenuTitle = '내 커넥팅의 최근 댓글 순';
		}
		else if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_MINE) {
			$currMenuTitle = '나의 커넥팅';
		}
		else if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_COMMENT) {
			$currMenuTitle = '전체 최근 댓글 순';
		}
		else if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_FRIEND) {
			$currMenuTitle = '일촌+친구의 커넥팅';
		} 
		else if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_TWITTER) {
			$currMenuTitle = '트위터';
		}
		else if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_TIMELINE) {
			$currMenuTitle = '실시간 커넥팅';
		} else {
			$currMenuTitle = '전체';
		}

		$sender = null;
		if ($this->request->senderCmn) {
			$sender = User::instance($this->request->senderCmn);
		}
		
		if (strval(trim($this->request->sort)) == ContainerAPI::LIST_SORT_TWITTER) {
			$messagesResult = ContainerAPI::getTwitterMessages($this->myUser);
		} else {
			$messagesResult = ContainerAPI::getMessages($this->myUser, '', $this->request->sort, '', $sender, 10);
		}

		$this->response->messages      = $messagesResult['messages'];
		$this->response->currMenuTitle = $currMenuTitle;
		$this->response->sort= $this->request->sort;
	} /*}}}*/

	/**
	 * 네이트온 커넥팅 탭 메인 > 나의 커넥팅 상태
	 */
	public function doMine() /*{{{*/
	{
		$this->response->enableExtBlogs = ExtBlogPeer::retrieveEnableExtBlogs();

		$myBlogs = array();

		if ($this->myUser->getMyExtBlogs() == false) {
			$this->response->myBlogs = false;
		} else {
			foreach ($this->myUser->getMyExtBlogs() as $blog) {
				$myBlogs[] = $blog->getBlogId();
			}
			$this->response->myBlogs = $myBlogs;
		}
	} /*}}}*/

	public function doSsoRequired() /*{{{*/
	{
		if ($this->myUser->isNateAccount()) {
			$this->response->setRedirect('/');
		}
	} /*}}}*/

	public function doSsoComplete() /*{{{*/
	{
	} /*}}}*/

	/**
	 * 정기점검 페이지
	 */
	public function doRoutinCheck() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'startTime' => '',
		                               'endTime' => '',
		                           ));

		$this->response->startTime = $this->request->startTime;
		$this->response->endTime   = $this->request->endTime;
	} /*}}}*/

	/**
	 * 임시점검 페이지
	 */
	public function doTemperCheck() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'startTime' => '',
		                               'endTime' => '',
		                           ));
		$this->response->startTime = $this->request->startTime;
		$this->response->endTime   = $this->request->endTime;
	} /*}}}*/

	/**
	 * 말풍선 확인
	 */
	public function doCheckBalloon() /*{{{*/
	{
		$this->myUser->balloonCheck($this->request->balloon_type);
		exit;
	} /*}}}*/
}
?>
