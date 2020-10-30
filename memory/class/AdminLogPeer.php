<?php
class AdminLogPeer
{
	public static function add(AdminOfficer $officer, $actionGb, $arg1 = null, $arg2 = null) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'INSERT INTO admin_log
				  (officer_id, action_gb, arg1, arg2)
				  VALUES (:officer_id, :action_gb, :arg1, :arg2)';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':officer_id', $officer->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':action_gb',  $actionGb,             PDO::PARAM_INT);
		if (isset($arg1)) {
			$stmt->bindValue(':arg1', $arg1->getUniqueCode(), PDO::PARAM_STR);
		}
		else {
			$stmt->bindValue(':arg1', '', PDO::PARAM_STR);
		}
		if (isset($arg2)) {
			$stmt->bindValue(':arg2', $arg2->getUniqueCode(), PDO::PARAM_STR);
		}
		else {
			$stmt->bindValue(':arg2', '', PDO::PARAM_STR);
		}
		$stmt->execute();
	} /*}}}*/

	public static function retrieveAdminLogs($page, $numPerPage) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT admin_log_sq, officer_id, action_gb, arg1, arg2, insert_dt
			      FROM admin_log ORDER BY admin_log_sq DESC LIMIT :offset, :limit';
		$stmt  = $pdo->prepare($query);

		$stmt->bindValue(':offset', ($page-1)*$numPerPage, PDO::PARAM_INT);
		$stmt->bindValue(':limit',  $numPerPage,             PDO::PARAM_INT);
		$stmt->execute();

		$logs = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$log = AdminLog::instance($row['admin_log_sq']);

			$officer = AdminOfficer::instance($row['officer_id']);
			Logger::debug($officer);

			$log->setOfficer($officer);

			$log->setActionGb(intval($row['action_gb']));
			$log->setArg1($row['arg1']);
			$log->setArg2($row['arg2']);
			$log->setInsertDt(strtotime($row['insert_dt']));
			$logs[] = $log;
		}

		return $logs;
	} /*}}}*/

	public static function countAdminLogs() /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM admin_log';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return $row['cnt'];
		}
		else {
			return 0;
		}
	} /*}}}*/
}
?>
