<?php
class InvitePeer
{
	public static function countInvite() {
		$pdo = PDO_Manager::getMemoryDB();

		$query = "SELECT COUNT(invite_sq) AS cnt FROM invite";
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		$cnt = 0;
		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$cnt = $row['cnt'];
		}

		return $cnt;
	}

	public static function delInvite($invite_sq) {
		$pdo = PDO_Manager::getMemoryDB();

		$query = "DELETE FROM invite
					WHERE invite_sq = :invite_sq";
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':invite_sq', $invite_sq, PDO::PARAM_INT);

		$stmt->execute();
	}

	public static function addInvite($recieve_email, $userId, $inviteEmail, $inviteMessage, $shareMp) {
		$pdo = PDO_Manager::getMemoryDB();

		$query = "INSERT INTO invite
					 (invite_id, invite_email, recieve_email, invite_message, share_mp)
					 VALUES
					 (:invite_id, :invite_email, :recieve_email, :invite_message, :share_mp)";

		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':invite_id', $userId, PDO::PARAM_STR);
		$stmt->bindValue(':invite_email', $inviteEmail, PDO::PARAM_STR);
		$stmt->bindValue(':recieve_email', $recieve_email, PDO::PARAM_STR);
		$stmt->bindValue(':invite_message', $inviteMessage, PDO::PARAM_STR);
		$stmt->bindValue(':share_mp', $shareMp, PDO::PARAM_INT);

		$stmt->execute();

		return $pdo->lastInsertID();

	}

	// 이거 여기다 놓고 쓸만한가?
	public static function setVisitDescPre($inviteFl) {
		if($inviteFl==0) {
			return "미사용";
		} else {
			return "사용중";
		}
	}
}

?>