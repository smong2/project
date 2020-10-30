<?php
class Invite extends BaseObject
{
	protected $__inviteSq;
	protected $__inviteId;
	protected $__inviteEmail;
	protected $__recieveEmail;
	protected $__inviteMessage;
	protected $__shareMp;
	protected $__insertDt;
	protected $__visitFl;
	protected $__visitDesc;

	public static function instance($userid) /*{{{*/
	{
		static $sInstance = array();

		$userid = intval($userid);

		if (isset($sInstance[$userid]) === false) {
			$className          = __CLASS__;
			$user               = new $className($userid);
			$sInstance[$userid] = $user;
		}

		return $sInstance[$userid];
	} /*}}}*/


	public function retrieveInvite($page, $numPerPage) {
		$pdo = PDO_Manager::getMemoryDB();

		$query = "SELECT invite_sq, invite_id, invite_email, recieve_email, invite_message, share_mp, insert_dt, visit_fl
					FROM invite
					WHERE invite_id = :invite_id
					LIMIT :offset, :limit";
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':invite_id', $this->myUser->getUserId(), PDO::PARAM_STR);
		$stmt->bindValue(':offset', ($page-1)*$numPerPage, PDO::PARAM_INT);
		$stmt->bindValue(':limit',  $numPerPage,           PDO::PARAM_INT);

		$stmt->execute();

		$invites = array();
		while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$invite = Invite::instance($row["invite_sq"]);
			$invite->setInviteSq($row["invite_sq"]);
			$invite->setInviteId($row["invite_id"]);
			$invite->setInviteEmail($row["invite_email"]);
			$invite->setRecieveEmail($row["recieve_email"]);
			$invite->setInviteMessage($row["invite_message"]);
			$invite->setShareMp($row["share_mp"]);
			$invite->setInsertDt(strtotime($row["insert_dt"]));
			$invite->setVisitFl($row["visit_fl"]);
			$invite->setVisitDesc(InvitePeer::setVisitDescPre($row["visit_fl"]));


			$invites[] = $invite;
		}
		return $invites;
	}
}

?>