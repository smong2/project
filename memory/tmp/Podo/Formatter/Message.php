<?php
class Message Extends BaseObject
{
	protected $__messageId;
	protected $__messageKey;
	protected $__reconnectKey;
	protected $__message;
	protected $__sender;
	protected $__writerNm;
	protected $__nickname;
	protected $__writeDt;
	protected $__commentCnt;
	protected $__comment;
	protected $__commentDt;
	protected $__profileType;
	protected $__profileUrl;
	protected $__profileTitle;
	protected $__sourceType;
	protected $__sourceTitle;
	protected $__sourceUrl;
	protected $__attachType;
	protected $__attachUrl;
	protected $__from;
	protected $__openYN;
	protected $__domain;
	protected $__maxId;
	protected $__originMsgId;
	protected $__originMsgCmn;
	protected $__originMsgWriterNm;
	protected $__originMessage;
	protected $__twitId;


	const SOURCE_TYPE_CONNECT         = 0;      // 직접 작성
	const SOURCE_TYPE_NATEON_CHATNAME = 1;      // 네이트온 대화명 변경
	const SOURCE_TYPE_EXTERNAL_BLOG   = 2;      // 외부 블로그
	const SOURCE_TYPE_CLIPPED         = 3;      // 스크랩 API

	const ATTACH_TYPE_IMAGE            = 1;     // 이미지
	const ATTACH_TYPE_FLASH            = 2;     // 플래쉬
	const ATTACH_TYPE_SILVERLIGHT      = 3;     // 실버라이트
	const ATTACH_TYPE_CLIPPED_VIDEO    = 10;    // 스크랩 - 동영상
	const ATTACH_TYPE_CLIPPED_SHOPPING = 11;    // 스크랩 - 쇼핑
	const ATTACH_TYPE_CLIPPED_NEWS     = 12;    // 스크랩 - 뉴스

	const ATTACH_URL_FROM_KBSZZIM = 's0100006'; // KBS ZZIM 스크랩 아이디

	const MAXLEN_MESSAGE = 150;

	const OPEN_ONLY_ALL = 'y';
	const OPEN_PEOPLE   = 'n';
	const OPEN_ALL      = 'a';

	const LIST_TYPE_SENT    = 0;
	const LIST_TYPE_RECIEVE = 1;
	const LIST_TYPE_ALL     = 2;

	const SORT_BY_CREATE_DT  = 0;
	const SORT_BY_COMMENT_DT = 1;

	const FROM_TWITTER = '트위터';
	const FROM_NATEON  = '네이트온';
	const FROM_MOBILE  = '모바일';

	const MSG_OPEN_DEFAULT_Y = 'y'; // open_yn + twitter_yn 설정 유지하기
	const MSG_OPEN_DEFAULT_N = 'n'; // open_yn + twitter_yn 설정 유지하지 않기

	public static function instance($pk) /*{{{*/
	{
		static $sInstance = array();

		$pk = strval($pk);

		if (isset($sInstance[$pk]) === false) {
			$className      = __CLASS__;
			$obj            = new $className($pk);
			$sInstance[$pk] = $obj;
		}

		return $sInstance[$pk];
	} /*}}}*/

	protected function __construct($messageKey) /*{{{*/
	{
		$this->__messageKey = $messageKey;
	} /*}}}*/

	/************************************************************************** 
	 ***** ACTION ************************************************************* 
	 **************************************************************************/

	/**
	 * 메시지를 등록한다.
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public function add(User $myUser, $msgOpenDefault, $sendTwitter) /*{{{*/
	{
		return ContainerAPI::addMessage($myUser, $this, $sendTwitter, $msgOpenDefault);
	} /*}}}*/

	/**
	 * 메시지를 삭제한다.
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public function delete() /*{{{*/
	{
		return ContainerAPI::deleteMessage($this);
	} /*}}}*/

