<?php
set_include_path('/home/mong/project/NateOnConnecting'.PATH_SEPARATOR.'/home/mong/project/NateOnConnecting/class');

if (defined('PODO_CONFIG_ISLIVE') === FALSE)
	define('PODO_CONFIG_ISLIVE', false);
if (defined('PODO_CONFIG_BASEDIR') === FALSE)
	define('PODO_CONFIG_BASEDIR', '/home/mong/project/NateOnConnecting');
if (defined('PODO_CONFIG_KIWIDIR') === FALSE)
    define('PODO_CONFIG_KIWIDIR', '/skcomms/frw/kiwi-connecting');
if (defined('PODO_CONFIG_CACHEDIR') === FALSE)
	define('PODO_CONFIG_CACHEDIR', '/home/mong/project/NateOnConnecting/tmp/Podo/System/ConfigManager');
if (defined('PODO_CONFIG_TTL') === FALSE)
	define('PODO_CONFIG_TTL', 0);
?>
