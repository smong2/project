<?php
class Mybox_ConfigController extends BaseController
{
	public function doIndex() /*{{{*/
	{
		$this->response->setRedirect('basic');
	} /*}}}*/

	/**
	 * 기본정보  페이지
	 */
	public function doBasic() /*{{{*/
	{
		$this->myUser->loadMemoryInfo();
		// 처음 기억한지 몇일 째?
		$this->response->firstMemoryDistance = ceil((time()-$this->myUser->memory->getInsertDt())/86400);
	} /*}}}*/

	/**
	 * 닉네임 중복체크 - AJAX
	 */
	public function doDuplicate() /*{{{*/
	{
		$nick_name = $this->request->nick_name;

		if (!trim($nick_name)) {
			// 공백으로 된 닉네임은 취급 안함
			$this->json = array(true, 0);
		}

		$dup_result = ConfigUserPeer::duplicateCheck($nick_name,$this->myUser->getUserId());

		$this->json = array(true, $dup_result);
	} /*}}}*/

	/**
	 * 기본설정 데이터 추가/수정
	 */
	public function doBasicProc() /*{{{*/
	{
		$nickFl         = $this->req->nick_fl;          // 닉네임 사용 여부
		$nickname       = $this->req->nick_name;        // 닉네임
		$nicknamePre    = $this->req->nick_name_pre;    // 전에 사용하던 닉네임
		$blogGbn        = $this->req->blog_gbn;         // 블로그 구분
		$homepageText   = $this->req->blog_text;        // 홈페이지 URL
		$perPage        = $this->req->per_page;         // 페이지당 글수
		$homepageLinkFl = $this->req->homepage_link_fl; // 링크 끊기
		$preProfileImg  = $this->req->pre_profile_img;  // 사진 파일

		// TODO: 중복체크 - 해결 - ConfigUserPeer  사용가능일 때 1, 중복일 때 0 Return
		$dup_result = ConfigUserPeer::duplicateCheck($nickname,$this->myUser->getUserId());

		if(!$dup_result) {
			$this->alertAndGoBack('이미 사용중인 닉네임입니다.');
			$this->response->setRedirect('basic');
		}

		// 닉네임 처리 - 체크되어 있지 않고 내용도 빈경우 (실명) - 에러처리 구문
		if (!$nickFl && strlen(trim($nicknamePre)) == 0) {
			$nickname = $this->myUser->getRealName();
		}
		// 닉네임 처리 - 체크되어 있지 않지만 값은 숨어있는 경우 - 값을 보존한다
		if (!$nickFl && strlen(trim($nicknamePre)) > 0) {
			$nickname = $nicknamePre;
		}

		// 실제 업데이트 작업
		$this->myUser->memory->modifyBasicInfo($nickFl, $nickname, $homepageLinkFl, $homepageText, $perPage, $preProfileImg);

		$this->response->setRedirect('basic');
	} /*}}}*/

	/**
	 * 이미지 편집 툴 팝업
	 */
	public function doCyImage() /*{{{*/
	{
	} /*}}}*/

	/**
	 * 이미지 업로드 처리 - HTTP_Request #1
	 */
	public function dobasicImgUp() /*{{{*/
	{
		// 파일 정보 얻어오기
		$img = $this->request->getFile('file00');

		$image_ext = substr($img['name'], -3);
		if (strcasecmp($image_ext, 'jpg') != 0 && strcasecmp($image_ext, 'gif') != 0 && strcasecmp($image_ext, 'png') != 0) {
			echo('<br>file extension error<br>'.$image_ext);
			exit;
		}

		// 임시 파일 , 파일명 , 디렉토리 생성을 위한 네이트 아이디
		$this->response->userid = $this->myUser->getUserId();

		// 파일객체, 네이트 아이디를 파라미터로 설정
		$fileNm = FileUploader::upload($img,$this->myUser->getUserId(),$image_ext);
		$this->response->fileNm = $fileNm;
	} /*}}}*/

	/**
	 * 기억 외부공유
	 */
	public function doBlogSync() /*{{{*/
	{
		$page = isset($this->request->page) ? $this->request->page : 1;

		if ($page < 1) {
			$page = 1;
		}

		$cnt = BlogSyncPeer::countBlogSync();

		$numPerPage = 10;
		$maxPage    = max((int)(($cnt-1)/$numPerPage)+1, 1);
		if ($page > $maxPage) {
			$page = $maxPage;
		}

		// 카테고리 정보를 미리 읽어와서 인스턴스 값을 채워놓기 위함

		$this->response->page    = $page;
		$this->response->maxPage = $maxPage;
		$this->response->cnt     = $cnt;

		$this->response->blogsync = BlogSync::retrieveBlogSync($page, $numPerPage);
	} /*}}}*/

	/**
	 * 기억 외부공유 삭제
	 */
	public function doBlogsyncDelete() /*{{{*/
	{
		// 삭제할 자료를 가져와서 클래스로 보낸다.
		BlogSyncPeer::preRemoveProc();

		$this->response->setRedirect('blogsync');
	} /*}}}*/

	/**
	 * 기억 외부공유 AJAX
	 */
	public function doBlogreg() /*{{{*/
	{
		// 외부 블로그 등록 모드에서는 해당 변수값이 0, 수정 모드일 경우 sequence 번호가 된다.
		$processMode = isset($this->request->processMode);

		// 초기화 데이터를 가져온다.
		$modify                 = BlogSyncPeer::retrieveBlogSyncBySeq();
		$this->response->modify = $modify;
	} /*}}}*/

