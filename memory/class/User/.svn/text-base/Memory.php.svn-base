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
			$wholepath = "/fs/memory/profile/";
			$dirname = ConfigUserPeer::directoryName($this->getUserId());

			return $wholepath.$dirname."/". $this->getProfileImage();
		}
	} /*}}}*/

	public function modifyBasicInfoPre() {
		$pdo = PDO_Manager::getMemoryDB();

		// 우선 insert된 데이터가 있는지 확인 - count로 세지 않고 ID로 세도록 했음
		$query = 'SELECT user_id FROM user WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		return $stmt->fetch(PDO::FETCH_ASSOC);
	}

	public function modifyBasicInfo($nickEnableFl, $nickname, $homepageLinkFl, $homepage, $viewPerPage, $profileImage) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();
		$cnt = User_Memory::modifyBasicInfoPre();

		if ($row = $cnt) {
			// 자료가 있으면 Update
			$query = "UPDATE user SET nick_enable_fl = :nick_enable_fl,
									  profile_image = :profile_image,
									  nickname = :nickname,
									  homepage = :homepage,
									  homepage_link_fl = :homepage_link_fl,
									  view_per_page = :view_per_page,
									  update_dt = now()
					  WHERE user_id = :user_id";
		} else {
			// 자료가 없으면 Insert
			$query = "INSERT INTO user
					  (user_id, homepage, homepage_link_fl, nickname, nick_enable_fl, view_per_page, update_dt, profile_image)
					  VALUES (:user_id, :homepage, :homepage_link_fl, :nickname, :nick_enable_fl, :view_per_page, now(), :profile_image)";
		}

		$stmt  = $pdo->prepare($query);

		$stmt->bindValue(':nick_enable_fl',   $nickEnableFl,              PDO::PARAM_INT);
		$stmt->bindValue(':profile_image',    $profileImage,              PDO::PARAM_STR);
		$stmt->bindValue(':nickname',         $nickname,                  PDO::PARAM_STR);
		$stmt->bindValue(':homepage_link_fl', $homepageLinkFl,            PDO::PARAM_INT);
		$stmt->bindValue(':homepage',         $homepage,                  PDO::PARAM_STR);
		$stmt->bindValue(':view_per_page',    $viewPerPage,                   PDO::PARAM_INT);
		$stmt->bindValue(':user_id',          $this->getUserId(), PDO::PARAM_STR);

		$stmt->execute();
	} /*}}}*/
}
?>
