<?php
// 인스톨러 파일 경로
$gStrInstallerFilePath = dirname(__FILE__) . '/Installer.php';

// common_base.inc.php 의 파일 경로
$gStrCommonBaseFilePath = dirname(__FILE__) . '/common_base.inc.php';

// 실서버용 환경설정 파일 목록
$gArrLiveConfFile = array('config/common.cfg');

// 개발서버용 환경설정 파일 목록
$gArrDevConfFile = array_merge(array('config/dev.cfg'), $gArrLiveConfFile);

// 키위 프레임웍 로드하기
// 프레임웍을 다른 디렉토리로 설정할 경우에는 아래 주석을 해제하고,
// 원하는 디렉토리로 설정해서 사용하면 됩니다.
// define('PODO_CONFIG_KIWIDIR', '#directory of kiwi framework#');
if (defined('PODO_CONFIG_KIWIDIR')) {
	require_once PODO_CONFIG_KIWIDIR . '/podo/config/common.inc.php';
}
else {
	require_once '/skcomms/frw/kiwi/podo/config/common.inc.php';
}

// 웹페이지를 캐쉬할 수 있도록 할 경우 주석해제하고 true 로 설정
// define('COMMON_CACHE', false);

// Content-Type 을 변경하고 싶은 경우 주석해제하고 설정
// define('COMMON_CONTENT_TYPE', 'text/html');

// 인코딩을 변경하고 싶은 경우 주석해제하고 설정
// define('COMMON_CHARSET', 'utf-8');
?>
