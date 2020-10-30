<?php
class AdminOfficer extends BaseObject
{
	protected $__userId;
	protected $__user;
	protected $__modifier;
	protected $__officerDt;    // 운영자로 임명된 시각
	protected $__lastAccessDt; // 마지막 접속 시각

	private $_arrAuthMenu;     // 권한을 가지고 있는 메뉴 목록, haveAuthOf 를 호출하면 자동으로 갱신된다.

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

		$this->user = User::instance($this->__userId);
	} /*}}}*/

	public function getRealName() /*{{{*/
	{
		return $this->user->getRealName();
	} /*}}}*/

	public function updateLastUpdateDt() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE admin_officer SET last_access_dt = now() WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->__userId, PDO::PARAM_STR);
		$stmt->execute();

		$this->setLastUpdateDt(time());
	} /*}}}*/

	public function dismiss(AdminOfficer $modifier) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE admin_officer 
				  SET officer_fl = 0, update_dt = now() 
				  WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->__userId, PDO::PARAM_STR);
		$stmt->execute();

		AdminLogPeer::add($modifier, AdminLog::GB_OFFICER_REMOVE, $this);
	} /*}}}*/

	public function haveAuthOf($menuGb) /*{{{*/
	{
		if (isset($this->_arrAuthMenu) === false) {
			$this->_arrAuthMenu = array();

			$pdo = PDO_Manager::getMemoryDB();

			$query = 'SELECT menu_gb FROM admin_auth WHERE user_id = :user_id';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id', $this->__userId, PDO::PARAM_STR);
			$stmt->execute();

			while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
				$this->_arrAuthMenu[] = $row['menu_gb'];
			}
		}

		return in_array($menuGb, $this->_arrAuthMenu);
	} /*}}}*/

	/**
	 * 운영자의 메뉴 권한을 변경한다.
	 * 기존에 있던 메뉴 권한을 모두 무시하고 $arrMenuGb 에 해당하는 메뉴 권한을 부여한다.
	 * 
	 * @param array $arrMenuGb 메뉴 권한을 부여할 메뉴 구분 코드를 담은 배열, 메뉴 구분 코드는 모두 값에 들어있어야 한다.
	 */
	public function updateAuth(array $arrMenuGb, AdminOfficer $modifier) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'DELETE FROM admin_auth WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $this->__userId, PDO::PARAM_STR);
		$stmt->execute();

		foreach ($arrMenuGb as $menuGb) {
			$query = 'INSERT INTO admin_auth (user_id, menu_gb) VALUES (:user_id, :menu_gb)';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id', $this->__userId, PDO::PARAM_STR);
			$stmt->bindValue(':menu_gb', $menuGb,         PDO::PARAM_INT);
			$stmt->execute();
		}

		$this->_arrAuthMenu = $arrMenuGb;

		AdminLogPeer::add($modifier, AdminLog::GB_AUTH_MODIFY_OFFICER, $this);
	} /*}}}*/

	public function getUniqueCode() /*{{{*/
	{
		return 'user#' . $this->__userId;
	} /*}}}*/
}
?>
