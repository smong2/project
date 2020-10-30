<?php
class AdminMenu extends BaseObject
{
	protected $__menuGb;

	const GB_CATEGORY = 3;
	const GB_MP       = 5;
	const GB_OFFICER  = 1;
	const GB_AUTH     = 2;
	const GB_LOG      = 4;

	public static $arrMenu = array(
	    self::GB_CATEGORY => '카테고리 관리',
	    self::GB_MP => 'MP 관리',
	    self::GB_OFFICER => '운영자 관리',
	    self::GB_AUTH => '권한 관리',
	    self::GB_LOG => '관리 로그',
	);

	private $_arrAuthUser;

	public static function instance($menuGb) /*{{{*/
	{
		static $sInstance = array();

		$menuGb = intval($menuGb);

		if (isset($sInstance[$menuGb]) === false) {
			$className          = __CLASS__;
			$menu               = new $className($menuGb);
			$sInstance[$menuGb] = $menu;
		}

		return $sInstance[$menuGb];
	} /*}}}*/

	protected function __construct($menuGb) /*{{{*/
	{
		$this->__menuGb = $menuGb;
	} /*}}}*/

	public function isGrantedTo(AdminOfficer $officer) /*{{{*/
	{
		if (isset($this->_arrAuthUser) === false) {
			$this->_arrAuthUser = array();

			$pdo = PDO_Manager::getMemoryDB();

			$query = 'SELECT user_id FROM admin_auth WHERE menu_gb = :menu_gb';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':menu_gb', $this->__menuGb, PDO::PARAM_INT);
			$stmt->execute();

			while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
				$this->_arrAuthUser[] = AdminOfficer::instance($row['user_id']);
			}
		}

		return in_array($officer, $this->_arrAuthUser);
	} /*}}}*/

	/**
	 * 메뉴의 권한 부여자를 변경한다.
	 * 기존에 있던 운영자 권한을 모두 무시하고 $arrOfficerId 에 해당하는 운영자에게 권한을 부여한다.
	 * 
	 * @param array $arrOfficerId 메뉴 권한을 부여할 운영자 아이디를 담은 배열, 운영자 아이디는 모두 값에 들어있어야 한다.
	 */
	public function updateAuth(array $arrOfficerId, AdminOfficer $modifier) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'DELETE FROM admin_auth WHERE menu_gb = :menu_gb';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':menu_gb', $this->__menuGb, PDO::PARAM_INT);
		$stmt->execute();

		foreach ($arrOfficerId as $officerId) {
			$query = 'INSERT INTO admin_auth (user_id, menu_gb) VALUES (:user_id, :menu_gb)';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id', $officerId,      PDO::PARAM_STR);
			$stmt->bindValue(':menu_gb', $this->__menuGb, PDO::PARAM_INT);
			$stmt->execute();
		}

		$this->_arrAuthUser = $arrOfficerId;

		AdminLogPeer::add($modifier, AdminLog::GB_AUTH_MODIFY_MENU, $this);
	} /*}}}*/

	public function getUniqueCode() /*{{{*/
	{
		return 'menu#' . $this->__menuGb;
	} /*}}}*/
}
?>
