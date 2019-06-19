<?php
class User Extends BaseObject
{
	protected $__userId;       // CMN
	protected $__isLogged = 0; // 로그인 했는지 여부

	// NATE 정보
	protected $__nateId;   // 네이트 ID
	protected $__realname; // 실명

	// Cyworld 정보

	// 커넥팅 정보
	protected $__profileImage;      // 프로필 이미지
	protected $__friendCnt;         // 나의 커넥팅 피플
	protected $__reverseFriendCnt;  // 나를 피플로 추가한 친구
	protected $__msgCnt;            // 내가 보낸 커넥팅
	protected $__senderName;        // 커넥팅 등록명
	protected $__domain   = '';     // 사용자 도메인
	protected $__nickname = '';     // 닉네임
	protected $__toastYn;           // 토스트 사용여부
	protected $__tHomeTlYn;         // 트위터 홈 타임라인 보여줄지 여부
	protected $__tUserTlYn;         // 트위터 유저 타임라인 보여줄지 여부
	protected $__introduce;         // 자기 소개글
	protected $__showNickname;      // 닉네임 값을 노출할 것인지

	const PROFILE_TYPE_CUSTOM = 0;  // 사용자 등록 이미지
	const CMN_LENGTH          = 11; // cmn 자릿수

	const BUDDY_SELECT_TYPE_ALL = 'all';

	const SEND_TWITTER_Y = 'y';
	const SEND_TWITTER_N = 'n';

	const OPEN_Y = 'y';
	const OPEN_N = 'n';

	const CLEAR_ALARM_Y = 'y';
	const CLEAR_ALARM_N = 'n';

	const SHOW_NICKNAME_Y = 'y';
	const SHOW_NICKNAME_N = 'n';

	const VIEW_STAT_MODE_COMMENT_BY_3DAYS = 1;
	const VIEW_STAT_MODE_ISCONNECTING     = 2;
	const VIEW_STAT_MODE_ALL              = 3;

	const DEFAULT_PROFILE_IMG_CNT = 5;

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

	protected function __construct($userId) /*{{{*/
	{
		$this->__userId = $userId;
	} /*}}}*/

	/***************************************************************************** 
	 ***** 사용자 기본 정보 관련 ******************************************************* 
	 *****************************************************************************/

	/**
	 * 나의 커넥팅 상태 조회 (최근 3일간 댓글 등록 여부, 최초 커넥팅 여부, 댓글 정보 초기화
	 * 
	 * @param string $mode 모드 0:댓글 정보 초기화, 1:최근 3일간 댓글 등록 여부
	 *                          2:최초 커넥팅 여부, 3:1+2
	 * @param Service $service 컨테이너 계정 정보
	 * 
	 * @return array of (container's response Data)
	 */
	public function getStatus($mode = self::VIEW_STAT_MODE_ALL, Service $service) /*{{{*/
	{
		return ContainerAPI::getUserStatus($this, $mode, $service);
	} /*}}}*/

	/**
	 * 사용자 정보
	 */
	public function getUserInfo(Service $service) /*{{{*/
	{
		return ContainerAPI::getUserInfo($this, $service);
	} /*}}}*/

	/**
	 * 풍선 도움말 정보 가져오기
	 */
	public function getBalloonView(Service $service) /*{{{*/
	{
		return ContainerAPI::balloonView($this, $service);
	} /*}}}*/

	/**
	 * 풍선 도움말 정보 확인
	 */
	public function getBalloonCheck($baloonType, Service $service) /*{{{*/
	{
		return ContainerAPI::balloonCheck($this, $baloonType, $service);
	} /*}}}*/

	/**
	 * 사용자 프로필 이미지 리스트 조회
	 */
	public function getProfileImgs() /*{{{*/
	{
		$retval = array();

		$retval[0] = '';

		for ($i=1; $i<=self::DEFAULT_PROFILE_IMG_CNT; $i++) {
			$retval[$i] = self::generateProfileImageUrl($i);
		}

		return $retval;
	} /*}}}*/

	/**
	 * 사용자 정보 수정
	 */
	public function update(Service $service) /*{{{*/
	{
		return ContainerAPI::updateUserInfo($this, $service);
	} /*}}}*/

