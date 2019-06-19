<?php
class Message Extends BaseObject
{
	protected $__messageKey;
	protected $__messageId;
	protected $__reconnectKey;
	protected $__message;
	protected $__sender;
	protected $__writerNm;
	protected $__writeDt;
	protected $__comment;
	protected $__commentCnt;
	protected $__commentDt;
	protected $__profileType;
	protected $__profileUrl;
	protected $__parentId;
	protected $__sourceType;
	protected $__sourceTitle;
	protected $__sourceUrl;
	protected $__attachType;
	protected $__attachUrl;
	protected $__from;
	protected $__openYn;
	protected $__domain;
	protected $__twitId;
	protected $__originMsgId;
	protected $__originMsgCmn;
	protected $__originMsgWriterNm;
	protected $__parentMsgId;
	protected $__msgOpenDefault;
	protected $__sendTwitter;
	protected $__fromTitle;
	protected $__fromUrl;

	const SOURCE_TYPE_ALL             = -1;     // 전체보기
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

	const OPEN_N = 'n';
	const OPEN_Y = 'y';

	const SEND_TWITTER_Y = 'y';
	const SEND_TWITTER_N = 'n';

	const CLEAR_ALARM_N = 'n';
	const CLEAR_ALARM_Y = 'y';

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
	 * 메시지 등록
	 * @param Service $service 컨테이너 계정 정보
	 */
	public function addMessage(Service $service) /*{{{*/
	{
		return ContainerAPI::addMessage($this, $service);
	} /*}}}*/

	/**
	 * 단일 메시지를 조회한다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param sring $clearAlarm 알람초기화 여부
	 * @param Service $service 컨테이너 계정 정보
	 * 
	 * @return array of (Container's response Data)
	 */
	public function viewMessage(User $user, $clearAlarm, Service $service) /*{{{*/
	{
		return ContainerAPI::viewMessage($user, $this, $clearAlarm, $service);
	} /*}}}*/

	/**
	 * 메시지를 삭제한다.
	 * 
	 * @return response 
	 */
	public function delete(Service $service) /*{{{*/
	{
		return ContainerAPI::deleteMessage($this, $service);
	} /*}}}*/

	/** 
	 * 리커넥트 하기
	 */
	public function reconnect(User $user, Service $service) /*{{{*/
	{
		return ContainerAPI::reconnect($user, $this, $service);
	} /*}}}*/
	/** 
	 * 
	 * 댓글 목록을 가져온다
	 * 
	 * @param User $user 객체
	 * @param int $page 댓글 페이지
	 * @param int $rows 페이지당 댓글 수
	 * @param string $mode 재댓글 출력시 사용 (mode=re)
	 * @param Service $service 서비스 계정 객체
	 */
	public function getComments(User $user, $page, $rows, $mode, Service $service) /*{{{*/
	{
		return ContainerAPI::getComments($user, $this, $page, $rows, $mode, $service);
	} /*}}}*/
}
?>
