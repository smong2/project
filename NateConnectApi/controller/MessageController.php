<?php
class MessageController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	/*
	 * 1. 메시지 조회 (list)
	 */
	public function doList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'domain' => '',
		                               'viewer_cmn' => '',
		                               'source_type' => Message::SOURCE_TYPE_ALL,
		                               'list_type' => ContainerAPI::LIST_TYPE_ALL,
		                               'sender_cmn' => '',
		                               'rows' => 10,
		                               'sort' => ContainerAPI::SORT_BY_CREATE_DT,
		                               'start_idx' => '',
		                               'open_yn' => '',
		                           ));

		$sender = null;

		if (trim($this->request->sender_cmn)) {
			$sender = User::instance($this->request->sender_cmn);
		}

		$messages = $this->user->getMessages($this->request->start_idx, $this->request->sort, $this->request->source_type, $this->request->list_type, $sender, $this->request->rows, $this->request->open_yn, $this->request->domain, $this->request->viewer_cmn, $this->svcAccount);

		$this->display($messages);
	} /*}}}*/

	/*
	 * 1. 메시지 조회 - 전체 공개 (list)
	 */
	public function doTimeline() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'rows' => 10,
		                               'start_idx' => '',
		                           ));

		$messages = $this->user->getMessagesTimeline($this->request->rows, $this->request->start_idx, $this->svcAccount);

		$this->display($messages);
	} /*}}}*/

	/*
	 * 1. 메시지 조회 (home)
	 */
	public function doHome() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'source_type' => Message::SOURCE_TYPE_ALL,
		                               'list_type' => ContainerAPI::LIST_TYPE_ALL,
		                               'sender_cmn' => '',
		                               'rows' => 10,
		                               'sort' => ContainerAPI::SORT_BY_CREATE_DT,
		                               'start_idx' => '',
		                           ));

		$sender = null;

		if (trim($this->request->sender_cmn)) {
			$sender = User::instance($this->request->sender_cmn);
		}

		$messages = $this->user->getHomeMessages($this->request->start_idx, $this->request->sort, $this->request->source_type, $this->request->list_type, $sender, $this->request->rows, $this->svcAccount);

		$this->display($messages);
	} /*}}}*/

	/*
	 * 1. 메시지 조회 (home)
	 */
	public function doListV1() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'rows' => 10,
		                               'start_idx' => '',
		                               'source_type' => Message::SOURCE_TYPE_ALL,
		                               'list_type' => ContainerAPI::LIST_TYPE_ALL,
		                               'sender_cmn' => '',
		                               'sort' => ContainerAPI::SORT_BY_CREATE_DT,
		                           ));

		$sender = null;

		if (trim($this->request->sender_cmn)) {
			$sender = User::instance($this->request->sender_cmn);
		}

		$messages = ContainerAPI::getMessagesV1($this->user, $this->request->start_idx, $this->request->sort, $this->request->source_type, $this->request->list_type, $sender, $this->request->rows, $this->svcAccount);

		$this->display($messages);
	} /*}}}*/

	/**
	 * 2. 메시지 등록 
	 */
	public function doAdd() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message' => '',
		                               'profile_type' => User::PROFILE_TYPE_CUSTOM,
		                               'comment' => '',
		                               'open_yn' => Message::OPEN_N,
		                               'msg_open_default' => '',
		                               'send_twitter' => Message::SEND_TWITTER_N,
		                               'from_title' => '',
		                               'from_url' => '',
		                           ));

		$message = Message::instance('');
		$sender  = null;

		$message->setMessage($this->request->message);
		$message->setProfileType($this->request->profile_type);
		$message->setSender($this->user);
		$message->setComment($this->request->comment);
		$message->setOpenYn($this->request->open_yn);
		$message->setMsgOpenDefault($this->request->msg_open_default);
		$message->setSendTwitter($this->request->send_twitter);
		$message->setFromTitle($this->request->from_title);
		$message->setFromUrl($this->request->from_url);

		// 메시지 등록
		$result = $message->addMessage($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 3. 메시지 삭제
	 */
	public function doDelete() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_key' => ''
		                           ));

		$message = Message::instance($this->request->message_key);
		$message->setSender($this->user);
		$result = $message->delete($this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 4. 단일 메시지 조회
	 */
	public function doView() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_key' => '',
		                               'message_id' => '',
		                               'clear_alarm' => Message::CLEAR_ALARM_N,
		                           ));

		$message = Message::instance($this->request->message_key);
		$message->setMessageId($this->request->message_id);
		$result = $message->viewMessage($this->user, $this->request->clear_alarm, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 5. 메시지 알람
	 */
	public function doAlarm() /*{{{*/
	{
		$result = $this->user->messageAlarm($this->svcAccount);
		$this->display($result);
	} /*}}}*/

	/**
	 * 6. 리커넥팅하기
	 */
	public function doReconnect() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'reconnect_key' => '',
		                               'comment' => '',
		                           ));

		$message = Message::instance($this->request->reconnect_key);
		$message->setReconnectKey($this->request->reconnect_key);
		$message->setComment($this->request->comment);

		$result = $message->reconnect($this->user, $this->svcAccount);
		$this->display($result);
	} /*}}}*/
}
?>