	/**
	 * 토스트창 업데이트
	 */
	public function updateToast(Service $service) /*{{{*/
	{
		return ContainerAPI::updateToast($this, $service);
	} /*}}}*/

	/**
	 * 도메인/닉네임 존재여부 확인
	 */
	public function checkExistDomainOrNickname(Service $service) /*{{{*/
	{
		return ContainerAPI::checkExistDomainOrNickname($this, $service);
	} /*}}}*/

	/***************************************************************************** 
	 ***** HTML 을 위한 GET 함수들 *********************************************** 
	 *****************************************************************************/

	/**
	 * 사용자가 등록한 프로필 이미지 URL 을 반환한다.
	 * 
	 * @return string
	 */
	public function getProfileImageUrl() /*{{{*/
	{
		return self::generateProfileImageUrl(self::PROFILE_TYPE_CUSTOM, $this->getProfileImage());
	} /*}}}*/

	/**
	 * $profileType과 $profileUrl을 참조하여 프로필 이미지 URL 을 반환한다.
	 * 
	 * $profileType 이 1 ~ 5 이면 제공 이미지이다.
	 * $profileType 이 0 이면 사용자 등록 이미지이다.
	 * 
	 * @param int $profileType 프로필 타입
	 * @param int $profileUrl 프로필 URL
	 * 
	 * @return string
	 */
	public static function generateProfileImageUrl($profileType, $profileUrl = '') /*{{{*/
	{
		if ($profileType == self::PROFILE_TYPE_CUSTOM) {
			if ($profileUrl) {
				return $profileUrl;
			}
			else {
				return 'http://connect.nate.com/img/2.0/thumb_56x56_01.gif';
			}
		}
		else {
			return 'http://connect.nate.com/img/2.0/thumb_56x56_0' . $profileType . '.gif';
		}
	} /*}}}*/


	/***************************************************************************** 
	 ***** 메시지 관련 ******************************************************* 
	 *****************************************************************************/

	/**
	 * 메시지 공개 여부 Default 값 가져오기
	 */
	public function getMessageDefault(Service $service) /*{{{*/
	{
		return ContainerAPI::getMessageDefault($this, $service);
	} /*}}}*/

	/**
	 * 메시지 알람
	 */
	public function messageAlarm(Service $service) /*{{{*/
	{
		return ContainerAPI::getAlarmMessage($this, $service);
	} /*}}}*/

	/**
	 * 메시지 목록을 얻어온다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $sort SORT_BY_XXX 정렬 타입
	 * @param int $sourceType SOURCE_TYPE_XXX 조회할 소스 타입
	 * @param int $listType LIST_TYPE_XXX 조회할 전송 대상
	 * @param User $sender 조회할 메시지를 보낸 사용자 객체
	 * @param int $rows 전달 받을 데이터 개수
	 * @param string $openYN 
	 * @param string $domain 사용자 도메인 정보
	 * @param string $viewerCmn 조회자 CMN
	 * 
	 * @return array of {container response}
	 */
	public function getMessages($startIdx = '', $sort = '', $sourceType = '', $listType = '', $sender = null, $rows = 10, $openYN, $domain, $viewerCmn, Service $service) /*{{{*/
	{
		return ContainerAPI::getMessages($this, $startIdx, $sort, $sourceType, $listType, $sender, $rows, $openYN, $domain, $viewerCmn, $service);
	} /*}}}*/

	/**
	 * 메시지 목록을 얻어온다 - 전체공개 커넥팅
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int  $row 전달 받을 데이터 개수
	 * 
	 * @return array of {container response}
	 */
	public function getMessagesTimeline($rows, $startIdx, Service $service) /*{{{*/
	{
		return ContainerAPI::getMessagesTimeline($this, $startIdx, $rows, $service);
	} /*}}}*/

