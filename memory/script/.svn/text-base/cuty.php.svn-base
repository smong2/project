#!/skcomms/php/bin/php
<?php
require dirname(__FILE__) . '/../config/common.inc.php';

$cuty = new Podo_Formatter();

if (count($argv) < 2) {
	echo "Usage: cuty.php filepath\n";
	exit;
}

$r = $cuty->executeFile($argv[1]);

$backupDir = str_replace('/', DIRECTORY_SEPARATOR, ConfigManager::get('common.tempdir').'/Podo/Formatter');
if (file_exists($backupDir) === false) {
	mkdir($backupDir, 0755, true);
}
if (isset($argv[2]) && $argv[2] === 'debug') {
	file_put_contents('/home/teeroz/a1.php', file_get_contents($argv[1]));
	file_put_contents('/home/teeroz/a2.php', $r);
	ob_start();
	system('diff ~/a1.php ~/a2.php');
	$diff = ob_get_contents();
	ob_clean();
	file_put_contents('/home/teeroz/a.diff', $diff);
}
else if (isset($argv[2]) && $argv[2] === 'vim') {
	file_put_contents($backupDir.DIRECTORY_SEPARATOR.basename($argv[1]), file_get_contents($argv[1]));
	// file_put_contents($argv[1], $r);
	file_put_contents($backupDir.DIRECTORY_SEPARATOR.'result.php', $r);
	echo $r;
	$r = shell_exec('diff '.$backupDir.DIRECTORY_SEPARATOR.basename($argv[1]).' '.$backupDir.DIRECTORY_SEPARATOR.'result.php');
	file_put_contents($backupDir.DIRECTORY_SEPARATOR.'formatter.diff', $r);
}
else {
	file_put_contents($backupDir.DIRECTORY_SEPARATOR.basename($argv[1]), file_get_contents($argv[1]));
	file_put_contents($argv[1],                                          $r);
	system('diff '.$backupDir.DIRECTORY_SEPARATOR.basename($argv[1]).' '.$argv[1]);
}
?>
