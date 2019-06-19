<?php
class ListController extends BaseController
{
	/**
	 * 메시지 목록 <ul> ... </ul>
	 * 
	 * @param string $startIdx 이 번호 다음에 해당하는 메시지부터 읽어온다.
	 * @param int $sort 정렬 순서
	 * @param int $listType 나의 커넥팅 보기 할 때 사용
	 * @param string $senderCmn 이 사용자가 등록한 메시지만 읽어온다.
	 */
	public function doMessagesAjax() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'startIdx' => '',
		                               'sort' => '',
		                               'senderCmn' => '',
		                           ));

		$sender = null;
		if ($this->request->senderCmn) {
			$sender = User::instance($this->request->senderCmn);
		}

		if ($this->request->sort == ContainerAPI::LIST_SORT_TWITTER) {
			$messagesResult = ContainerAPI::getTwitterMessages($this->myUser, $this->request->startIdx);
		} else if ($this->request->sort == ContainerAPI::LIST_SORT_TIMELINE) {
			$messagesResult = ContainerAPI::getMessagesTimeline($this->myUser, $this->request->startIdx);
		} else {
			$messagesResult = ContainerAPI::getMessages($this->myUser, $this->request->startIdx, $this->request->sort, '', $sender);
		}

		$this->response->messages     = $messagesResult['messages'];
		$this->response->nextStartIdx = $messagesResult['nextStartIdx'];
		$this->response->sort         = $this->request->sort;
	} /*}}}*/

	/**
	 * 이미지 보기
	 */
	public function doViewImage() /*{{{*/
	{
		$this->request->setDefault(array('imgurl' => null));
	} /*}}}*/
}
?>