	/**
	 * Home 메시지 목록을 얻어온다.
	 * 
	 * @param User $user 조회하려는 사용자 객체
	 * @param string $startIdx 다음 페이지 시작 ID
	 * @param int $sort SORT_BY_XXX 정렬 타입
	 * @param int $sourceType SOURCE_TYPE_XXX 조회할 소스 타입
	 * @param int $listType LIST_TYPE_XXX 조회할 전송 대상
	 * @param User $sender 조회할 메시지를 보낸 사용자 객체
	 * @param int $rows 전달 받을 데이터 개수
	 * 
	 * @return array of {container response}
	 */
	public function getHomeMessages($startIdx = '', $sort = '', $sourceType = '', $listType = '', $sender = null, $rows = 10, Service $service) /*{{{*/
	{
		return ContainerAPI::getHomeMessages($this, $startIdx, $sort, $sourceType, $listType, $sender, $rows, $service);
	} /*}}}*/

	/**
	 * 메시지 등록
	 */
	public function addMessage($content, $profileType = self::PROFILE_TYPE_CUSTOM, $senderName) /*{{{*/
	{
		return ContainerAPI::addMessages($this, $content, $profileType, $senderName);
	} /*}}}*/

	/***************************************************************************** 
	 ***** 댓글 관련 ******************************************************* 
	 *****************************************************************************/
	/**
	 * 댓글 알람
	 */
	public function commentAlarm(Service $service) /*{{{*/
	{
		return ContainerAPI::getCommentAlarm($this, $service);
	} /*}}}*/


	/***************************************************************************** 
	 ***** 트위터 연동 ******************************************************* 
	 *****************************************************************************/

	/**
	 * 트위터 관련 - 트위터 연동하기
	 */
	public function linkAtTwitter($token, $tokenSecret, $screenName, Service $service) /*{{{*/
	{
		return ContainerAPI::linkAtTwitter($this, $token, $tokenSecret, $screenName, $service);
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 연동해제
	 */
	public function unlinkAtTwitter($blogUrl, Service $service) /*{{{*/
	{
		return ContainerAPI::unlinkAtTwitter($this, $blogUrl, $service);
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 홈타임라인 가져오기
	 */
	public function getHomeTimelineAtTwitter($page, $rows, $sinceId, $maxId, Service $service) /*{{{*/
	{
		return ContainerAPI::getHomeTimelineAtTwitter($this, $page, $rows, $sinceId, $maxId, $service);
	} /*}}}*/

	/**
	 * 트위터 관련 - 트위터 유저타임라인 가져오기
	 */
	public function getUserTimelineAtTwitter($page, $rows, $sinceId, $maxId, Service $service) /*{{{*/
	{
		return ContainerAPI::getUserTimelineAtTwitter($this, $page, $rows, $sinceId, $maxId, $service);
	} /*}}}*/

	/**
	 * 블로그 연동 확인
	 */
	public function getLinkedBlogs($page = 1, $rows = 10, Service $service) /*{{{*/
	{
		return ContainerAPI::getLinkedBlogs($this, $page, $rows, $service);
	} /*}}}*/

	/***************************************************************************** 
	 ***** follow / following ******************************************************* 
	 *****************************************************************************/

	/**
	 * Follow 목록 조회
	 */
	public function getFollowerList($domain, $page, $rows, $sortType, $schType, $schValue, Service $service) /*{{{*/
	{
		return ContainerAPI::getFollowerList($this, $domain, $page, $rows, $sortType, $schType, $schValue, $service);
	} /*}}}*/

	/**
	 * Following 목록 조회
	 */
	public function getFollowingList($domain, $page, $rows, $sortType, $schType, $schValue, Service $service) /*{{{*/
	{
		return ContainerAPI::getFollowingList($this, $domain, $page, $rows, $sortType, $schType, $schValue, $service);
	} /*}}}*/

	/**
	 * Following 맺기
	 */
	public function addFollow($userName, $userNateId, $followingCmn, Service $service) /*{{{*/
	{
		return ContainerAPI::addFollow($this, $userName, $userNateId, $followingCmn, $service);
	} /*}}}*/

	/**
	 * Following 끊기
	 */
	public function deleteFollow($followingCmn, Service $service) /*{{{*/
	{
		return ContainerAPI::deleteFollow($this, $followingCmn, $service);
	} /*}}}*/
}
?>
