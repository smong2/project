<?php
require dirname(dirname(__FILE__)) . '/config/common.inc.php';

 ConfigManager::set('DBGate.disable', true);

function addRandomTalk() /*{{{*/
{
	static $random_mt_cnt = 0;

	$pdo = PDO_Manager::getMemoryDB();
	$random_mt_cnt++;
	$depth = mt_rand(1, 3);

	$user = User::instance(mt_rand(10000000000, 10000009999));
	$user->setRealName('user#'.substr($user->getUserId(), -4));
	$user->setNickName($user->getRealName());

	$mt = new Mt();
	$mt->setWriter($user);
	$mt->setWriterNick($user->getNickname());
	$mt->setContent(date('Y년 m월 d일 H시 i분에 자동으로 작성된 댓글입니다. 댓글 번호 - '.$random_mt_cnt));

	if ($depth < 3) {
		$timeTag = new TimeTag();
		$timeTag->setUser($user);
		$timeTag->setInsertDt(time());
		$timeTag->setCustom('', '', '');
		$timeTag->setTheDay('');
		$timeTag->setAgo('');
		$timeTag->setAges('');

		$gb_rand = mt_rand(1, 6);
		if ($gb_rand <= 5) {
			$timeTag->setTimeTagGb(TimeTag::GB_CUSTOM);

			if ($gb_rand <= 3) {
				$timeTag->setCustom(mt_rand(1960, 2009), '', '');
			}
			else if ($gb_rand <= 4) {
				$timeTag->setCustom(mt_rand(1960, 2009), mt_rand(1, 12), '');
			}
			else if ($gb_rand <= 5) {
				$timeTag->setCustom(mt_rand(1960, 2009), mt_rand(1, 12), mt_rand(1, 28));
			}
		}
		else {
			$timeTag->setTimeTagGb(TimeTag::GB_THEDAY);
			$thedayGbs = array_keys(TimeTag::$thedays);
			$key       = array_rand($thedayGbs);
			$timeTag->setTheDay($thedayGbs[$key]);
		}

		$mt->setTimeTag($timeTag);
	}

	if ($depth == 1) {
		$query = 'SELECT count(*) cnt FROM memory_piece';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		$row        = $stmt->fetch(PDO::FETCH_ASSOC);
		$totalMpCnt = $row['cnt'];

		if ($totalMpCnt <= 0) {
			return;
		}

		$query = 'SELECT * FROM memory_piece LIMIT :offset, :limit';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':offset', mt_rand(0, $totalMpCnt-1), PDO::PARAM_INT);
		$stmt->bindValue(':limit',  1,                         PDO::PARAM_INT);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$parent = Mp::instance($row['mp_sq']);
			$parent->loadByRowData($row);

			$parent->addMt($mt);
		}
	}
	else {
		$query = 'SELECT count(*) cnt FROM memory_talk';
		$stmt  = $pdo->prepare($query);
		$stmt->execute();

		$row        = $stmt->fetch(PDO::FETCH_ASSOC);
		$totalMtCnt = $row['cnt'];

		if ($totalMtCnt <= 0) {
			return;
		}

		$query = 'SELECT * FROM memory_talk LIMIT :offset, :limit';
		$stmt  = $pdo->prepare($query);
		$stmt->bindValue(':offset', mt_rand(0, $totalMtCnt-1), PDO::PARAM_INT);
		$stmt->bindValue(':limit',  1,                         PDO::PARAM_INT);
		$stmt->execute();

		if ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
			$parent = Mt::instance($row['mt_sq']);
			$parent->loadByRowData($row);

			$parent->addChild($mt);
		}
	}
} /*}}}*/

for ($i=0; $i<100; $i++) {
	addRandomTalk();
}
?>
