<?php
class Message_CommentController extends BaseController
{
	/**
	 * 댓글 목록 하단에 보일 페이지 네비게이터
	 * 
	 * @param int $max 가장 마지막 페이지 번호
	 * @param int $curr 현재 페이지 번호
	 * @param strign $senderCmn 메시지 등록 사용자 ID, 페이지 이동을 위하여 필요하다.
	 * @param string $messageId 메시지 ID, 페이지 이동을 위하여 필요하다.
	 */
	public function doPageNavigator() /*{{{*/
	{
		$this->request->setDefault(array(
		                               'max' => 1,
		                               'curr' => 1,
		                               'senderCmn' => null,
		                               'messageKey' => null,
									   'mode'		=> '',
									   'twit_id'	=> '',
		                           ));

		if (isset($this->request->senderCmn) === false || isset($this->request->messageKey) === false) {
			exit;
		}

		$maxPage   = $this->request->max;
		$currPage  = $this->request->curr;
		$pageBlock = 10;

		if ($currPage < 1) {
			$currPage = 1;
		}

		if ($currPage > $maxPage) {
			$currPage = $maxPage;
		}

		$firstPage        = (int)(($currPage-1)/$pageBlock) * $pageBlock + 1;
		$lastPage         = min(((int)(($currPage-1)/$pageBlock)+1)*$pageBlock, $maxPage);
		$prevPage         = max($firstPage-1, 1);
		$nextPage         = min($lastPage+1, $maxPage);
		$dblPrevPage      = 1;
		$dblNextPage      = $maxPage;
		$isShowPrevBtn    = (bool)($firstPage > 1);
		$isShowNextBtn    = (bool)($lastPage < $maxPage);
		$isShowDblPrevBtn = $isShowPrevBtn;
		$isShowDblNextBtn = $isShowNextBtn;

		$this->response->currPage         = $currPage;
		$this->response->firstPage        = $firstPage;
		$this->response->lastPage         = $lastPage;
		$this->response->prevPage         = $prevPage;
		$this->response->nextPage         = $nextPage;
		$this->response->dblPrevPage      = $dblPrevPage;
		$this->response->dblNextPage      = $dblNextPage;
		$this->response->isShowPrevBtn    = $isShowPrevBtn;
		$this->response->isShowNextBtn    = $isShowNextBtn;
		$this->response->isShowDblPrevBtn = $isShowDblPrevBtn;
		$this->response->isShowDblNextBtn = $isShowDblNextBtn;
		$this->response->mode			  = $this->request->mode;
		$this->response->twit_id		  = $this->request->twit_id;
	} /*}}}*/

	/**
	 * 댓글 삭제하기
	 *
	 * @param string $senderCmn 메시지 작성자
	 * @param string $messageKey 메시지 Key
	 * @param string $commentId 댓글 ID
	 */
	public function doDelete()/*{{{*/
	{
		$this->request->setDefault(array(
			'senderCmn' => null,
			'messageKey' => null,
			'commentKey' => null,
			'mode'		 => '',
		));

		try {
			if (isset($this->request->senderCmn) === false || isset($this->request->messageKey) === false || isset($this->request->commentKey) === false) {
				throw new Exception();
			}

			$comment = Comment::instance($this->request->commentKey);
			$message =Message::instance($this->request->messageKey);

			$comment->setMessage($message);
			$comment->getMessage()->setSender(User::instance($this->request->senderCmn));

			$this->json->result = $comment->delete($this->myUser, $this->request->mode);
		} catch (Exception $e) {
			$this->json->result = false;
		}
	}/*}}}*/
}
?>
