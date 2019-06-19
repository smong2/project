<?php
class CommentController extends BaseController
{
	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();
	} /*}}}*/

	/**
	 * 댓글 등록
	 * @param string $message_id   메시지 ID
	 * @param string $message_cmn  메시지 작성자 cmn
	 * @param string $sender_cmn   댓글 작성자 cmn
	 * @param string $sender_name  댓글 작성자명
	 * @param string $comment      댓글 내용
	 * @param bool   $is_secret    비밀글 여부
	 * @param string $mode 트위터 댓글(twit)/일반 댓글
	 * @param string $twit_id 트위터 스크린명
	 */
	public function doAdd() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_key' => '',
		                               'parent_id' => '',
		                               'comment' => '',
		                               'is_secret' => Comment::IS_SECRET_N,
		                               'mode' => '',
		                               'twit_id' => '',
		                           ));

		$message = Message::instance($this->request->message_key);

		$comment = Comment::instance(0);
		$comment->setParentId($this->request->parent_id);
		$comment->setWriter(User::instance($this->user->getUserId()));
		$comment->setContent($this->request->comment);
		$comment->setIsSecret($this->request->is_secret);

		$comment->setMessage($message);

		$result = $comment->add($this->user, $this->request->mode, $this->request->twit_id, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 댓글 조회 
	 */
	public function doList() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_key' => '',
		                               'page' => 1,
		                               'rows' => 5,
		                               'mode' => '',
		                           ));

		$message = Message::instance($this->request->message_key);

		// 1. 댓글 조회
		$comments = $message->getComments($this->user, $this->request->page, $this->request->rows, $this->request->mode, $this->svcAccount);
		$this->display($comments);
	} /*}}}*/

	public function doListV1() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_id' => '',
		                               'message_cmn' => '',
		                               'page' => 1,
		                               'rows' => 10
		                           ));

		$message = Message::instance($this->request->message_id);
		$message->setMessageId($this->request->message_id);
		$message->setSender(User::instance($this->request->message_cmn));

		// 1. 댓글 조회
		$comments = ContainerAPI::getCommentsV1($this->user, $message, $this->request->page, $this->request->rows, $this->svcAccount);
		$this->display($comments);
	} /*}}}*/
	/**
	 * 댓글 삭제
	 */
	public function doDelete() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_key' => '',
		                               'comment_key' => '',
		                               'mode' => '',
		                           ));

		$comment = Comment::instance($this->request->comment_key);
		$message = Message::instance($this->request->message_key);

		$comment->setMessage($message);

		$result = $comment->delete($this->user, $this->request->mode, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/** 
	 * 댓글 비밀플래그 수정
	 */
	public function doSecret() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'message_id' => '',
		                               'message_cmn' => '',
		                               'comment_id' => '',
		                               'is_secret' => Comment::IS_SECRET_N
		                           ));

		$message = Message::instance($this->request->message_id);
		$message->setMessageId($this->request->message_id);
		$message->setSender(User::instance($this->request->message_cmn));
		$comment = Comment::instance($this->request->comment_id);
		$comment->setMessage($message);
		$comment->setIsSecret($this->request->is_secret);

		$result = $comment->secret($this->user, $this->svcAccount);

		$this->display($result);
	} /*}}}*/

	/**
	 * 댓글 알람
	 */
	public function doAlarm() /*{{{*/
	{
		$result = $this->user->commentAlarm($this->svcAccount);
		$this->display($result);
	} /*}}}*/
}
?>
