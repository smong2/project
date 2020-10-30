<?php
class BaseController extends Podo_Controller_Base
{
	var $cache;

	public function __preProcessor() /*{{{*/
	{
		parent::__preProcessor();

		$cache = new SimpleDBCache();
		$cache->connect(ConfigManager::get('DBCache_Info.Host'), 0, 0);

	} /*}}}*/
}
