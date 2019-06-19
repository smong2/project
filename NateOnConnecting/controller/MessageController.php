<?php
class MessageController extends BaseController
{
	/**
	 * 커넥팅 글 등록하기
	 * 
	 * @param string $message 메시지 내용 
	 * @param string $open_yn 공개여부 (y/n)
	 * @param string $send_twitter 트위터로 보낼 것인지 여부(y/n)
	 * @param string $msg_open_default 메시지 전송 상태 저장 여부
	 */
	public function doAdd() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message' => null,
		                               'open_yn' => null,
		                               'send_twitter' => null,
		                               'msg_open_default' => Message::MSG_OPEN_DEFAULT_Y,
		                           ));

		try {
			$message = Message::instance(0);
			$message->setMessage($this->request->message);
			$message->setOpenYN($this->request->open_yn);
			$message->setProfileType(User::PROFILE_TYPE_CUSTOM);

			$this->json->descript = '';

			$result = $this->json->result = $message->add($this->myUser, $this->request->msg_open_default, $this->request->send_twitter);

			if ($result === true) {
				$this->json->result = true;
			} elseif (eregi(ContainerAPI::CHECK_FORBID_WORD, $result)) {
				$this->json->result   = ContainerAPI::CHECK_FORBID_WORD;
				$this->json->descript = str_replace(ContainerAPI::CHECK_FORBID_WORD.' '.ContainerAPI::FORBID_WORD_TEXT, '', $result);
			} else {
				$this->json->result = $result;
			}
		} catch (Exception $e) {
			$this->json->result = false;
		}
	} /*}}}*/

	/**
	 * 커넥팅 글 삭제하기
	 * 
	 * @param string $senderCmn 커넥팅 글쓴이
	 * @param string $messageId 메시지 ID
	 */
	public function doDelete() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'senderCmn' => null,
		                               'messageKey' => null,
		                               'listType' => null,
		                               'sort' => null,
		                           ));

		try {
			if (isset($this->request->senderCmn) === false || isset($this->request->messageKey) === false) {
				throw new Exception();
			}

			$message = Message::instance($this->request->messageKey);
			$message->setSender(User::instance($this->request->senderCmn));

			if ($message->getSender()->getUserId() != $this->myUser->getUserId()) {
				throw new Exception();
			}

			$this->json->result = $message->delete();
		} catch (Exception $e) {
			$this->json->result = false;
		}
	} /*}}}*/

	/**
	 * 댓글 목록 <ul> ... </ul> 
	 * 
	 * @param strign senderCmn 메시지 등록 사용자 ID
	 * @param string messageId 메시지 ID
	 * @param int page 페이지 번호
	 * @param string $mode 댓글 분류 - 트위터 댓글일 때 twit 사용
	 * @param string $twit_id 트위터 댓글 시 필요한 screen_name
	 * @param int page 페이지 번호
	 */
	public function doCommentsAjax() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'senderCmn' => null,
		                               'messageKey' => null,
		                               'page' => -1,
		                               'mode' => '',
		                               'twit_id' => '',
		                           ));

		if (isset($this->request->senderCmn) === false || isset($this->request->messageKey) === false) {
			exit;
		}

		$page = $this->request->page;

		$message = Message::instance($this->request->messageKey);
		$message->setSender(User::instance($this->request->senderCmn));
		$message->setTwitId($this->request->twit_id);

		$commentsResult = ContainerAPI::getComments($message, $this->myUser, $this->request->mode, $page);

		if ($page == -1) {
			$page = $commentsResult['totalPages'];
		}

		if ($page > $commentsResult['totalPages'] && $page > 1) {
			$commentsResult = ContainerAPI::getComments($message, $this->myUser, $this->request->mode, $commentsResult['totalPages']);
		}

		$this->response->message       = $message;
		$this->response->comments      = $commentsResult['comments'];
		$this->response->totalPages    = $commentsResult['totalPages'];
		$this->response->totalComments = $commentsResult['totalComments'];
		$this->response->page          = $page;
		$this->response->mode          = $this->request->mode;
		$this->response->twit_id       = $this->request->twit_id;
	} /*}}}*/

	/**
	 * 댓글 추가하기
	 * 
	 * @param string $senderCmn 메시지 작성자
	 * @param string $messageId 메시지 ID
	 * @param int $isSecret 비밀글 여부
	 * @param string $content 댓글 내용
	 * @param string $parent_id 재댓글시 부모 댓글 ID 
	 * @param string $mode 댓글 분류 - 트위터 댓글일 때 twit 사용
	 * @param string $twit_id 트위터 댓글 시 필요한 screen_name
	 */
	public function doAddComment() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'senderCmn' => null,
		                               'messageKey' => null,
		                               'isSecret' => null,
		                               'content' => null,
		                               'parent_id' => '',
		                               'mode' => '',
		                               'twit_id' => '',
		                           ));

		try {
			if (isset($this->request->senderCmn) === false || isset($this->request->isSecret) === false || isset($this->request->content) === false) {
				throw new Exception();
			}

			$message = Message::instance($this->request->messageKey);
			$message->setSender(User::instance($this->request->senderCmn));

			$commentResult = $message->addComment($this->myUser, $this->request->content, $this->request->isSecret, $this->request->mode, $this->request->twit_id, $this->request->parent_id);

			$this->json->descript = '';

			if ($commentResult === true) {
				$this->json->result = true;
			} elseif (eregi(ContainerAPI::CHECK_FORBID_WORD, $commentResult)) {
				$this->json->result   = ContainerAPI::CHECK_FORBID_WORD;
				$this->json->descript = str_replace(ContainerAPI::CHECK_FORBID_WORD.' '.ContainerAPI::FORBID_WORD_TEXT, '', $commentResult);
			} else {
				$this->json->result = $result;
			}
		} catch (Exception $e) {
			$this->json->result = false;
		}
	} /*}}}*/

	/**
	 * 리커넥팅 하기
	 * 
	 * @param string $reconnect_key 리커넥팅키
	 * @param string $comment 댓글을 남기는지
	 */
	public function doReconnect() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'reconnect_key' => null,
		                               'comment' => '',
		                           ));

		try {
			if (isset($this->request->reconnect_key) === false || isset($this->request->comment) === false) {
				throw new Exception();
			}

			$message = Message::instance($this->request->reconnect_key);
			$message->setReconnectKey($this->request->reconnect_key);
			$message->setComment($this->request->comment);
			$result = $message->reconnect($this->myUser);

			$this->json->descript = '';

			if ($result === true) {
				$this->json->result = true;
			} elseif (eregi(ContainerAPI::CHECK_FORBID_WORD, $result)) {
				$this->json->result   = ContainerAPI::CHECK_FORBID_WORD;
				$this->json->descript = str_replace(ContainerAPI::CHECK_FORBID_WORD.' '.ContainerAPI::FORBID_WORD_TEXT, '', $result);
			} else {
				$this->json->result = $result;
			}
		} catch (Exception $e) {
			$this->json->result = false;
		}
	} /*}}}*/

	public function doShortenUrl() /*{{{*/
	{
		try {
			$this->request->setDefault(array(
			                               'url' => null,
			                           ));

			$result             = ContainerAPI::shortenUrl($this->myUser, $this->request->url);
			$this->json->result = $result;
		} catch (Exception $e) {
			$this->json->result = false;
		}
	} /*}}}*/
}
?>
