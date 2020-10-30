<?php
class User_Memory extends BaseObject
{
	protected $__userId;
	protected $__nickEnableFl;
	protected $__nickname;
	protected $__homepageLinkFl;
	protected $__homepage;
	protected $__viewPerPage;
	protected $__profileImage;
	protected $__insertDt;

	protected $parent;

	public function __construct(User $user) /*{{{*/
	{
		$this->__userId = $user->getUserId();
		$this->parent   = $user;
	} /*}}}*/

	public function getProfileImageUrl() /*{{{*/
	{
		if ($this->getProfileImage() == '') {
			return 'about:blank';
		}
		else {
			return '/imgProfile/' . $this->getProfileImage();
		}
	} /*}}}*/

	public function modifyBasicInfo($nickEnableFl, $nickname, $homepageLinkFl, $homepage, $perPage) /*{{{*/
	{
		// Data Insert를 위한 initializing
		if ($nickFl == 'on') {
			$nickFl = 1;
		} else {
			$nickFl = 0;
		}

		if ($homepageLinkFl == 'on') {
			$homepageLinkFl = 1;
		} else {
			$homepageLinkFl = 0;
		}

		// 닉네임을 사용하지 않거나 닉네임 필드가 공백이라면 실명으로 넣는다
		if (!$nickEnableFl || !strlen($nickname)) {
			$nickname = $this->myUser->getRealName();
		}

		$pdo = PDO_Manager::getMemoryDB();

		// 우선 insert된 데이터가 있는지 확인 - count로 세지 않고 ID로 세도록 했음
		$query = 'SELECT user_id
					 FROM user
					 WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			// 자료가 있으면 Update
			$query = 'UPDATE user
						 SET nick_enable_fl = :nick_enable_fl,
						 	  nickname = :nickname,
						 	  homepage = :homepage,
						 	  homepage_link_fl = :homepage_link_fl,
						 	  view_per_page = :view_per_page
						 WHERE user_id= :user_id';
		} else {
			// 자료가 없으면 Insert
			$query = 'INSERT INTO user
					 		(user_id, homepage, homepage_link_fl, nickname, nick_enable_fl,
					 		 view_per_page)
					 	 VALUES
					 		(:user_id, :homepage, :homepage_link_fl, :nickname, :nick_enable_fl, :view_per_page)';
		}

		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':nick_enable_fl',   $nickEnableFl,                    PDO::PARAM_INT);
		$stmt->bindValue(':nickname',         $nickname,                  PDO::PARAM_STR);
		$stmt->bindValue(':homepage_link_fl', $homepageLinkFl,            PDO::PARAM_INT);
		$stmt->bindValue(':homepage',         $homepage,                  PDO::PARAM_STR);
		$stmt->bindValue(':view_per_page',    $perPage,                   PDO::PARAM_INT);
		$stmt->bindValue(':user_id',          $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->execute();
	} /*}}}*/
}
?>
