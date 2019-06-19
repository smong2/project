<?php
	// 인스톨러 파일 경로
    $gStrInstallerFilePath = dirname(__FILE__).'/Installer.php';

	// common_base.inc.php 의 파일 경로
    $gStrCommonBaseFilePath = dirname(__FILE__).'/common_base.inc.php';

	// 실서버용 환경설정 파일 목록
	$gArrLiveConfFile = array('config/common.cfg');

	// 개발서버용 환경설정 파일 목록
	$gArrDevConfFile = array_merge(array('config/dev.cfg'), $gArrLiveConfFile);

    define('PODO_CONFIG_KIWIDIR', '/skcomms/frw/kiwi-connecting');

    if (defined('PODO_CONFIG_KIWIDIR')) {
        require_once PODO_CONFIG_KIWIDIR.'/podo/config/common.inc.php';
    }
    else {
        require_once '/skcomms/frw/kiwi/podo/config/common.inc.php';
    }
?>