	/**
	 * 기억 외부공유 Insert or Update
	 */
	public function doBlogregProc() /*{{{*/
	{
		// 수정이든 값을 넣는 일이든 일단 한다.
		$chkval = BlogSyncPeer::addModify();

		if ($chkval) {
			$this->alertAndGoBack('정상적으로 추가되었습니다');
		} else {
			$this->alertAndGoBack('추가되지 않았습니다. 다시 시도해주십시오');
		}

		$this->response->setRedirect('blogsync');
	} /*}}}*/


	/**
	 * 위젯 가져가기
	 */
	public function doWidget() /*{{{*/
	{
	} /*}}}*/

	/**
	 * 위젯 자바스크립트 생성
	 */
	public function doWidgetCreate() /*{{{*/
	{
		$size_width  = $this->request->size_width;
		$size_height = $this->request->size_height;

		if (!trim($size_width)) {
			// 공백으로 된 닉네임은 취급 안함
			$this->json = array(true, 0);
		}

		$javasrt = 'javascriptfile?size_width=' . $size_width . '&size_height=' . $size_height . '&id=' . $this->myUser->getUserId() . '.js';

		$this->json = array(true, $javasrt);
	} /*}}}*/

	/**
	 * 초대하기
	 */
	public function doInvite() /*{{{*/
	{
		$page = isset($this->request->page) ? $this->request->page : 1;
		if ($page < 1) {
			$page = 1;
		}

		$cntInvite = InvitePeer::countInvite();

		$numPerPage = 5;
		$maxPage    = max((int)(($cntInvite-1)/$numPerPage)+1, 1);
		if ($page > $maxPage) {
			$page = $maxPage;
		}

		$Invite_list = Invite::retrieveInvite($page, $numPerPage);

		// 총 초대장 수 - 20 -  초대장은 DB 또는 데이터 Source가 정해지면 적용
		$remainInvite = 20 - $cntInvite;

		$this->response->page         = $page;
		$this->response->maxPage      = $maxPage;
		$this->response->remainInvite = $remainInvite;
		$this->response->cntInvite    = $cntInvite;
		$this->response->Invite       = $Invite_list;
	} /*}}}*/

	/**
	 * 초대하기 추가
	 */
	public function doInviteProc() /*{{{*/
	{
		$rEmail = explode(',', $this->request->recieve_email);

		for ($i=0; $i<sizeof($rEmail); $i++) {
			if (strpos($rEmail[$i], '@') === false) {
				$this->alertAndGoBack('초대장을 받을 친구의 주소 형식이 잘못되었습니다');
				$this->response->setRedirect('invite');
			}
		}

		if ($i > $this->req->remainInvite) {
			$this->alertAndGoBack('남은 초대장 수가 부족합니다. (초대할 친구 수 : '.$i.'명, 남은 초대장 수 : '.$this->req->remainInvite.'장)');
			$this->response->setRedirect('invite');
		}


		if (strpos($this->request->invite_email, '@') === false) {
			$this->alertAndGoBack('보내는 사람 이메일 주소 형식이 잘못되었습니다');
			$this->response->setRedirect('invite');
		}

		$resultCnt = 0;

		$userId        = $this->myUser->getUserId();
		$inviteEmail   = $this->req->invite_email;
		$inviteMessage = $this->req->invite_message;
		$shareMp       = $this->req->share_mp;

		$rdfile  = fopen(ConfigManager::get('common.basedir').'/template/Mybox/Config/MailForm.tpl', 'r');
		$tmpfile = fread($rdfile, filesize(ConfigManager::get('common.basedir').'/template/Mybox/Config/MailForm.tpl'));

		for ($i=0; $i<sizeof($rEmail); $i++) {
			$tmpfile = fread($rdfile, filesize(ConfigManager::get('common.basedir').'/template/Mybox/Config/MailForm.tpl'));

			$searchData      = array('__message__', '__mp__');
			$destinationData = array($inviteMessage, $shareMp);

			$tmpfile = str_replace($searchData, $destinationData, $tmpfile);

			$mresult = mail($rEmail[$i], '기억나 초대메일', $tmpfile, 'From: '.$userId.' <'.$inviteEmail.">\r\n");

			$result = InvitePeer::addInvite($rEmail[$i], $userId, $inviteEmail, $inviteMessage, $shareMp);

			if ($result) {
				$resultCnt++;
			}
		}


		if ($resultCnt == sizeof($rEmail)) {
			$this->alertAndGoBack('초대 요청 완료되었습니다.');
		} else {
			$this->alertAndGoBack('일부 초대가 실패되었습니다.\\n초대 리스트를 확인해주세요.');
		}

		$this->response->setRedirect('Invite');
	} /*}}}*/

	public function doInviteDelProc() /*{{{*/
	{
		$chkInviteSq = $this->request->chk_invite_sq;

		for ($i=0; $i<sizeof($chkInviteSq); $i++) {
			InvitePeer::delInvite($chkInviteSq[$i]);
		}

		$this->response->setRedirect('Invite');
	} /*}}}*/

	public function doMailForm() /*{{{*/
	{
	} /*}}}*/
}
?>
