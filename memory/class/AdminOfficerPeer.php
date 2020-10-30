<?php
class AdminOfficerPeer
{
	public function retrieveAdminOfficers() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT user_id, nate_id, realname, officer_dt, last_access_dt
			      FROM admin_officer
				  WHERE officer_fl = 1';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		$officers = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$officer = AdminOfficer::instance($row['user_id']);
			$officer->user->nate->setNateId($row['nate_id']);
			$officer->user->setRealName($row['realname']);
			$officer->setOfficerDt(strtotime($row['officer_dt']));
			$officer->setLastAccessDt(strtotime($row['last_access_dt']));

			$officers[] = $officer;
		}

		usort($officers, array($officer, 'compareWithRealName'));

		return $officers;
	} /*}}}*/

	public function add(User $user, AdminOfficer $modifier) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'UPDATE admin_officer 
				  SET officer_fl = 1, officer_dt = now(), update_dt = now() 
				  WHERE user_id = :user_id';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $user->getUserId(), PDO::PARAM_STR);
		$stmt->execute();

		if ($stmt->rowCount() <= 0) {
			$query = 'INSERT INTO admin_officer
					  (user_id, nate_id, realname, officer_fl, officer_dt, update_dt)
					  VALUES (:user_id, :nate_id, :realname, 1, now(), now())';
			$stmt  = $pdo->prepare($query);
			$stmt->bindValue(':user_id',  $user->getUserId(),       PDO::PARAM_STR);
			$stmt->bindValue(':nate_id',  $user->nate->getNateId(), PDO::PARAM_STR);
			$stmt->bindValue(':realname', $user->getRealName(),     PDO::PARAM_STR);
			$stmt->execute();
		}

		$officer = AdminOfficer::instance($user->getUserId());
		AdminLogPeer::add($modifier, AdminLog::GB_OFFICER_ADD, $officer);

		return $officer;
	} /*}}}*/

	/**
	 * 운영자로 등록되어있는지 여부를 반환한다.
	 */
	public function isOfficerByUserId($userId) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM admin_officer WHERE user_id = :user_id and officer_fl = 1';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':user_id', $userId, PDO::PARAM_STR);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return (bool)($row['cnt']);
		}

		return false;
	} /*}}}*/
}
?>
