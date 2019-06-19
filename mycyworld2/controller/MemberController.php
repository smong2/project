<?php
class MemberController extends Podo_Controller_Base
{
	public function doUserInfo() /*{{{*/
	{
		$this->request->setDefault(
		                              array('cmn' => '',
		                                   ));

		$this->response->cmn = '';

		if ($this->request->cmn) {
			$api = Member::instance(0);
			$api->setUserId($this->request->cmn);
			$result = $api->getUserInfo();

			$this->response->user = $result['profile'];
			$this->response->cmn  = $this->request->cmn;
			Logger::debug($this->response->user);
			Logger::debug($result);
		}
	} /*}}}*/

	public function doFormatting() /*{{{*/
	{
		$a   = 2231314143;
		$b   = 11231;
		$aaa = '111';

		if ($a == 1) {
			echo '1';
		}
	} /*}}}*/

	/**
	 * 테스트용 비밀 게시판 클래스 
	 * @param string $name 작성자명
	 * @param string $subject 제목
	 * @param string $content 내용
	 */
	public function doSecretBoard() /*{{{*/
	{
		$board = Board::instance(11231312);
		$board->setName('테스터');
		$board->setRegDt('2011-05-19');
		$board->transTimeformat();


		$member = Member::instance('infra');

		$board->setMember($member);

		$this->response->board = $board;
	} /*}}}*/

	public function doPublicViewConnecting() /*{{{*/
	{
		$testArr             = array('1', '2', '3');
		$this->response->arr = $testArr;
	} /*}}}*/
}
?>