	/**
	 * 댓글을 추가한다.
	 * 
	 * @param User $myUser 글쓴이
	 * @param string $content 댓글 내용
	 * @param int $isSecret 비밀글 여부
	 * @param int $isSecret 비밀글 여부
	 * @param string $mode 일반댓글, 재댓글, 트위터 댓글 모드 
	 * @param string $twitId 트위터 스크린명 - 트위터 댓글 모드시 사용
	 * @param int $parentId 재댓글 등록시 키값 
	 * 
	 * @return bool 성공할 경우 true 를 반환한다.
	 */
	public function addComment(User $myUser, $content, $isSecret, $mode, $twitId, $parentId) /*{{{*/
	{
		return ContainerAPI::addComment($this, $myUser, $content, $isSecret, $mode, $twitId, $parentId);
	} /*}}}*/

	/**
	 * 리커넥팅을 한다
	 * 
	 * @param User $myUser 리커넥팅 하는 사람
	 * 
	 * @return bool 성공할 경우 true 를 반환한다
	 */
	public function reconnect(User $user) /*{{{*/
	{
		return ContainerAPI::reconnect($user, $this);
	} /*}}}*/

	/************************************************************************** 
	 ***** GET 함수들 (Overide) *********************************************** 
	 **************************************************************************/

	/**
	 * SourceUrl을 반환한다.
	 * 
	 * KBS 찜 동영상의 경우 초기에 잘못된 $sourceUrl이 저장되어
	 * 보정하는 작업을 한 후 반환한다.
	 * 
	 * @return string
	 */
	public function getSourceUrl() /*{{{*/
	{
		$sourceUrl = parent::__call('getSourceUrl', array());

		if ($this->getAttachType() != self::ATTACH_TYPE_CLIPPED_VIDEO) {
			return $sourceUrl;
		}

		list($from, $url) = explode(',', $this->getAttachUrl(), 2);
		// 출처가 KBS 찜이 아니거나 Url이 정상이라면 $sourceUrl을 그대로 반환한다.
		if ($from != self::ATTACH_URL_FROM_KBSZZIM || strpos($sourceUrl, 'www.kbs.co.kr') !== false) {
			return $sourceUrl;
		}

		$params = explode(',', $sourceUrl);
		list($key, $markid) = explode('=', $params[0]);
		return 'http://www.kbs.co.kr/zzim/player/html/vmplayer/index.html?markid=' . $markid;
	} /*}}}*/

	/************************************************************************** 
	 ***** HTML 을 위한 GET 함수들 ******************************************** 
	 **************************************************************************/

	/**
	 * $message를 웹 화면에 맞게 변환하여 반환한다.
	 * 
	 * 1. New Line 문자는 <br /> 로 변환한다.
	 * 2-1. SourceUrl이 없는 경우 (커넥팅에서 직접 작성한 메시지일 경우)
	 *      HTML 문자를 escape 하고 URL에 링크 태그를 추가한다.
	 * 2-2. SourceUrl이 있는 경우
	 *      SourceUrl로 본문 전체에 링크 태그를 추가한다.
	 * 
	 * @return string
	 */
	public function getMessageHTML() /*{{{*/
	{
		$html = $this->getMessage();

		// 이미지 주소 존재시 치환

		$html = htmlspecialchars($html);
	//	$html = $this->_getAttachUrlMessage($html);
	//	$html = $this->_getTwitterUrlMessage($html, $this);
	//	 	$html = $this->_getImageInMessage($html);
		$html = str_replace('%3D', '=', $html);
		$html = str_replace('%26', '&', $html);

		if ($this->getFrom() != self::FROM_TWITTER) {
			$html = nl2br($html);
		}
		$html = str_replace('<br', ' <br', $html);

		return $html;
	} /*}}}*/


	private static function _getAttachUrlMessage($html) /*{{{*/
	{
		static $exprUrl = '((http|ftp)(s)?:\/\/)[^ina.tc][\S]+(\.[^(\"\n\t\s))]+)+';

		$html = preg_replace('/('.$exprUrl.')/i', '<a href="\1" class="link" target="_blank" onclick="olapStat(\'CNT14\');">\1</a>', $html);

		return $html;
	} /*}}}*/

