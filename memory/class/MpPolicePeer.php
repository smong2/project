<?php
class MpPolicePeer
{
	public static function countMpPolices($mp_Nm, $reasonGb, $statusGb) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT count(*) cnt FROM mp_police';

		$whereClause = array();
		if ($reasonGb) {
			$whereClause[] = 'reason_gb = :reason_gb';
		}
		if ($statusGb) {
			$whereClause[] = 'status_gb = :status_gb';
		}
		if ($mp_Nm) {
			$whereClause[] = 'mp_nm like :mp_nm';
		}

		if (count($whereClause) > 0) {
			$query .= ' WHERE '.join(' and ', $whereClause);
		}

		$stmt = $pdo->prepare($query);
		if ($reasonGb) {
			$stmt->bindValue(':reason_gb', $reasonGb, PDO::PARAM_INT);
		}
		if ($statusGb) {
			$stmt->bindValue(':status_gb', $statusGb, PDO::PARAM_INT);
		}
		if ($mp_Nm) {
			$stmt->bindValue(':mp_nm', '%'.str_replace('%', '\%', $mp_Nm).'%', PDO::PARAM_STR);
		}

		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			return $row['cnt'];
		}
		else {
			return 0;
		}
	} /*}}}*/

	public static function retrieveMpPolicesByPage($page, $numPerPage, $mp_Nm, $reasonGb, $statusGb) /*{{{*/
	{
		$pdo = PDO_Manager::getMemoryDB();

		$query = 'SELECT mp_police.mp_sq, mp_police.mp_nm, mp_police.creator_id, creator_nick,
						 status_gb, reason_gb, mp_police.content, mp_police.update_dt,
						 mp_police.officer_id, admin_officer.realname, admin_officer.nate_id									  
				  FROM mp_police LEFT JOIN memory_piece ON mp_police.mp_sq = memory_piece.mp_sq 
								 LEFT JOIN admin_officer ON mp_police.officer_id = admin_officer.user_id';

		$whereClause = array();
		if ($reasonGb) {
			$whereClause[] = 'reason_gb = :reason_gb';
		}
		if ($statusGb) {
			$whereClause[] = 'status_gb = :status_gb';
		}
		if ($mp_Nm) {
			$whereClause[] = 'mp_police.mp_nm like :mp_nm';
		}

		if (count($whereClause) > 0) {
			$query .= ' WHERE '.join(' and ', $whereClause);
		}

		$query .= ' LIMIT :offset, :limit';

		$stmt = $pdo->prepare($query);
		$stmt->bindValue(':offset', ($page-1)*$numPerPage, PDO::PARAM_INT);
		$stmt->bindValue(':limit',  $numPerPage,           PDO::PARAM_INT);

		// 검색어 관련 변수도 있어야할 듯
		if ($mp_Nm) {
			$stmt->bindValue(':mp_nm', '%'.str_replace('%', '\%', $mp_Nm).'%', PDO::PARAM_STR);
		}
		if ($reasonGb) {
			$stmt->bindValue(':reason_gb', $reasonGb, PDO::PARAM_INT);
		}
		if ($statusGb) {
			$stmt->bindValue(':status_gb', $statusGb, PDO::PARAM_INT);
		}
		$stmt->execute();

		$retvals = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$retval = MpPolice::instance($row['mp_sq']);

			$mp = Mp::instance($row['mp_sq']);
			$mp->setMpNm($row['mp_nm']);
			$mp->setCreator(User::instance($row['creator_id']));

			// 닉네임이 없으면 코드로 가져온다
			$cn = $row['creator_nick'];

			if (!$cn) {
				$cn = $row['creator_id'];
			}
			else {
				$cn = $row['creator_nick'];
			}

			$mp->setCreatorNick($cn);

			$retval->setMp($mp);
			$retval->setReasonGb($row['reason_gb']);
			$retval->setStatusGb($row['status_gb']);

			// 관리자 정보 가져오려면 AdminOfficer 객체를 쓰자
			$officer = AdminOfficer::instance($row['officer_id']);
			$officer->user->setRealName($row['realname']);
			$officer->user->nate->setNateId($row['nate_id']);

			$retval->setOfficer($officer);
			$retval->setContent($row['content']);
			$retval->setUpdateDt(strtotime($row['update_dt']));
			$retvals[] = $retval;
		}		
		return $retvals;
	} /*}}}*/
}
?>
