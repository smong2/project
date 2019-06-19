<?php
class User Extends BaseObject
{
	protected $__userId;       // CMN
	protected $__isLogged = 0; // 로그인 했는지 여부

	// NATE 정보
	protected $__nateId;     // 네이트 ID
	protected $__email;      // 이메일
	protected $__gender;     // M: Male, F: Female
	protected $__birthday;   // YYYYMMDD
	protected $__lunar;      // 0: 음력, 1: 양력
	protected $__realAge;    // 만 나이
	protected $__realname;   // 실명
	protected $__realnameCd; // Y: 실명인증, N: 실명인증안됨
	protected $__cyworldId;  // 싸이월드 아이디
	protected $__nateNick;   // 네이트 닉네임

	protected $__type;       // 로그인 아이디 유형 - 네이트 : N, 싸이 : C
	protected $__link;       // 연동된 아이디 N일 경우 CyID, C일 경우 NateID

	// Cyworld 정보

	protected $__profileImage     = ''; // 프로필 이미지
	protected $__friendCnt        = 0;  // 나의 커넥팅 피플
	protected $__reverseFriendCnt = 0;  // 나를 피플로 추가한 친구
	protected $__followingCnt     = 0;
	protected $__followerCnt      = 0;
	protected $__msgCnt; // 내가 보낸 커넥팅
	protected $__domain   = '';
	protected $__nickname = '';
	protected $__toastYN  = '';
	protected $__profileImageUrl;
	protected $__profileThumbnailUrl;
	protected $__msgOpenDefault;
	protected $__creatDt; // 최근 데이터 입력일
	protected $__isTempDomain;
	protected $__isDomainsOwner;
	protected $__isShowTwits;
	protected $__showNickname;
	protected $__privateMsgCnt;
	protected $__introduce;

	const PROFILE_TYPE_CUSTOM  = 0; // 사용자 등록 이미지
	const PROFILE_TYPE_TWITTER = 9; // 사용자 등록 이미지

	// 처음 방문자 카운트 - 몇명에게 커넥팅이 발송되는지 수치 정보
	const BALLOON_FOLLOWER = 1;
	const BALLOON_RPEOPLE  = 2;


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
	 ***** LOAD ****************************************************************** 
	 *****************************************************************************/

	/**
	 * 나의 커넥팅 상태 정보를 가져온다.
	 * 
	 * @return User $user 객체에 값을 저장하여 $this 를 반환한다.
	 */
	public function getUserInfo() /*{{{*/
	{
		return ContainerAPI::getUserInfo($this);
	} /*}}}*/

	/***************************************************************************** 
	 ***** 기타 GET 함수들 ******************************************************* 
	 *****************************************************************************/

	/**
	 * 내가 등록한 외부 블로그 목록을 가져온다.
	 * 
	 * @return array of MyExtBlog
	 */
	public function getMyExtBlogs() /*{{{*/
	{
		return ContainerAPI::getLinkedBlogs($this);
	} /*}}}*/

	/**
	 * 트위터 연동이 되어있는지 확인
	 * 
	 * @return bool
	 */
	public function isLinkedTwitter() /*{{{*/
	{
		$linkedBlogs = self::getMyExtBlogs();

		if ($linkedBlogs == false) {
			return false;
		}

		foreach ($linkedBlogs as $blog) {
			if ($blog->getBlogId() == ExtBlog::BLOG_TWITTER) {
				return true;
			}
		}

		return false;
	} /*}}}*/

	/**
	 * 3일간 자기 자신을 피플로 추가한 사람 수, follwer 수
	 */
	public function balloonView() /*{{{*/
	{
		return ContainerAPI::balloonView($this);
	} /*}}}*/

	public function balloonCheck($balloonType) /*{{{*/
	{
		return ContainerAPI::balloonCheck($this, $balloonType);
	} /*}}}*/

	/***************************************************************************** 
	 ***** HTML 을 위한 GET 함수들 *********************************************** 
	 *****************************************************************************/

	/**
	 * 네이트 계정인지, 또는 네이트 연동 계정인지 여부를 반환한다.
	 * 
	 * @return bool 네이트 게정, 싸이 계정이지만 연동이 되어 있는 경우 true를 반환한다.
	 */
	public function isNateAccount() /*{{{*/
	{
		if ($this->getType() == 'N') {
			return true;
		}
		if ($this->getType() == 'C' && $this->getLink() != '') {
			return true;
		}

		return false;
	} /*}}}*/

	/**
	 * 로그인 여부를 반환한다.
	 * 
	 * @return bool 로그인 했으면 TRUE 를 반환한다.
	 */
	public function isLogged() /*{{{*/
	{
		return (bool) $this->getIsLogged();
	} /*}}}*/

	/**
	 * 첫 방문인지 확인
	 * 
	 * @return bool // 첫 방문이면 true 
	 */
	public function isFirstVisit() /*{{{*/
	{
		return ContainerAPI::isFirstVisit($this);
	} /*}}}*/

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
		if ($profileType == self::PROFILE_TYPE_TWITTER) {
			if ($profileUrl) {
				return $profileUrl;
			}
			else {
				return 'http://connect.nate.com/img/2.0/thumb_56x56_01.gif';
			}
		}
		else if ($profileType == self::PROFILE_TYPE_CUSTOM) {
			if ($profileUrl) {
				return 'http://connect.nateimg.co.kr/thumb_56x56_prop/http://cyimg.cyworld.com/common/file_down.asp?redirect=' . $profileUrl;
			}
			else {
				return 'http://connect.nate.com/img/2.0/thumb_56x56_01.gif';
			}
		}
		else {
			return 'http://connect.nate.com/img/2.0/thumb_56x56_0' . $profileType . '.gif';
		}
	} /*}}}*/

	/**
	 * 토스트 창 사용여부 설정
	 */
	public function updateToast() /*{{{*/
	{
		return ContainerAPI::updateToast($this);
	} /*}}}*/

	/**
	 * 닉네임 사용여부 설정
	 */
	public function updateShowNickname() /*{{{*/
	{
		return ContainerAPI::updateUserInfo($this);
	} /*}}}*/
}
?>