	/**
	 * 트위터 계정 링크
	 */
	private static function _getTwitterUrlMessage($html, $message) /*{{{*/
	{
		static $exprUrl = '(@[_0-9a-zA-Z]{1,15})';

		$html = preg_replace('/('.$exprUrl.')/i', '<a href="http://twitter.com/\1" target="_blank" class="link" onfocus="blur()">\1</a>', $html);
		$html = str_replace('/@', '/', $html);

		return $html;
	} /*}}}*/

	/**
	 * deprecated --- connect.nate.com 에서 제공하는 js로 대체 사용
	 * 이미지 파일 링크가 존재하는지 여부 체크하여 이미지 리턴
	 * ina.tc 주소를 이미지 링크로 변환 
	 */
	private static function _getImageInMessage($html = '') /*{{{*/
	{
		static $exprUrl = '(?:http(?:s?)\:\/\/)(?:ina.tc\/)(?:\w+:\w+@)?(?:(?:[-\w]+)+(?:com|org|net|gov|mil|biz|info|mobi|name|aero|jobs|museum|travel|[a-z0-9-_]))(?::[\d]{1,5})?(?:(?:(?:\/(?:[-\w~!$+|.,=]|%[a-f\d]{2})+)+|\/)+|\?|#)?(?:(?:\?(?:[-\w~!$+|.,*:]|%[a-f\d{2}])+=(?:[-\w~!$+|.,*:=]|%[a-f\d]{2})*)(?:\&amp;(?:[-\w~!$+|.,*:]|%[a-f\d{2}])+=(?:[-\w~!$+|.,*:=]|%[a-f\d]{2})*)*)*(?:#(?:[-\w~!$+|.,*:=]|%[a-f\d]{2})*)?';

		$html = preg_replace('/('.$exprUrl.')/i', '<br/><img src="\1" width="62" class="upload" alt="" onclick="ExpIt(this)" style="cursor:pointer"/><br/><a href="#" onclick="openPopupWindowNoneBrg(\'/list/viewImage?url=\1\',0,0); return false;" target="_blank" class="link" onfocus="blur()">\1</a><br/>', $html);

		$html = str_replace('%3D', '=', $html);
		$html = str_replace('%26', '&', $html);
		$html = nl2br($html);

		return $html;
	} /*}}}*/

	public function getWriterNm() /*{{{*/
	{
		$html = $this->__writerNm;
		$html = htmlspecialchars($html);
		$html = str_replace('%3D', '=', $html);
		$html = str_replace('%26', '&', $html);
		$html = str_replace('&amp;#', '&#', $html); // 유니코드 처리
		$html = str_replace('<br', ' <br', $html);
		return $html;
	} /*}}}*/

	/**
	 * ProfileType과 ProfileUrl을 참조하여 프로필 이미지 URL 을 반환한다.
	 * 
	 * @return string
	 */
	public function getProfileImageUrl() /*{{{*/
	{
		return User::generateProfileImageUrl($this->getProfileType(), $this->getProfileUrl());
	} /*}}}*/

	/**
	 * $writeDt를 기획에 맞게 변환하여 반환한다.
	 * 
	 * 1분 이내일 경우, 지금 막
	 * 1시간 이내일 경우, X분 전
	 * 1일 이내일 경우, X시간 전
	 * 그 외의 경우는 YYYY.MM/DD HH:MM 형식으로 반환한다.
	 * 
	 * @return string
	 */
	public function getWriteDtDiffStr() /*{{{*/
	{
		$diff = time() - $this->getWriteDt();

		if ($diff < 60) {
			return '지금 막';
		}
		else if ($diff < 60*60) {
			return (int)($diff/60) . '분 전';
		}
		else if ($diff < 24*60*60) {
			return (int)($diff/(60*60)) . '시간 전';
		}
		else {
			return date('Y.m.d H:i', $this->getWriteDt());
		}
	} /*}}}*/

