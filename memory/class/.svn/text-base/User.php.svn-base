<?php
class User extends BaseObject
{
	protected $__userId;
	protected $__gender;   // 1 : 남성, 0 : 여성
	protected $__birthday; // YYYYMMDD
	protected $__lunar;    // 1 : 양력, 0 : 음력
	protected $__realAge;
	protected $__realName;
	protected $__mail;

	protected $__nickname; // memory.user.nickname DB 필드
	protected $__cyId;

	public $nate;          // User_Nate
	public $cyworld;       // User_Cyworld
	public $memory;        // User_Memory

	public static function instance($userId) /*{{{*/
	{
		static $sInstance = array();

		$userId = strval($userId);

		if (isset($sInstance[$userId]) === false) {
			$className          = __CLASS__;
			$user               = new $className($userId);
			$sInstance[$userId] = $user;
		}

		return $sInstance[$userId];
	} /*}}}*/

	protected function __construct($userId) /*{{{*/
	{
		$this->__userId = $userId;

		$this->nate    = new User_Nate($this);
		$this->cyworld = new User_Cyworld($this);
		$this->memory  = new User_Memory($this);
	} /*}}}*/

	/***************************************************************************
	 ***** CHECK 함수들 ********************************************************
	 **************************************************************************/

	/**
	 * $mp 기억을 기억했는지 여부를 반환한다.
	 */
	public function isMemorize(Mp $mp) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM memorize WHERE user_id = :user_id and mp_sq = :mp_sq';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':mp_sq',   $mp->getMpSq(),     PDO::PARAM_INT);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return ($row['cnt'] > 0);
		}
		else {
			return false;
		}
	} /*}}}*/

	/***************************************************************************
	 ***** ACTION 함수들 *******************************************************
	 **************************************************************************/

	/**
	 * $mp 기억을 기억한다.
	 */
	public function memorize($mp) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'INSERT INTO memorize (user_id, mp_sq) VALUES (:user_id, :mp_sq)';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':mp_sq',   $mp->getMpSq(),     PDO::PARAM_INT);
		$stmt->execute();

		$this->increaseMemorizeCnt();
		$mp->increaseMemorizeCnt();
	} /*}}}*/

	public function increaseMemorizeCnt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE user SET memorize_cnt = memorize_cnt + 1, update_dt = now() WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($stmt->rowCount() <= 0) {
			$query = 'INSERT INTO user (user_id, memorize_cnt, nickname, update_dt)
					  VALUES (:user_id, :memorize_cnt, :nickname, now())';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id',      $this->getUserId(),   PDO::PARAM_STR);
			$stmt->bindValue(':memorize_cnt', 1,                    PDO::PARAM_INT);
			$stmt->bindValue(':nickname',     $this->getRealName(), PDO::PARAM_STR);
			$stmt->execute();
		}

		if (isset($this->__memorizeCnt)) {
			$this->__memorizeCnt++;
		}
	} /*}}}*/

	public function increaseMpCreateCnt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE user SET mp_create_cnt = mp_create_cnt + 1, update_dt = now() WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($stmt->rowCount() <= 0) {
			$query = 'INSERT INTO user (user_id, mp_create_cnt, nickname, update_dt)
					  VALUES (:user_id, :mp_create_cnt, :nickname, now())';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id',       $this->getUserId(),   PDO::PARAM_STR);
			$stmt->bindValue(':mp_create_cnt', 1,                    PDO::PARAM_INT);
			$stmt->bindValue(':nickname',      $this->getRealName(), PDO::PARAM_STR);
			$stmt->execute();
		}

		if (isset($this->__mpCreateCnt)) {
			$this->__mpCreateCnt++;
		}
	} /*}}}*/

	public function increaseMtCnt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE user SET mt_cnt = mt_cnt + 1, update_dt = now() WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($stmt->rowCount() <= 0) {
			$query = 'INSERT INTO user (user_id, mt_cnt, nickname, update_dt)
					  VALUES (:user_id, :mt_cnt, :nickname, now())';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id',  $this->getUserId(),   PDO::PARAM_STR);
			$stmt->bindValue(':mt_cnt',   1,                    PDO::PARAM_INT);
			$stmt->bindValue(':nickname', $this->getRealName(), PDO::PARAM_STR);
			$stmt->execute();
		}

		if (isset($this->__mtCnt)) {
			$this->__mtCnt++;
		}
	} /*}}}*/

	/***************************************************************************
	 ***** LOAD 함수들 *********************************************************
	 **************************************************************************/

	public function loadNateInfo() /*{{{*/
	{
		UserPeer::retrieveNateInfoByUserId($this->__userId);
	} /*}}}*/

	public function loadMemoryInfo() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT user_id, nick_enable_fl, nickname, homepage_link_fl, homepage, view_per_page, profile_image, insert_dt
				  FROM user WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			// 값이 있다면 가져오고
			$this->memory->loadByRowData($row);

		} else {
			// 저장된 값이 없다면 초기값을 넣어서 불러온다
			$this->memory->setInsertDt('기억한 데이터가 없습니다');
			$this->memory->setDateDiff('');
			$this->memory->setNickEnableFl('');
			$this->memory->setNickName($this->getRealName());
			$this->memory->setHomepageLinkFl('');
			$this->memory->setHomepage('');
			$this->memory->setviewPerPage(5);
			$this->memory->setProfileImage('');
		}
	} /*}}}*/

	/***************************************************************************
	 ***** GET 함수들 **********************************************************
	 **************************************************************************/

	/**
	 * 실명 (아이디) 형식의 문자열을 반환한다.
	 */
	public function getRealNameAndIdStr() /*{{{*/
	{
		return $this->getRealName() . ' (' . $this->nate->getNateIdStr() . ')';
	} /*}}}*/

	public function getBirthYear() /*{{{*/
	{
		return intval(substr($this->getBirthday(), 0, 4));
	} /*}}}*/

	public function getKoreanAge() /*{{{*/
	{
		return date('Y') - $this->getBirthYear() + 1;
	} /*}}}*/

	public function getNickname() /*{{{*/
	{
		if (isset($this->__nickname)) {
			return $this->__nickname;
		}
		else {
			return $this->nate->getNickname();
		}
	} /*}}}*/
}
?>
