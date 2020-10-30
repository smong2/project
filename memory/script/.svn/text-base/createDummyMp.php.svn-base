<?php
	require dirname(dirname(__FILE__)).'/config/common.inc.php';

	ConfigManager::set('DBGate.disable', true);

	$pdo = PDO_Manager::getMemoryDB();

	$query = 'DELETE FROM memory_piece';
	$stmt = $pdo->prepare($query);
	$stmt->execute();

	$query = 'DELETE FROM memory_talk';
	$stmt = $pdo->prepare($query);
	$stmt->execute();

	$query = 'DELETE FROM mp_timetag';
	$stmt = $pdo->prepare($query);
	$stmt->execute();

	$query = 'DELETE FROM memorize';
	$stmt = $pdo->prepare($query);
	$stmt->execute();

	$query = 'DELETE FROM user';
	$stmt = $pdo->prepare($query);
	$stmt->execute();

	$query = 'UPDATE category SET mp_cnt = 0, update_dt = now()';
	$stmt = $pdo->prepare($query);
	$stmt->execute();

	$myUser = User::instance('10013573443');
	$myUser->nate->setNickName('티로');
	$myUser->setRealName('신종훈');
	$categories = CategoryPeer::retrieveActivatedCategories();

	function addByYear(User $myUser, $mpNm, Category $category, $categoryMiscNm, $year, $content) 
	{
		// MP 객체 생성
		$mp = new Mp();
		$mp->setCreator($myUser);
		$mp->setCreatorNick($myUser->getNickname());
		$mp->setMpNm($mpNm);
		$mp->setCategory($category);
		$mp->setCategoryMiscNm($categoryMiscNm);

		// 타임 태그 객체 생성
		$timeTag = new TimeTag();
		$timeTag->setUser($myUser);
		$timeTag->setInsertDt(time());
		$timeTag->setTimeTagGb(TimeTag::GB_CUSTOM);
		$timeTag->setCustom($year, '', '');
		$timeTag->setTheDay('');
		$timeTag->setAgo('');
		$timeTag->setAges('');

		// MT 객체 생성
		$mt = new Mt();
		$mt->setWriter($myUser);
		$mt->setWriterNick($myUser->getNickname());
		$mt->setContent($content);
		$mt->setTimeTag($timeTag);
		$mt->setParentMt(false);

		// MP 데이타 DB에 기록
		$mp->setTimeTag(clone $timeTag);
		$mp->doAdd();

		// MT 데이타 DB에 기록
		$mp->addMt($mt);
	}

	foreach ($categories as $category) {
		for ($year=1970; $year<2010; $year++) {
			for ($i=1; $i<=100; $i++) {
				$title = $category->getCategoryNm().'의 '.$year.'년도 기억 #'.sprintf("%03d", $i);
				$myUser = User::instance(mt_rand(10000000000, 10000009999));
				$myUser->setRealName('user#'.substr($myUser->getUserId(), -4));
				$myUser->setNickName($myUser->getRealName());
				addByYear($myUser, $title, $category, '', $year, $title);
			}
		}
	}

	function addByTheDay(User $myUser, $mpNm, Category $category, $categoryMiscNm, $thedayGb, $content) 
	{
		// MP 객체 생성
		$mp = new Mp();
		$mp->setCreator($myUser);
		$mp->setCreatorNick($myUser->getNickname());
		$mp->setMpNm($mpNm);
		$mp->setCategory($category);
		$mp->setCategoryMiscNm($categoryMiscNm);

		// 타임 태그 객체 생성
		$timeTag = new TimeTag();
		$timeTag->setUser($myUser);
		$timeTag->setInsertDt(time());
		$timeTag->setTimeTagGb(TimeTag::GB_THEDAY);
		$timeTag->setCustom('', '', '');
		$timeTag->setTheDay($thedayGb);
		$timeTag->setAgo('');
		$timeTag->setAges('');

		// MT 객체 생성
		$mt = new Mt();
		$mt->setWriter($myUser);
		$mt->setWriterNick($myUser->getNickname());
		$mt->setContent($content);
		$mt->setTimeTag($timeTag);
		$mt->setParentMt(false);

		// MP 데이타 DB에 기록
		$mp->setTimeTag(clone $timeTag);
		$mp->doAdd();

		// MT 데이타 DB에 기록
		$mp->addMt($mt);
	}

	$categories = CategoryPeer::retrieveActivatedCategories();

	foreach ($categories as $category) {
		foreach (TimeTag::$thedays as $thedayGb=>$theday) {
			for ($i=1; $i<=100; $i++) {
				$title = $category->getCategoryNm().'의 '.$theday.' 시절 기억 #'.sprintf("%03d", $i);
				$myUser = User::instance(mt_rand(10000000000, 10000009999));
				$myUser->setRealName('user#'.substr($myUser->getUserId(), -4));
				$myUser->setNickName($myUser->getRealName());
				addByTheDay($myUser, $title, $category, '', $thedayGb, $title);
			}
		}
	}
?>