	/**
	 * 커넥팅을 등록한 출처를 반환한다.
	 * 출처가 없는 경우는 네이트 커넥트이며 네이트 커넥트 일 때는 from을 명시하지 않는다. 
	 * 외부 커넥팅의 경우 sourceTitle을 사용함
	 * @return string
	 */
	public function getSourceTitleStr() /*{{{*/
	{
		if ($this->isReconnected()) {
			$msg = $this->getOriginMessage();
		} else {
			$msg = $this;
		}

		if (trim($msg->getFrom()) == self::FROM_NATEON || trim($msg->getFrom()) == self::FROM_MOBILE) {
			return;
		}

		// from 이 존재하지 않으면 title을 반환한다
		if (trim($msg->getFrom()) == '') {
			if (trim($msg->getSourceTitle()) != '') {
				return 'from ' . $msg->getSourceTitle();
			}
			return;
		}

		return 'from ' . $msg->getFrom();
	} /*}}}*/

	/**
	 *  출처에 따른 아이콘 표시
	 */
	public function getFromIcon() /*{{{*/
	{
		if ($this->isReconnected()) {
			$msg = $this->getOriginMessage();
		} else {
			$msg = $this;
		}

		if (trim($msg->getFrom()) == self::FROM_NATEON) {
			return 'ic_nateon.gif';
		}

		else if (trim($msg->getFrom()) == self::FROM_MOBILE) {
			return 'ic_phone.gif';
		}

		else {
			return false;
		}
	} /*}}}*/

	public function getTwitterIcon() /*{{{*/
	{
		if (trim($this->getFrom()) == self::FROM_TWITTER) {
			return 'ic_twitter.gif';
		}

		return false;
	} /*}}}*/

	/**
	 * 새 댓글이 달렸는지 여부를 반환한다.
	 * 
	 * 지금으로부터 24시간 이내에 새 댓글이 달린 경우 새 댓글이 달린 것으로 한다.
	 * 댓글이 1개 미만일 경우에는 false 를 반환한다.
	 * 
	 * @return bool 새 댓글이 있을 경우 true를 반환한다.
	 */
	public function hasNewComments() /*{{{*/
	{
		return ($this->getCommentCnt() > 0 && time()-$this->getCommentDt() < 24*60*60);
	} /*}}}*/

	/**
	 * 스크랩 여부를 반환한다.
	 * 
	 * @return bool 스크랩 커넥팅인 경우 true를 반환한다.
	 */
	public function isClipped() /*{{{*/
	{
		return in_array($this->getAttachType(), array(self::ATTACH_TYPE_CLIPPED_VIDEO, self::ATTACH_TYPE_CLIPPED_SHOPPING, self::ATTACH_TYPE_CLIPPED_NEWS));
	} /*}}}*/

	/**
	 * 삭제할 수 있는지 여부를 반환한다.
	 * 
	 * @return bool 삭제할 수 있을 경우 true 를 반환한다.
	 */
	public function isRemovable(User $myUser) /*{{{*/
	{
		if ($this->getSender()->getUserId() == $myUser->getUserId()) {
			return true;
		}

		return false;
	} /*}}}*/

	/**
	 * 리커넥팅이 가능한 지 여부를 반환한다.
	 * 
	 * @return bool 가능할 경우 true 를 반환한다.
	 */
	public function isReconnectable(User $myUser) /*{{{*/
	{
		if ($this->getSender()->getUserId() == $myUser->getUserId()) {
			return false;
		}

		if ($this->getOpenYN() !== self::OPEN_ONLY_ALL) {
			return false;
		}

		if ($this->getOriginMsgCmn() == $myUser->getUserId()) {
			return false;
		}

		return true;
	} /*}}}*/

	/**
	 * 리커넥팅 글인지 판단
	 */
	public function isReconnected() /*{{{*/
	{
		if (trim($this->getOriginMsgCmn()) != '') {
			return true;
		} else {
			return false;
		}
	} /*}}}*/

	/**
	 * 동영상 썸네일 URL을 반환한다.
	 * 
	 * @return string
	 */
	public function getThumbUrl() /*{{{*/
	{
		switch ($this->getAttachType()) {
			case self::ATTACH_TYPE_CLIPPED_VIDEO:
				list($from, $url) = explode(',', $this->getAttachUrl(), 2);
				return VideoThumb::getThumbUrl($url);

			case self::ATTACH_TYPE_CLIPPED_SHOPPING:
			case self::ATTACH_TYPE_CLIPPED_NEWS:
				return $this->getAttachUrl();
		}

		return '';
	} /*}}}*/
}
?>
