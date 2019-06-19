<?php
set_include_path('{PODO_INSTALL_BASEDIR}');

if (defined('PODO_CONFIG_ISLIVE') === FALSE)
	define('PODO_CONFIG_ISLIVE', {PODO_INSTALL_ISLIVE});
if (defined('PODO_CONFIG_BASEDIR') === FALSE)
	define('PODO_CONFIG_BASEDIR', '{PODO_INSTALL_BASEDIR}');
if (defined('PODO_CONFIG_KIWIDIR') === FALSE)
    define('PODO_CONFIG_KIWIDIR', '/skcomms/frw/kiwi');
if (defined('PODO_CONFIG_CACHEDIR') === FALSE)
	define('PODO_CONFIG_CACHEDIR', '{PODO_INSTALL_TEMPDIR}/Podo/System/ConfigManager');
if (defined('PODO_CONFIG_TTL') === FALSE)
	define('PODO_CONFIG_TTL', 0);
?>
