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
?>
